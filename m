Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267760AbUIAWhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267760AbUIAWhU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 18:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267443AbUIAWfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 18:35:11 -0400
Received: from the-village.bc.nu ([81.2.110.252]:28556 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267520AbUIAWaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 18:30:21 -0400
Subject: Re: MMC block major dev
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040901225503.A26520@flint.arm.linux.org.uk>
References: <4134CDF0.7070600@drzeus.cx>
	 <20040831201556.B11053@flint.arm.linux.org.uk> <4134D5EF.9080903@drzeus.cx>
	 <1094040990.2399.56.camel@localhost.localdomain>
	 <20040901225503.A26520@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094074082.3100.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 01 Sep 2004 22:28:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-01 at 22:55, Russell King wrote:
> Surely the same arguments also apply to character drivers as well?

Beats me but I had this argument before 1.0 was out and lost.

> >From what you're saying, any use of these dynamic majors what so
> ever is buggy.  So WTF do we have this facility in the kernel in
> the first place?

It makes sense if you have something truely managing your device space
like devfs or udev. 

> I suggest that someone submits a patch to rip out this apparantly
> buggy and useless feature, or at least make the kernel print a
> warning when its used such that people are aware of its dangerous
> nature.

Once everyone is using udev its useful. It also works out for devices
you never "give" to a user. The problem with MMC slots is they are the
kind of thing you want to hand out to a user on the console of a machine
in many situations.

> Of course, if you do rip out dynamic majors then you _will_ need
> to have an assigned major number for PCMCIA driver services, and
> probably a bunch of other stuff.

PCMCIA is very careful to create and remove its nodes and make sure they
don't ever become non root only.

> I also seem to remember hearing that we will only be using dynamically
> assigned device numbers in the new expanded device space.

If and when everyone has udev happy then yes - although LANANA is still
needed for name assignment between vendors. That or we give it to the
LSB, and personally I'd rather LANANA did it 8)

Alan

