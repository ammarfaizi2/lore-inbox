Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290423AbSCCXep>; Sun, 3 Mar 2002 18:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290685AbSCCXee>; Sun, 3 Mar 2002 18:34:34 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15120 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290423AbSCCXeT>; Sun, 3 Mar 2002 18:34:19 -0500
Subject: Re: [RFC] Arch option to touch newly allocated pages
To: jdike@karaya.com (Jeff Dike)
Date: Sun, 3 Mar 2002 23:48:56 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <200203032327.SAA04176@ccure.karaya.com> from "Jeff Dike" at Mar 03, 2002 06:27:20 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16hfiq-0005qg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't have individual little map requests going on here.  I have a single
> large map happening at boot time which creates the UML "physical" memory
> area.  

Doesn't matter

> So, say I have a 128M UML which is only ever going to use 32M of that.  If 
> there isn't 128M of address space, but there is 32M, this UML will never
> get off the ground, even though it really deserved to.

Well thats up to you on how you implement it. mmap will tell you the truth
in overcommit mode 2 or 3. Nothing will get killed off when you try and
mmap too much or dirty pages you have.

> About the swap allocation, I'd bet essentially all the time when a page
> is allocated, its dirtiness is imminent anyway.  So, I'm not adding anything

Nothing of the sort. Sitting in a gnome desktop I'm showing a 41200Kb worst
case swap requirement, but it appears under half of that is used.

> to swap.  It'll be there a usec later anyway.  What I want is for the dirtying
> to happen in a controlled place where something sane can be done if the page
> isn't really there.

Like randomly killing another process off ? If you want to dirty the pages
pray and catch the sigbus then see memset(3). If you want to be told "sorry
you can't have that" and write a simple loop to pick a good memory size,
you need the address space accounting.


Alan
