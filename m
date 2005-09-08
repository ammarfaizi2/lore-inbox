Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932664AbVIHPq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664AbVIHPq7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932704AbVIHPq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:46:58 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:60889 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932664AbVIHPqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:46:46 -0400
Date: Thu, 8 Sep 2005 08:46:45 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 CFI annotations
Message-ID: <20050908154645.GN3966@smtp.west.cox.net>
References: <432070850200007800024465@emea1-mh.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432070850200007800024465@emea1-mh.id2.novell.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 05:10:29PM +0200, Jan Beulich wrote:

> As a foundation for reliable stack unwinding, this adds CFI unwind
> annotations to many low-level i386 routines, plus a config option
> (available to all architectures) to enable them as well as the
> compiler
> producing similar information for all C sources.
> 
> Signed-off-by: Jan Beulich <jbeulich@novell.com>

x86_64 has proper CFI annotations on things, and just depends on
DEBUG_INFO.  Perhaps that would be a slightly easier path to use for
pushing this along?

> +	CFI_ADJUST_CFA_OFFSET 4;\
> +	/*CFI_REL_OFFSET es, 0;*/\
>  	pushl %ds; \
> +	CFI_ADJUST_CFA_OFFSET 4;\
> +	/*CFI_REL_OFFSET ds, 0;*/\

Adding new commented out code never wins new friends. :)

> diff -Npru 2.6.13/include/asm-i386/dwarf2.h
[snip]
> +#ifdef CONFIG_UNWIND_INFO
[snip]
> +#else
[snip]
> +#define CFI_STARTPROC	ignore

Why not just empty defines?

-- 
Tom Rini
http://gate.crashing.org/~trini/
