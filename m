Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbVKEKKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbVKEKKh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 05:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbVKEKKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 05:10:37 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53265 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751339AbVKEKKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 05:10:37 -0500
Date: Sat, 5 Nov 2005 10:10:27 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ian Campbell <icampbell@arcom.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org
Subject: Re: [WATCHDOG] sa1100_wdt.c sparse cleanups
Message-ID: <20051105101026.GA28438@flint.arm.linux.org.uk>
Mail-Followup-To: Ian Campbell <icampbell@arcom.com>,
	Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org
References: <1130921809.12578.179.camel@icampbell-debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130921809.12578.179.camel@icampbell-debian>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 08:56:49AM +0000, Ian Campbell wrote:
> @@ -96,20 +96,20 @@
>  
>  	switch (cmd) {
>  	case WDIOC_GETSUPPORT:
> -		ret = copy_to_user((struct watchdog_info *)arg, &ident,
> +		ret = copy_to_user((struct watchdog_info __user *)arg, &ident,
>  				   sizeof(ident)) ? -EFAULT : 0;

It's probably better to use a union with these, eg:

	union {
		void __user *arg;
		struct watchdog_info __user *info;
		int __user *i;
	} u;

	u.arg = (void __user *)arg;

...

	ret = copy_to_user(u.info, &ident, sizeof(ident)) ? -EFAULT : 0;

etc


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
