Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267677AbTCESOy>; Wed, 5 Mar 2003 13:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267679AbTCESOy>; Wed, 5 Mar 2003 13:14:54 -0500
Received: from ltgp.iram.es ([150.214.224.138]:64896 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id <S267677AbTCESOw>;
	Wed, 5 Mar 2003 13:14:52 -0500
From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 5 Mar 2003 19:17:48 +0100
To: "Randy.Dunlap" <randy.dunlap@verizon.net>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] move SWAP option in menu
Message-ID: <20030305181748.GA11729@iram.es>
References: <3E657EBD.59E167D6@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E657EBD.59E167D6@verizon.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 04, 2003 at 08:36:13PM -0800, Randy.Dunlap wrote:
> Hi,
> 
> Please apply this patch (option B of 2 choices) from
> Tomas Szepe to move the SWAP option into the General Setup
> menu.
> 
> Patch is to 2.5.64.
> 
> Thanks,
> ~Randy
> diff -urN a/arch/i386/Kconfig b/arch/i386/Kconfig
> --- a/arch/i386/Kconfig	2003-03-03 20:04:08.000000000 +0100
> +++ b/arch/i386/Kconfig	2003-03-03 19:58:48.000000000 +0100
> @@ -18,15 +18,6 @@
>  	bool
>  	default y
>  
> -config SWAP
> -	bool "Support for paging of anonymous memory"
> -	default y
> -	help
> -	  This option allows you to choose whether you want to have support
> -	  for socalled swap devices or swap files in your kernel that are
> -	  used to provide more virtual memory than the actual RAM present
> -	  in your computer.  If unusre say Y.
> -
>  config SBUS
>  	bool
>  
> diff -urN a/init/Kconfig b/init/Kconfig
> --- a/init/Kconfig	2003-02-11 01:09:48.000000000 +0100
> +++ b/init/Kconfig	2003-03-03 20:02:11.000000000 +0100
> @@ -34,9 +34,18 @@
>  
>  endmenu
>  
> -
>  menu "General setup"
>  
> +config SWAP
> +	depends on X86

Why restrict it to Intel only? I don't know if it works properly on
other architectures, but at least it would give people the opportunity 
to test it on embedded PPC/Arm/MIPS/CRIS/whatever.

>From a quick grep over a recent BK tree, the only files who have 
sections conditional on CONFIG_SWAP are:

include/linux/page-flags.h
include/linux/swap.h
mm/vmscan.c
mm/Makefile

no architecture specific code at all. From a quick look, the
conditionals are rather simple (most of them are replacements of
actual functions by dummies) and should work on all architectures.
Please let people test it on non-X86, after all it's still a 
development kernel. Any breakage is unlikely to be serious and 
embedded people are going to be the most interested since it 
saves some space.

	Gabriel

