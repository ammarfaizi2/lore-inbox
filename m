Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbWG2OgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWG2OgG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 10:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWG2OgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 10:36:06 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:37979 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751370AbWG2OgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 10:36:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qyUzxsKWJA3opGsyecolkTngJgV0e2h2TYfiXQbYbrKqfyS6mQ14c23B1Aw4N7dszT/NOJWuCR34dO2PvgL+w55J/hYc4Ck5dNYW5LkLdzO/MwdE+6CPxS7v5Mig1WAMKUPCBidhUUmRe6CawxXVrhq40OBM/4VdWRBTjhbQH14=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: 2.6.18-rc2-git7 build error with CONFIG_STACK_UNWIND enabled
Date: Sat, 29 Jul 2006 16:37:10 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <9a8748490607290641r51085a69vbea4192136f64e7c@mail.gmail.com> <20060729142648.GH6843@martell.zuzino.mipt.ru>
In-Reply-To: <20060729142648.GH6843@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607291637.10282.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 July 2006 16:26, Alexey Dobriyan wrote:
> On Sat, Jul 29, 2006 at 03:41:46PM +0200, Jesper Juhl wrote:
> > With 2.6.18-rc2-git7 I get the following build error if I have
> > CONFIG_STACK_UNWIND enabled :
> > 
> >  CC      arch/i386/kernel/traps.o
> > arch/i386/kernel/traps.c: In function `show_trace_log_lvl':
> > arch/i386/kernel/traps.c:193: error: invalid type argument of `->'
> > arch/i386/kernel/traps.c:196: error: invalid type argument of `->'
> > arch/i386/kernel/traps.c:197: error: invalid type argument of `->'
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> 
> --- a/arch/i386/kernel/traps.c
> +++ b/arch/i386/kernel/traps.c
> @@ -190,11 +190,11 @@ static void show_trace_log_lvl(struct ta
>  		if (unw_ret > 0 && !arch_unw_user_mode(&info)) {
>  #ifdef CONFIG_STACK_UNWIND
>  			print_symbol("DWARF2 unwinder stuck at %s\n",
> -				     UNW_PC(info.regs));
> +				     UNW_PC(&info));
>  			if (call_trace == 1) {
>  				printk("Leftover inexact backtrace:\n");
> -				if (UNW_SP(info.regs))
> -					stack = (void *)UNW_SP(info.regs);
> +				if (UNW_SP(&info))
> +					stack = (void *)UNW_SP(&info);
>  			} else if (call_trace > 1)
>  				return;
>  			else
> 
> 
I can confirm that this fixes the build error.
Thanks Alexey.

/ Jesper Juhl <jesper.juhl@gmail.com> /

