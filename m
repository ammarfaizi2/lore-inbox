Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315961AbSEGUHs>; Tue, 7 May 2002 16:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315962AbSEGUHr>; Tue, 7 May 2002 16:07:47 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56325 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315961AbSEGUHq>; Tue, 7 May 2002 16:07:46 -0400
Subject: Re: Memory Barrier Definitions
To: engebret@vnet.ibm.com (Dave Engebretsen)
Date: Tue, 7 May 2002 21:27:04 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3CD830BE.CAB7FA96@vnet.ibm.com> from "Dave Engebretsen" at May 07, 2002 02:53:34 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E175BY8-0008S4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> forms of processor memory barrier instructions.  It is _very_ expensive
> to blindly force all memory references to be ordered completely to the
> seperate spaces.  The use of wmb(), rmb(), and mb() is overloaded in the
> context of PowerPC.

I think I follow

You have

	Compiler ordering
	CPU v CPU memory ordering
	CPU v I/O memory ordering
	I/O v I/O memory ordering

and our current heirarchy is a little bit more squashed than that. I'd 
agree. We actually hit a corner case of this on the IDT winchip x86 where
we run relaxed store ordering and have to define wmb() as a locked add of
zero to the top of stack - which does have a penalty that isnt needed
for CPU ordering.

How much of this impacts Mips64 ?

Alan


