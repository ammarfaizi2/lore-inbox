Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262185AbVDWXro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbVDWXro (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 19:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbVDWXro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 19:47:44 -0400
Received: from fire.osdl.org ([65.172.181.4]:19154 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262185AbVDWXrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 19:47:42 -0400
Date: Sat, 23 Apr 2005 16:44:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] unexport insert_resource
Message-Id: <20050423164411.51d77bf1.akpm@osdl.org>
In-Reply-To: <20050415151043.GJ5456@stusta.de>
References: <20050415151043.GJ5456@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> I didn't find any possible modular usage in the kernel.
> 

True, but this looks like something which out-of-tree code could possibly
be using.  I'd prefer to see this one get the deprecated_for_modules
twelve-month treatment.

Or we just leave it as-is.  It depends whether insert_resource is a
sensible part of the resource management API (I think it is).  If so,
then we should just leave it exported, whether or not any in-kernel moduels
happen to be using it at this point in time.


> 
> --- linux-2.6.11-rc5-mm1-full/kernel/resource.c.old	2005-03-04 01:01:30.000000000 +0100
> +++ linux-2.6.11-rc5-mm1-full/kernel/resource.c	2005-03-04 01:01:42.000000000 +0100
> @@ -371,8 +371,6 @@
>  	return result;
>  }
>  
> -EXPORT_SYMBOL(insert_resource);
> -
>  /*
>   * Given an existing resource, change its start and size to match the
>   * arguments.  Returns -EBUSY if it can't fit.  Existing children of
