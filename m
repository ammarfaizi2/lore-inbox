Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270843AbUJVEKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270843AbUJVEKR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 00:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270899AbUJVEHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 00:07:33 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:9213 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S270911AbUJUUbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 16:31:11 -0400
Date: Thu, 21 Oct 2004 13:31:10 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: roland@topspin.com, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] ppc: fix build with O=$(output_dir)
Message-ID: <20041021203110.GA1532@smtp.west.cox.net>
References: <200410211910.i9LJAKjf029014@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410211910.i9LJAKjf029014@hera.kernel.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 05:56:14PM +0000, roland@topspin.com wrote:
> ChangeSet 1.2040, 2004/10/21 10:56:14-07:00, roland@topspin.com
> 
> 	[PATCH] ppc: fix build with O=$(output_dir)
> 	
> 	Recent changes to arch/ppc/boot/lib/Makefile cause
> 	
> 	      CC      arch/ppc/boot/lib/../../../../lib/zlib_inflate/infblock.o
> 	    Assembler messages:
> 	    FATAL: can't create arch/ppc/boot/lib/../../../../lib/zlib_inflate/infblock.o: No such file or directory
> 	
> 	when building a ppc kernel using O=$(output_dir) with CONFIG_ZLIB_INFLATE=n,
> 	because the $(output_dir)/lib/zlib_inflate directory doesn't get created.
> 	
> 	This patch, which makes arch/ppc/boot/lib/Makefile create the
> 	directory if needed, is one fix for the problem.
> 	
> 	Signed-off-by: Roland Dreier <roland@topspin.com>
> 	Signed-off-by: Andrew Morton <akpm@osdl.org>
> 	Signed-off-by: Linus Torvalds <torvalds@osdl.org>

Can we back this out please?  As I noted on lkml once I saw this, it
still doesn't fix the problem of overwriting files in lib/zlib_inflate/
if ZLIB_INFLATE!=n, and adding explicit rules for lib/zlib_inflate/foo.c
-> ./foo.o looks quite bad (it's 2 calls if we want checker to get
invoked, one if we skip doing that).  At the end of the thread, both
Roland and I were hoping Sam knew of a clever solution to this.

-- 
Tom Rini
http://gate.crashing.org/~trini/
