Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262235AbUKQIbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbUKQIbH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 03:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbUKQIbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 03:31:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:65233 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262235AbUKQIbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 03:31:01 -0500
Date: Wed, 17 Nov 2004 00:30:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] DEBUG_BUGVERBOSE for i386 (fwd)
Message-Id: <20041117003032.7fd91c47.akpm@osdl.org>
In-Reply-To: <20041117043228.GH4943@stusta.de>
References: <20041117043228.GH4943@stusta.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> The patch below implements CONFIG_DEBUG_BUGVERBOSE for i386 (more 
>  exactly, it allows disabling the verbose BUG() reporting).
> 
> 
>  Signed-off-by: Adrian Bunk <bunk@fs.tum.de>
> 
>  --- linux-2.6.9-rc1-mm1-full/lib/Kconfig.debug.old	2004-08-29 21:22:20.000000000 +0200
>  +++ linux-2.6.9-rc1-mm1-full/lib/Kconfig.debug	2004-08-29 21:28:29.000000000 +0200
>  @@ -61,7 +61,7 @@
>   
>   config DEBUG_BUGVERBOSE
>   	bool "Verbose BUG() reporting (adds 70K)"
>  -	depends on DEBUG_KERNEL && (ARM || ARM26 || M68K || SPARC32 || SPARC64)
>  +	depends on DEBUG_KERNEL && (ARM || ARM26 || M68K || SPARC32 || SPARC64 || (X86 && !X86_64))

I think I'll stick an `&& EMBEDDED' in there to make it harder to disable
BUG traces.  We really don't want to be screwing ourselves over by removing
useful diagnostic info.
