Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292133AbSBAX0P>; Fri, 1 Feb 2002 18:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292134AbSBAX0E>; Fri, 1 Feb 2002 18:26:04 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5900 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292133AbSBAXZs>; Fri, 1 Feb 2002 18:25:48 -0500
Subject: Re: [PATCH] IBM Lanstreamer bugfixes
To: yoder1@us.ibm.com (Kent E Yoder)
Date: Fri, 1 Feb 2002 23:38:38 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org
In-Reply-To: <OFB91B46B3.DE7448D0-ON85256B53.0071158D@raleigh.ibm.com> from "Kent E Yoder" at Feb 01, 2002 02:53:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16WnGQ-0006T1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> what purpose does the volatile below serve? 
> 
> io.h:122:#define writew(b,addr) (*(volatile unsigned short *) 
> __io_virt(addr) = (b))X
> 
> Is this a sort of "go do this now" command to flush it from the CPU to the 
> PCI bus, while the readw() makes sure its flushed out of the PCI cache? 

The compiler isnt obliged to actually generate the assignment in order
otherwise, so given

	writew(1, foo+2);
	writew(2, foo);

it might have the urge to reverse them - perhaps to optimise in using
postincrement modes

volatile says "stuff happens here beyond the compilers direct knowledge of
events".

Simple example

	i=0;
	while(i<100000) i++;

can be optimised to i=100000 if i is not volatile

Alan
