Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269371AbUIYR5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269371AbUIYR5j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 13:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269372AbUIYR5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 13:57:39 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:2490 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269371AbUIYR5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 13:57:38 -0400
Message-ID: <9e47339104092510574c908525@mail.gmail.com>
Date: Sat, 25 Sep 2004 13:57:37 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: __initcall macros and C token pasting
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#define DRM(x) r128_##x
module_init( DRM(init) );

#define __define_initcall(level,fn) \
        static initcall_t __initcall_##fn __attribute_used__ \
        __attribute__((__section__(".initcall" level ".init"))) = fn

This gives the error:
{standard input}: Assembler messages:
{standard input}:104: Error: junk at end of line, first unrecognized
character is `('

I believe this is because the C macro is not being expanded in the
assembler context of the section with the fn assignment.

Any ideas on how to fix this?

-- 
Jon Smirl
jonsmirl@gmail.com
