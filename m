Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265919AbUBBVXW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 16:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265922AbUBBVXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 16:23:22 -0500
Received: from chaos.analogic.com ([204.178.40.224]:64898 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265919AbUBBVXU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 16:23:20 -0500
Date: Mon, 2 Feb 2004 16:25:55 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Kronos <kronos@kronoz.cjb.net>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Compile Regression in 2.4.25-pre8][PATCH 11/42]
In-Reply-To: <20040202194452.GK6785@dreamland.darkstar.lan>
Message-ID: <Pine.LNX.4.53.0402021622390.28946@chaos>
References: <20040130204956.GA21643@dreamland.darkstar.lan>
 <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
 <20040202194452.GK6785@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Feb 2004, Kronos wrote:

>
> include/asm/smpboot.h:126: warning: deprecated use of label at end of compound statement
>
> Move the return statement under 'default' label to suppress the warning.
>
> diff -Nru -X dontdiff linux-2.4-vanilla/include/asm-i386/smpboot.h linux-2.4/include/asm-i386/smpboot.h
> --- linux-2.4-vanilla/include/asm-i386/smpboot.h	Tue Nov 11 17:51:14 2003
> +++ linux-2.4/include/asm-i386/smpboot.h	Sat Jan 31 17:10:50 2004
> @@ -123,8 +123,8 @@
>  			cpu = (cpu+1)%smp_num_cpus;
>  			return cpu_to_physical_apicid(cpu);
>  		default:
> +			return cpu_online_map;
>  	}
> -	return cpu_online_map;
>  }
>  #else
>  #define target_cpus() (cpu_online_map)
>

Not correct. This removes the main-line return of a value.
You just need a ';' after the default to suppress the error
(or a break; ). Neither will make any additional code.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


