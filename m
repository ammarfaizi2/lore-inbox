Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131173AbQK0PXP>; Mon, 27 Nov 2000 10:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132109AbQK0PXF>; Mon, 27 Nov 2000 10:23:05 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61038 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S132104AbQK0PWw>; Mon, 27 Nov 2000 10:22:52 -0500
Subject: Re: [Oops] apic, smp and k6
To: Torsten.Duwe@caldera.de
Date: Mon, 27 Nov 2000 14:52:51 +0000 (GMT)
Cc: aj@dungeon.inka.de (Andreas Jellinghaus), linux-kernel@vger.kernel.org
In-Reply-To: <14882.27508.534457.187156@ns.caldera.de> from "Torsten Duwe" at Nov 27, 2000 03:11:00 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E140PeH-0003AW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> while now with an appropriate patch. Now Christoph Hellwig has identifi=
> ed a
> simpler solution (updated for -test11 by me):
> 
> --- linux/arch/i386/kernel/setup.c~	Fri Jul  7 04:42:06 2000
> +++ linux/arch/i386/kernel/setup.c	Tue Jul 18 19:22:48 2000
> @@ -785,7 +785,8 @@
>  	/*
>  	 * get boot-time SMP configuration:
>  	 */
> -	if (smp_found_config)
> +	if (smp_found_config && /* try only if the cpu has a local apic */
> +	    test_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability))
>  		get_smp_config();

This patch unfortunately does break some real setups, since it is legal to
have non APIC on the CPU but an APIC as an addon chip.

> I think Alan has a similar thing in his test11-ac* series.

Maciej Rozycki provided a much better test, that from reports so far seems
to be working

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
