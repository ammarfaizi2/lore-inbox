Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264954AbTLKNvn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 08:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264949AbTLKNvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 08:51:43 -0500
Received: from math.ut.ee ([193.40.5.125]:47552 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S264954AbTLKNvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 08:51:41 -0500
Date: Thu, 11 Dec 2003 15:51:34 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Tom Rini <trini@kernel.crashing.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: PPC & 2.6.0-test3: wrong mem size & hang on ifconfig
In-Reply-To: <20031210161142.GE23731@stop.crashing.org>
Message-ID: <Pine.GSO.4.44.0312111357130.24419-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ===== arch/ppc/boot/prep/misc.c 1.14 vs edited =====
> --- 1.14/arch/ppc/boot/prep/misc.c	Mon Oct 20 11:49:35 2003
> +++ edited/arch/ppc/boot/prep/misc.c	Wed Dec 10 09:11:05 2003
> @@ -251,15 +251,21 @@
>  		{
>  			phandle dev_handle;
>  			int mem_info[2];
> +			int n;
> +			puts("Trying OF\n");
>
>  			/* get handle to memory description */
>  			if (!(dev_handle = finddevice("/memory@0")))
>  				break;
> +			puts("Found /memory@0\n");
>
>  			/* get the info */
>  			if (getprop(dev_handle, "reg", mem_info,
> -						sizeof(mem_info) != 8))
> +						sizeof(mem_info) != 8)) {
> +				puts("n = 0x");puthex(n);puts("\n");
>  				break;
> +			}
> +			puts("Found reg prop\n");

Are you sure that n really gets a value?

It prints
Found /memory@0
n = 0x00000000

and nothinf about reg prop as the code tells. What do you actually mean
by n?

-- 
Meelis Roos (mroos@linux.ee)


