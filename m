Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbVEPUF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbVEPUF7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 16:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVEPUF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 16:05:59 -0400
Received: from fire.osdl.org ([65.172.181.4]:3248 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261803AbVEPUDu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 16:03:50 -0400
Date: Mon, 16 May 2005 13:03:17 -0700
From: Chris Wright <chrisw@osdl.org>
To: Reiner Sailer <sailer@us.ibm.com>
Cc: linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
       davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: crypto api initialized late
Message-ID: <20050516200317.GD23013@shell0.pdx.osdl.net>
References: <Pine.WNT.4.63.0505161359560.840@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.63.0505161359560.840@laptop>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Reiner Sailer (sailer@us.ibm.com) wrote:
> 
> I am writing a Linux Security Module that needs SHA1 support very early in 
> the kernel startup (before any fs are mounted,modules are loaded,  or 
> files are mapped; including initrd). Therefore, I use the __initcall 
> to initialize the security module. SHA1 can currently be used only 
> through the crypto-api (static definitions and hidden context structure).
> 
> This crypto-API, however, initializes AFTER the security module
> code in the __initicall block. Currently, I use the following patch into 
> the main Linux Makefile to start up the crypto-API earlier:
> 
> diff -uprN linux-2.6.12-rc3_orig/Makefile 
> linux-2.6.12-rc3-ima-newpatch/Makefile
> --- linux-2.6.12-rc3_orig/Makefile	2005-04-20 20:03:12.000000000 -0400
> +++ linux-2.6.12-rc3-ima-newpatch/Makefile	2005-05-11 
> 15:18:32.000000000 -0400
> @@ -560,7 +560,7 @@ export MODLIB
> 
> 
>  ifeq ($(KBUILD_EXTMOD),)
> -core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/
> +core-y		+= kernel/ mm/ fs/ ipc/ crypto/ security/

I'm surprised this helps at all.  Does this mean you are not using
security_initcall() in your module?

thanks,
-chris
