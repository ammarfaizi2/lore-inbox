Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWCFHFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWCFHFJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 02:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923AbWCFHFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 02:05:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26092 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750957AbWCFHFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 02:05:07 -0500
Date: Sun, 5 Mar 2006 23:03:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-kernel@vger.kernel.org, ben@fluff.org
Subject: Re: [PATCH] define setup_arch() in header file
Message-Id: <20060305230321.6ce3ea57.akpm@osdl.org>
In-Reply-To: <20060305204418.GA7244@home.fluff.org>
References: <20060305204418.GA7244@home.fluff.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Dooks <ben-linux@fluff.org> wrote:
>
> When running sparse over an ARM build of 2.6.16-rc5, I came
>  across this error, which is due to setup_arch() being used
>  be init/main.c, but not being defined in any headers.
> 
>  This patch adds setup_arch() definition to include/linux/init.h
> 
>  The warning is:
>    arch/arm/kernel/setup.c:730:13: warning: symbol 'setup_arch' was not declared. Should it be static?
> 
> ...
>
>  --- linux-2.6.16-rc5/include/linux/init.h	2006-02-28 09:05:02.000000000 +0000
>  +++ linux-2.6.16-rc5-fixes/include/linux/init.h	2006-03-05 20:39:21.000000000 +0000
>  @@ -69,6 +69,10 @@ extern initcall_t __security_initcall_st
>   
>   /* Defined in init/main.c */
>   extern char saved_command_line[];
>  +
>  +/* used by init/main.c */
>  +extern void setup_arch(char **);

There are already declarations of setup_arch in include/asm-ppc and
include/asm-powerpc.  Different declarations.

Plus there's an unneeded-with-this-patch declaration in init/main.c.
