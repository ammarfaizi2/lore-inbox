Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVB0XBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVB0XBR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 18:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVB0XBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 18:01:17 -0500
Received: from fire.osdl.org ([65.172.181.4]:43477 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261505AbVB0W5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 17:57:46 -0500
Date: Sun, 27 Feb 2005 14:46:41 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: torvalds@osdl.org
Cc: ak@suse.de, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] srat: initdata section references
Message-Id: <20050227144641.7743bd4a.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


srat's node_to_pxm() references pxm2node[] after init. so pxm2node[]
should not be __initdata.

Error: ./arch/x86_64/mm/srat.o .text refers to 0000000000000008 R_X86_64_32S      .init.data
Error: ./arch/x86_64/mm/srat.o .text refers to 0000000000000015 R_X86_64_32S      .init.data

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 arch/x86_64/mm/srat.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./arch/x86_64/mm/srat.c~srat_sections ./arch/x86_64/mm/srat.c
--- ./arch/x86_64/mm/srat.c~srat_sections	2005-02-27 12:54:05.127144000 -0800
+++ ./arch/x86_64/mm/srat.c	2005-02-27 14:46:03.202841256 -0800
@@ -23,7 +23,7 @@ static struct acpi_table_slit *acpi_slit
 static nodemask_t nodes_parsed __initdata;
 static nodemask_t nodes_found __initdata;
 static struct node nodes[MAX_NUMNODES] __initdata;
-static __u8  pxm2node[256] __initdata = { [0 ... 255] = 0xff };
+static __u8  pxm2node[256] = { [0 ... 255] = 0xff };
 
 static __init int setup_node(int pxm)
 {


---
