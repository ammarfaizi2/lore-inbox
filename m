Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262162AbREPX4M>; Wed, 16 May 2001 19:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262160AbREPX4E>; Wed, 16 May 2001 19:56:04 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:49669 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262162AbREPXzs>; Wed, 16 May 2001 19:55:48 -0400
Message-ID: <3B03137A.80221C59@transmeta.com>
Date: Wed, 16 May 2001 16:55:38 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <200105152141.f4FLff300686@vindaloo.ras.ucalgary.ca>
		<Pine.LNX.4.05.10105160921220.23225-100000@callisto.of.borg>
		<200105161822.f4GIMo509185@vindaloo.ras.ucalgary.ca>
		<3B02D6AB.E381D317@transmeta.com>
		<200105162001.f4GK18X10128@vindaloo.ras.ucalgary.ca>
		<3B02DD79.7B840A5B@transmeta.com>
		<200105162054.f4GKsaF10834@vindaloo.ras.ucalgary.ca>
		<3B02F2EC.F189923@transmeta.com>
		<20010517001155.H806@nightmaster.csn.tu-chemnitz.de>
		<3B02FBA6.86969BDE@transmeta.com>
		<200105162303.f4GN3n212178@vindaloo.ras.ucalgary.ca>
		<3B030C76.40BB4558@transmeta.com>
		<200105162337.f4GNb0j12743@vindaloo.ras.ucalgary.ca>
		<3B030F86.EDA45D1A@transmeta.com>
		<200105162341.f4GNfvT12861@vindaloo.ras.ucalgary.ca>
		<3B0310A4.87138FB5@transmeta.com> <200105162349.f4GNnSJ13049@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> OK. How do you figure on dealing with the problem of multiple
> high-level drivers talking to the same device? How does sr.o "know"
> that this is also a CD-RW? How does sg.o "know" that this is also a
> tape?
> 

At some point something talks to the device -- in this case, it's the
SCSI layer.  Follow the interfaces in the kernel and it becomes obvious.

> Where does the responsibility lie for figuring out the capabilities?
> 
> Further, which device node/fs/driver exports the capability list?
> 
> And what about locking between drivers?

Orthogonal issue.  You may want a locking mechanism, but it almost
certainly should not be automatic.

Note that especially ide-scsi is a good example on how *not* to do
things.  The fact that you have to choose one of two interfaces for
different operations (I can't use a CD-writer in the default
configuration!) is insane.

	-hpa


-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
