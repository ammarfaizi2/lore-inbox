Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265695AbUAQFLv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 00:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265928AbUAQFLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 00:11:51 -0500
Received: from linuxhacker.ru ([217.76.32.60]:49046 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S265695AbUAQFLt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 00:11:49 -0500
Date: Sat, 17 Jan 2004 07:11:07 +0200
From: Oleg Drokin <green@linuxhacker.ru>
To: Brad Tilley <bradtilley@usa.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Re: Possible Bug in 2.4.24???]
Message-ID: <20040117051107.GC1967@linuxhacker.ru>
References: <514iaqBeC5488S07.1074301468@uwdvg007.cms.usa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <514iaqBeC5488S07.1074301468@uwdvg007.cms.usa.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Jan 16, 2004 at 08:04:28PM -0500, Brad Tilley wrote:
> > > Jan 16 11:50:43 athop1 kernel:  I/O error: dev 08:15, sector 54128
> > > Jan 16 11:50:43 athop1 kernel: journal-601, buffer write failed
> > > Jan 16 11:50:43 athop1 kernel:  (device sd(8,21))
> > A device error happened (you see the "SCSI disk error : " message and
> > "Additional sense indicates Internal target failure") which reiserfs
> > could not handle.
> > kernel BUG at prints.c:341 == reiserfs_panic().
> Does this mean that there is a physical or mechanical problem with the drive
> itself? I do use 

Yes it does.

> reiserfs as it's the best fs available for my purposes. Could the drive
> attempt to write 
> outside its physical bounds? Move the arm right when it was instructed to go

The sector for I/O error is 54128, which is somewhere withing journal (at the
beginning of a disk). What was the problem inside of the drive is not very
clear, as modern drives are sort of black-boxes.

> left? I don't 
> understand how the drive could have an error w/o affecting the filesystem.

Well, there was affect on filesystem - the write have failed.
Also may be later that block was remapped, or that was internal drive's logic
failure or something else like that.
This journal block won't be used on subsequent mount (because transaction
was not closed), but will be just
overwritten. So even if its content was corrupted, reiserfs does not care.

Bye,
    Oleg
