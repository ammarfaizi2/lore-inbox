Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbTAATs5>; Wed, 1 Jan 2003 14:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbTAATs5>; Wed, 1 Jan 2003 14:48:57 -0500
Received: from dsl-67-48-44-237.telocity.com ([67.48.44.237]:46646 "EHLO
	lnuxlab.ath.cx") by vger.kernel.org with ESMTP id <S262604AbTAATsx>;
	Wed, 1 Jan 2003 14:48:53 -0500
Date: Wed, 1 Jan 2003 15:14:51 -0500
To: Sowmya Adiga <sowmya.adiga@wipro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.53mm2 for AIMbench
Message-ID: <20030101201451.GA3397@lnuxlab.ath.cx>
References: <002c01c2b14b$0ecd8a10$6009720a@wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002c01c2b14b$0ecd8a10$6009720a@wipro.com>
User-Agent: Mutt/1.3.28i
From: khromy@lnuxlab.ath.cx (khromy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 01, 2003 at 09:35:37AM +0530, Sowmya Adiga wrote:
> Hi,
>  
>       I gave 60 second for each test while running AIM bench for
> 2.5.53mm2 patch.But it ran each test for only 6 second.Is there any
> change in kernel frequency with this release?
>  
> Regards
> sowmya adiga

I had some timing problems also but Andrew pointed out the following:

Seems that this is because different parts of the kernel are using
different values of HZ (!).

In include/asm-i386/param.h, please add:

#ifdef __KERNEL__

+#include <linux/config.h>

#ifdef CONFIG_1000HZ

Here is a patch for that change:

--- linux-2.5/include/asm-i386/param.h.bak	2002-12-30 00:39:35.000000000 -0500
+++ linux-2.5/include/asm-i386/param.h	2002-12-30 00:40:18.000000000 -0500
@@ -3,6 +3,8 @@
 
 #ifdef __KERNEL__
 
+#include <linux/config.h>
+
 #ifdef CONFIG_1000HZ
 # define HZ	1000		/* Internal kernel timer frequency */
 #else

-- 
L1:	khromy		;khromy(at)lnuxlab.ath.cx
