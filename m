Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310859AbSCHNKP>; Fri, 8 Mar 2002 08:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310850AbSCHNKF>; Fri, 8 Mar 2002 08:10:05 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21003 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310860AbSCHNJx>; Fri, 8 Mar 2002 08:09:53 -0500
Subject: Re: [PATCH] Submitting PROMISE IDE Controllers Driver Patch
To: hanky@promise.com.tw (Hank Yang)
Date: Fri, 8 Mar 2002 13:25:05 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), arjanv@redhat.com,
        linux-kernel@vger.kernel.org, linusc@promise.com.tw (Linus Chen)
In-Reply-To: <010c01c1c64d$85550e90$59cca8c0@hank> from "Hank Yang" at Mar 08, 2002 11:01:18 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16jKMr-0006AG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The ataraid driver in the standard kernel requires the IDE drive is seen
> > by the ide layer otherwise ataraid cannot bind it into a raid module
> 
> First, the IDE driver doesn't check the controller's class code is raid
> controller (0x0104) or other controller(0x0180). So If our raid controller
> (FastTrak series) be seen by IDE driver. It will snatch the same IRQ.
> It will cause our trouble.

It wants to. What happens is this

-	The IDE layer detects the raid chip
-	We check it isnt a supertrak hardware raid
-	If it isnt we add the chips as basic ide devices
-	The ataraid module loaded on top of those opens the ide disks and
	hunts for promise and hpt raid descriptors
-	When it finds the raid descriptor it creates an additional
	/dev/ataraid/.... device

Because our ataraid driver actually sits on top of the existing IDE drivers it
requires they grab the devices. This also allows end users to issue commands
directly to the drives (for example for SMART)

Alan
