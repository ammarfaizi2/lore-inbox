Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbUDXBrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbUDXBrZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 21:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbUDXBrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 21:47:25 -0400
Received: from gate.crashing.org ([63.228.1.57]:18374 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261821AbUDXBrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 21:47:24 -0400
Subject: Re: Si3112 S-ATA bug preventing use of udma5.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brenden Matthews <brenden@rty.ca>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <42822.68.144.162.3.1082757748.squirrel@webmail.rty.ca>
References: <42822.68.144.162.3.1082757748.squirrel@webmail.rty.ca>
Content-Type: text/plain
Message-Id: <1082771045.10727.46.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 24 Apr 2004 11:44:06 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Incase the link is down/broken, to fix the bug change line 269 of
> drivers/ide/pci/siimage.c from:
> 
>         u32 speedt              = 0;
> 
> to:
>         u16 speedt              = 0;

> The crux of the problem is that the first arguent to OUTW (out WORD)
> was a doubleword. The arguments were getting all screwed up on the stack.
> The lower order 16-bit were being used in the second argument of OUTW,
> and the upper order word was being used as the whole first argument,
> which was always 0000. So basically the on-disk controller was being
> programmed with erroneous settings. This fixes it and SATA on the SiI3112
> is now good on Linux. Apply this fix to linux/drivers/ide/pci/siimage.c
> and recompile your Kernel for SATA love.

Hrm... that's strange. I'd tend to think it's a bogus definition
of outw on this architecture (x86 ?) instead. an u32 should be casted
down to u16 without problem.


Ben.


