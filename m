Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270371AbUJVIBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270371AbUJVIBR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 04:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269848AbUJVH4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 03:56:09 -0400
Received: from gprs214-34.eurotel.cz ([160.218.214.34]:36996 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S270020AbUJVHzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 03:55:08 -0400
Date: Fri, 22 Oct 2004 09:54:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __init & __initdata during resume
Message-ID: <20041022075454.GD8376@elf.ucw.cz>
References: <41788761.8020508@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41788761.8020508@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 'make buildcheck' reports:
> Error: ./arch/x86_64/ia32/syscall32.o .text refers to 0000000000000002
> R_X86_64_PC32     .init.data+0x000000000000152b
> Error: ./arch/x86_64/ia32/syscall32.o .text refers to 0000000000000017
> R_X86_64_PC32     .init.data+0x000000000000152c
> 
> 
> I'm looking at a recent (2 weeks) changeset:
> [PATCH] Fix random crashes in x86-64 swsusp
> 
> http://linux.bkbits.net:8080/linux-2.5/cset@4166a52aYzzfOE3F63Kkb966K2Qz3g?nav=index.html|src/|src/arch|src/arch/x86_64|src/arch/x86_64/ia32|related/arch/x86_64/ia32/syscall32.c
> 
> in which this change was made:
> 
> -void __init syscall32_cpu_init(void)
> +/* May not be __init: called during resume */
> +void syscall32_cpu_init(void)
> 
> but syscall32_cpu_init() uses <use_sysenter>, which is:
> static int use_sysenter __initdata = -1;
> 
> so the question is:  does that "__initdata" need to removed also?

Yes, I'm afraid that I overlooked that one.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
