Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbVCGAyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVCGAyz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 19:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVCGAyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 19:54:55 -0500
Received: from fire.osdl.org ([65.172.181.4]:61402 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261287AbVCGAyn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 19:54:43 -0500
Date: Sun, 6 Mar 2005 16:54:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: domen@coderock.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, yrgrknmxpzlk@gawab.com
Subject: Re: [patch 11/12] sound/oss/emu10k1/* - compile warning cleanup
Message-Id: <20050306165439.04acd045.akpm@osdl.org>
In-Reply-To: <20050305153542.7A66E1F208@trashy.coderock.org>
References: <20050305153542.7A66E1F208@trashy.coderock.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

domen@coderock.org wrote:
>
> @@ -316,7 +320,10 @@ static void copy_block(u8 __user *dst, u
>  
>  		for (i = 0; i < len; i++) {
>  			byte = src[2 * i] ^ 0x80;
> -			__copy_to_user(dst + i, &byte, 1);
> +			if (__copy_to_user(dst + i, &byte, 1)) {
> +				printk( KERN_ERR "emu10k1: %s: copy_to_user failed\n",__FUNCTION__);
> +				return;
> +			}
>  		}

This allows users to spam the logs without bounds, which is normally
something we try to avoid.  If it's a privileged operation then OK.  But it
would be better to propagate an error back to userspace.

I'll drop the patch for now.
