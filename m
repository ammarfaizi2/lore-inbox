Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313967AbSDKCjC>; Wed, 10 Apr 2002 22:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313969AbSDKCjB>; Wed, 10 Apr 2002 22:39:01 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:38642
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S313967AbSDKCjB>; Wed, 10 Apr 2002 22:39:01 -0400
Date: Wed, 10 Apr 2002 19:41:11 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org,
        Keith Owens <kaos@ocs.com.au>
Subject: Re: RAID superblock confusion
Message-ID: <20020411024111.GL23513@matchmail.com>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	Richard Gooch <rgooch@ras.ucalgary.ca>,
	Andreas Dilger <adilger@clusterfs.com>,
	linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>
In-Reply-To: <200204101533.g3AFXwS09100@vindaloo.ras.ucalgary.ca> <20020410184010.GC3509@turbolinux.com> <200204101924.g3AJOp113305@vindaloo.ras.ucalgary.ca> <20020410193812.GE3509@turbolinux.com> <200204102037.g3AKbmT14222@vindaloo.ras.ucalgary.ca> <15540.59659.114876.390224@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2002 at 11:38:19AM +1000, Neil Brown wrote:
> autodetect is the other alternative.  However, as has been mentioned,
> it does not and cannot work with md as a module.  This is because
> devices can only be register for autodetection after md.o is loaded,
> and autodetection is done at the time that md is loaded.  So
> autodetection can only work if the device driver and md are loaded at
> simultaneously.  i.e. they are compiled into the kernel.

Ahh, but if you use initrd you can even have the ide and scsi drivers as
modules. 

What is needed is to make the disk modules depend on the raid modules (only
if the raid code is enabled of course) so that modprobe can load the raid
modules first. 

Then you'd just need to make sure that if there are any block modules linked
into the kernel that raid is also linked into the kernle instead of a module.

Is there some reason why this wouldn't work (except for CML1
complications...)?

Kieth, will kbuild2.5 affect this in any way?  Or is this entirely a CML2
thing? 

Mike
