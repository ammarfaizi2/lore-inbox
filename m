Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290587AbSCCXYx>; Sun, 3 Mar 2002 18:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290423AbSCCXYe>; Sun, 3 Mar 2002 18:24:34 -0500
Received: from mnh-1-08.mv.com ([207.22.10.40]:1802 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S290333AbSCCXY0>;
	Sun, 3 Mar 2002 18:24:26 -0500
Message-Id: <200203032327.SAA04176@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages 
In-Reply-To: Your message of "Sun, 03 Mar 2002 22:01:30 GMT."
             <E16he2s-0005ak-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 03 Mar 2002 18:27:20 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@lxorguk.ukuu.org.uk said:
> No - you think you want to dirty the pages - you want to account the
> address space. What you want to do is run 2.4.18ac3 and do
> 	echo "2" > /proc/sys/vm/overcommit_memory
> which on a good day will give you overcommit protection. Your map
> requests will fail without the pages being dirtied and the extra swap
> that would cause.

That doesn't sound right to me.

I don't have individual little map requests going on here.  I have a single
large map happening at boot time which creates the UML "physical" memory
area.  

So, say I have a 128M UML which is only ever going to use 32M of that.  If 
there isn't 128M of address space, but there is 32M, this UML will never
get off the ground, even though it really deserved to.

About the swap allocation, I'd bet essentially all the time when a page
is allocated, its dirtiness is imminent anyway.  So, I'm not adding anything
to swap.  It'll be there a usec later anyway.  What I want is for the dirtying
to happen in a controlled place where something sane can be done if the page
isn't really there.

				Jeff

