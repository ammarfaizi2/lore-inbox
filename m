Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311092AbSCRPPv>; Mon, 18 Mar 2002 10:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311119AbSCRPPl>; Mon, 18 Mar 2002 10:15:41 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:23427
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S311092AbSCRPPb>; Mon, 18 Mar 2002 10:15:31 -0500
Date: Mon, 18 Mar 2002 08:15:26 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: paulus@samba.org, marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zlib double-free bug
Message-ID: <20020318151526.GD3762@opus.bloom.county>
In-Reply-To: <15509.51214.495427.580341@argo.ozlabs.ibm.com> <20020318144946.GA7052@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2002 at 03:49:46PM +0100, J.A. Magallon wrote:
 
> The only rest it leaves in 19-pre3 are:
> 
> ./arch/ppc/boot/lib/zlib.c
> ./arch/ppc/boot/include/zlib.h
> 
> Patch already does:
> 
> --- linux-2.4.19-pre2-ac2/arch/ppc/config.in    Sun Mar  3 18:54:31 2002
> +++ linux-2.4.19-pre2-ac2-zlib/arch/ppc/config.in   Tue Mar  5 08:57:31 2002
> @@ -396,6 +396,8 @@
>     source net/bluetooth/Config.in
>  fi
>  
> +source lib/Config.in
> +  
>  mainmenu_option next_comment
>  comment 'Kernel hacking'
>  
> 
> So wouldn't it be better to kill ppc/.../zlib and make it use also the
> shared copy ?

Not really.  The arch/ppc/boot version (and arch/mips/boot'ish too, when
it gets merged) are slightly different from the in-kernel ones by ~1
line, so that they allow things to be decompressed to 0x0.  My plan for
2.5 is to get the PPC version using the lib/zlib_deflate stuff (by dummy
files doing #include too), maybe.  But either way it's a non-issue (if
you can't trust the 'zImage' binary, you've got bigger problems than
someone trying to expliot a bug before Linux is running).

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
