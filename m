Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315815AbSEECKN>; Sat, 4 May 2002 22:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315816AbSEECKM>; Sat, 4 May 2002 22:10:12 -0400
Received: from web21507.mail.yahoo.com ([66.163.169.18]:32299 "HELO
	web21507.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S315814AbSEECKL>; Sat, 4 May 2002 22:10:11 -0400
Message-ID: <20020505021011.52472.qmail@web21507.mail.yahoo.com>
Date: Sun, 5 May 2002 03:10:11 +0100 (BST)
From: =?iso-8859-1?q?Neil=20Conway?= <nconway_kernel@yahoo.co.uk>
Subject: Re: PATCH, IDE corruption, 2.4.18
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10205041556460.19145-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ah good stuff, an honest-to-god expert with brains for the picking :)

 --- Andre Hedrick <andre@linux-ide.org> wrote: > 
> It is a viable check but it the need for it shows another problem in
> the
> code.  In the IDEDMA recovery kludges it must be losing the the
> hwgroup
> busy state.

Have I misunderstood then?  My understanding was this:
ide_config_drive_speed is doing a SELECT_DRIVE, which is quite liable
to happen during a DMA transfer to/from the other unit on the hwif, and
thus screw up that transfer.

The recovery or not (from the screw-up) is a secondary factor (and it
would be nice if such recoveries worked) but the primary fix is surely
to make sure we don't gratuitously screw up transfers in the first
place.

Or have I just demonstrated my utter ignorance of IDE?

Neil
PS: a secondary issue is that after ide_config_drive_speed buggers up a
transfer, the selected drive is NOT the one that ide_intr expects to be
selected.  I haven't yet got any clue if this is also relevant though.


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com
