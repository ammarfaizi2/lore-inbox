Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262861AbVCJW5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbVCJW5M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 17:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbVCJW5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 17:57:07 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:47364 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263427AbVCJWxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 17:53:42 -0500
Date: Thu, 10 Mar 2005 23:53:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Dike <jdike@addtoit.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/9] UML - Export gcov symbol based on gcc version
Message-ID: <20050310225340.GD3205@stusta.de>
References: <200503100216.j2A2G2DN015232@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503100216.j2A2G2DN015232@ccure.user-mode-linux.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 09:16:02PM -0500, Jeff Dike wrote:
> The init function called by gcc when gcov is enabled is __gcov_init or
> __bb_init_func, depending on the gcc version.  Anton is using 3.3.4 and 
> seeing __gcov_init.  I'm using 3.3.2 and seeing __bb_init_func, so we need
> to close that gap a bit.
> 
> Signed-off-by: Jeff Dike <jdike@addtoit.com>
> 
> Index: linux-2.6.11/arch/um/kernel/gmon_syms.c
> ===================================================================
> --- linux-2.6.11.orig/arch/um/kernel/gmon_syms.c	2005-03-07 10:53:03.000000000 -0500
> +++ linux-2.6.11/arch/um/kernel/gmon_syms.c	2005-03-07 16:29:37.000000000 -0500
> @@ -5,8 +5,14 @@
>  
>  #include "linux/module.h"
>  
> +#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 3) || \
> +	(__GNUC__ == 3 && __GNUC_MINOR__ == 3 && __GNUC_PATCHLEVEL__ >= 4)
>...

This patch is still wrong.

It seems my comment on this [1] was lost:

<--  snip  -->

This line has to be something like

( (__GNUC__ == 3 && __GNUC_MINOR__ == 3 && __GNUC_PATCHLEVEL__ >= 4) && \
   HEAVILY_PATCHED_SUSE_GCC ) 

I hope SuSE has added some #define to distinguish what they call 
"gcc 3.3.4" from GNU gcc 3.3.4

<--  snip  -->


cu
Adrian

[1] http://www.ussg.iu.edu/hypermail/linux/kernel/0503.0/1876.html

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

