Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265291AbUHHMdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265291AbUHHMdP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 08:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265301AbUHHMdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 08:33:15 -0400
Received: from cantor.suse.de ([195.135.220.2]:57033 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265291AbUHHMdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 08:33:11 -0400
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH][2.6] Completely out of line spinlocks / i386
References: <Pine.LNX.4.58.0408072123590.19619@montezuma.fsmlabs.com>
	<Pine.LNX.4.58.0408072157500.1793@ppc970.osdl.org>
	<Pine.LNX.4.58.0408080110280.19619@montezuma.fsmlabs.com>
	<Pine.LNX.4.58.0408072220490.1793@ppc970.osdl.org>
	<Pine.LNX.4.58.0408080143230.19619@montezuma.fsmlabs.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Is this ANYWHERE, USA?
Date: Sun, 08 Aug 2004 14:33:07 +0200
In-Reply-To: <Pine.LNX.4.58.0408080143230.19619@montezuma.fsmlabs.com> (Zwane
 Mwaikambo's message of "Sun, 8 Aug 2004 02:00:32 -0400 (EDT)")
Message-ID: <je4qndlsho.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linuxpower.ca> writes:

> Index: linux-2.6.8-rc3-mm1/arch/i386/lib/spinlock.c
> ===================================================================
> RCS file: linux-2.6.8-rc3-mm1/arch/i386/lib/spinlock.c
> diff -N linux-2.6.8-rc3-mm1/arch/i386/lib/spinlock.c
> --- /dev/null	1 Jan 1970 00:00:00 -0000
> +++ linux-2.6.8-rc3-mm1/arch/i386/lib/spinlock.c	8 Aug 2004 05:39:13 -0000

Why not just make this an assembler source?  It contains no real C code.
The only downside is that EXPORT_SYMBOL must be moved elsewhere, but on
the other hand it would make the assembler code more readable,

> +#define PROC(name)	\
> +	".align 4\n" \
> +	".globl " #name"\n" \
> +	#name":\n"

and you could use ENTRY from <linux/linkage.h>.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
