Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262551AbVDAHYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbVDAHYt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 02:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbVDAHYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 02:24:48 -0500
Received: from mail.portrix.net ([212.202.157.208]:15555 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S262551AbVDAHYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 02:24:36 -0500
Message-ID: <424CF71B.80204@ppp0.net>
Date: Fri, 01 Apr 2005 09:24:11 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050116 Thunderbird/1.0 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, dwmw2@shinybook.infradead.org
Subject: Re: 2.6.12-rc1-mm4
References: <20050331022554.735a1118.akpm@osdl.org>
In-Reply-To: <20050331022554.735a1118.akpm@osdl.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>  bk-audit.patch

This seems to have broken compile for uml:


  CC      arch/um/kernel/ptrace.o
arch/um/kernel/ptrace.c:345:74: macro "audit_syscall_entry" requires 7 arguments, but only 6 given
arch/um/kernel/ptrace.c: In function `syscall_trace':
arch/um/kernel/ptrace.c:340: error: `audit_syscall_entry' undeclared (first use in this function)
arch/um/kernel/ptrace.c:340: error: (Each undeclared identifier is reported only once
arch/um/kernel/ptrace.c:340: error: for each function it appears in.)
arch/um/kernel/ptrace.c:348:72: macro "audit_syscall_exit" requires 3 arguments, but only 2 given
arch/um/kernel/ptrace.c:347: error: `audit_syscall_exit' undeclared (first use in this function)
make[1]: *** [arch/um/kernel/ptrace.o] Error 1
make: *** [arch/um/kernel] Error 2
Fri, 01 Apr 2005 09:08:16 +0200

in particular I suspect:

# include/linux/audit.h
#   2005/03/25 13:53:15+00:00 dwmw2@shinybook.infradead.org +44 -4
#   Add AUDIT_ARCH and its definitions
#   Add arch to audit_syscall_entry()
#   Add success/failure to audit_syscall_exit()
#
# arch/x86_64/kernel/ptrace.c
#   2005/03/25 13:53:15+00:00 dwmw2@shinybook.infradead.org +8 -5
#   Reorder audit w.r.t ptrace, provide arch and success.
#
# arch/s390/kernel/ptrace.c
#   2005/03/25 13:53:15+00:00 dwmw2@shinybook.infradead.org +11 -10
#   Reorder audit w.r.t ptrace, provide arch and success.
#
# arch/ppc64/kernel/ptrace.c
#   2005/03/25 13:53:15+00:00 dwmw2@shinybook.infradead.org +10 -6
#   Reorder audit w.r.t ptrace, provide arch and success.
#
# arch/mips/kernel/ptrace.c
#   2005/03/25 13:53:15+00:00 dwmw2@shinybook.infradead.org +28 -10
#   Reorder audit w.r.t ptrace, provide arch and success.
#
# arch/ia64/kernel/ptrace.c
#   2005/03/25 13:53:14+00:00 dwmw2@shinybook.infradead.org +13 -8
#   Reorder audit w.r.t ptrace, provide arch and success.
#
# arch/i386/kernel/ptrace.c
#   2005/03/25 13:53:14+00:00 dwmw2@shinybook.infradead.org +9 -10
#   Reorder audit w.r.t ptrace, provide arch and success.

defconfig, gcc 3.3.5, see http://l4x.org/k/?d=3004 for details.

Jan
