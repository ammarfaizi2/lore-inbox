Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWHAV6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWHAV6j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 17:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWHAV6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 17:58:39 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57225 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751168AbWHAV6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 17:58:38 -0400
Subject: Re: use persistent allocation for cursor blinking.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060801185618.GS22240@redhat.com>
References: <20060801185618.GS22240@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 01 Aug 2006 23:17:40 +0100
Message-Id: <1154470660.15540.92.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-01 am 14:56 -0400, ysgrifennodd Dave Jones:
> +	static u8 *src=NULL;
> +	static int allocsize=0;

s/=/ = /

> +	if (dsize + sizeof(struct fb_image) != allocsize) {
> +		if (src != NULL)
> +			kfree(src);
> +		allocsize = dsize + sizeof(struct fb_image);
> +
> +		src = kmalloc(allocsize, GFP_ATOMIC);
> +		if (!src)
> +			return -ENOMEM;
> +	}

If the allocation fails we have allocsize = "somesize" and src = NULL.
The next time we enter the if is false and we fall through and Oops

Either check src in the if or set allocsize to something impossible (eg
0) on the error path.

NAK


