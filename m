Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUCZSAS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 13:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264100AbUCZSAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 13:00:18 -0500
Received: from math.ut.ee ([193.40.5.125]:45468 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S264098AbUCZSAN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 13:00:13 -0500
Date: Fri, 26 Mar 2004 20:00:06 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Tom Rini <trini@kernel.crashing.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] asm-ppc/elf.h warning
In-Reply-To: <20040326174338.GB17402@smtp.west.cox.net>
Message-ID: <Pine.GSO.4.44.0403261956350.2460-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you try just removing <linux/elf.h> from everything in
> arch/ppc/boot/ ?

elf.h include is present in arch/ppc/boot/simple/misc.c and
arch/ppc/boot/simple/misc-embedded.c. The first one caused my warning
and the include can be safely removed from there. The other file is not
used in my config (prep) but I did try to compile it with elf.h include
removed (make arch/ppc/boot/simple/misc-embedded.o) and it failed. So
here is the patch against arch/ppc/boot/simple/misc.c. Nevertheless,
asm-ppc/elf.h can not be included by itself without a warning about
struct task_struct - is this a problem or not?

===== arch/ppc/boot/simple/misc.c 1.18 vs edited =====
--- 1.18/arch/ppc/boot/simple/misc.c	Tue Mar  2 01:34:28 2004
+++ edited/arch/ppc/boot/simple/misc.c	Fri Mar 26 19:51:24 2004
@@ -17,7 +17,6 @@
  */

 #include <linux/types.h>
-#include <linux/elf.h>
 #include <linux/config.h>
 #include <linux/string.h>

-- 
Meelis Roos (mroos@linux.ee)

