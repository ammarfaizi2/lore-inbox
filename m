Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbVCHU1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbVCHU1K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 15:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVCHU1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 15:27:10 -0500
Received: from fire.osdl.org ([65.172.181.4]:11756 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262131AbVCHTkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 14:40:49 -0500
Date: Tue, 8 Mar 2005 11:40:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Mundt <lethal@Linux-SH.ORG>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm2
Message-Id: <20050308114015.07d45bfb.akpm@osdl.org>
In-Reply-To: <20050308135836.GC12820@linux-sh.org>
References: <20050308033846.0c4f8245.akpm@osdl.org>
	<20050308135836.GC12820@linux-sh.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mundt <lethal@Linux-SH.ORG> wrote:
>
> With this I can build on sh again. The other solution is to add the
>  include to asm/bug.h directly, but it would be nice to avoid linux/
>  includes from asm/ context in general..
> 
>  Thoughts? Or ideas for a more appropriate fix?
> 
>  --- linux-sh-2.6.11-mm2.orig/include/linux/list.h	2005-03-08 15:46:50.601565604 +0200
>  +++ linux-sh-2.6.11-mm2/include/linux/list.h	2005-03-08 15:46:53.882114403 +0200
>  @@ -5,6 +5,7 @@
>   
>   #include <linux/stddef.h>
>   #include <linux/prefetch.h>
>  +#include <linux/kernel.h>
>   #include <asm/system.h>
>   #include <asm/bug.h>

It always feels bad doing something like the above, because you *know* it's
going to slow the compile down.

Happily, this change is only needed in -mm, so I'll add it to
list_del-debug.patch, thanks.

