Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbWINPvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWINPvY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 11:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbWINPvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 11:51:24 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:43914 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750894AbWINPvX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 11:51:23 -0400
Date: Thu, 14 Sep 2006 10:51:18 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Linux Containers <containers@lists.osdl.org>
Subject: Re: [patch -mm] utsname namespace : fix unshare when CONFIG_UTS_NS is not set
Message-ID: <20060914155118.GA4337@sergelap.austin.ibm.com>
References: <4509771B.9070204@fr.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4509771B.9070204@fr.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Cedric Le Goater (clg@fr.ibm.com):
> If the kernel is not configured with the CONFIG_UTS_NS, unshare of
> ipc namespace will fail and return -EINVAL.
> 
> The patch changes the dummy unshare_utsname() to check the clone flags
> before returning.
> 
> Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>

Acked-by: Serge E. Hallyn <serue@us.ibm.com>

thanks,
-serge

> Cc: Andrew Morton <akpm@osdl.org>
> Cc: Serge E. Hallyn <serue@us.ibm.com>
> Cc: Linux Containers <containers@lists.osdl.org>
> 
> ---
>  include/linux/utsname.h |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> Index: 2.6.18-rc6-mm2/include/linux/utsname.h
> ===================================================================
> --- 2.6.18-rc6-mm2.orig/include/linux/utsname.h
> +++ 2.6.18-rc6-mm2/include/linux/utsname.h
> @@ -60,8 +60,12 @@ static inline void put_uts_ns(struct uts
>  static inline int unshare_utsname(unsigned long unshare_flags,
>  			struct uts_namespace **new_uts)
>  {
> -	return -EINVAL;
> +	if (unshare_flags & CLONE_NEWUTS)
> +		return -EINVAL;
> +
> +	return 0;
>  }
> +
>  static inline int copy_utsname(int flags, struct task_struct *tsk)
>  {
>  	return 0;
