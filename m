Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281514AbRKUUGy>; Wed, 21 Nov 2001 15:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281961AbRKUUGq>; Wed, 21 Nov 2001 15:06:46 -0500
Received: from chamber.cco.caltech.edu ([131.215.48.55]:42446 "EHLO
	chamber.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S281514AbRKUUGY>; Wed, 21 Nov 2001 15:06:24 -0500
From: "Alex Adriaanse" <alex_a@caltech.edu>
To: "Andreas Dilger" <adilger@turbolabs.com>, "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: LFS stopped working
Date: Wed, 21 Nov 2001 12:06:13 -0800
Message-ID: <JIEIIHMANOCFHDAAHBHOAEPJCMAA.alex_a@caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20011121120718.R1308@lynx.no>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Upgrading to Debian woody (with glibc 2.2) fixed the problem. :)

Thanks,

Alex

-----Original Message-----
From: Andreas Dilger [mailto:adilger@turbolabs.com]
Sent: Wednesday, November 21, 2001 11:07 AM
To: Andi Kleen
Cc: Alex Adriaanse; linux-kernel@vger.kernel.org
Subject: Re: LFS stopped working


On Nov 15, 2001  07:08 +0100, Andi Kleen wrote:
> "Alex Adriaanse" <alex_a@caltech.edu> writes:
> > = 4095
> > write(1, "\0", 1)                       = -1 EFBIG (File too large)
> > --- SIGXFSZ (File size limit exceeded) ---
> > +++ killed by SIGXFSZ +++
> >
> > I'm doing this on a ReiserFS filesystem, but trying it on an ext2
partition
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


