Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317338AbSGDFge>; Thu, 4 Jul 2002 01:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317340AbSGDFgd>; Thu, 4 Jul 2002 01:36:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48644 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317338AbSGDFgc>;
	Thu, 4 Jul 2002 01:36:32 -0400
Message-ID: <3D23E0C7.3B30B618@zip.com.au>
Date: Wed, 03 Jul 2002 22:44:39 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Jens Axboe <axboe@suse.de>, Joe Thornber <joe@fib011235813.fsnet.co.uk>,
       linux-lvm@sistina.com, linux-kernel@vger.kernel.org
Subject: Re: [linux-lvm] LVM2 modifies the buffer_head struct?
References: message from Jens Axboe on Wednesday July 3 <15651.54044.557070.109158@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> 
> ...
> We just want ext3/jbd to make sure that it only calls bh2jh on
> an unlocked buffer... is that easy?

It's feasible, but a downright pita.

> Ofcourse this ceases to be an issue in 2.5 because the filesys uses
> pages or buffer_heads and the device driver uses bios.

Well, for 2.4 I'd be inclined to just add the extra field to 
struct buffer_head and be done with it.

Current sizeof(buffer_head) is 96 bytes, and making that 100 would
be a nuisance, but its quite easy to shrink the buffer_head a
bit (replace b_inode with BH_inode, say...).

-
