Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268813AbRHTMeV>; Mon, 20 Aug 2001 08:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269770AbRHTMeB>; Mon, 20 Aug 2001 08:34:01 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12295 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268813AbRHTMdz>; Mon, 20 Aug 2001 08:33:55 -0400
Subject: Re: On Network Drivers......
To: vvgkrishna_78@yahoo.com (Venu Gopal Krishna Vemula)
Date: Mon, 20 Aug 2001 13:36:58 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Venu Gopal Krishna Vemula" at Aug 20, 2001 05:14:09 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15YoId-0005y8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  A driver of layered one.., in which one layer
> communicates with another. But overall there should be
> only one driver . (Just like Stream's drivers, but we
> don't want Stream Drivers). 
>     Is there any support in Linux to implement Network
> Drivers as multi layered in a single driver .If so,
> please let me know where I can get good information?

We have a single layer between the network stack and the drivers. However
nothing stops drivers from implementing multiple layers internally or
calling back into other drivers. shaper is an example of a driver that
calls other drivers.

The basic attitude is layering is slow, and generally poor for the cache
behaviour. You want to do a single pass of the packet (or less if possible
when using DMA). However the interface is flexible and if a driver wants
to be layered or has reason for it - sure it can do it internally


