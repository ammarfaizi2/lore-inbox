Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVCGAqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVCGAqu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 19:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVCGAqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 19:46:49 -0500
Received: from fire.osdl.org ([65.172.181.4]:38873 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261614AbVCGAqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 19:46:31 -0500
Date: Sun, 6 Mar 2005 16:46:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: domen@coderock.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, yrgrknmxpzlk@gawab.com
Subject: Re: [patch 09/12] include/linux/module.h - compile warning cleanup
Message-Id: <20050306164626.48bb5be8.akpm@osdl.org>
In-Reply-To: <20050305153535.EFDCC1EE1E@trashy.coderock.org>
References: <20050305153535.EFDCC1EE1E@trashy.coderock.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

domen@coderock.org wrote:
>
> , extinguish warning for module structure that is still 
> live when module is compiled into the kernel; do this in one central 
> place so all such type warnings are automatically taken care of
> 
> Signed-off-by: Stephen Biggs <yrgrknmxpzlk@gawab.com>
> Signed-off-by: Domen Puncer <domen@coderock.org>
> ---
> 
> 
>  kj-domen/include/linux/module.h |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff -puN include/linux/module.h~extinguish_warnings-include_linux_module.h include/linux/module.h
> --- kj/include/linux/module.h~extinguish_warnings-include_linux_module.h	2005-03-05 16:12:03.000000000 +0100
> +++ kj-domen/include/linux/module.h	2005-03-05 16:12:03.000000000 +0100
> @@ -93,7 +93,10 @@ extern struct module __this_module;
>  
>  #else  /* !MODULE */
>  
> -#define MODULE_GENERIC_TABLE(gtype,name)
> +#define MODULE_GENERIC_TABLE(gtype,name)			\
> +extern const struct gtype##_id __not_mod_##name##_unused	\
> +  __attribute__ ((unused, weak, alias(__stringify(name))))
> +

There's already a patch similar to this in Sam's bk-kbuild tree.
