Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261973AbVBYV6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbVBYV6l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 16:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVBYV6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 16:58:41 -0500
Received: from fire.osdl.org ([65.172.181.4]:43169 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261973AbVBYV6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 16:58:30 -0500
Date: Fri, 25 Feb 2005 13:55:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] unexport do_settimeofday
Message-Id: <20050225135504.7749942e.akpm@osdl.org>
In-Reply-To: <20050225214326.GE3311@stusta.de>
References: <20050224233742.GR8651@stusta.de>
	<20050224212448.367af4be.akpm@osdl.org>
	<20050225214326.GE3311@stusta.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> On Thu, Feb 24, 2005 at 09:24:48PM -0800, Andrew Morton wrote:
> > Adrian Bunk <bunk@stusta.de> wrote:
> > >
> > > 
> > >  I haven't found any possible modular usage of do_settimeofday in the 
> > >  kernel.
> > 
> > Please,
> > 
> > - Add deprecated_if_module
> >...
> 
> What's the correct header file for __deprecated_if_module ?

Actually, __deprecated_in_modules would be a better name.

> module.h ?

compiler.h, I guess.

--- 25/include/linux/compiler.h~a	2005-02-25 13:53:32.000000000 -0800
+++ 25-akpm/include/linux/compiler.h	2005-02-25 13:54:45.000000000 -0800
@@ -86,6 +86,12 @@ extern void __chk_io_ptr(void __iomem *)
 # define __deprecated		/* unimplemented */
 #endif
 
+#ifdef MODULE
+#define __deprecated_in_modules __deprecated
+#else
+#define __deprecated_in_modules /* OK in non-modular code */
+#endif
+
 #ifndef __must_check
 #define __must_check
 #endif
_


