Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWGWX47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWGWX47 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 19:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWGWX47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 19:56:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:24336 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751153AbWGWX47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 19:56:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=h/2cDiR2Hr3L4D6DcOORsuNXLC6B6AhqJeNfswKWgQh4siITM6ro+gULU/r6gOUYk62g4rAgghLu12FSLk0K0vlD9J6+EkrMKf5eg/TX5ZGPqlB0nFiW6DHqy7g19oQTU6UedSAXI67cBODxW2Og6CMfcaBkTpXBDCgkRvdFvt0=
Message-ID: <44C40CD3.80000@gmail.com>
Date: Mon, 24 Jul 2006 01:56:44 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: hnazfoo@googlemail.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent usage of uninitialized variable in transmeta
 cpu driver
References: <20060723214834.GA1484@leiferikson.gentoo>
In-Reply-To: <20060723214834.GA1484@leiferikson.gentoo>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Weiner napsal(a):
> This patch fixes a gcc-`uninitialized' warning in
> arch/i386/kernel/cpu/transmeta.c.

NACK.

Gcc bug, don't hide it (I don't really know, why cpu_rev is zeroed).

[Post only whitespace changes. And note that such changes should be in separated
patches.]

> 
> Signed-off-by: Johannes Weiner <hnazfoo@gmail.com>
> 
> ---
> 
> 
> ------------------------------------------------------------------------
> 
> diff --git a/arch/i386/kernel/cpu/transmeta.c b/arch/i386/kernel/cpu/transmeta.c
> index 7214c9b..5b71071 100644
> --- a/arch/i386/kernel/cpu/transmeta.c
> +++ b/arch/i386/kernel/cpu/transmeta.c
> @@ -17,9 +17,9 @@ static void __init init_transmeta(struct
>  
>  	/* Print CMS and CPU revision */
>  	max = cpuid_eax(0x80860000);
> -	cpu_rev = 0;
> +	cpu_rev = cpu_freq = 0;
>  	if ( max >= 0x80860001 ) {
> -		cpuid(0x80860001, &dummy, &cpu_rev, &cpu_freq, &cpu_flags); 
> +		cpuid(0x80860001, &dummy, &cpu_rev, &cpu_freq, &cpu_flags);
>  		if (cpu_rev != 0x02000000) {
>  			printk(KERN_INFO "CPU: Processor revision %u.%u.%u.%u, %u MHz\n",
>  				(cpu_rev >> 24) & 0xff,
> @@ -72,7 +72,7 @@ static void __init init_transmeta(struct
>  	wrmsr(0x80860004, ~0, uk);
>  	c->x86_capability[0] = cpuid_edx(0x00000001);
>  	wrmsr(0x80860004, cap_mask, uk);
> -	
> +
>  	/* If we can run i686 user-space code, call us an i686 */
>  #define USER686 (X86_FEATURE_TSC|X86_FEATURE_CX8|X86_FEATURE_CMOV)
>          if ( c->x86 == 5 && (c->x86_capability[0] & USER686) == USER686 )

regards,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
