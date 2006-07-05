Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbWGERNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbWGERNF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 13:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWGERNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 13:13:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:64719 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964923AbWGERNC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 13:13:02 -0400
From: Andreas Schwab <schwab@suse.de>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: NULL terminate over-long /proc/kallsyms symbols
References: <200607051859.41638.agruen@suse.de>
X-Yow: Is it NOUVELLE CUISINE when 3 olives are struggling with a scallop
 in a plate of SAUCE MORNAY?
Date: Wed, 05 Jul 2006 19:13:00 +0200
In-Reply-To: <200607051859.41638.agruen@suse.de> (Andreas Gruenbacher's
	message of "Wed, 5 Jul 2006 18:59:41 +0200")
Message-ID: <jewtasm0v7.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Gruenbacher <agruen@suse.de> writes:

> Index: linux-2.6.17/kernel/module.c
> ===================================================================
> --- linux-2.6.17.orig/kernel/module.c
> +++ linux-2.6.17/kernel/module.c
> @@ -1935,7 +1935,7 @@ struct module *module_get_kallsym(unsign
>  		if (symnum < mod->num_symtab) {
>  			*value = mod->symtab[symnum].st_value;
>  			*type = mod->symtab[symnum].st_info;
> -			strncpy(namebuf,
> +			strlcpy(namebuf,
>  				mod->strtab + mod->symtab[symnum].st_name,
>  				127);

Just a minor point: you probably also want to change 127 to 128.
Unfortunately sizeof does not work here, despite the declaration.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
