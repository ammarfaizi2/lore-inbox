Return-Path: <linux-kernel-owner+w=401wt.eu-S936393AbWLIItr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936393AbWLIItr (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 03:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936396AbWLIItr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 03:49:47 -0500
Received: from smtp.osdl.org ([65.172.181.25]:57126 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936393AbWLIItq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 03:49:46 -0500
Date: Sat, 9 Dec 2006 00:49:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, phil.el@wanadoo.fr, ak@suse.de
Subject: Re: [PATCH] x86 smp: export smp_num_siblings for oprofile
Message-Id: <20061209004939.85d72e2c.akpm@osdl.org>
In-Reply-To: <20061209003424.cecc58a4.randy.dunlap@oracle.com>
References: <20061209003424.cecc58a4.randy.dunlap@oracle.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2006 00:34:24 -0800
Randy Dunlap <randy.dunlap@oracle.com> wrote:

> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> oprofile uses smp_num_siblings without testing for CONFIG_X86_HT.
> I looked at modifying oprofile, but this way is cleaner & simpler
> and I didn't see a good reason not to just export it when CONFIG_SMP.
> 
> WARNING: "smp_num_siblings" [arch/i386/oprofile/oprofile.ko] undefined!
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  arch/i386/kernel/smpboot.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2.6.19-git13.orig/arch/i386/kernel/smpboot.c
> +++ linux-2.6.19-git13/arch/i386/kernel/smpboot.c
> @@ -69,7 +69,7 @@ static int __devinitdata smp_b_stepping;
>  
>  /* Number of siblings per CPU package */
>  int smp_num_siblings = 1;
> -#ifdef CONFIG_X86_HT
> +#ifdef CONFIG_SMP
>  EXPORT_SYMBOL(smp_num_siblings);
>  #endif

smpboot.c isn't compiled if CONFIG_SMP=n, so I'll just remove the ifdef,
thanks.
