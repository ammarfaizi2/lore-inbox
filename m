Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932516AbWEIN1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbWEIN1G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 09:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbWEIN1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 09:27:06 -0400
Received: from cantor2.suse.de ([195.135.220.15]:56200 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932516AbWEIN1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 09:27:05 -0400
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC PATCH 29/35] Add the Xen virtual console driver.
Date: Tue, 9 May 2006 15:26:10 +0200
User-Agent: KMail/1.9.1
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>
References: <20060509084945.373541000@sous-sol.org> <20060509085159.285105000@sous-sol.org>
In-Reply-To: <20060509085159.285105000@sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605091526.10936.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> --- linus-2.6.orig/drivers/char/tty_io.c
> +++ linus-2.6/drivers/char/tty_io.c
> @@ -132,6 +132,8 @@ LIST_HEAD(tty_drivers);			/* linked list
>     vt.c for deeply disgusting hack reasons */
>  DEFINE_MUTEX(tty_mutex);
>  
> +int console_use_vt = 1;
> +

Can you explain why this variable is needed? It shouldn't. If you only
register your console as the primary console nothing else should
be printed.


> +/*** Useful function for console debugging -- goes straight to Xen. ***/
> +asmlinkage int xprintk(const char *fmt, ...)

This is called early_printk in the rest of i386. Please use that name too.

-Andi
