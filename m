Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTFZXWL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 19:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbTFZXWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 19:22:11 -0400
Received: from 12-226-168-214.client.attbi.com ([12.226.168.214]:36283 "EHLO
	marta.kurtwerks.com") by vger.kernel.org with ESMTP id S262373AbTFZXWI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 19:22:08 -0400
Date: Thu, 26 Jun 2003 19:36:21 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix inlining with gcc3
Message-ID: <20030626233621.GC20094@kurtwerks.com>
References: <Pine.LNX.4.55L.0306261858460.10651@freak.distro.conectiva> <20030626230824.GM3827@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030626230824.GM3827@werewolf.able.es>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.21-krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[CCs slightly trimmed]

Quoth J.A. Magallon:

[snippety]
 
> This fixes inlining (really, not-inlining) with gcc3. How about next -pre ?
> 
> --- 25/include/linux/compiler.h~gcc3-inline-fix	2003-03-06 03:02:43.000000000 -0800
> +++ 25-akpm/include/linux/compiler.h	2003-03-06 03:11:42.000000000 -0800
> @@ -1,6 +1,13 @@
>  #ifndef __LINUX_COMPILER_H
>  #define __LINUX_COMPILER_H
>  
> +#if __GNUC__ >= 3
> +#define inline		__inline__ __attribute__((always_inline))
> +#define inline__	__inline__ __attribute__((always_inline))
> +#define __inline	__inline__ __attribute__((always_inline))
> +#define __inline__	__inline__ __attribute__((always_inline))
> +#endif
> +
>  /* Somewhere in the middle of the GCC 2.96 development cycle, we implemented
>     a mechanism by which the user can annotate likely branch directions and
>     expect the blocks to be reordered appropriately.  Define __builtin_expect

I'm willing to give this a shot. Where, or perhaps what, should I test
to evaluate best the effects, if any, of this patch? 

Kurt
-- 
Decision maker, n.:
	The person in your office who was unable to form a task force
before the music stopped.
