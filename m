Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318741AbSHWKoE>; Fri, 23 Aug 2002 06:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318743AbSHWKoE>; Fri, 23 Aug 2002 06:44:04 -0400
Received: from h-64-105-137-141.SNVACAID.covad.net ([64.105.137.141]:20631
	"EHLO freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S318741AbSHWKoD>; Fri, 23 Aug 2002 06:44:03 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 23 Aug 2002 03:48:06 -0700
Message-Id: <200208231048.DAA02646@adam.yggdrasil.com>
To: aebr@win.tue.nl
Subject: Re: IDE-flash device and hard disk on same controller
Cc: andre@linux-ide.org, ebiederm@xmission.com, jgarzik@mandrakesoft.com,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Date: Fri, 23 Aug 2002 11:54:21 +0200
>From: Andries Brouwer <aebr@win.tue.nl>

>Read e.g. ATA-6.

> [If things work well, they may well be fast. But you are only entitled
> to conclude that something is wrong after waiting for 31 s. In
> particular, if you want to detect device 1 (the slave device), then
> only after 31 s you know that it is absent.]

We're only talking about going fast if we detect that things have gone well.


>See for example the Device power-on or hardware reset state diagram in 9.1.

	Thanks for the reference.  Pointing to the actual standards
makes these discussions a lot more efficient.

	What I said to Andre about software reset also apparently
applies to hardware reset.

	The state diagram that you refer to for hardware reset is on
page 312 of ATA/ATAPI-6 revision 3b, 28 February 2002 and
page 85 of ATA/ATAPI-7 revision 0d, 8 July 2002.  As with
software reset, BSY is asserted within 400ns of reset being asserted
and remains set until the transition at the end of the diagram
(D0HR3:Set_Status --> Device_idle_S).

	So, I think that Eric Biederman's suggestion about waiting for
BSY to clear, so as to accomodate Power On Self Test that can complete
in under 31 seconds should be OK.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
