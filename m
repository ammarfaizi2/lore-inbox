Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030179AbWJWTtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030179AbWJWTtz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 15:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbWJWTt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 15:49:27 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:31926 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S965040AbWJWTsu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 15:48:50 -0400
Date: Mon, 23 Oct 2006 15:37:48 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: [PATCH 7/11] i386: Kallsyms generate relocatable symbols
Message-ID: <20061023193748.GH13263@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061023192456.GA13263@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061023192456.GA13263@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Print the addresses of non-absolute symbols relative to _text
so that ld will generate relocations.  Allowing a relocatable
kernel to relocate them.  We can't actually use the symbol names
because kallsyms includes static symbols that are not exported
from their object files.

Add the _text symbol definitions to the architectures which don't
define it otherwise linker will fail.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/h8300/kernel/vmlinux.lds.S     |    1 +
 arch/m68knommu/kernel/vmlinux.lds.S |    1 +
 arch/powerpc/kernel/vmlinux.lds.S   |    1 +
 arch/ppc/kernel/vmlinux.lds.S       |    1 +
 arch/sparc/kernel/vmlinux.lds.S     |    1 +
 arch/sparc64/kernel/vmlinux.lds.S   |    1 +
 arch/v850/kernel/vmlinux.lds.S      |    1 +
 scripts/kallsyms.c                  |   20 +++++++++++++++++---
 8 files changed, 24 insertions(+), 3 deletions(-)

