Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269570AbUJSSeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269570AbUJSSeO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 14:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269586AbUJSSct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 14:32:49 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:53425 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S269570AbUJSS33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 14:29:29 -0400
Date: Tue, 19 Oct 2004 11:29:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Roland Dreier <roland@topspin.com>
Cc: sam@ravnborg.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/take 2] ppc: fix build with O=$(output_dir)
Message-ID: <20041019182928.GA12544@smtp.west.cox.net>
References: <52is979pah.fsf@topspin.com> <20041019164449.GF6298@smtp.west.cox.net> <521xfua835.fsf_-_@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <521xfua835.fsf_-_@topspin.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 11:14:38AM -0700, Roland Dreier wrote:

> Subject: [PATCH/take 2] ppc: fix build with O=$(output_dir)
> 
> OK, here's a patch that builds a separate copy for arch/ppc/boot/lib.
> 
> Recent changes to arch/ppc/boot/lib/Makefile cause
> 
>       CC      arch/ppc/boot/lib/../../../../lib/zlib_inflate/infblock.o
>     Assembler messages:
>     FATAL: can't create arch/ppc/boot/lib/../../../../lib/zlib_inflate/infblock.o: No such file or directory
> 
> when building a ppc kernel using O=$(output_dir) with CONFIG_ZLIB_INFLATE=n,
> because the $(output_dir)/lib/zlib_inflate directory doesn't get created.
> 
> This patch, which uses the lib/zlib_inflate sources to build objects
> in the arch/ppc/boot/lib/directory, is one fix for the problem.

This misses the bit to invoke the checker as well (when I first thought
this up I poked Al Viro about the general question of checker on boot
code, and he wanted it, so...).  And having 2 'magic' rules not just 1
is why I don't like this too much and was hoping Sam would have some
idea of a good fix.

-- 
Tom Rini
http://gate.crashing.org/~trini/
