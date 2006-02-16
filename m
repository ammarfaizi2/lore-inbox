Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWBPBXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWBPBXF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 20:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWBPBXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 20:23:05 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:28622 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750711AbWBPBXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 20:23:04 -0500
Subject: Re: [PATCH 0/2] strndup_user, v2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Davi Arnaut <davi.arnaut@gmail.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060215182258.03505613.davi.arnaut@gmail.com>
References: <20060215182258.03505613.davi.arnaut@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 16 Feb 2006 01:25:56 +0000
Message-Id: <1140053156.14831.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-02-15 at 18:22 -0300, Davi Arnaut wrote:
> +static inline char *strdup_user(const char __user *s)
> +{
> +	return strndup_user(s, 4096);
> +}

Still shouldn't exist. Its just a bad idea to give people broken
function they don't yet use.


> +	length = strlen_user(s);

Should use strnlen_user or this function is useless for most cases.

> +
> +	if (!length)
> +		return ERR_PTR(-EFAULT);

Zero isn't an -EFAULT length. Its a null string and valid
> +
> +	if (length > n)
> +		length = n;
> +
> +	p = kmalloc(length, GFP_KERNEL);
> +
> +	if (!p)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (strncpy_from_user(p, s, length) < 0) {
> +		kfree(p);
> +		return ERR_PTR(-EFAULT);
> +	}
> +
> +	p[length - 1] = '\0';

And still broken.

"Hello" -> length = 5   "Hello\0"[4] = 0 "Hell"


