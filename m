Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbUKHWXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbUKHWXd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 17:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbUKHWXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 17:23:32 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:15415 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261270AbUKHWWy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 17:22:54 -0500
Date: Mon, 8 Nov 2004 23:23:20 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Zbigniew Szmek <zjedrzejewski-szmek@wp.pl>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make crypto modular
Message-ID: <20041108222320.GA16150@mars.ravnborg.org>
Mail-Followup-To: Zbigniew Szmek <zjedrzejewski-szmek@wp.pl>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200411082149.54723.zjedrzejewski-szmek@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411082149.54723.zjedrzejewski-szmek@wp.pl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 09:49:54PM +0100, Zbigniew Szmek wrote:
 diff -rupN 2610rc1mm1.um/crypto.modular/Makefile 2610rc1mm1.um/crypto/Makefile
> --- 2610rc1mm1.um/crypto.modular/Makefile	2004-11-07 18:41:35.000000000 +0100
> +++ 2610rc1mm1.um/crypto/Makefile	2004-11-08 11:44:52.000000000 +0100
> @@ -2,12 +2,13 @@
>  # Cryptographic API
>  #
>  
> -proc-crypto-$(CONFIG_PROC_FS) = proc.o
> +obj-$(CONFIG_CRYPTO) += crypto.o
>  
> -obj-$(CONFIG_CRYPTO) += api.o scatterwalk.o cipher.o digest.o compress.o \
> -			$(proc-crypto-y)

> +crypto-objs = $(crypto-objs-y)
> +crypto-objs-y = api.o scatterwalk.o cipher.o digest.o compress.o
> +crypto-objs-$(CONFIG_PROC_FS) += proc.o
> +crypto-objs-$(CONFIG_CRYPTO_HMAC) += hmac.o
Please use:
crypto-y := api.o scatterwalk.o cipher.o digest.o compress.o
crypto-$(CONFIG_PROC_FS)     += proc.o
crypto-$(CONFIG_CRYPTO_HMAC) += hmac.o

More compact and nicer format.

I did not look through the rest of the changes.

	Sam
