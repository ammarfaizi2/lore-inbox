Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbUKHT31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbUKHT31 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 14:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbUKHQtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 11:49:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:3715 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261883AbUKHPWC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 10:22:02 -0500
Date: Mon, 8 Nov 2004 07:21:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: adaplas@pol.net
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
In-Reply-To: <200411081706.55261.adaplas@hotpop.com>
Message-ID: <Pine.LNX.4.58.0411080719460.24286@ppc970.osdl.org>
References: <200411080521.iA85LbG6025914@hera.kernel.org>
 <1099893447.10262.154.camel@gaston> <200411081706.55261.adaplas@hotpop.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Nov 2004, Antonino A. Daplas wrote:
> 
> How about this patch?  This is almost the original macro in riva_hw.h,
> with the __force annotation.

Why not just use __raw_readl/__raw_writel?

That's what they exist for, and they still do any IO accesses correctly, 
which a direct store does not do (it would seriously break on older 
alphas, for example).

Of course, clearly the thing has never worked on things like alphas 
anyway, but the point is that accessing IO memory with direct loads and 
stores really _is_ fundamentally wrong, even if it happens to work on many 
architectures. The keyword is "happens". 

		Linus
