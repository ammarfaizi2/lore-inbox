Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270224AbRHWTlh>; Thu, 23 Aug 2001 15:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270221AbRHWTl2>; Thu, 23 Aug 2001 15:41:28 -0400
Received: from mail.zmailer.org ([194.252.70.162]:50701 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S270203AbRHWTlI>;
	Thu, 23 Aug 2001 15:41:08 -0400
Date: Thu, 23 Aug 2001 22:40:39 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: releasing driver to kernel in source+binary format
Message-ID: <20010823224039.U11046@mea-ext.zmailer.org>
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971880B3F@xsj02.sjs.agilent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971880B3F@xsj02.sjs.agilent.com>; from hiren_mehta@agilent.com on Thu, Aug 23, 2001 at 12:43:05PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2001 at 12:43:05PM -0600, MEHTA,HIREN (A-SanJose,ex1) wrote:
> Well, Qlogic also has their firmware released in binary format.
> Any comment on that ?

	That firmware is something which is run by the card itself,
	and appears as series of services which plain source C code
	driver executed by the Linux kernel then uses.
	Linux writes/reads something at magic locations, sends and
	receives interrupts, all that fun.

	If the card firmware is binary, I don't see any real problems
	(aside of purity of 'all in source').  Properly written drivers
	can be compiled and RUN at any hardware where Linux runs,
	including future changes in driver infrastructure.
	(Interrupts, semaphores, ...)

	For Linux kernel there is a ABI to the card firmware.
	It might not be very well documented, or explained, but
	a ABI it is none the less.

	Linux runs on lots of different processors/architectures/systems.
	A PCI card should be workable at any of them.

	Consider i386 series, and ia64.  Linux kernel won't be running
	in i386 mode for drivers, for just one example from intel
	product lines.


	What we are seeing with one particular .o  driver in Linux
	kernel is that users who use it are having problems due to
	*SOMETHING*, but we (linux kernel hacker community) can't
	figure it out when the vendor is unable to fix it.

	In recent hardware purchase this particular driver problem
	detail guided me to choose different component for the system.


> -hiren

	/Matti Aarnio

> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> Sent: Thursday, August 23, 2001 11:14 AM
> To: hiren_mehta@agilent.com
> Cc: linux-kernel@vger.kernel.org; linux-scsi@vger.kernel.org
> Subject: Re: releasing driver to kernel in source+binary format
> 
> > HBAs and make it part of the kernel source tree. Because of IP 
> > related issues, we can only release one part of the sources with 
> > GPL. We want to release the other part in the binary format (.o)
> > as a library which needs to be linked with the first part.
> > If somebody can advise me on how to go about this, I would
> > appreciate it. 
> 
> Very simple. You can't link GPL and proprietary code together. You may be
> able to make your code a non free module distributed by yourselves if you
> can satisfy your lawyers that it is a seperate work. Take that one up with
> your lawyers. Also remember that the kernel code is GPL, so if you based
> your driver on existing GPL code (eg by copying an existing scsi drivers
> code as a basis) you will also have to sort that issue out too.
> 
> > I went through the "SubmittingDrivers" file
> > which does not talk about this kind of special cases.
> 
> Thats becase Linux is free software. We don't merge binary only drivers, and
> only maintain source level compatibility between different compiles of the
> kernel.
> 
> The whole Linux concept is geared around free software, that means source
> code, source level compatibility, the ability for people to recompile and
> for sane debugging because we have all the sources.
> 
> Alan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
