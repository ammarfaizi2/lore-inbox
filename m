Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbULUBPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbULUBPQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 20:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbULUBPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 20:15:15 -0500
Received: from waste.org ([216.27.176.166]:45515 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261498AbULUBPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 20:15:10 -0500
Date: Mon, 20 Dec 2004 17:15:07 -0800
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: kai@germaschewski.name, sam@ravnborg.org
Subject: Re: [PATCH] make depmod
Message-ID: <20041221011507.GE5974@waste.org>
References: <20041221002416.GC28322@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041221002416.GC28322@waste.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2004 at 04:24:16PM -0800, Matt Mackall wrote:
> This patch exposes the modules_install depmod functionality as a
> convenience to external modules
> 
> Index: l/Makefile
> ===================================================================
> --- l.orig/Makefile	2004-11-04 10:52:49.499525000 -0800
> +++ l/Makefile	2004-12-20 16:19:01.195688000 -0800
> @@ -867,7 +867,9 @@
>  depmod_opts	:= -b $(INSTALL_MOD_PATH) -r
>  endif
>  .PHONY: _modinst_post
> -_modinst_post: _modinst_
> +_modinst_post: _modinst_ depmod
> +
> +depmod:
>  	if [ -r System.map ]; then $(DEPMOD) -ae -F System.map $(depmod_opts) $(KERNELRELEASE); fi
>  
>  else # CONFIG_MODULES

As was pointed out to me privately, this is broken for make -j.

-- 
Mathematics is the supreme nostalgia of our time.
