Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265291AbUFOFXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265291AbUFOFXO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 01:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265292AbUFOFXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 01:23:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:29892 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265291AbUFOFXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 01:23:05 -0400
Date: Mon, 14 Jun 2004 22:18:29 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] fix initdata usage in i386/kernel/cpu/mtrr/generic.c
Message-Id: <20040614221829.79303ec8.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix bad initdata use in cpu/mtrr/generic.c

Error: ./arch/i386/kernel/cpu/mtrr/generic.o .text refers to 0000038f R_386_32          .init.data

arch/i386/kernel/cpu/mtrr/generic.c
generic_set_all() uses __initdata smp_changes_mask.

smp_changes_mask should not be __initdata.

Error no longer reported by reference_init.pl.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


diffstat:=
 arch/i386/kernel/cpu/mtrr/generic.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./arch/i386/kernel/cpu/mtrr/generic.c~cpu_mtrr_gen ./arch/i386/kernel/cpu/mtrr/generic.c
--- ./arch/i386/kernel/cpu/mtrr/generic.c~cpu_mtrr_gen	2004-05-09 19:32:38.000000000 -0700
+++ ./arch/i386/kernel/cpu/mtrr/generic.c	2004-06-14 22:05:02.000000000 -0700
@@ -18,7 +18,7 @@ struct mtrr_state {
 	mtrr_type def_type;
 };
 
-static unsigned long smp_changes_mask __initdata = 0;
+static unsigned long smp_changes_mask;
 struct mtrr_state mtrr_state = {};
 
 


--
~Randy
