Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271928AbRHVFHV>; Wed, 22 Aug 2001 01:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271929AbRHVFHL>; Wed, 22 Aug 2001 01:07:11 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:417 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S271928AbRHVFG4>; Wed, 22 Aug 2001 01:06:56 -0400
Date: Tue, 21 Aug 2001 23:07:06 -0600
Message-Id: <200108220507.f7M576q25412@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Taylor Carpenter <taylorcc@codecafe.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops when accessing /dev/fd0 (kernel 2.4.7 and devfsd 1.3.11)
In-Reply-To: <20010821223042.A30478@pioneer.oftheInter.net>
In-Reply-To: <20010816222811.A1672@pioneer.oftheInter.net>
	<200108170419.f7H4J7c20693@vindaloo.ras.ucalgary.ca>
	<20010821223042.A30478@pioneer.oftheInter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Taylor Carpenter writes:
> 
> On Thu, Aug 16, 2001 at 10:19:07PM -0600, Richard Gooch wrote:
> > If you think the problem may be devfs-related, a good test is to try
> > again with CONFIG_DEVFS_FS=n.
> 
> I tried kernel 2.4.8 and also had an oops.  An earlier kernel w/out devfs did
> not cause an oops.  I plan on making a non-devfs 2.4.8 kernel to see if the
> oops does not happen.
> 
> > However, I run devfs, and I don't see this problem.
> 
> I do not know if the devfs info, in the oops (ksymoops output) data below
> indicates a problem w/devfs or not.  Maybe you can tell?

Well, the following line suggests a devfs interaction (provided you
are sure that you used the correct System.map:
> Trace; c015469b <devfs_unregister_blkdev+12eb/1960>

Are you unloading the floppy driver at some point? Or using module
autoloading?

> After watching what happens during the boot process I started turning off
> things that might be touching the floppy device (at boot), such as autofs.
> What finally stopped the Oops was to comment out the floppy entry in
> /etc/fstab:
> 
> 	/dev/fd0 /floppy auto defaults,user,noauto 0 0

Interesting. What happens if you use /dev/floppy/0 instead of /dev/fd0
in the /etc/fstab? Still an Oops?

> I can then load the floppy module after boot, and successfully access the
> floppy device w/o any problems.  The oops happened when the mountall script
> (Debian testing) was running:
> 
> 	mount -avt nonfs,noproc,nosmbfs
> 
> Devfsd is started way before mountall is ran so I do not know why it is
> causing problems.

Strange. I tried the following sequence, without problems:
# devfsd /dev
# mount /floppy
# ls -lF /dev/floppy

where /etc/fstab has:
/dev/floppy/0  /floppy  ext2  defaults,noauto,user  0 0

I have nothing in my /etc/devfsd.conf which refers to the floppy. In
addition, I don't have any LOOKUP entries. I did this with 2.4.9 with
devfs-patch-v188.

Could you please try reproducing the problem with the setup and
sequence I used?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
