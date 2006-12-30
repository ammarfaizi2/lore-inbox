Return-Path: <linux-kernel-owner+w=401wt.eu-S1755146AbWL3PyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755146AbWL3PyR (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 10:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755149AbWL3PyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 10:54:17 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:27344 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755146AbWL3PyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 10:54:16 -0500
Subject: Should be [PATCH -mm] --  Re: [PATCH -rt] panic on SLIM + selinux
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Mimi Zohar <zohar@us.ibm.com>,
       Kylene Hall <kjhall@us.ibm.com>
In-Reply-To: <20061230154804.862606000@mvista.com>
References: <20061230154804.862606000@mvista.com>
Content-Type: text/plain
Date: Sat, 30 Dec 2006 07:53:27 -0800
Message-Id: <1167494007.14081.75.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry, really for -mm .

On Sat, 2006-12-30 at 07:48 -0800, Daniel Walker wrote:
> If you have both SLIM and selinux compiled into your kernel selinux will panic
> if it can't register itself. The code below, 
> 
> if (register_security (&selinux_ops))
> 	panic("SELinux: Unable to register with kernel.\n");
> 
> "security/selinux/hooks.c" 5014 lines --95%--                                                                           4811,35       96%
> 
> This could be a bug report cause I bet there's a better way to make these mutually 
> exclusive.
> 
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>
> 
> ---
>  security/slim/Kconfig |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6.19/security/slim/Kconfig
> ===================================================================
> --- linux-2.6.19.orig/security/slim/Kconfig
> +++ linux-2.6.19/security/slim/Kconfig
> @@ -1,6 +1,6 @@
>  config SECURITY_SLIM
>  	boolean "SLIM support"
> -	depends on SECURITY && SECURITY_NETWORK && INTEGRITY
> +	depends on SECURITY && SECURITY_NETWORK && INTEGRITY && !SECURITY_SELINUX
>  	help
>  	  The Simple Linux Integrity Module implements a modified low water-mark
>  	  mandatory access control integrity model.
> --
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

