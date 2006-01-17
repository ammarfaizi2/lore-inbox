Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbWAQKQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWAQKQh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 05:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbWAQKQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 05:16:37 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:18886 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932383AbWAQKQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 05:16:36 -0500
Date: Tue, 17 Jan 2006 19:16:37 +0900
To: ak@suse.de, linux-kernel@vger.kernel.org
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Christoph Hellwig <hch@infradead.org>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: [PATCH 4/4] i386: print system_utsname.version in oops
Message-ID: <20060117101637.GE19473@miraclelinux.com>
References: <20060117101339.GA19473@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060117101339.GA19473@miraclelinux.com>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

print system_utsname.version in i386 oops to make it possible doing a
double check that the oops is matching the vmlinux we're looking at.

for example:
(2.6.15-git12) --> (2.6.15-git12 #1 SMP Tue Jan 17 13:59:15 JST 2006)

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
----
 traps.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

--- 2.6-git/arch/i386/kernel/traps.c.orig	2006-01-17 12:45:41.000000000 +0900
+++ 2.6-git/arch/i386/kernel/traps.c	2006-01-17 12:49:35.000000000 +0900
@@ -239,9 +239,10 @@ void show_registers(struct pt_regs *regs
 	}
 	print_modules();
 	printk(KERN_EMERG "CPU:    %d\nEIP:    %04x:[<%08lx>]    %s VLI\n"
-			"EFLAGS: %08lx   (%s) \n",
+			"EFLAGS: %08lx   (%s %s) \n",
 		smp_processor_id(), 0xffff & regs->xcs, regs->eip,
-		print_tainted(), regs->eflags, system_utsname.release);
+		print_tainted(), regs->eflags, system_utsname.release,
+		system_utsname.version);
 	print_symbol(KERN_EMERG "EIP is at %s\n", regs->eip);
 	printk(KERN_EMERG "eax: %08lx   ebx: %08lx   ecx: %08lx   edx: %08lx\n",
 		regs->eax, regs->ebx, regs->ecx, regs->edx);
