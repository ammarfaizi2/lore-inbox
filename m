Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135354AbRDWPan>; Mon, 23 Apr 2001 11:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135363AbRDWPae>; Mon, 23 Apr 2001 11:30:34 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:51717 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135353AbRDWPaZ>; Mon, 23 Apr 2001 11:30:25 -0400
Subject: Re: P4 problem with 2.4.3
To: clarkmic@pobox.upenn.edu (Michael J Clark)
Date: Mon, 23 Apr 2001 16:32:08 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200104231340.f3NDeJu29169@pobox.upenn.edu> from "Michael J Clark" at Apr 23, 2001 09:40:19 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14riJv-0008FV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> dies at the line "cpu:0, clocks:0, slice:0".  It also says something about 
> "wierd, boot kernel (CPU#0) not found in BIOS. "  There is also a message 

This message is printed when the kernel finds it is running on a processor
not listed in the MP table. Basically your machine seems to have broken MP
tables. 

What is happening is something like this

	Kernel:		Find MP table
			Ok We have CPUs 1 and 2
			We have PCI
			We have etc...

	Kernel:		What CPU number are you
	CPU:		Im CPU 0
	Kernel:		but you dont exist..

		** boom **

Try booting with 'noapic' and also send a report to Ingo Molnar as he may want
to double check the table is wrong not the kernel code. 

2.2 doesn't use the APIC on non SMP boxes so won't notice the problem.


