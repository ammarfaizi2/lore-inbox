Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161124AbWF0Pu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161124AbWF0Pu4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 11:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161125AbWF0Pu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 11:50:56 -0400
Received: from ns2.suse.de ([195.135.220.15]:50915 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161124AbWF0Puz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 11:50:55 -0400
From: Andi Kleen <ak@suse.de>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] Restore set_nmi_callback export on x86_64
Date: Tue, 27 Jun 2006 17:50:27 +0200
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20060627172418.84423784.khali@linux-fr.org>
In-Reply-To: <20060627172418.84423784.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606271750.27899.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 June 2006 17:24, Jean Delvare wrote:
> Commit 2ee60e17896c65da1df5780d3196c050bccb7d10 broke modular
> oprofile (amongst others I suspect) on x86_64 by killing the
> exports of set_nmi_callback and unset_nmi_callback. Let's
> restore the exports next to the functions as is prefered now.

Hmm yes this happened because I got unsubmitted patches 
that remove set_nmi_callback/unset_nmi_callback

But for 2.6.18 the patch is good, thanks.

-Andi

> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Andi Kleen <ak@suse.de>
> ---
>  arch/x86_64/kernel/nmi.c |    2 ++
>  1 files changed, 2 insertions(+)
> 
> --- linux-2.6.17-git.orig/arch/x86_64/kernel/nmi.c	2006-06-27 16:22:17.000000000 +0200
> +++ linux-2.6.17-git/arch/x86_64/kernel/nmi.c	2006-06-27 17:08:18.000000000 +0200
> @@ -607,11 +607,13 @@
>  	vmalloc_sync_all();
>  	rcu_assign_pointer(nmi_callback, callback);
>  }
> +EXPORT_SYMBOL_GPL(set_nmi_callback);
>  
>  void unset_nmi_callback(void)
>  {
>  	nmi_callback = dummy_nmi_callback;
>  }
> +EXPORT_SYMBOL_GPL(unset_nmi_callback);
>  
>  #ifdef CONFIG_SYSCTL
>  
> 
> 
