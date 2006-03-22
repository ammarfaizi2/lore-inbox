Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWCVPD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWCVPD5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWCVPDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:03:33 -0500
Received: from ns1.suse.de ([195.135.220.2]:928 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751270AbWCVPD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:03:29 -0500
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC PATCH 29/35] Add the Xen virtual console driver.
Date: Wed, 22 Mar 2006 15:17:41 +0100
User-Agent: KMail/1.9.1
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063804.956561000@sorel.sous-sol.org>
In-Reply-To: <20060322063804.956561000@sorel.sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221517.42144.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 07:31, Chris Wright wrote:

Basically it's the same thing as the buffer in printk.c except
that it does input too.

You could safe a lot of code by just teaching the Hypervisor
about that one. Not sure it is fully practical though,


> --- xen-subarch-2.6.orig/drivers/char/tty_io.c
> +++ xen-subarch-2.6/drivers/char/tty_io.c
> @@ -132,6 +132,8 @@ LIST_HEAD(tty_drivers);			/* linked list
>     vt.c for deeply disgusting hack reasons */
>  DECLARE_MUTEX(tty_sem);
>  
> +int console_use_vt = 1;

This doesn't have anything to do with early console.

Why is it needed? Looks like a ugly hack.



> +#define __RETCODE 0

What is that? 

> +/*** Useful function for console debugging -- goes straight to Xen. ***/
> +asmlinkage int xprintk(const char *fmt, ...)

In normal Linux this is called early_printk()

> +{
> +	va_list args;
> +	int printk_len;
> +	static char printk_buf[1024];

Who does the locking here?

-Andi
