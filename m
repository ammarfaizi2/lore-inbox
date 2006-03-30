Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbWC3Co3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWC3Co3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 21:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWC3Co3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 21:44:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38316 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751451AbWC3Co2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 21:44:28 -0500
Date: Wed, 29 Mar 2006 18:44:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch:001/011] Configureable NODES_SHIFT (Generic part)
Message-Id: <20060329184412.63e5f2d6.akpm@osdl.org>
In-Reply-To: <20060330110304.DCA1.Y-GOTO@jp.fujitsu.com>
References: <20060330105135.DC9F.Y-GOTO@jp.fujitsu.com>
	<20060330110304.DCA1.Y-GOTO@jp.fujitsu.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yasunori Goto <y-goto@jp.fujitsu.com> wrote:
>
> 
> This is generic part.
> include/asm-xxx/numnodes.h becomes not necessary.
> 

One thing which we aim to do where practical is to ensure that the kernel
compiles and builds at each step of a patch series.  Mainly because it is
very painful when git-bisect hits a won't-compile point.

> 
> Index: pxm_ver4/include/linux/numa.h
> ===================================================================
> --- pxm_ver4.orig/include/linux/numa.h	2005-10-28 12:03:06.000000000 +0900
> +++ pxm_ver4/include/linux/numa.h	2006-03-29 19:03:55.705109954 +0900
> @@ -3,11 +3,9 @@
>  
>  #include <linux/config.h>
>  
> -#ifndef CONFIG_FLATMEM
> -#include <asm/numnodes.h>
> -#endif
> -
> -#ifndef NODES_SHIFT
> +#ifdef CONFIG_NODES_SHIFT
> +#define NODES_SHIFT     CONFIG_NODES_SHIFT
> +#else
>  #define NODES_SHIFT     0
>  #endif

So I think this is in fact [patch 11/11/]?
