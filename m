Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbVASIJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbVASIJK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 03:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbVASIHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 03:07:08 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55231 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261644AbVASHds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:33:48 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <fastboot@lists.osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/29] x86_64-e820-64bit
Date: Wed, 19 Jan 2005 0:31:37 -0700
Message-ID: <x86-64-e820-64bit-11061198971581@ebiederm.dsl.xmission.com>
X-Mailer: patch-bomb.pl@ebiederm.dsl.xmission.com
In-Reply-To: <x86-local-apic-fix-11061198972413@ebiederm.dsl.xmission.com>
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
	<x86-rename-apic-mode-exint-11061198973109@ebiederm.dsl.xmission.com>
	<x86-local-apic-fix-11061198972413@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Eric W. Biederman <ebiederm@xmission.com>

It is ok to reserve resources > 4G on x86_64 struct resource is 64bit now :)

Signed-off-by: Eric Biederman <ebiederm@xmission.com>
---

 e820.c |    2 --
 1 files changed, 2 deletions(-)

diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86-local-apic-fix/arch/x86_64/kernel/e820.c linux-2.6.11-rc1-mm1-nokexec-x86_64-e820-64bit/arch/x86_64/kernel/e820.c
--- linux-2.6.11-rc1-mm1-nokexec-x86-local-apic-fix/arch/x86_64/kernel/e820.c	Mon Oct 18 15:53:45 2004
+++ linux-2.6.11-rc1-mm1-nokexec-x86_64-e820-64bit/arch/x86_64/kernel/e820.c	Tue Jan 18 22:44:10 2005
@@ -185,8 +185,6 @@
 	int i;
 	for (i = 0; i < e820.nr_map; i++) {
 		struct resource *res;
-		if (e820.map[i].addr + e820.map[i].size > 0x100000000ULL)
-			continue;
 		res = alloc_bootmem_low(sizeof(struct resource));
 		switch (e820.map[i].type) {
 		case E820_RAM:	res->name = "System RAM"; break;
