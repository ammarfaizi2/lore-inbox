Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317467AbSGEOqs>; Fri, 5 Jul 2002 10:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317466AbSGEOqr>; Fri, 5 Jul 2002 10:46:47 -0400
Received: from [193.14.93.89] ([193.14.93.89]:37380 "HELO acolyte.hack.org")
	by vger.kernel.org with SMTP id <S317467AbSGEOqo>;
	Fri, 5 Jul 2002 10:46:44 -0400
To: Alan Cox <alan@www.linux.org.uk>
Cc: proski@gnu.org (Pavel Roskin), linux-kernel@vger.kernel.org,
       dhinds@sonic.net (David Hinds), mj@ucw.cz (Martin Mares)
Subject: Re: Cyrix IRQ routing is wrong?
References: <Pine.LNX.4.44.0207031946230.4282-100000@marabou.research.att.com>
	<E17QTp2-0004Ay-00@www.linux.org.uk>
From: Christer Weinigel <wingel@acolyte.hack.org>
Date: 05 Jul 2002 16:49:13 +0200
In-Reply-To: Alan Cox's message of "Fri, 5 Jul 2002 15:12:32 +0100 (BST)"
Message-ID: <m3wusa44d2.fsf@acolyte.hack.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@www.linux.org.uk> writes:

> > 1) 2.4.17 was using the code I want to restore.  Where was your hanging 
> > box then?
> 
> Hanging. Thats why I fixed it when Nat Semi documentation for the old cyrix
> appeared

So your BIOS probably has a buggy PIRQ table.  

>From page 155 of the CS5530 manual found at:

    http://www.national.com/ds/CS/CS5530.pdf

Index 5Ch PCI Interrupt Steering Register 1 (R/W) Reset Value = 00h

7:4 INTB# Target Interrupt: Selects target interrupt for INTB#
3:0 INTA# Target Interrupt: Selects target interrupt for INTA#

Index 5Dh PCI Interrupt Steering Register 2 (R/W) Reset Value = 00h
7:4 INTD# Target Interrupt: Selects target interrupt for INTD#
3:0 INTC# Target Interrupt: Selects target interrupt for INTC#

So I have to switch that code around on most GX1 boards that I use or
I'll get a lot of messages about IRQ routing conflicts.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"
