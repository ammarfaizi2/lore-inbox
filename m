Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261371AbSJUNqg>; Mon, 21 Oct 2002 09:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261394AbSJUNpD>; Mon, 21 Oct 2002 09:45:03 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:18868 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261393AbSJUNoj>; Mon, 21 Oct 2002 09:44:39 -0400
Subject: Re: NatSemi Geode improvement
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hiroshi Miura <miura@da-cha.org>
Cc: davej@suse.de, hpa@zytor.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021017171217.4749211782A@triton2>
References: <20021017171217.4749211782A@triton2>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 15:06:18 +0100
Message-Id: <1035209178.27318.118.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +     printk(KERN_INFO "Enable Memory access reorder on Cyrix/NSC processor.\n");
> +     local_irq_save(flags);
> +     ccr3 = getCx86(CX86_CCR3);
> +     setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10); /* enable MAPEN  */
> +     /* Load/Store Serialize to mem access disable (=reorder it)  */
> +     setCx86(CX86_PCR0, getCx86(CX86_PCR0) & ~0x80);
> +#ifdef CONFIG_NOHIGHMEM
> +     /* set load/store serialize from 1GB to 4GB */
> +     ccr3 |= 0xe0;
> +#endif
> +     setCx86(CX86_CCR3, ccr3);

I dont think this is safe. You now need store fences on bus mastering
DMA. You should be able to reuse the IDT winchip code for that - I set
the winchip up for weak store ordering too, and its a big win (I also
saw about 30% on block copies)

Alan

