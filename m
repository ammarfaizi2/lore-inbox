Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbUAIMse (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 07:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUAIMse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 07:48:34 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:46232 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261492AbUAIMsX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 07:48:23 -0500
Subject: eliminating gcc warning...
From: "Yury V. Umanets" <umka@namesys.com>
To: Linux kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-OdKQS2rjjlZRCWJgDUi+"
Organization: NAMESYS
Message-Id: <1073652555.17813.9.camel@firefly>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 09 Jan 2004 15:49:16 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OdKQS2rjjlZRCWJgDUi+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello all,

I'm trying to eliminate all gcc warnings, which can be obtained by means
of using -Wall and -W gcc keys, in linux-2.6.1. I decided, that this
should be done step-by-step. And now I have made a patch for scripts
directory. See attachment.

If something wrong and someone is so kind to tell me about, I will be
very thankful.

-- 
umka

--=-OdKQS2rjjlZRCWJgDUi+
Content-Disposition: attachment; filename=linux-2.6.1-scripts-cleanup.diff
Content-Type: text/x-patch; name=linux-2.6.1-scripts-cleanup.diff; charset=koi8-r
Content-Transfer-Encoding: 7bit

diff -rupN ./linux-2.6.1.orig/scripts/file2alias.c ./linux-2.6.1/scripts/file2alias.c
--- ./linux-2.6.1.orig/scripts/file2alias.c	2004-01-09 09:59:33.000000000 +0300
+++ ./linux-2.6.1/scripts/file2alias.c	2004-01-09 15:20:33.000000000 +0300
@@ -127,10 +127,10 @@ static int do_pci_entry(const char *file
 	id->class_mask = TO_NATIVE(id->class_mask);
 
 	strcpy(alias, "pci:");
-	ADD(alias, "v", id->vendor != PCI_ANY_ID, id->vendor);
-	ADD(alias, "d", id->device != PCI_ANY_ID, id->device);
-	ADD(alias, "sv", id->subvendor != PCI_ANY_ID, id->subvendor);
-	ADD(alias, "sd", id->subdevice != PCI_ANY_ID, id->subdevice);
+	ADD(alias, "v", (int)id->vendor != PCI_ANY_ID, id->vendor);
+	ADD(alias, "d", (int)id->device != PCI_ANY_ID, id->device);
+	ADD(alias, "sv", (int)id->subvendor != PCI_ANY_ID, id->subvendor);
+	ADD(alias, "sd", (int)id->subdevice != PCI_ANY_ID, id->subdevice);
 
 	baseclass = (id->class) >> 16;
 	baseclass_mask = (id->class_mask) >> 16;
diff -rupN ./linux-2.6.1.orig/scripts/fixdep.c ./linux-2.6.1/scripts/fixdep.c
--- ./linux-2.6.1.orig/scripts/fixdep.c	2004-01-09 09:59:33.000000000 +0300
+++ ./linux-2.6.1/scripts/fixdep.c	2004-01-09 14:32:31.000000000 +0300
@@ -211,9 +211,9 @@ void use_config(char *m, int slen)
 
 void parse_config_file(char *map, size_t len)
 {
-	int *end = (int *) (map + len);
+	unsigned int *end = (int *) (map + len);
 	/* start at +1, so that p can never be < map */
-	int *m   = (int *) map + 1;
+	unsigned int *m   = (int *) map + 1;
 	char *p, *q;
 
 	for (; m < end; m++) {
@@ -356,7 +356,7 @@ void traps(void)
 {
 	static char test[] __attribute__((aligned(sizeof(int)))) = "CONF";
 
-	if (*(int *)test != INT_CONF) {
+	if (*(unsigned int *)test != INT_CONF) {
 		fprintf(stderr, "fixdep: sizeof(int) != 4 or wrong endianess? %#x\n",
 			*(int *)test);
 		exit(2);
diff -rupN ./linux-2.6.1.orig/scripts/genksyms/keywords.c_shipped ./linux-2.6.1/scripts/genksyms/keywords.c_shipped
--- ./linux-2.6.1.orig/scripts/genksyms/keywords.c_shipped	2004-01-09 10:00:13.000000000 +0300
+++ ./linux-2.6.1/scripts/genksyms/keywords.c_shipped	2004-01-09 15:19:51.000000000 +0300
@@ -62,70 +62,71 @@ is_reserved_word (register const char *s
 
   static const struct resword wordlist[] =
     {
-      {""}, {""}, {""}, {""},
+      {"", 0}, {"", 0}, {"", 0}, {"", 0},
       {"auto", AUTO_KEYW},
-      {""}, {""},
+      {"", 0}, {"", 0},
       {"__asm__", ASM_KEYW},
-      {""},
+      {"", 0},
       {"_restrict", RESTRICT_KEYW},
       {"__typeof__", TYPEOF_KEYW},
       {"__attribute", ATTRIBUTE_KEYW},
       {"__restrict__", RESTRICT_KEYW},
       {"__attribute__", ATTRIBUTE_KEYW},
-      {""},
+      {"", 0},
       {"__volatile", VOLATILE_KEYW},
-      {""},
+      {"", 0},
       {"__volatile__", VOLATILE_KEYW},
       {"EXPORT_SYMBOL", EXPORT_SYMBOL_KEYW},
-      {""}, {""}, {""},
+      {"", 0}, {"", 0}, {"", 0},
       {"EXPORT_SYMBOL_GPL", EXPORT_SYMBOL_KEYW},
       {"int", INT_KEYW},
       {"char", CHAR_KEYW},
-      {""}, {""},
+      {"", 0}, {"", 0},
       {"__const", CONST_KEYW},
       {"__inline", INLINE_KEYW},
       {"__const__", CONST_KEYW},
       {"__inline__", INLINE_KEYW},
-      {""}, {""}, {""}, {""},
+      {"", 0}, {"", 0}, {"", 0}, {"", 0},
       {"__asm", ASM_KEYW},
       {"extern", EXTERN_KEYW},
-      {""},
+      {"", 0},
       {"register", REGISTER_KEYW},
-      {""},
+      {"", 0},
       {"float", FLOAT_KEYW},
       {"typeof", TYPEOF_KEYW},
       {"typedef", TYPEDEF_KEYW},
-      {""}, {""},
+      {"", 0}, {"", 0},
       {"_Bool", BOOL_KEYW},
       {"double", DOUBLE_KEYW},
-      {""}, {""},
+      {"", 0}, {"", 0},
       {"enum", ENUM_KEYW},
-      {""}, {""}, {""},
+      {"", 0}, {"", 0}, {"", 0},
       {"volatile", VOLATILE_KEYW},
       {"void", VOID_KEYW},
       {"const", CONST_KEYW},
       {"short", SHORT_KEYW},
       {"struct", STRUCT_KEYW},
-      {""},
+      {"", 0},
       {"restrict", RESTRICT_KEYW},
-      {""},
+      {"", 0},
       {"__signed__", SIGNED_KEYW},
-      {""},
+      {"", 0},
       {"asm", ASM_KEYW},
-      {""}, {""},
+      {"", 0}, {"", 0},
       {"inline", INLINE_KEYW},
-      {""}, {""}, {""},
+      {"", 0}, {"", 0}, {"", 0},
       {"union", UNION_KEYW},
-      {""}, {""}, {""}, {""}, {""}, {""},
+      {"", 0}, {"", 0}, {"", 0}, {"", 0}, {"", 0}, {"", 0},
       {"static", STATIC_KEYW},
-      {""}, {""}, {""}, {""}, {""}, {""},
+      {"", 0}, {"", 0}, {"", 0}, {"", 0}, {"", 0}, {"", 0},
       {"__signed", SIGNED_KEYW},
-      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
-      {""}, {""}, {""}, {""}, {""},
+      {"", 0}, {"", 0}, {"", 0}, {"", 0}, {"", 0}, {"", 0}, 
+      {"", 0}, {"", 0}, {"", 0},
+      {"", 0}, {"", 0}, {"", 0}, {"", 0}, {"", 0},
       {"unsigned", UNSIGNED_KEYW},
-      {""}, {""}, {""}, {""},
+      {"", 0}, {"", 0}, {"", 0}, {"", 0},
       {"long", LONG_KEYW},
-      {""}, {""}, {""}, {""}, {""}, {""}, {""},
+      {"", 0}, {"", 0}, {"", 0}, {"", 0}, {"", 0}, {"", 0}, {"", 0},
       {"signed", SIGNED_KEYW}
     };
 
diff -rupN ./linux-2.6.1.orig/scripts/kconfig/confdata.c ./linux-2.6.1/scripts/kconfig/confdata.c
--- ./linux-2.6.1.orig/scripts/kconfig/confdata.c	2004-01-09 10:00:05.000000000 +0300
+++ ./linux-2.6.1/scripts/kconfig/confdata.c	2004-01-09 14:38:18.000000000 +0300
@@ -214,12 +214,14 @@ int conf_read(const char *name)
 			case no:
 				break;
 			case mod:
-				if (cs->user.tri == yes)
+				if (cs->user.tri == yes) {
 					/* warn? */;
+				}
 				break;
 			case yes:
-				if (cs->user.tri != no)
+				if (cs->user.tri != no) {
 					/* warn? */;
+				}
 				cs->user.val = sym;
 				break;
 			}
diff -rupN ./linux-2.6.1.orig/scripts/kconfig/mconf.c ./linux-2.6.1/scripts/kconfig/mconf.c
--- ./linux-2.6.1.orig/scripts/kconfig/mconf.c	2004-01-09 09:59:19.000000000 +0300
+++ ./linux-2.6.1/scripts/kconfig/mconf.c	2004-01-09 14:35:35.000000000 +0300
@@ -438,7 +438,8 @@ static void conf(struct menu *menu)
 	const char *prompt = menu_get_prompt(menu);
 	struct symbol *sym;
 	char active_entry[40];
-	int stat, type, i;
+	int stat, type;
+	unsigned int i;
 
 	unlink("lxdialog.scrltmp");
 	active_entry[0] = 0;
diff -rupN ./linux-2.6.1.orig/scripts/kconfig/menu.c ./linux-2.6.1/scripts/kconfig/menu.c
--- ./linux-2.6.1.orig/scripts/kconfig/menu.c	2004-01-09 10:00:02.000000000 +0300
+++ ./linux-2.6.1/scripts/kconfig/menu.c	2004-01-09 14:39:12.000000000 +0300
@@ -88,7 +88,7 @@ void menu_set_type(int type)
 {
 	struct symbol *sym = current_entry->sym;
 
-	if (sym->type == type)
+	if (sym->type == (unsigned int)type)
 		return;
 	if (sym->type == S_UNKNOWN) {
 		sym->type = type;
diff -rupN ./linux-2.6.1.orig/scripts/lxdialog/checklist.c ./linux-2.6.1/scripts/lxdialog/checklist.c
--- ./linux-2.6.1.orig/scripts/lxdialog/checklist.c	2004-01-09 09:59:33.000000000 +0300
+++ ./linux-2.6.1/scripts/lxdialog/checklist.c	2004-01-09 14:41:12.000000000 +0300
@@ -161,7 +161,7 @@ dialog_checklist (const char *title, con
     wattrset (dialog, dialog_attr);
     waddch (dialog, ACS_RTEE);
 
-    if (title != NULL && strlen(title) >= width-2 ) {
+    if (title != NULL && strlen(title) >= (unsigned int)(width-2)) {
 	/* truncate long title -- mec */
 	char * title2 = malloc(width-2+1);
 	memcpy( title2, title, width-2 );
@@ -195,7 +195,7 @@ dialog_checklist (const char *title, con
     /* Find length of longest item in order to center checklist */
     check_x = 0;
     for (i = 0; i < item_no; i++) 
-	check_x = MAX (check_x, + strlen (items[i * 3 + 1]) + 4);
+	check_x = MAX ((unsigned int)check_x, + strlen (items[i * 3 + 1]) + 4);
 
     check_x = (list_width - check_x) / 2;
     item_x = check_x + 4;
diff -rupN ./linux-2.6.1.orig/scripts/lxdialog/inputbox.c ./linux-2.6.1/scripts/lxdialog/inputbox.c
--- ./linux-2.6.1.orig/scripts/lxdialog/inputbox.c	2004-01-09 09:59:08.000000000 +0300
+++ ./linux-2.6.1/scripts/lxdialog/inputbox.c	2004-01-09 14:42:42.000000000 +0300
@@ -69,7 +69,7 @@ dialog_inputbox (const char *title, cons
     wattrset (dialog, dialog_attr);
     waddch (dialog, ACS_RTEE);
 
-    if (title != NULL && strlen(title) >= width-2 ) {
+    if (title != NULL && strlen(title) >= (unsigned int)(width-2)) {
 	/* truncate long title -- mec */
 	char * title2 = malloc(width-2+1);
 	memcpy( title2, title, width-2 );
diff -rupN ./linux-2.6.1.orig/scripts/lxdialog/menubox.c ./linux-2.6.1/scripts/lxdialog/menubox.c
--- ./linux-2.6.1.orig/scripts/lxdialog/menubox.c	2004-01-09 10:00:04.000000000 +0300
+++ ./linux-2.6.1/scripts/lxdialog/menubox.c	2004-01-09 14:45:59.000000000 +0300
@@ -193,7 +193,7 @@ dialog_menu (const char *title, const ch
     wbkgdset (dialog, dialog_attr & A_COLOR);
     waddch (dialog, ACS_RTEE);
 
-    if (title != NULL && strlen(title) >= width-2 ) {
+    if (title != NULL && strlen(title) >= (unsigned int)(width-2)) {
 	/* truncate long title -- mec */
 	char * title2 = malloc(width-2+1);
 	memcpy( title2, title, width-2 );
@@ -230,7 +230,7 @@ dialog_menu (const char *title, const ch
      */
     item_x = 0;
     for (i = 0; i < item_no; i++) {
-	item_x = MAX (item_x, MIN(menu_width, strlen (items[i * 2 + 1]) + 2));
+	item_x = MAX ((unsigned int)item_x, MIN((unsigned int)menu_width, strlen(items[i * 2 + 1]) + 2));
 	if (strcmp(current, items[i*2]) == 0) choice = i;
     }
 
diff -rupN ./linux-2.6.1.orig/scripts/lxdialog/msgbox.c ./linux-2.6.1/scripts/lxdialog/msgbox.c
--- ./linux-2.6.1.orig/scripts/lxdialog/msgbox.c	2004-01-09 09:59:44.000000000 +0300
+++ ./linux-2.6.1/scripts/lxdialog/msgbox.c	2004-01-09 14:46:23.000000000 +0300
@@ -43,7 +43,7 @@ dialog_msgbox (const char *title, const 
 
     draw_box (dialog, 0, 0, height, width, dialog_attr, border_attr);
 
-    if (title != NULL && strlen(title) >= width-2 ) {
+    if (title != NULL && strlen(title) >= (unsigned int)(width-2)) {
 	/* truncate long title -- mec */
 	char * title2 = malloc(width-2+1);
 	memcpy( title2, title, width-2 );
diff -rupN ./linux-2.6.1.orig/scripts/lxdialog/textbox.c ./linux-2.6.1/scripts/lxdialog/textbox.c
--- ./linux-2.6.1.orig/scripts/lxdialog/textbox.c	2004-01-09 10:00:02.000000000 +0300
+++ ./linux-2.6.1/scripts/lxdialog/textbox.c	2004-01-09 14:50:14.000000000 +0300
@@ -106,7 +106,7 @@ dialog_textbox (const char *title, const
     wbkgdset (dialog, dialog_attr & A_COLOR);
     waddch (dialog, ACS_RTEE);
 
-    if (title != NULL && strlen(title) >= width-2 ) {
+    if (title != NULL && strlen(title) >= (unsigned int)(width-2)) {
 	/* truncate long title -- mec */
 	char * title2 = malloc(width-2+1);
 	memcpy( title2, title, width-2 );
@@ -463,10 +463,10 @@ print_line (WINDOW * win, int row, int w
     char *line;
 
     line = get_line ();
-    line += MIN (strlen (line), hscroll);	/* Scroll horizontally */
+    line += MIN (strlen (line), (unsigned int)hscroll);	/* Scroll horizontally */
     wmove (win, row, 0);	/* move cursor to correct line */
     waddch (win, ' ');
-    waddnstr (win, line, MIN (strlen (line), width - 2));
+    waddnstr (win, line, MIN (strlen (line), (unsigned int)(width - 2)));
 
     getyx (win, y, x);
     /* Clear 'residue' of previous line */
diff -rupN ./linux-2.6.1.orig/scripts/lxdialog/util.c ./linux-2.6.1/scripts/lxdialog/util.c
--- ./linux-2.6.1.orig/scripts/lxdialog/util.c	2004-01-09 09:59:34.000000000 +0300
+++ ./linux-2.6.1/scripts/lxdialog/util.c	2004-01-09 15:11:40.000000000 +0300
@@ -231,7 +231,7 @@ print_autowrap (WINDOW * win, const char
 	    room = width - cur_x;
 	    wlen = strlen(word);
 	    if (wlen > room ||
-	       (newl && wlen < 4 && sp && wlen+1+strlen(sp) > room
+	       (newl && wlen < 4 && sp && wlen+1+(int)strlen(sp) > room
 		     && (!(sp2 = index(sp, ' ')) || wlen+1+(sp2-sp) > room))) {
 		cur_y++;
 		cur_x = x;
@@ -342,7 +342,8 @@ draw_shadow (WINDOW * win, int y, int x,
 int
 first_alpha(const char *string, const char *exempt)
 {
-	int i, in_paren=0, c;
+	int in_paren=0, c;
+	unsigned int i;
 
 	for (i = 0; i < strlen(string); i++) {
 		c = tolower(string[i]);
diff -rupN ./linux-2.6.1.orig/scripts/lxdialog/yesno.c ./linux-2.6.1/scripts/lxdialog/yesno.c
--- ./linux-2.6.1.orig/scripts/lxdialog/yesno.c	2004-01-09 09:59:33.000000000 +0300
+++ ./linux-2.6.1/scripts/lxdialog/yesno.c	2004-01-09 15:12:05.000000000 +0300
@@ -63,7 +63,7 @@ dialog_yesno (const char *title, const c
     wattrset (dialog, dialog_attr);
     waddch (dialog, ACS_RTEE);
 
-    if (title != NULL && strlen(title) >= width-2 ) {
+    if (title != NULL && strlen(title) >= (unsigned int)(width-2)) {
 	/* truncate long title -- mec */
 	char * title2 = malloc(width-2+1);
 	memcpy( title2, title, width-2 );
diff -rupN ./linux-2.6.1.orig/scripts/modpost.c ./linux-2.6.1/scripts/modpost.c
--- ./linux-2.6.1.orig/scripts/modpost.c	2004-01-09 09:59:10.000000000 +0300
+++ ./linux-2.6.1/scripts/modpost.c	2004-01-09 15:23:50.348598952 +0300
@@ -342,7 +342,7 @@ read_symbols(char *modname)
 {
 	const char *symname;
 	struct module *mod;
-	struct elf_info info = { };
+	struct elf_info info;
 	struct symbol *s;
 	Elf_Sym *sym;
 
@@ -350,6 +350,7 @@ read_symbols(char *modname)
 	 * unresolved symbols (since there'll be too many ;) */
 	have_vmlinux = is_vmlinux(modname);
 
+	memset(&info, 0, sizeof(info));
 	parse_elf(&info, modname);
 
 	mod = new_module(modname);
@@ -513,7 +514,7 @@ write_if_changed(struct buffer *b, const
 		goto close_write;
 
 	tmp = NOFAIL(malloc(b->pos));
-	if (fread(tmp, 1, b->pos, file) != b->pos)
+	if (fread(tmp, 1, b->pos, file) != (unsigned int)b->pos)
 		goto free_write;
 
 	if (memcmp(tmp, b->p, b->pos) != 0)
@@ -533,7 +534,7 @@ write_if_changed(struct buffer *b, const
 		perror(fname);
 		exit(1);
 	}
-	if (fwrite(b->p, 1, b->pos, file) != b->pos) {
+	if (fwrite(b->p, 1, b->pos, file) != (unsigned int)b->pos) {
 		perror(fname);
 		exit(1);
 	}
@@ -544,9 +545,10 @@ int
 main(int argc, char **argv)
 {
 	struct module *mod;
-	struct buffer buf = { };
+	struct buffer buf;
 	char fname[SZ];
 
+	memset(&buf, 0, sizeof(buf));
 	for (; argv[1]; argv++) {
 		read_symbols(argv[1]);
 	}

--=-OdKQS2rjjlZRCWJgDUi+--

