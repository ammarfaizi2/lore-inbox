Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281005AbRLDRL0>; Tue, 4 Dec 2001 12:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281202AbRLDRJ6>; Tue, 4 Dec 2001 12:09:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42244 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281077AbRLDRJc>; Tue, 4 Dec 2001 12:09:32 -0500
Subject: Re: [Linux-ia64] patch to no longer use ia64's software mmu
To: davidm@hpl.hp.com
Date: Tue, 4 Dec 2001 17:18:17 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), arjanv@redhat.com (Arjan van de Ven),
        linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org,
        marcelo@conectiva.com.br, davem@redhat.com
In-Reply-To: <15372.63827.716885.948119@napali.hpl.hp.com> from "David Mosberger" at Dec 04, 2001 08:26:59 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BJCz-0002jc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think the issue at hand is whether, longer term, it is desirable to
> move all bounce buffer handling into the PCI DMA layer or whether
> Linux should continue to make bounce buffer management visible to
> drivers.  I'd be interested in hearing opinions.

I think the performance figures we see currently answer that already. Bounce
management in a sense is PCI layer, but its PCI layer in the sense of
helpers called by subsystems or devices not as a global layer in the middle.

On a box with 32bit limited cards you need to do zone stuff and play with
the high zone even though your kmap is a nop. It's not ideal but its the
real world. IA64 also needs to correct its GFP_DMA to mean "low 16Mb" for
ISA DMA. While there is no ISA DMA on ia64 (thankfully) many PCI cards have
26-31 bit limits.

Alan
