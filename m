Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281954AbRKUTIM>; Wed, 21 Nov 2001 14:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281943AbRKUTID>; Wed, 21 Nov 2001 14:08:03 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:55291 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281949AbRKUTHu>;
	Wed, 21 Nov 2001 14:07:50 -0500
Date: Wed, 21 Nov 2001 12:07:18 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Andi Kleen <ak@suse.de>
Cc: Alex Adriaanse <alex_a@caltech.edu>, linux-kernel@vger.kernel.org
Subject: Re: LFS stopped working
Message-ID: <20011121120718.R1308@lynx.no>
Mail-Followup-To: Andi Kleen <ak@suse.de>,
	Alex Adriaanse <alex_a@caltech.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <JIEIIHMANOCFHDAAHBHOOEOLCMAA.alex_a@caltech.edu.suse.lists.linux.kernel> <p737kss7eia.fsf@amdsim2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <p737kss7eia.fsf@amdsim2.suse.de>; from ak@suse.de on Thu, Nov 15, 2001 at 07:08:13AM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 15, 2001  07:08 +0100, Andi Kleen wrote:
> "Alex Adriaanse" <alex_a@caltech.edu> writes:
> > = 4095
> > write(1, "\0", 1)                       = -1 EFBIG (File too large)
> > --- SIGXFSZ (File size limit exceeded) ---
> > +++ killed by SIGXFSZ +++
> > 
> > I'm doing this on a ReiserFS filesystem, but trying it on an ext2 partition
> > yields the same results.
> > 
> > Any suggestions?
> 
> ulimit -f unlimited.
> 
> SIGXFSZ means you exceeded your quota. Somehow you managed to set your 
> file size quotas to 2GB. Set them to unlimited instead. It could be caused
> by same PAM module; e.g. pam_limits, check /etc/security/*

The problem is that the old getrlimit() syscall returns a max of 0x7fffffff
for the limit, while the kernel uses 0xffffffff for unlimited, so if you
do "setrlimit(getrlimit())" you may actually be going from a real unlimited
ulimit, to a "bogus" unlimited limit that the kernel will deny you on.

I think the fix is to simply ignore file limits when writing to block
devices.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

