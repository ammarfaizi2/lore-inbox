Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263114AbVG3TFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263114AbVG3TFi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 15:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263112AbVG3TDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 15:03:40 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:15782 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S263111AbVG3TDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 15:03:01 -0400
Subject: [patch 1/3] uml: add dwarf sections to static link script
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Sat, 30 Jul 2005 21:05:33 +0200
Message-Id: <20050730190534.6FB5B843@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Inside the linker script, insert the code for DWARF debug info sections. This
may help GDB'ing a Uml binary. Actually, it seems that ld is able to guess
what I added correctly, but normal linker scripts include this section so it
should be correct anyway adding it.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/kernel/uml.lds.S |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+)

diff -puN arch/um/kernel/uml.lds.S~uml-add-dwarf-sections-to-static-link-script arch/um/kernel/uml.lds.S
--- linux-2.6.git/arch/um/kernel/uml.lds.S~uml-add-dwarf-sections-to-static-link-script	2005-07-30 13:41:40.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/uml.lds.S	2005-07-30 13:41:40.000000000 +0200
@@ -103,4 +103,29 @@ SECTIONS
   .stab.index 0 : { *(.stab.index) }
   .stab.indexstr 0 : { *(.stab.indexstr) }
   .comment 0 : { *(.comment) }
+  /* DWARF debug sections.
+     Symbols in the DWARF debugging sections are relative to the beginning
+     of the section so we begin them at 0.  */
+  /* DWARF 1 */
+  .debug          0 : { *(.debug) }
+  .line           0 : { *(.line) }
+  /* GNU DWARF 1 extensions */
+  .debug_srcinfo  0 : { *(.debug_srcinfo) }
+  .debug_sfnames  0 : { *(.debug_sfnames) }
+  /* DWARF 1.1 and DWARF 2 */
+  .debug_aranges  0 : { *(.debug_aranges) }
+  .debug_pubnames 0 : { *(.debug_pubnames) }
+  /* DWARF 2 */
+  .debug_info     0 : { *(.debug_info .gnu.linkonce.wi.*) }
+  .debug_abbrev   0 : { *(.debug_abbrev) }
+  .debug_line     0 : { *(.debug_line) }
+  .debug_frame    0 : { *(.debug_frame) }
+  .debug_str      0 : { *(.debug_str) }
+  .debug_loc      0 : { *(.debug_loc) }
+  .debug_macinfo  0 : { *(.debug_macinfo) }
+  /* SGI/MIPS DWARF 2 extensions */
+  .debug_weaknames 0 : { *(.debug_weaknames) }
+  .debug_funcnames 0 : { *(.debug_funcnames) }
+  .debug_typenames 0 : { *(.debug_typenames) }
+  .debug_varnames  0 : { *(.debug_varnames) }
 }
_
