Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262268AbRERHuQ>; Fri, 18 May 2001 03:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262269AbRERHuG>; Fri, 18 May 2001 03:50:06 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:53514 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262268AbRERHuB>; Fri, 18 May 2001 03:50:01 -0400
Subject: Re: problem: reading from (rivafb) framebuffer is really slow
To: leitner@convergence.de (Felix von Leitner)
Date: Fri, 18 May 2001 08:46:38 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010518032923.A17686@convergence.de> from "Felix von Leitner" at May 18, 2001 03:29:23 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150ey6-0006nw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When benchmarking DirectFB, I found that a typical software alpha
> blending rectangle fill is completely dominated (I'm talking 90% of the
> CPU cycles here) by the time it takes to read pixels from the
> framebuffer.

I would expect that. Guess why X11 is designed not to do this.

> The pixels are read linearly in chunks of aligned 32-bit words.  It's a
> Geforce 2 GTS in 1024x768 with 32-bit color depth using rivafb.  This
> looks quite crass to me.  Any ideas?  Maybe rivafb does not initialize
> AGP and the card is in PCI mode or something?

Writes across the PCI bus are posted, and potentially merged. Read posting is
rather harder to do. This is one reason to keep copies of data or to use
DMA or textures from AGP space to speed up access to the data you need.

In general pci write = fast, pci read = slow. High performance subsystems
you write to their pci memory they DMA back to your main memory. 

Alan

