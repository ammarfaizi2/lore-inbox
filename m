Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315442AbSFTUVL>; Thu, 20 Jun 2002 16:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315449AbSFTUVK>; Thu, 20 Jun 2002 16:21:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28680 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315442AbSFTUUI>;
	Thu, 20 Jun 2002 16:20:08 -0400
Message-ID: <3D1238A0.EA4906FB@zip.com.au>
Date: Thu, 20 Jun 2002 13:18:40 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Griffiths, Richard A" <richard.a.griffiths@intel.com>
CC: "'Jens Axboe'" <axboe@suse.de>, mgross@unix-os.sc.intel.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: Re: ext3 performance bottleneck as the number of spindles gets large
References: <01BDB7EEF8D4D3119D95009027AE99951B0E63E4@fmsmsx33.fm.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
