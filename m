Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269860AbUJSRFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269860AbUJSRFo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 13:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269761AbUJSRD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 13:03:26 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:39125 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S269842AbUJSQou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:44:50 -0400
Date: Tue, 19 Oct 2004 09:44:49 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Roland Dreier <roland@topspin.com>
Cc: sam@ravnborg.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc: fix build with O=$(output_dir)
Message-ID: <20041019164449.GF6298@smtp.west.cox.net>
References: <52is979pah.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52is979pah.fsf@topspin.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2004 at 11:48:22PM -0700, Roland Dreier wrote:

> Recent changes to arch/ppc/boot/lib/Makefile cause
> 
>       CC      arch/ppc/boot/lib/../../../../lib/zlib_inflate/infblock.o
>     Assembler messages:
>     FATAL: can't create arch/ppc/boot/lib/../../../../lib/zlib_inflate/infblock.o: No such file or directory
> 
> when building a ppc kernel using O=$(output_dir) with CONFIG_ZLIB_INFLATE=n,
> because the $(output_dir)/lib/zlib_inflate directory doesn't get created.
> 
> This patch, which makes arch/ppc/boot/lib/Makefile create the
> directory if needed, is one fix for the problem.

IMHO, this is the uglier of the two fixes for the problem, as this means
you'll still be clobbering lib/zlib_inflate/*.o when ZLIB_INFLATE!=n.
The other is to go back to putting the object in $(O)/arch/ppc/boot/lib/
and copying the guts of the .c.o rule to arch/ppc/boot/lib/Makefile

Sam, any chance you've had time to think up a good fix to this?  Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
