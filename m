Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130384AbRCIAaP>; Thu, 8 Mar 2001 19:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130383AbRCIAaF>; Thu, 8 Mar 2001 19:30:05 -0500
Received: from dweeb.lbl.gov ([128.3.1.28]:46345 "EHLO beeble.lbl.gov")
	by vger.kernel.org with ESMTP id <S130381AbRCIA36>;
	Thu, 8 Mar 2001 19:29:58 -0500
Message-ID: <3AA823DC.30D392D4@lbl.gov>
Date: Thu, 08 Mar 2001 16:29:16 -0800
From: Thomas Davis <tadavis@lbl.gov>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-RAID i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Sightler <ttsig@tuxyturvy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Questions about Enterprise Storage with Linux
In-Reply-To: <E14an7j-0001rZ-00@the-village.bc.nu> <20010307164052.B788@wirex.com> <006301c0a765$3ca118e0$1601a8c0@zeusinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Sightler wrote:
> 
> Hi All,
> 
> I'm seeking information in regards to a large Linux implementation we are
> planning.  We have been evaluating many storage options and I've come up
> with some questions that I have been unable to answer as far as Linux
> capabilities in regards to storage.
> 
> We are looking at storage systems that provide approximately 1TB of capacity
> for now and can scale to 10+TB in the future.  We will almost certainly use
> a storage system that provides both fiber channel connectivity as well as
> NFS connectivity.
> 
> The questions that have been asked are as follows (assume 2.4.x kernels):
> 
> 1.  What is the largest block device that linux currently supports?  i.e.
> Can I create a single 1TB volume on my storage device and expect linux to
> see it and be able to format it?
> 

Yes.

[root@pdsfdv10 data]# df .
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/rza3            1046274600 889731608 146074448  86% /export/data

> 2.  Does linux have any problems with large (500GB+) NFS exports, how about
> large files over NFS?
> 

No.
[root@pdsflx002 pdsfdv10]# df .
Filesystem           1k-blocks      Used Available Use% Mounted on
pdsfdv10.nersc.gov:/export/data
                     1046274600 889731608 146074448  86% /auto/pdsfdv10

(same filesystem, via NFS)

files > 2gb need LFS support in ia32 environments.

> 3.  What filesystem would be best for such large volumes?  We currently use
> reirserfs on our internal system, but they generally have filesystems in the
> 18-30GB ranges and we're talking about potentially 10-20x that.  Should we
> look at JFS/XFS or others?
> 

ext2 works fine, you just have to wait about 3 hrs to FSCK a crashed
filesystem; ext3 also works fine.  Get a 2.2.18, apply the ext3 fs
patches, bang, your done.

reiserfs won't work via NFS, without kernel patches.

-- 
------------------------+--------------------------------------------------
Thomas Davis		| ASG Cluster guy
tadavis@lbl.gov		| 
(510) 486-4524		| "80 nodes and chugging Captain!"
