Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283843AbRK3X7j>; Fri, 30 Nov 2001 18:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283835AbRK3X73>; Fri, 30 Nov 2001 18:59:29 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:35089 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S283844AbRK3X7T>; Fri, 30 Nov 2001 18:59:19 -0500
Message-ID: <3C081D47.C931377B@zip.com.au>
Date: Fri, 30 Nov 2001 15:59:03 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kamil Iskra <kamil@science.uva.nl>
CC: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: Problems with APM suspend and ext3
In-Reply-To: <Pine.LNX.4.10.10111291006380.20544-100000@coffee.psychology.mcmaster.ca> <Pine.LNX.4.33.0111302355140.1582-100000@bubu.home>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kamil Iskra wrote:
> 
> I've long since known that the
> suspends are not completely reliable, even with ext2, particularly if
> there was some disk activity going to right before or during a suspend.

Yup.  It seems that your BIOS is being asked to suspend all devices
while there is still disk IO being performed.  And it refuses to
suspend because the disk is still active.

The patch I sent you attempts to put a one-seond delay in the
APM suspend function before calling into the BIOS.  That _should_
improve your suspend success rate, but there's really not much we
can do to prevent disk IO from being started at any time.

-
