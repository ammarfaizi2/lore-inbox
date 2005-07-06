Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262229AbVGFLvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262229AbVGFLvI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 07:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbVGFLsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 07:48:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56787 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262244AbVGFJDl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 05:03:41 -0400
Date: Wed, 6 Jul 2005 02:02:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, ast@domdv.de
Subject: Re: [swsusp] encrypt suspend data for easy wiping
Message-Id: <20050706020251.2ba175cc.akpm@osdl.org>
In-Reply-To: <20050703213519.GA6750@elf.ucw.cz>
References: <20050703213519.GA6750@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> To prevent data gathering from swap after resume you can encrypt the
> suspend image with a temporary key that is deleted on resume. Note
> that the temporary key is stored unencrypted on disk while the system
> is suspended... still it means that saved data are wiped from disk
> during resume by simply overwritting the key.

hm, how useful is that?  swap can still contain sensitive userspace stuff.

Are there any plans to allow the user to type the key in on resume?

> +Encrypted suspend image:
> +------------------------
> +If you want to store your suspend image encrypted with a temporary
> +key to prevent data gathering after resume you must compile
> +crypto and the aes algorithm into the kernel - modules won't work
> +as they cannot be loaded at resume time.

Why not just `select' the needed symbols in Kconfig?  It makes
configuration much easier for the user.

> +	if(!*tfm) {
> +	if(sizeof(key) < crypto_tfm_alg_min_keysize(*tfm)) {
> +	if (mode) {

Coding style nit: please use a single space after `if'.

> +fail:	crypto_free_tfm(*tfm);
> +out:	return error;

We conventionally insert a newline directly after labels.

> +#ifdef CONFIG_SWSUSP_ENCRYPT
> +#ifdef CONFIG_SWSUSP_ENCRYPT
> +#ifdef CONFIG_SWSUSP_ENCRYPT
> +#ifdef CONFIG_SWSUSP_ENCRYPT
> +#ifdef CONFIG_SWSUSP_ENCRYPT
> +#ifdef CONFIG_SWSUSP_ENCRYPT
> +#ifdef CONFIG_SWSUSP_ENCRYPT
> +#ifdef CONFIG_SWSUSP_ENCRYPT
> +#ifdef CONFIG_SWSUSP_ENCRYPT

err, no.  Please find a way to reduce the ifdeffery.
