Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753920AbWKRFWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920AbWKRFWN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 00:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753921AbWKRFWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 00:22:13 -0500
Received: from main.gmane.org ([80.91.229.2]:12995 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1753920AbWKRFWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 00:22:13 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [PATCH 20/20] x86_64: Move CPU verification code to common file
Date: Sat, 18 Nov 2006 05:21:58 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnelt6h7.dd3.olecom@flower.upol.cz>
References: <20061117223432.GA15449@in.ibm.com> <20061117225953.GU15449@in.ibm.com>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>, olecom@flower.upol.cz, vgoyal@in.ibm.com, akpm@osdl.org, rjw@sisk.pl, ebiederm@xmission.com, hpa@zytor.com,   Reloc Kernel List <fastboot@lists.osdl.org>, pavel@suse.cz, magnus.damm@gmail.com, ak@suse.de
User-Agent: slrn/0.9.8.1pl1 (Debian)
Cc: fastboot@lists.osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo.

On 2006-11-17, Vivek Goyal wrote:
[]
> +no_longmode:
> +	/* This isn't an x86-64 CPU so hang */
> +1:
> +	hlt
> +	jmp     1b
> +
> +#include "../../kernel/verify_cpu.S"
> +

May hang be done optional? There was a discussion about applying
"panic" reboot timeout here. Is it possible to implement somehow?

[]
> diff -puN /dev/null arch/x86_64/kernel/verify_cpu.S
> --- /dev/null	2006-11-17 00:03:10.168280803 -0500
> +++ linux-2.6.19-rc6-reloc-root/arch/x86_64/kernel/verify_cpu.S	2006-11-17 00:14:07.000000000 -0500
> @@ -0,0 +1,106 @@
> +/*
> + *
> + *	verify_cpu.S - Code for cpu long mode and SSE verification
> + *
> + *	Copyright (c) 2006-2007  Vivek Goyal (vgoyal@in.ibm.com)
                           ^^^^
Warning: File verify_cpu.S has modification time in the future...
(preliminary shoot (in the head ;))

[]
> +verify_cpu:
> +
> +	pushfl				# Save caller passed flags
> +	pushl	$0			# Kill any dangerous flags
> +	popfl
> +
> +	/* minimum CPUID flags for x86-64 */
> +	/* see http://www.x86-64.org/lists/discuss/msg02971.html */

Maybe there's a place for this in Documentation/ ?

> +#define SSE_MASK ((1<<25)|(1<<26))
> +#define REQUIRED_MASK1 ((1<<0)|(1<<3)|(1<<4)|(1<<5)|(1<<6)|(1<<8)|\
> +					   (1<<13)|(1<<15)|(1<<24))

Maybe there is a more readable way to setup this mask?
____

