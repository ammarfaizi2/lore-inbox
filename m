Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbVHLERb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbVHLERb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 00:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbVHLERb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 00:17:31 -0400
Received: from outbound1.mail.tds.net ([216.170.230.91]:18591 "EHLO
	outbound1.mail.tds.net") by vger.kernel.org with ESMTP
	id S1750816AbVHLERa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 00:17:30 -0400
Date: Thu, 11 Aug 2005 23:17:20 -0500
From: Phil Dier <phil@icglink.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, ziggy@icglink.com, scott@icglink.com,
       jack@icglink.com
Subject: Re: 2.6.13-rc6 Oops with Software RAID, LVM, JFS, NFS
Message-Id: <20050811231720.3ecedcd9.phil@icglink.com>
In-Reply-To: <17148.1113.664829.360594@cse.unsw.edu.au>
References: <20050811105954.31f25407.phil@icglink.com>
	<17148.1113.664829.360594@cse.unsw.edu.au>
Organization: ICGLInk
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Aug 2005 12:07:21 +1000
Neil Brown <neilb@cse.unsw.edu.au> wrote:

> On Thursday August 11, phil@icglink.com wrote:
> > Hi,
> > 
> > I posted an oops a few days ago from 2.6.12.3 [1].  Here are the results
> > of my tests on 2.6.13-rc6.  The kernel oopses, but it the box isn't completely
> > hosed; I can still log in and move around.  It appears that the only things that are
> > locked are the apps that were doing i/o to the test partition.  More detailed info 
> > about my configuration can be found here:
> > 
> > <http://www.icglink.com/debug-2.6.13-rc6.html>
> 
> You don't seem to give details on how lvm is used to combine the md
> arrays, though I'm not sure that would help particularly.
> 

FYI:

vgdisplay -v vg1  
    Using volume group(s) on command line
    Finding volume group "vg1"
  --- Volume group ---
  VG Name               vg1
  System ID             
  Format                lvm2
  Metadata Areas        2
  Metadata Sequence No  8
  VG Access             read/write
  VG Status             resizable
  MAX LV                255
  Cur LV                1
  Open LV               0
  Max PV                255
  Cur PV                2
  Act PV                2
  VG Size               410.00 GB
  PE Size               128.00 MB
  Total PE              3280
  Alloc PE / Size       1093 / 136.62 GB
  Free  PE / Size       2187 / 273.38 GB
  VG UUID               XuRomW-O6Uw-oQGq-vdwD-YwMT-Dltj-NExFmV
   
  --- Logical volume ---
  LV Name                /dev/vg1/home
  VG Name                vg1
  LV UUID                K7Gq9l-Vjte-ksFt-s0vn-ejqT-RGYc-5Aibtx
  LV Write Access        read/write
  LV Status              available
  # open                 0
  LV Size                136.62 GB
  Current LE             1093
  Segments               1
  Allocation             inherit
  Read ahead sectors     0
  Block device           253:3
   
  --- Physical volumes ---
  PV Name               /dev/md4     
  PV UUID               VgHU6k-lZmE-j686-dvfX-OSsM-yh28-Jyfidn
  PV Status             allocatable
  Total PE / Free PE    1093 / 0
   
  PV Name               /dev/md7     
  PV UUID               n4rVmy-rARO-a5mY-Iiqo-GvOx-2nbG-HluaTa
  PV Status             allocatable
  Total PE / Free PE    2187 / 2187

md7 is in there to test live migration from smaller disks to larger ones.


> 
> 	struct bio_vec *from;
> 	int i;
> 	bio_for_each_segment(from, bio, i)
> 		BUG_ON(page_zone(from->bv_page)==NULL);
> 
> in generic_make_requst in drivers/block/ll_rw_blk.c, just before
> the call to q->make_request_fn.
> This might trigger the bug early enough to see what is happening.


I'll try this and report the results.


-- 

Phil Dier <phil@dier.us>

/* vim:set ts=8 sw=8 nocindent noai: */
