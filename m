Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265445AbRGBWQK>; Mon, 2 Jul 2001 18:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265440AbRGBWQA>; Mon, 2 Jul 2001 18:16:00 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:56847 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265443AbRGBWPt>; Mon, 2 Jul 2001 18:15:49 -0400
Subject: Re: [RFC] I/O Access Abstractions
To: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Mon, 2 Jul 2001 23:15:27 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010702220848.12689@smtp.wanadoo.fr> from "Benjamin Herrenschmidt" at Jul 03, 2001 12:08:48 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15HByZ-0006hZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  - Parsing of this cookie on each inx/outx access, which can
> take a bit of time (typically looking up the host bridge)

It depends on the implementation obviously, but its typically something like

	take lock
	writew(port&0xFFFF, port&0xFFFF0000);
	writew(data, port&0xFFFF0000+1);
	drop lock

Assuming you can drop the bridges on 64K boundaries in pci mem space, or
one extra deref and a register load if not.

Can you give me an idea of what sort of cookie decoding a PPC/PMac would need
and why - Im working off things like pa-risc so I dont have a full picture.

