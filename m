Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289353AbSA2OZn>; Tue, 29 Jan 2002 09:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289372AbSA2OYx>; Tue, 29 Jan 2002 09:24:53 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1284 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289353AbSA2OYq>; Tue, 29 Jan 2002 09:24:46 -0500
Subject: Re: pagecoloring: kernel 2.2 mm question: what is happening during fork ?
To: Sebastien.Cabaniols@Compaq.com (Cabaniols, Sebastien)
Date: Tue, 29 Jan 2002 14:37:13 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <11EB52F86530894F98FFB1E21F9972540C239A@aeoexc01.emea.cpqcorp.net> from "Cabaniols, Sebastien" at Jan 29, 2002 02:36:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16VZNp-00044g-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When I do a fork, which part of the kernel is allocating the memory for
> the childs, where and when the memory copy takes place ? I know that
> linux is doing copy on write but I don't know which part of the kernel
> is really doing the page allocation when the copy on write understands
> that the process really wants to write now. Then the second question is
> how is the memory copy done ?

The page fault handler. When you write to a copy on write page its actually
marked read-only in the hardware. The kernel copies the page marks both
copies writable and fixes up the fault so that user space doesn't see anything
happen.

Alan
