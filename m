Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWELWAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWELWAJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 18:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWELWAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 18:00:08 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37390 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932260AbWELWAH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 18:00:07 -0400
Date: Fri, 12 May 2006 21:56:45 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 28/35] add support for Xen feature queries
Message-ID: <20060512215645.GA4491@ucw.cz>
References: <20060509084945.373541000@sous-sol.org> <20060509085158.933866000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509085158.933866000@sous-sol.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Add support for parsing and interpreting hypervisor feature
> flags. These allow the kernel to determine what features are provided
> by the underlying hypervisor. For example, whether page tables need to
> be write protected explicitly by the kernel, and whether the kernel
> (appears to) run in ring 0 rather than ring 1. This information allows
> the kernel to improve performance by avoiding unnecessary actions.


> --- /dev/null
> +++ linus-2.6/include/xen/features.h
> @@ -0,0 +1,20 @@
> +/******************************************************************************
> + * features.h
> + *
> + * Query the features reported by Xen.
> + *
> + * Copyright (c) 2006, Ian Campbell
> + */
> +
> +#ifndef __ASM_XEN_FEATURES_H__
> +#define __ASM_XEN_FEATURES_H__
> +
> +#include <xen/interface/version.h>
> +
> +extern void setup_xen_features(void);
> +
> +extern u8 xen_features[XENFEAT_NR_SUBMAPS * 32];

32 bytes per submap? Why not use __test_bit & friends and make the
bitmap compact?

> +#define xen_feature(flag)	(xen_features[flag])

Perhaps this kind of indirection is not neccessary?

> --- /dev/null
> +++ linus-2.6/drivers/xen/core/features.c
> @@ -0,0 +1,29 @@
> +/******************************************************************************
> + * features.c
> + *
> + * Xen feature flags.
> + *
> + * Copyright (c) 2006, Ian Campbell, XenSource Inc.

GPL?
						Pavel
-- 
Thanks for all the (sleeping) penguins.
