Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262709AbREOJoW>; Tue, 15 May 2001 05:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262710AbREOJoM>; Tue, 15 May 2001 05:44:12 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43790 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262709AbREOJoD>; Tue, 15 May 2001 05:44:03 -0400
Subject: Re: Memory Access Problem
To: Rich.Liu@ite.com.tw
Date: Tue, 15 May 2001 10:40:41 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <412C066DD818D3118D4300805FD4667902090B77@ITEMAIL> from "Rich.Liu@ite.com.tw" at May 15, 2001 02:36:51 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zbJp-0002Gu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I use readw to access memory below 1MB , report "Segmentation fault"
> and stall in memory
> 
> simple code below (this will get paraller port)
> ==
> int init_module(void){
> 	unsigned int   *BIOS_Data=(unsigned int *)0x400;
> 	u32 test;
>                 test = readw(BIOS_Data);
> 
> 	 printk(KERN_CRIT  "0x400:%x\n",test);
> }
> ==
> but those can work in kernel 2.2.19 , no problem .
> 
> can anyone help me ?

2.2 had back compatibility support for old drivers that did this 2.4 does
not.

	readb() is for bus accesses after mapping with ioremap
	isa_readb() is a quick form for ISA bus which is always mapped

For main memory you want to use
	phys_to_virt()

to get the virtual mapping of the page. That will work for the BIOS page but
not for arbitary higher pages which may not even be mapped.



