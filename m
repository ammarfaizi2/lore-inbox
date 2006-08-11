Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWHKNJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWHKNJo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 09:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWHKNJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 09:09:44 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:12201 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751112AbWHKNJo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 09:09:44 -0400
Date: Fri, 11 Aug 2006 18:41:28 +0530
From: Rachita Kothiyal <rachita@in.ibm.com>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, fastboot@osdl.org,
       Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [RFC] ELF Relocatable x86 and x86_64 bzImages
Message-ID: <20060811131128.GA32007@in.ibm.com>
Reply-To: rachita@in.ibm.com
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com> <20060804225611.GG19244@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060804225611.GG19244@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 06:56:11PM -0400, Vivek Goyal wrote:
> 
> Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
> ---
> 
>  arch/i386/boot/compressed/head.S |   32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff -puN arch/i386/boot/compressed/head.S~debug1-patch arch/i386/boot/compressed/head.S
> --- linux-2.6.18-rc3-1M/arch/i386/boot/compressed/head.S~debug1-patch	2006-08-04 18:03:02.000000000 -0400
> +++ linux-2.6.18-rc3-1M-root/arch/i386/boot/compressed/head.S	2006-08-04 18:18:26.000000000 -0400
> @@ -60,13 +60,32 @@ startup_32:
>  	 * a relocatable kernel this is the delta to our load address otherwise
>  	 * this is the delta to CONFIG_PHYSICAL start.
>  	 */
> +
>  #ifdef CONFIG_RELOCTABLE
              ^^^^^^^^^
Vivek, did you mean CONFIG_RELOCATABLE ?


Thanks
Rachita

> +	/* If loaded by non kexec boot loader, then we will be loaded
> +	 * at 1MB fixed address. But probably the intention is to run
> +	 * from a address for which kernel has been compiled which can
> +	 * be non 1MB.
> +	 */
> +	xorl %eax, %eax
> +	movb 0x210(%esi), %al
> +
> +	/ * check boot loader type. Kexec bootloader id 9, version any */
> +	shrl $4, %eax
> +	subl $0x9, %eax
> +	jnz  1f
