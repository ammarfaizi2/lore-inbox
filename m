Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264270AbUEXM2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264270AbUEXM2W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 08:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264271AbUEXM2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 08:28:21 -0400
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:57481 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S264270AbUEXM2U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 08:28:20 -0400
Date: Mon, 24 May 2004 14:28:19 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, willy@w.ods.org, linux-kernel@vger.kernel.org
Subject: Re: i486 emu in mainline?
In-Reply-To: <20040522234059.GA3735@infradead.org>
Message-ID: <Pine.LNX.4.55.0405241419540.4876@jurand.ds.pg.gda.pl>
References: <20040522234059.GA3735@infradead.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 May 2004, Christoph Hellwig wrote:

> +			/* we'll verify if this is a BSWAP opcode, main source of SIGILL on 386's */
> +			if ((*eip & 0xF8) == 0xC8) {  /* BSWAP */
> +				u8 reg;
> +
> +				reg = *eip++ & 0x07;
> +				src = reg_address(regs, 1, reg);
> +				
> +				__asm__ __volatile__ (
> +						      "xchgb %%al, %%ah\n\t"
> +						      "roll $16, %%eax\n\t"
> +						      "xchgb %%al, %%ah\n\t"
> +						      : "=a" (*(u32*)src)
> +						      : "a" (*(u32*)src));
> +				regs->eip = (u32)eip;
> +				goto out;
> +			}

 You've forgotten about the 16-bit variant here -- the emulation is wrong 
with PREFIX_D32.  This may not matter much in practice, though.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
