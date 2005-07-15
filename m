Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbVGOWUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbVGOWUb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 18:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbVGOWO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 18:14:57 -0400
Received: from smtp04.auna.com ([62.81.186.14]:39134 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S262111AbVGOWOr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 18:14:47 -0400
Date: Fri, 15 Jul 2005 22:14:43 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: [PATCH] signed char fixes for scripts
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1121465068l.13352l.0l@werewolf.able.es> (from
	jamagallon@able.es on Sat Jul 16 00:04:28 2005)
X-Mailer: Balsa 2.3.4
Message-Id: <1121465683l.13352l.5l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.215.11] Login:jamagallon@able.es Fecha:Sat, 16 Jul 2005 00:14:43 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.16, J.A. Magallon wrote:
> 
> On 07.15, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm1/
> > 

This time I did not break anything... and they shut up gcc4 ;)

--- linux-2.6.12-jam1/scripts/mod/sumversion.c.orig	2005-06-21 23:44:30.000000000 +0200
+++ linux-2.6.12-jam1/scripts/mod/sumversion.c	2005-06-21 23:47:09.000000000 +0200
@@ -252,9 +252,9 @@
 }
 
 /* FIXME: Handle .s files differently (eg. # starts comments) --RR */
-static int parse_file(const signed char *fname, struct md4_ctx *md)
+static int parse_file(const char *fname, struct md4_ctx *md)
 {
-	signed char *file;
+	char *file;
 	unsigned long i, len;
 
 	file = grab_file(fname, &len);
@@ -332,7 +332,7 @@
 	   Sum all files in the same dir or subdirs.
 	*/
 	while ((line = get_next_line(&pos, file, flen)) != NULL) {
-		signed char* p = line;
+		char* p = line;
 		if (strncmp(line, "deps_", sizeof("deps_")-1) == 0) {
 			check_files = 1;
 			continue;
@@ -458,7 +458,7 @@
 	close(fd);
 }
 
-static int strip_rcs_crap(signed char *version)
+static int strip_rcs_crap(char *version)
 {
 	unsigned int len, full_len;
 
--- linux-2.6.12-jam1/scripts/lxdialog/inputbox.c.orig	2005-06-21 23:40:27.000000000 +0200
+++ linux-2.6.12-jam1/scripts/lxdialog/inputbox.c	2005-06-21 23:42:39.000000000 +0200
@@ -21,7 +21,7 @@
 
 #include "dialog.h"
 
-unsigned char dialog_input_result[MAX_LEN + 1];
+char dialog_input_result[MAX_LEN + 1];
 
 /*
  *  Print the termination buttons
@@ -48,7 +48,7 @@
 {
     int i, x, y, box_y, box_x, box_width;
     int input_x = 0, scroll = 0, key = 0, button = -1;
-    unsigned char *instr = dialog_input_result;
+    char *instr = dialog_input_result;
     WINDOW *dialog;
 
     /* center dialog box on screen */
--- linux-2.6.12-jam1/scripts/lxdialog/dialog.h.orig	2005-06-21 23:42:55.000000000 +0200
+++ linux-2.6.12-jam1/scripts/lxdialog/dialog.h	2005-06-21 23:43:19.000000000 +0200
@@ -163,7 +163,7 @@
 int dialog_checklist (const char *title, const char *prompt, int height,
 		int width, int list_height, int item_no,
 		const char * const * items, int flag);
-extern unsigned char dialog_input_result[];
+extern char dialog_input_result[];
 int dialog_inputbox (const char *title, const char *prompt, int height,
 		int width, const char *init);
 
--- linux-2.6.12-jam1/scripts/conmakehash.c.orig	2005-06-22 00:16:58.000000000 +0200
+++ linux-2.6.12-jam1/scripts/conmakehash.c	2005-06-22 00:17:21.000000000 +0200
@@ -33,7 +33,7 @@
 
 int getunicode(char **p0)
 {
-  unsigned char *p = *p0;
+  char *p = *p0;
 
   while (*p == ' ' || *p == '\t')
     p++;
--- linux-2.6.12-jam7/scripts/kallsyms.c.orig	2005-07-06 00:16:39.000000000 +0200
+++ linux-2.6.12-jam7/scripts/kallsyms.c	2005-07-06 00:42:24.000000000 +0200
@@ -166,9 +166,9 @@
 		 * move then they may get dropped in pass 2, which breaks the
 		 * kallsyms rules.
 		 */
-		if ((s->addr == _etext && strcmp(s->sym + offset, "_etext")) ||
-		    (s->addr == _einittext && strcmp(s->sym + offset, "_einittext")) ||
-		    (s->addr == _eextratext && strcmp(s->sym + offset, "_eextratext")))
+		if ((s->addr == _etext && strcmp((char*)s->sym + offset, "_etext")) ||
+		    (s->addr == _einittext && strcmp((char*)s->sym + offset, "_einittext")) ||
+		    (s->addr == _eextratext && strcmp((char*)s->sym + offset, "_eextratext")))
 			return 0;
 	}
 


--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.12-jam9 (gcc 4.0.1 (4.0.1-0.2mdk for Mandriva Linux release 2006.0))


