Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315536AbSFTVBy>; Thu, 20 Jun 2002 17:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315539AbSFTVBx>; Thu, 20 Jun 2002 17:01:53 -0400
Received: from fmr03.intel.com ([143.183.121.5]:65514 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP
	id <S315536AbSFTVBw>; Thu, 20 Jun 2002 17:01:52 -0400
Message-Id: <200206202101.g5KL1BP10776@unix-os.sc.intel.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: mgross <mgross@unix-os.sc.intel.com>
Reply-To: mgross@unix-os.sc.intel.com
Organization: SSG Intel
To: Andrew Morton <akpm@zip.com.au>,
       "Griffiths, Richard A" <richard.a.griffiths@intel.com>
Subject: Re: ext3 performance bottleneck as the number of spindles gets large
Date: Thu, 20 Jun 2002 14:08:38 -0400
X-Mailer: KMail [version 1.3.1]
Cc: "'Jens Axboe'" <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
References: <01BDB7EEF8D4D3119D95009027AE99951B0E63E4@fmsmsx33.fm.intel.com> <3D1238A0.EA4906FB@zip.com.au>
In-Reply-To: <3D1238A0.EA4906FB@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 June 2002 04:18 pm, Andrew Morton wrote:
> Yup.  I take it back - high ext3 lock contention happens on 2.5
> as well, which has block-highmem.  With heavy write traffic onto
> six disks, two controllers, six filesystems, four CPUs the machine
> spends about 40% of the time spinning on locks in fs/ext3/inode.c
> You're un dual CPU, so the contention is less.
>
> Not very nice.  But given that the longest spin time was some
> tens of milliseconds, with the average much lower, it shouldn't
> affect overall I/O throughput.

How could losing 40% of your CPU's to spin locks NOT spank your throughtput?  
Can you copy your lockmeter data from its kernel_flag section?  Id like to 
see it.

>
> Possibly something else is happening.  Have you tested ext2?

No.  We're attempting to see if we can scale to large numbers of spindles 
with EXT3 at the moment.  Perhaps we can effect positive changes to ext3 
before giving up on it and moving to another Journaled FS.


--mgross
