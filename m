Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282270AbRK2BkQ>; Wed, 28 Nov 2001 20:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282271AbRK2BkH>; Wed, 28 Nov 2001 20:40:07 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7172 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282270AbRK2Bjv>; Wed, 28 Nov 2001 20:39:51 -0500
Subject: Re: [PATCH] remove BKL from drivers' release functions
To: haveblue@us.ibm.com (David C. Hansen)
Date: Thu, 29 Nov 2001 01:47:47 +0000 (GMT)
Cc: rmk@arm.linux.org.uk (Russell King), linux-kernel@vger.kernel.org
In-Reply-To: <3C059087.9070900@us.ibm.com> from "David C. Hansen" at Nov 28, 2001 05:33:59 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E169GIl-0006tH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does everyone agree that we need to get the BKL out of common areas like 
> this?  For starters, what about adding a pair of spinlocks for block 

Ideally the BKL itself should die.

> devices and character devices to take the place of the BKL in 
> serializing opens?  Or, should we make it the driver's responsibility 
> completely?

It needs to be the drivers job, to be documented as such and to be
implemented properly in some drivers. In paticular there are some extremely
interesting closedown races in existing drivers where it goes


		CPU1			CPU2
	release
	[do slow thing]
					open
					ioctl
						setting stuff up
	slow thing done
	trash the chip setup
	turn the chip off
	return
					ouch bang splat Oops!!!

Alan