diff -puN arch/h8300/kernel/vmlinux.lds.S~kallsyms.c-Generate-relocatable-symbols arch/h8300/kernel/vmlinux.lds.S
--- linux-2.6.19-rc2-git7-reloc/arch/h8300/kernel/vmlinux.lds.S~kallsyms.c-Generate-relocatable-symbols	2006-10-23 13:15:21.000000000 -0400
+++ linux-2.6.19-rc2-git7-reloc-root/arch/h8300/kernel/vmlinux.lds.S	2006-10-23 13:15:21.000000000 -0400
@@ -70,6 +70,7 @@ SECTIONS
 #endif
         .text :
 	{
+	_text = .;
 #if defined(CONFIG_ROMKERNEL)
 	*(.int_redirect)
 #endif
diff -puN arch/m68knommu/kernel/vmlinux.lds.S~kallsyms.c-Generate-relocatable-symbols arch/m68knommu/kernel/vmlinux.lds.S
--- linux-2.6.19-rc2-git7-reloc/arch/m68knommu/kernel/vmlinux.lds.S~kallsyms.c-Generate-relocatable-symbols	2006-10-23 13:15:21.000000000 -0400
+++ linux-2.6.19-rc2-git7-reloc-root/arch/m68knommu/kernel/vmlinux.lds.S	2006-10-23 13:15:21.000000000 -0400
@@ -60,6 +60,7 @@ SECTIONS {
 #endif
 
 	.text : {
+		_text = .;
 		_stext = . ;
         	*(.text)
 		SCHED_TEXT
diff -puN arch/powerpc/kernel/vmlinux.lds.S~kallsyms.c-Generate-relocatable-symbols arch/powerpc/kernel/vmlinux.lds.S
--- linux-2.6.19-rc2-git7-reloc/arch/powerpc/kernel/vmlinux.lds.S~kallsyms.c-Generate-relocatable-symbols	2006-10-23 13:15:21.000000000 -0400
+++ linux-2.6.19-rc2-git7-reloc-root/arch/powerpc/kernel/vmlinux.lds.S	2006-10-23 13:15:21.000000000 -0400
@@ -33,6 +33,7 @@ SECTIONS
 
 	/* Text and gots */
 	.text : {
+		_text = .;
 		*(.text .text.*)
 		SCHED_TEXT
 		LOCK_TEXT
diff -puN arch/ppc/kernel/vmlinux.lds.S~kallsyms.c-Generate-relocatable-symbols arch/ppc/kernel/vmlinux.lds.S
--- linux-2.6.19-rc2-git7-reloc/arch/ppc/kernel/vmlinux.lds.S~kallsyms.c-Generate-relocatable-symbols	2006-10-23 13:15:21.000000000 -0400
+++ linux-2.6.19-rc2-git7-reloc-root/arch/ppc/kernel/vmlinux.lds.S	2006-10-23 13:15:21.000000000 -0400
@@ -31,6 +31,7 @@ SECTIONS
   .plt : { *(.plt) }
   .text      :
   {
+    _text = .;
     *(.text)
     SCHED_TEXT
     LOCK_TEXT
diff -puN arch/sparc64/kernel/vmlinux.lds.S~kallsyms.c-Generate-relocatable-symbols arch/sparc64/kernel/vmlinux.lds.S
--- linux-2.6.19-rc2-git7-reloc/arch/sparc64/kernel/vmlinux.lds.S~kallsyms.c-Generate-relocatable-symbols	2006-10-23 13:15:21.000000000 -0400
+++ linux-2.6.19-rc2-git7-reloc-root/arch/sparc64/kernel/vmlinux.lds.S	2006-10-23 13:15:21.000000000 -0400
@@ -13,6 +13,7 @@ SECTIONS
   . = 0x4000;
   .text 0x0000000000404000 :
   {
+    _text = .;
     *(.text)
     SCHED_TEXT
     LOCK_TEXT
diff -puN arch/sparc/kernel/vmlinux.lds.S~kallsyms.c-Generate-relocatable-symbols arch/sparc/kernel/vmlinux.lds.S
--- linux-2.6.19-rc2-git7-reloc/arch/sparc/kernel/vmlinux.lds.S~kallsyms.c-Generate-relocatable-symbols	2006-10-23 13:15:21.000000000 -0400
+++ linux-2.6.19-rc2-git7-reloc-root/arch/sparc/kernel/vmlinux.lds.S	2006-10-23 13:15:21.000000000 -0400
@@ -11,6 +11,7 @@ SECTIONS
   . = 0x10000 + SIZEOF_HEADERS;
   .text 0xf0004000 :
   {
+    _text = .;
     *(.text)
     SCHED_TEXT
     LOCK_TEXT
diff -puN arch/v850/kernel/vmlinux.lds.S~kallsyms.c-Generate-relocatable-symbols arch/v850/kernel/vmlinux.lds.S
--- linux-2.6.19-rc2-git7-reloc/arch/v850/kernel/vmlinux.lds.S~kallsyms.c-Generate-relocatable-symbols	2006-10-23 13:15:21.000000000 -0400
+++ linux-2.6.19-rc2-git7-reloc-root/arch/v850/kernel/vmlinux.lds.S	2006-10-23 13:15:21.000000000 -0400
@@ -90,6 +90,7 @@
 
 /* Kernel text segment, and some constant data areas.  */
 #define TEXT_CONTENTS							      \
+		_text = .;						      \
 		__stext = . ;						      \
         	*(.text)						      \
 		SCHED_TEXT						      \
diff -puN scripts/kallsyms.c~kallsyms.c-Generate-relocatable-symbols scripts/kallsyms.c
--- linux-2.6.19-rc2-git7-reloc/scripts/kallsyms.c~kallsyms.c-Generate-relocatable-symbols	2006-10-23 13:15:21.000000000 -0400
+++ linux-2.6.19-rc2-git7-reloc-root/scripts/kallsyms.c	2006-10-23 13:15:21.000000000 -0400
@@ -43,7 +43,7 @@ struct sym_entry {
 
 static struct sym_entry *table;
 static unsigned int table_size, table_cnt;
-static unsigned long long _stext, _etext, _sinittext, _einittext, _sextratext, _eextratext;
+static unsigned long long _text, _stext, _etext, _sinittext, _einittext, _sextratext, _eextratext;
 static int all_symbols = 0;
 static char symbol_prefix_char = '\0';
 
@@ -91,7 +91,9 @@ static int read_symbol(FILE *in, struct 
 		sym++;
 
 	/* Ignore most absolute/undefined (?) symbols. */
-	if (strcmp(sym, "_stext") == 0)
+	if (strcmp(sym, "_text") == 0)
+		_text = s->addr;
+	else if (strcmp(sym, "_stext") == 0)
 		_stext = s->addr;
 	else if (strcmp(sym, "_etext") == 0)
 		_etext = s->addr;
@@ -265,9 +267,21 @@ static void write_src(void)
 
 	printf(".data\n");
 
+	/* Provide proper symbols relocatability by their '_text'
+	 * relativeness.  The symbol names cannot be used to construct
+	 * normal symbol references as the list of symbols contains
+	 * symbols that are declared static and are private to their
+	 * .o files.  This prevents .tmp_kallsyms.o or any other
+	 * object from referencing them.
+	 */
 	output_label("kallsyms_addresses");
 	for (i = 0; i < table_cnt; i++) {
-		printf("\tPTR\t%#llx\n", table[i].addr);
+		if (toupper(table[i].sym[0]) != 'A') {
+			printf("\tPTR\t_text + %#llx\n",
+				table[i].addr - _text);
+		} else {
+			printf("\tPTR\t%#llx\n", table[i].addr);
+		}
 	}
 	printf("\n");
 
_
