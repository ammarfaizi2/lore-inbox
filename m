Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbUKHW0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbUKHW0K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 17:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbUKHW0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 17:26:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:39823 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261273AbUKHWZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 17:25:54 -0500
Date: Mon, 8 Nov 2004 14:25:04 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: adaplas@pol.net
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Guido Guenther <agx@sigxcpu.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
In-Reply-To: <200411090608.02759.adaplas@hotpop.com>
Message-ID: <Pine.LNX.4.58.0411081422560.2301@ppc970.osdl.org>
References: <200411080521.iA85LbG6025914@hera.kernel.org>
 <200411090402.22696.adaplas@hotpop.com> <Pine.LNX.4.58.0411081211270.2301@ppc970.osdl.org>
 <200411090608.02759.adaplas@hotpop.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Nov 2004, Antonino A. Daplas wrote:
> 
> In big endian machines, the read*/write* accessors do a byteswap for an
> inherently little endian PCI bus.  However, rivafb puts the hardwire in big
> endian register access, thus the byteswap is not needed. So for 16- and
> 32-bit access, instead of read*/write*, use __raw_read*/__raw_write* for all
> archs.

Ok, applied with some further simplifications (use "void __iomem *" and 
suddenly those /2 and /4 just go away - also use __raw_xxxx for the 
single-byte versions to be consistent).

		Linus
