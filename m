Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263594AbTJ0U7F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 15:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263595AbTJ0U7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 15:59:05 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:14353 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S263594AbTJ0U7A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 15:59:00 -0500
Date: Mon, 27 Oct 2003 12:58:54 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Blockbusting news, results end
Message-ID: <20031027205854.GF8540@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <346101c39b9e$35932680$24ee4ca5@DIAMONDLX60> <20031026092256.GA293@elf.ucw.cz> <355901c39bb3$e6ca3a50$24ee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <355901c39bb3$e6ca3a50$24ee4ca5@DIAMONDLX60>
User-Agent: Mutt/1.3.27i
X-Message-Flag: The contents of this message may cause confusion and disorientation to persons think they know everything.  Read at your own risk.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 26, 2003 at 08:25:26PM +0900, Norman Diamond wrote:
> Pavel Machek replied to me:
> 
> > > The drive finally reallocated the block and there are no longer any
> > > visible bad blocks.
> >
> > And what was the operation that made it realocate?
> 
> At first I wasn't sure.  I noticed that the drive was behaving differently
> when I told dd to use bs=4096 instead of 512.  Until seeing Oleg Drokin's
> message about ReiserFS, I thought that the drive itself was doing something
> differently.  That didn't make much sense to me because the physical sectors
> are much longer than 4096 and the pseudo-sectors are the conventional 512,
> so why did 4096 cause different behaviour?  From Oleg Drokin's message, I
> guess that the use of 4096 might make a difference in the sequence of
> read-modify-write cycles involved in the logical write operation.

You bring up an interesting point.  If the physical sector
is larger than the data being written how can the drive
reallocate the sector without silently losing data?

To put it in the concrete, if the physical sector were 16K
and we only do a 4K write and there is a unrecoverable read
error on the physical sector as part of the
read-modify-write sequence what is the drive to do?  The
other 12K for which the drive has no data could be other
files not related to the 4K being written or even filesystem
meta-data.  Reallocation in that case would cause silent
corruption.

Perhaps what finally allowed the reallocation was that the
entire physical sector finally accumulated writes to all the
logical sectors needed to be a complete physical sector
write.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
