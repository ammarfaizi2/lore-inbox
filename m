Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWDJJNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWDJJNM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 05:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbWDJJNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 05:13:12 -0400
Received: from tensor.andric.com ([213.154.244.69]:14573 "EHLO
	tensor.andric.com") by vger.kernel.org with ESMTP id S1751052AbWDJJNL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 05:13:11 -0400
Message-ID: <443A2196.5090306@andric.com>
Date: Mon, 10 Apr 2006 11:12:54 +0200
From: Dimitry Andric <dimitry@andric.com>
User-Agent: Thunderbird 2.0a1 (Windows/20060324)
MIME-Version: 1.0
To: saeed bishara <saeed.bishara@gmail.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Paolo Ornati <ornati@fastwebnet.it>, linux-kernel@vger.kernel.org,
       linux-arm-kernel@lists.arm.linux.org.uk,
       Linux-arm-toolchain@lists.arm.linux.org.uk
Subject: Re: add new code section for kernel code
References: <c70ff3ad0604060545o2e2dc8fcg2948ca53b3b3c8b0@mail.gmail.com>	<20060406151003.0ef4e637@localhost>	<c70ff3ad0604060947t728fbad9g2e3b35198f9b0f66@mail.gmail.com>	<c70ff3ad0604070402p355a5695y28b5806cbf7bed0a@mail.gmail.com>	<1144422864.3117.0.camel@laptopd505.fenrus.org>	<20060407154349.GB31458@flint.arm.linux.org.uk>	<c70ff3ad0604090253n7fe4de4che67f18380ffa2efd@mail.gmail.com> <20060409203046.GA24461@flint.arm.linux.org.uk>
In-Reply-To: <20060409203046.GA24461@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> Thanks for testing; I've applied this patch so 2.6.17-rc2 onwards will
> have this fixed.

Maybe this can also be applied to the data sections, for people who
compile with -fdata-sections?  As in the following patch (note that the
.rodata sections are already wildcarded):

diff -urNd a/arch/arm/boot/compressed/vmlinux.lds.in
b/arch/arm/boot/compressed/vmlinux.lds.in
--- a/arch/arm/boot/compressed/vmlinux.lds.in	2006-03-20
06:53:29.000000000 +0100
+++ b/arch/arm/boot/compressed/vmlinux.lds.in	2006-04-10
11:06:03.000000000 +0200
@@ -34,7 +35,7 @@
   .got			: { *(.got) }
   _got_end = .;
   .got.plt		: { *(.got.plt) }
-  .data			: { *(.data) }
+  .data			: { *(.data) *(.data.*) }
   _edata = .;

   . = BSS_START;
