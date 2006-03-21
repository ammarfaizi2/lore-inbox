Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030460AbWCUQ2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030460AbWCUQ2t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030396AbWCUQVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:21:17 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:25868 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932410AbWCUQVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:10 -0500
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 03/46] kbuild: apply CodingStyle to modpost.c
In-Reply-To: <11429580542142-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:54 +0100
Message-Id: <11429580543482-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just some light CodingStyle updates - no functional changes.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/mod/modpost.c |  124 +++++++++++++++++++++----------------------------
 1 files changed, 54 insertions(+), 70 deletions(-)

5c3ead8c72788d36d34c9f1689fb529d1339b405
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index a3c57ec..4a2f2e3 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -21,8 +21,7 @@ int have_vmlinux = 0;
 /* Is CONFIG_MODULE_SRCVERSION_ALL set? */
 static int all_versions = 0;
 
-void
-fatal(const char *fmt, ...)
+void fatal(const char *fmt, ...)
 {
 	va_list arglist;
 
@@ -35,8 +34,7 @@ fatal(const char *fmt, ...)
 	exit(1);
 }
 
-void
-warn(const char *fmt, ...)
+void warn(const char *fmt, ...)
 {
 	va_list arglist;
 
@@ -59,8 +57,7 @@ void *do_nofail(void *ptr, const char *e
 
 static struct module *modules;
 
-struct module *
-find_module(char *modname)
+static struct module *find_module(char *modname)
 {
 	struct module *mod;
 
@@ -70,8 +67,7 @@ find_module(char *modname)
 	return mod;
 }
 
-struct module *
-new_module(char *modname)
+static struct module *new_module(char *modname)
 {
 	struct module *mod;
 	char *p, *s;
@@ -122,11 +118,12 @@ static inline unsigned int tdb_hash(cons
 	return (1103515243 * value + 12345);
 }
 
-/* Allocate a new symbols for use in the hash of exported symbols or
- * the list of unresolved symbols per module */
-
-struct symbol *
-alloc_symbol(const char *name, unsigned int weak, struct symbol *next)
+/**
+ * Allocate a new symbols for use in the hash of exported symbols or
+ * the list of unresolved symbols per module
+ **/
+static struct symbol *alloc_symbol(const char *name, unsigned int weak,
+				   struct symbol *next)
 {
 	struct symbol *s = NOFAIL(malloc(sizeof(*s) + strlen(name) + 1));
 
@@ -138,9 +135,8 @@ alloc_symbol(const char *name, unsigned 
 }
 
 /* For the hash of exported symbols */
-
-void
-new_symbol(const char *name, struct module *module, unsigned int *crc)
+static void new_symbol(const char *name, struct module *module,
+		       unsigned int *crc)
 {
 	unsigned int hash;
 	struct symbol *new;
@@ -154,8 +150,7 @@ new_symbol(const char *name, struct modu
 	}
 }
 
-struct symbol *
-find_symbol(const char *name)
+static struct symbol *find_symbol(const char *name)
 {
 	struct symbol *s;
 
@@ -170,10 +165,12 @@ find_symbol(const char *name)
 	return NULL;
 }
 
-/* Add an exported symbol - it may have already been added without a
- * CRC, in this case just update the CRC */
-void
-add_exported_symbol(const char *name, struct module *module, unsigned int *crc)
+/**
+ * Add an exported symbol - it may have already been added without a
+ * CRC, in this case just update the CRC
+ **/
+static void add_exported_symbol(const char *name, struct module *module,
+				unsigned int *crc)
 {
 	struct symbol *s = find_symbol(name);
 
@@ -187,8 +184,7 @@ add_exported_symbol(const char *name, st
 	}
 }
 
-void *
-grab_file(const char *filename, unsigned long *size)
+void *grab_file(const char *filename, unsigned long *size)
 {
 	struct stat st;
 	void *map;
@@ -207,13 +203,12 @@ grab_file(const char *filename, unsigned
 	return map;
 }
 
-/*
-   Return a copy of the next line in a mmap'ed file.
-   spaces in the beginning of the line is trimmed away.
-   Return a pointer to a static buffer.
-*/
-char*
-get_next_line(unsigned long *pos, void *file, unsigned long size)
+/**
+  * Return a copy of the next line in a mmap'ed file.
+  * spaces in the beginning of the line is trimmed away.
+  * Return a pointer to a static buffer.
+  **/
+char* get_next_line(unsigned long *pos, void *file, unsigned long size)
 {
 	static char line[4096];
 	int skip = 1;
@@ -243,14 +238,12 @@ get_next_line(unsigned long *pos, void *
 	return NULL;
 }
 
-void
-release_file(void *file, unsigned long size)
+void release_file(void *file, unsigned long size)
 {
 	munmap(file, size);
 }
 
-void
-parse_elf(struct elf_info *info, const char *filename)
+static void parse_elf(struct elf_info *info, const char *filename)
 {
 	unsigned int i;
 	Elf_Ehdr *hdr = info->hdr;
@@ -318,8 +311,7 @@ parse_elf(struct elf_info *info, const c
 	fatal("%s is truncated.\n", filename);
 }
 
-void
-parse_elf_finish(struct elf_info *info)
+static void parse_elf_finish(struct elf_info *info)
 {
 	release_file(info->hdr, info->size);
 }
@@ -327,9 +319,8 @@ parse_elf_finish(struct elf_info *info)
 #define CRC_PFX     "__crc_"
 #define KSYMTAB_PFX "__ksymtab_"
 
-void
-handle_modversions(struct module *mod, struct elf_info *info,
-		   Elf_Sym *sym, const char *symname)
+static void handle_modversions(struct module *mod, struct elf_info *info,
+			       Elf_Sym *sym, const char *symname)
 {
 	unsigned int crc;
 
@@ -397,8 +388,7 @@ handle_modversions(struct module *mod, s
 	}
 }
 
-int
-is_vmlinux(const char *modname)
+static int is_vmlinux(const char *modname)
 {
 	const char *myname;
 
@@ -410,7 +400,9 @@ is_vmlinux(const char *modname)
 	return strcmp(myname, "vmlinux") == 0;
 }
 
-/* Parse tag=value strings from .modinfo section */
+/**
+ * Parse tag=value strings from .modinfo section
+ **/
 static char *next_string(char *string, unsigned long *secsize)
 {
 	/* Skip non-zero chars */
@@ -443,8 +435,7 @@ static char *get_modinfo(void *modinfo, 
 	return NULL;
 }
 
-void
-read_symbols(char *modname)
+static void read_symbols(char *modname)
 {
 	const char *symname;
 	char *version;
@@ -496,8 +487,8 @@ read_symbols(char *modname)
  * following helper, then compare to the file on disk and
  * only update the later if anything changed */
 
-void __attribute__((format(printf, 2, 3)))
-buf_printf(struct buffer *buf, const char *fmt, ...)
+void __attribute__((format(printf, 2, 3))) buf_printf(struct buffer *buf,
+						      const char *fmt, ...)
 {
 	char tmp[SZ];
 	int len;
@@ -514,8 +505,7 @@ buf_printf(struct buffer *buf, const cha
 	va_end(ap);
 }
 
-void
-buf_write(struct buffer *buf, const char *s, int len)
+void buf_write(struct buffer *buf, const char *s, int len)
 {
 	if (buf->size - buf->pos < len) {
 		buf->size += len;
@@ -525,10 +515,10 @@ buf_write(struct buffer *buf, const char
 	buf->pos += len;
 }
 
-/* Header for the generated file */
-
-void
-add_header(struct buffer *b, struct module *mod)
+/**
+ * Header for the generated file
+ **/
+static void add_header(struct buffer *b, struct module *mod)
 {
 	buf_printf(b, "#include <linux/module.h>\n");
 	buf_printf(b, "#include <linux/vermagic.h>\n");
@@ -548,10 +538,10 @@ add_header(struct buffer *b, struct modu
 	buf_printf(b, "};\n");
 }
 
-/* Record CRCs for unresolved symbols */
-
-void
-add_versions(struct buffer *b, struct module *mod)
+/**
+ * Record CRCs for unresolved symbols
+ **/
+static void add_versions(struct buffer *b, struct module *mod)
 {
 	struct symbol *s, *exp;
 
@@ -591,8 +581,8 @@ add_versions(struct buffer *b, struct mo
 	buf_printf(b, "};\n");
 }
 
-void
-add_depends(struct buffer *b, struct module *mod, struct module *modules)
+static void add_depends(struct buffer *b, struct module *mod,
+			struct module *modules)
 {
 	struct symbol *s;
 	struct module *m;
@@ -622,8 +612,7 @@ add_depends(struct buffer *b, struct mod
 	buf_printf(b, "\";\n");
 }
 
-void
-add_srcversion(struct buffer *b, struct module *mod)
+static void add_srcversion(struct buffer *b, struct module *mod)
 {
 	if (mod->srcversion[0]) {
 		buf_printf(b, "\n");
@@ -632,8 +621,7 @@ add_srcversion(struct buffer *b, struct 
 	}
 }
 
-void
-write_if_changed(struct buffer *b, const char *fname)
+static void write_if_changed(struct buffer *b, const char *fname)
 {
 	char *tmp;
 	FILE *file;
@@ -677,8 +665,7 @@ write_if_changed(struct buffer *b, const
 	fclose(file);
 }
 
-void
-read_dump(const char *fname)
+static void read_dump(const char *fname)
 {
 	unsigned long size, pos = 0;
 	void *file = grab_file(fname, &size);
@@ -719,8 +706,7 @@ fail:
 	fatal("parse error in symbol dump file\n");
 }
 
-void
-write_dump(const char *fname)
+static void write_dump(const char *fname)
 {
 	struct buffer buf = { };
 	struct symbol *symbol;
@@ -744,8 +730,7 @@ write_dump(const char *fname)
 	write_if_changed(&buf, fname);
 }
 
-int
-main(int argc, char **argv)
+int main(int argc, char **argv)
 {
 	struct module *mod;
 	struct buffer buf = { };
@@ -800,4 +785,3 @@ main(int argc, char **argv)
 
 	return 0;
 }
-
-- 
1.0.GIT


