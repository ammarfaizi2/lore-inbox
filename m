Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbULGWbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbULGWbZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 17:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbULGWbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 17:31:25 -0500
Received: from gate.crashing.org ([63.228.1.57]:10113 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261949AbULGWbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 17:31:22 -0500
Subject: Re: [PATCH] PPC64 Close firmware stdin
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <200412071904.iB7J4DOj023759@hera.kernel.org>
References: <200412071904.iB7J4DOj023759@hera.kernel.org>
Content-Type: text/plain
Date: Wed, 08 Dec 2004 09:30:48 +1100
Message-Id: <1102458649.11516.35.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-07 at 18:15 +0000, Linux Kernel Mailing List wrote:
> ChangeSet 1.2146, 2004/12/07 10:15:41-08:00, paulus@samba.org
> 
> 	[PATCH] PPC64 Close firmware stdin

	.../...

I think you merged that one twice :)

Ben.

> 
> diff -Nru a/arch/ppc64/kernel/prom_init.c b/arch/ppc64/kernel/prom_init.c
> --- a/arch/ppc64/kernel/prom_init.c	2004-12-07 11:04:26 -08:00
> +++ b/arch/ppc64/kernel/prom_init.c	2004-12-07 11:04:26 -08:00
> @@ -1118,6 +1118,16 @@
>  		call_prom("close", 1, 0, val);
>  }
>  
> +static void __init prom_close_stdin(void)
> +{
> +	unsigned long offset = reloc_offset();
> +	struct prom_t *_prom = PTRRELOC(&prom);
> +	ihandle val;
> +
> +	if (prom_getprop(_prom->chosen, "stdin", &val, sizeof(val)) > 0)
> +		call_prom("close", 1, 0, val);
> +}
> +
>  static int __init prom_find_machine_type(void)
>  {
>  	unsigned long offset = reloc_offset();
> @@ -1695,6 +1705,9 @@
>  	 */
>         	prom_printf("copying OF device tree ...\n");
>         	flatten_device_tree();
> +
> +	/* in case stdin is USB and still active on IBM machines... */
> +	prom_close_stdin();
>  
>  	/* in case stdin is USB and still active on IBM machines... */
>  	prom_close_stdin();
> -
> To unsubscribe from this list: send the line "unsubscribe bk-commits-head" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

