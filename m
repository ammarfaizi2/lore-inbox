Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315487AbSFTUpe>; Thu, 20 Jun 2002 16:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315503AbSFTUpd>; Thu, 20 Jun 2002 16:45:33 -0400
Received: from pallas.or.intel.com ([134.134.214.21]:64974 "EHLO
	pallas.or.intel.com") by vger.kernel.org with ESMTP
	id <S315487AbSFTUpc>; Thu, 20 Jun 2002 16:45:32 -0400
Message-ID: <01BDB7EEF8D4D3119D95009027AE99951B0E63E6@fmsmsx33.fm.intel.com>
From: "Griffiths, Richard A" <richard.a.griffiths@intel.com>
To: "'Andrew Morton'" <akpm@zip.com.au>,
       "Griffiths, Richard A" <richard.a.griffiths@intel.com>
Cc: "'Jens Axboe'" <axboe@suse.de>, mgross@unix-os.sc.intel.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: RE: ext3 performance bottleneck as the number of spindles gets la
	rge
Date: Thu, 20 Jun 2002 13:45:22 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No.  The platform group is set on a journaling file system. They had already
run a comparison of the ones available and based on their criteria, ext3 was
the best choice.  Based on the lockmeter data, it does look as though the
scaling is trapped behind the BKL.

Richard

-----Original Message-----
From: Andrew Morton [mailto:akpm@zip.com.au]
Sent: Thursday, June 20, 2002 1:19 PM
To: Griffiths, Richard A
Cc: 'Jens Axboe'; mgross@unix-os.sc.intel.com; Linux Kernel Mailing
List; lse-tech@lists.sourceforge.net
Subject: Re: ext3 performance bottleneck as the number of spindles gets
large


"Griffiths, Richard A" wrote:
> 
> We ran without highmem enabled so the Kernel only saw 1GB of memory.
> 

Yup.  I take it back - high ext3 lock contention happens on 2.5
as well, which has block-highmem.  With heavy write traffic onto
six disks, two controllers, six filesystems, four CPUs the machine
spends about 40% of the time spinning on locks in fs/ext3/inode.c
You're un dual CPU, so the contention is less.

Not very nice.  But given that the longest spin time was some
tens of milliseconds, with the average much lower, it shouldn't
affect overall I/O throughput.

Possibly something else is happening.  Have you tested ext2?
