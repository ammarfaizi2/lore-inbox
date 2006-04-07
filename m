Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWDGPoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWDGPoK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 11:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWDGPoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 11:44:10 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:52492 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964811AbWDGPoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 11:44:08 -0400
Date: Fri, 7 Apr 2006 16:43:50 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: saeed bishara <saeed.bishara@gmail.com>,
       Paolo Ornati <ornati@fastwebnet.it>, linux-kernel@vger.kernel.org,
       linux-arm-kernel@lists.arm.linux.org.uk,
       Linux-arm-toolchain@lists.arm.linux.org.uk
Subject: Re: add new code section for kernel code
Message-ID: <20060407154349.GB31458@flint.arm.linux.org.uk>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	saeed bishara <saeed.bishara@gmail.com>,
	Paolo Ornati <ornati@fastwebnet.it>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.arm.linux.org.uk,
	Linux-arm-toolchain@lists.arm.linux.org.uk
References: <c70ff3ad0604060545o2e2dc8fcg2948ca53b3b3c8b0@mail.gmail.com> <20060406151003.0ef4e637@localhost> <c70ff3ad0604060947t728fbad9g2e3b35198f9b0f66@mail.gmail.com> <c70ff3ad0604070402p355a5695y28b5806cbf7bed0a@mail.gmail.com> <1144422864.3117.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144422864.3117.0.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2006 at 05:14:24PM +0200, Arjan van de Ven wrote:
> On Fri, 2006-04-07 at 14:02 +0300, saeed bishara wrote:
> > I noticed the arch/arm/boot/compressed/ files compiled with
> > ffunction-sections switch, so I added the -fno-function-sections to
> > the EXTRA_CFLAGS of the compressed/Makefile. And this solved the
> > problem.
> 
> can you send a patch for this to Russell ?

I'd prefer not to paper over such bugs.  Maybe the following patch will
fix the decompressor for saeed?

diff --git a/arch/arm/boot/compressed/vmlinux.lds.in b/arch/arm/boot/compressed/vmlinux.lds.in
--- a/arch/arm/boot/compressed/vmlinux.lds.in
+++ b/arch/arm/boot/compressed/vmlinux.lds.in
@@ -18,6 +18,7 @@ SECTIONS
     _start = .;
     *(.start)
     *(.text)
+    *(.text.*)
     *(.fixup)
     *(.gnu.warning)
     *(.rodata)


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
