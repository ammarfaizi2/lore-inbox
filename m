Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313970AbSDKDPh>; Wed, 10 Apr 2002 23:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313971AbSDKDPg>; Wed, 10 Apr 2002 23:15:36 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:6563 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S313970AbSDKDPg>; Wed, 10 Apr 2002 23:15:36 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Mike Fedyk <mfedyk@matchmail.com>
Date: Thu, 11 Apr 2002 13:18:33 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15541.137.92102.72095@notabene.cse.unsw.edu.au>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org,
        Keith Owens <kaos@ocs.com.au>
Subject: Re: RAID superblock confusion
In-Reply-To: message from Mike Fedyk on Wednesday April 10
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday April 10, mfedyk@matchmail.com wrote:
> On Thu, Apr 11, 2002 at 11:38:19AM +1000, Neil Brown wrote:
> > autodetect is the other alternative.  However, as has been mentioned,
> > it does not and cannot work with md as a module.  This is because
> > devices can only be register for autodetection after md.o is loaded,
> > and autodetection is done at the time that md is loaded.  So
> > autodetection can only work if the device driver and md are loaded at
> > simultaneously.  i.e. they are compiled into the kernel.
> 
> Ahh, but if you use initrd you can even have the ide and scsi drivers as
> modules. 
> 
> What is needed is to make the disk modules depend on the raid modules (only
> if the raid code is enabled of course) so that modprobe can load the raid
> modules first. 
> 
> Then you'd just need to make sure that if there are any block modules linked
> into the kernel that raid is also linked into the kernle instead of
> a module.

Woah... I think you are going off the deep end here.  This sounds just
too complicated.

1/ If you wanted to do autodetect "right", you would make it look a
   lot like partition detection (split md into two bits. A partition
   detection personality that registers the component devices
   somewhere, and the main raid module that gets autoloaded when you
   try to actually access a raid device).
2/ Partition detection *should* be done in user-space.  So should
   autodetect. mdadm does that for you..

NeilBrown
