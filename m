Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312470AbSCUUFf>; Thu, 21 Mar 2002 15:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312467AbSCUUF0>; Thu, 21 Mar 2002 15:05:26 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:19150 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S312469AbSCUUFK>; Thu, 21 Mar 2002 15:05:10 -0500
Date: Thu, 21 Mar 2002 21:01:39 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: alan@lxorguk.ukuu.org.uk, marcelo@conectiva.com.br, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] boot_cpu_data corruption on SMP x86
In-Reply-To: <200203141724.SAA05707@harpo.it.uu.se>
Message-ID: <Pine.GSO.3.96.1020321205927.22279J-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2002, Mikael Pettersson wrote:

> --- linux-2.4.19-pre3/arch/i386/kernel/head.S.~1~	Tue Feb 26 13:26:56 2002
> +++ linux-2.4.19-pre3/arch/i386/kernel/head.S	Thu Mar 14 16:20:57 2002
> @@ -178,7 +178,7 @@
>   * we don't need to preserve eflags.
>   */
>  
> -	movl $3,X86		# at least 386
> +	movb $3,X86		# at least 386
>  	pushfl			# push EFLAGS
>  	popl %eax		# get EFLAGS
>  	movl %eax,%ecx		# save original EFLAGS
> @@ -191,7 +191,7 @@
>  	andl $0x40000,%eax	# check if AC bit changed
>  	je is386
>  
> -	movl $4,X86		# at least 486
> +	movb $4,X86		# at least 486
>  	movl %ecx,%eax
>  	xorl $0x200000,%eax	# check ID flag
>  	pushl %eax

 This is broken -- these word stores assure a proper initialization on
pre-CPUID processors.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

