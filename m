Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264379AbUFPSGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264379AbUFPSGE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 14:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264401AbUFPSGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 14:06:04 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:62881 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264379AbUFPSEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 14:04:54 -0400
Date: Wed, 16 Jun 2004 20:04:02 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: make checkstack on m68k
Message-ID: <20040616180402.GB15365@wohnheim.fh-wedel.de>
References: <Pine.GSO.4.58.0406161845490.1249@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.GSO.4.58.0406161845490.1249@waterleaf.sonytel.be>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 June 2004 18:51:03 +0200, Geert Uytterhoeven wrote:
> 
> I tried to add m68k support to `make checkstack', but got stuck due to my
> limited knowledge of complex perl expressions. I actually need to catch both
> expressions (incl. the one I commented out). Anyone who can help?
> 
> Anyway, here's a first run:
>   - Add half-assed m68 support.
>   - Make sure `make checkstack' uses the script in the source tree directory
>     (BTW, I saw a few more targets in my eye corner that may need this)
>   - Fix checkstack.pl naming
> 
> --- linux-2.6.7/Makefile	2004-06-16 13:06:15.000000000 +0200
> +++ linux-m68k-2.6.7/Makefile	2004-06-16 18:27:13.000000000 +0200
> @@ -1070,7 +1070,7 @@ endif #ifeq ($(mixed-targets),1)
>  .PHONY: checkstack
>  checkstack:
>  	$(OBJDUMP) -d vmlinux $$(find . -name '*.ko') | \
> -	$(PERL) scripts/checkstack.pl $(ARCH)
> +	$(PERL) $(src)/scripts/checkstack.pl $(ARCH)

Does this actually matter?  Didn't hurt me yet.

>  #	Usage:
> -#	objdump -d vmlinux | stackcheck_ppc.pl [arch]
> +#	objdump -d vmlinux | stackcheck.pl [arch]

Those were the days... :)
Good catch.

> @@ -40,6 +40,11 @@
>  	} elsif ($arch =~ /^ia64$/) {
>  		#e0000000044011fc:       01 0f fc 8c     adds r12=-384,r12
>  		$re = qr/.*adds.*r12=-(([0-9]{2}|[3-9])[0-9]{2}),r12/o;
> +	} elsif ($arch =~ /^m68k$/) {
> +		#2b6c:       4e56 fb70       linkw %fp,#-1168
> +		#$re = qr/.*linkw %fp,#-([0-9]{1,4})/o;
> +		#1df770:       defc ffe4       addaw #-28,%sp
> +		$re = qr/.*addaw #-([0-9]{1,4}),%sp/o;

For i386 I used a really ugly hack, but this needs someone with better
perl skills.  Matt, can you find a nice regex?  If it adds more
brackets, that's fine.  We'll just add empty brackets to the other
regexes and use $2 instead of $1 or so.

Jörn

-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
-- Theodore Roosevelt, Kansas City Star, 1918
