Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWDFLol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWDFLol (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 07:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWDFLol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 07:44:41 -0400
Received: from nacho.alt.net ([207.14.113.18]:39591 "HELO nacho.alt.net")
	by vger.kernel.org with SMTP id S1751156AbWDFLol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 07:44:41 -0400
Date: Thu, 6 Apr 2006 11:44:38 +0000 (GMT)
To: erich <erich@areca.com.tw>
cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: about ll_rw_blk.c of void generic_make_request(struct bio *bio)
In-Reply-To: <026001c6595c$f6c5a890$b100a8c0@erich2003>
Message-ID: <Pine.LNX.4.64.0604060953000.13282@nacho.alt.net>
References: <001d01c65302$0fee8e10$b100a8c0@erich2003><20060330155804.GP13476@suse.de><Pine.LNX.4.64.0603311700310.14317@nacho.alt.net><Pine.LNX.4.64.0603311748010.14317@nacho.alt.net><20060331202202.GH14022@suse.de>
	<Pine.LNX.4.64.0603312028500.14317@nacho.alt.net>
	<026001c6595c$f6c5a890$b100a8c0@erich2003>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Delivery-Agent: TMDA/1.0.3 (Seattle Slew)
From: Chris Caputo <ccaputo@alt.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Apr 2006, erich wrote:
> I am so sorry that I reply this mail today.
> At 2006/4/3 my mother unexpectedly got paralysis and dead.
> I can not do any more "request testing" with this bug for some days.
> I do dump_stack as your request and attach it.
> And I do "fsck" before test this volume every time.
> It appears fine when do fsck with each testing volume.
> You can easily reproduce this bug from copy a 900MB file from ARECA volume
> (mkfs.ext2, mount -t ext2) to none ARECA volume.

Erich, my sincere condolences to you and your family.

With respect to this problem, is it possible with your driver that if a 
transfer read request is above a certain size, data corruption occurs?

It may be that fsck passes because it is doing smaller transfers while a 
file copy under ext2 (or in your example, ext3) fails because it is during 
those operations that the higher max_sectors makes a difference.

Curiously, the hex values of the "want=" field in your report are as 
follows:

  sdb1: rw=0, want=12126966488, limit=312496317
  2D2D2D2D8
  sdb1: rw=0, want=12126967088, limit=312496317
  2D2D2D530
  sdb1: rw=0, want=22232771288, limit=312496317
  52D2D2AD8
  sdb1: rw=0, want=22232771888, limit=312496317
  52D2D2D30

I wonder if 0x2D or 0xD2 corresponds to something on the disk such as in 
the file being copied or is otherwise familiar.

Chris
