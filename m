Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVDBMLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVDBMLX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 07:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVDBMLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 07:11:22 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:48325 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261383AbVDBMLU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 07:11:20 -0500
Date: Sat, 2 Apr 2005 04:10:09 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: blosure@sgi.com
Cc: mochel@digitalimplant.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: new SGI TIOCX driver in *-mm driver model locking broken
Message-Id: <20050402041009.72500c6f.pj@engr.sgi.com>
In-Reply-To: <20050402034313.4aa994f5.pj@engr.sgi.com>
References: <20050402034313.4aa994f5.pj@engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bruce - a related issue that fell out of the previous problem.  I
disabled SGI_TIOCX, with

# CONFIG_SGI_TIOCX is not set

and now 2.6.12-rc1-mm4 doesn't build SN2 because SGI_MBCS is still
enabled in my .config, even after doing 'make oldconfig':

CONFIG_SGI_MBCS=m

The error messages from the build begin with:

drivers/built-in.o(.text+0xa0f62): In function `mbcs_sram_read':
drivers/char/mbcs.c:137: undefined reference to `tiocx_dma_addr'
drivers/built-in.o(.text+0xa1582): In function `mbcs_sram_write':
drivers/char/mbcs.c:90: undefined reference to `tiocx_dma_addr'
drivers/built-in.o(.text+0xa1d62): In function `mbcs_intr_alloc':
drivers/char/mbcs.c:589: undefined reference to `tiocx_irq_alloc'
drivers/built-in.o(.text+0xa1e12):drivers/char/mbcs.c:602: undefined reference to `tiocx_irq_alloc'
drivers/built-in.o(.text+0xa1ec2):drivers/char/mbcs.c:620: undefined reference to `tiocx_irq_alloc'
drivers/built-in.o(.text+0xa1f92):drivers/char/mbcs.c:573: undefined reference to `tiocx_irq_free'
drivers/built-in.o(.text+0xa1fc2):drivers/char/mbcs.c:573: undefined reference to `tiocx_irq_free'

and indeed there are many tiocx references in drivers/char/mbcs.c.

I'm not a CONFIG wizard, but I would suspect that there should be
some sort of dependency in Kconfig, of SGI_MBCS on SGI_TIOCX, so
that I couldn't ask for this bogus config (MBCS on, TIOCX off).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
