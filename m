Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbTEAP2u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 11:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbTEAP2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 11:28:50 -0400
Received: from ns.suse.de ([213.95.15.193]:63492 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261375AbTEAP2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 11:28:49 -0400
To: Kimmo Sundqvist <rabbit80@mbnet.fi>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: 2.5.68-mm3 and a simple mistake
References: <200305011826.31389.rabbit80@mbnet.fi.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 01 May 2003 17:41:05 +0200
In-Reply-To: <200305011826.31389.rabbit80@mbnet.fi.suse.lists.linux.kernel>
Message-ID: <p734r4e3ca6.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kimmo Sundqvist <rabbit80@mbnet.fi> writes:

> /usr/bin/make -f scripts/Makefile.clean obj=arch/i386/mach-default
> /usr/bin/make -f scripts/Makefile.clean obj=arch/i386/mach-generic
> scripts/Makefile.clean:10: arch/i386/mach-generic/Makefile: No such file or 
> directory
> make[2]: *** No rule to make target `arch/i386/mach-generic/Makefile'.  Stop.
> make[1]: *** [_clean_arch/i386/mach-generic] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.5.68'
> make: *** [stamp-kernel-configure] Error 2

Most likely you need to apply this patch. It was in the original
subarch patch, but may be gotten lost somewhere.
Hopefully not more is missing.

diff -u linux-apic/arch/i386/mach-generic/Makefile-o linux-apic/arch/i386/mach-generic/Makefile
--- linux-apic/arch/i386/mach-generic/Makefile-o	2003-04-27 02:45:25.000000000 +0200
+++ linux-apic/arch/i386/mach-generic/Makefile	2003-04-27 02:45:25.000000000 +0200
@@ -0,0 +1,9 @@
+#
+# Makefile for the generic architecture
+#
+
+EXTRA_CFLAGS	+= -I../kernel
+
+obj-y				:= probe.o summit.o bigsmp.o default.o
+
+

-Andi
