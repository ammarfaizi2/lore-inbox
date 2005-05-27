Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262644AbVE0WZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262644AbVE0WZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 18:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262615AbVE0WYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 18:24:39 -0400
Received: from smtp06.auna.com ([62.81.186.16]:12438 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S262634AbVE0WVv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 18:21:51 -0400
Date: Fri, 27 May 2005 22:21:43 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Kill signed chars !!! [was Re: 2.6.12-rc5-mm1]
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
References: <20050525134933.5c22234a.akpm@osdl.org>
In-Reply-To: <20050525134933.5c22234a.akpm@osdl.org> (from akpm@osdl.org on
	Wed May 25 22:49:33 2005)
X-Mailer: Balsa 2.3.2
Message-Id: <1117232503l.24619l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.219.120] Login:jamagallon@able.es Fecha:Sat, 28 May 2005 00:21:44 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... and make gcc4 happy.

On 05.25, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc5/2.6.12-rc5-mm1/
> 
> 
> - Again, if there are patches in here which you think should be merged in
>   2.6.12, please point them out to me.
> 

scripts/ is full of mismatches between char* params an signed char* arguments,
and viceversa. gcc4 now complaints loud about this. Patch below deletes all
those 'signed'. Anyways, which was the purpose of declaring 'signed char's
to store text ?

--- linux-2.6.12-rc5-mm1/scripts/kconfig/mconf.c.orig	2005-05-28 00:11:01.000000000 +0200
+++ linux-2.6.12-rc5-mm1/scripts/kconfig/mconf.c	2005-05-28 00:11:07.000000000 +0200
@@ -254,8 +254,8 @@
 	"          USB$ => find all CONFIG_ symbols ending with USB\n"
 	"\n");
 
-static signed char buf[4096], *bufptr = buf;
-static signed char input_buf[4096];
+static char buf[4096], *bufptr = buf;
+static char input_buf[4096];
 static char filename[PATH_MAX+1] = ".config";
 static char *args[1024], **argptr = args;
 static int indent;
--- linux-2.6.12-rc5-mm1/scripts/kconfig/confdata.c.orig	2005-05-28 00:11:23.000000000 +0200
+++ linux-2.6.12-rc5-mm1/scripts/kconfig/confdata.c	2005-05-28 00:11:33.000000000 +0200
@@ -27,10 +27,10 @@
 	NULL,
 };
 
-static char *conf_expand_value(const signed char *in)
+static char *conf_expand_value(const char *in)
 {
 	struct symbol *sym;
-	const signed char *src;
+	const char *src;
 	static char res_value[SYMBOL_MAXLENGTH];
 	char *dst, name[SYMBOL_MAXLENGTH];
 
--- linux-2.6.12-rc5-mm1/scripts/kconfig/conf.c.orig	2005-05-28 00:12:18.000000000 +0200
+++ linux-2.6.12-rc5-mm1/scripts/kconfig/conf.c	2005-05-28 00:12:28.000000000 +0200
@@ -31,14 +31,14 @@
 static int indent = 1;
 static int valid_stdin = 1;
 static int conf_cnt;
-static signed char line[128];
+static char line[128];
 static struct menu *rootEntry;
 
 static char nohelp_text[] = N_("Sorry, no help available for this option yet.\n");
 
-static void strip(signed char *str)
+static void strip(char *str)
 {
-	signed char *p = str;
+	char *p = str;
 	int l;
 
 	while ((isspace(*p)))
--- linux-2.6.12-rc5-mm1/scripts/basic/fixdep.c.orig	2005-05-28 00:00:02.000000000 +0200
+++ linux-2.6.12-rc5-mm1/scripts/basic/fixdep.c	2005-05-28 00:07:27.000000000 +0200
@@ -212,23 +212,23 @@
 		if (*p == '_')
 			*p = '/';
 		else
-			*p = tolower((unsigned char)*p);
+			*p = tolower((int)*p);
 	}
 	printf("    $(wildcard include/config/%s.h) \\\n", s);
 }
 
-void parse_config_file(signed char *map, size_t len)
+void parse_config_file(char *map, size_t len)
 {
 	int *end = (int *) (map + len);
 	/* start at +1, so that p can never be < map */
 	int *m   = (int *) map + 1;
-	signed char *p, *q;
+	char *p, *q;
 
 	for (; m < end; m++) {
-		if (*m == INT_CONF) { p = (signed char *) m  ; goto conf; }
-		if (*m == INT_ONFI) { p = (signed char *) m-1; goto conf; }
-		if (*m == INT_NFIG) { p = (signed char *) m-2; goto conf; }
-		if (*m == INT_FIG_) { p = (signed char *) m-3; goto conf; }
+		if (*m == INT_CONF) { p = (char *) m  ; goto conf; }
+		if (*m == INT_ONFI) { p = (char *) m-1; goto conf; }
+		if (*m == INT_NFIG) { p = (char *) m-2; goto conf; }
+		if (*m == INT_FIG_) { p = (char *) m-3; goto conf; }
 		continue;
 	conf:
 		if (p > map + len - 7)
@@ -291,9 +291,9 @@
 
 void parse_dep_file(void *map, size_t len)
 {
-	signed char *m = map;
-	signed char *end = m + len;
-	signed char *p;
+	char *m = map;
+	char *end = m + len;
+	char *p;
 	char s[PATH_MAX];
 
 	p = strchr(m, ':');
--- linux-2.6.12-rc5-mm1/scripts/basic/docproc.c.orig	2005-05-28 00:09:23.000000000 +0200
+++ linux-2.6.12-rc5-mm1/scripts/basic/docproc.c	2005-05-28 00:10:12.000000000 +0200
@@ -52,7 +52,7 @@
 FILEONLY *externalfunctions;
 FILEONLY *symbolsonly;
 
-typedef void FILELINE(char * file, signed char * line);
+typedef void FILELINE(char * file, char * line);
 FILELINE * singlefunctions;
 FILELINE * entity_system;
 
@@ -148,9 +148,9 @@
  * Files are separated by tabs.
  */
 void adddep(char * file)		   { printf("\t%s", file); }
-void adddep2(char * file, signed char * line)     { line = line; adddep(file); }
+void adddep2(char * file, char * line)     { line = line; adddep(file); }
 void noaction(char * line)		   { line = line; }
-void noaction2(char * file, signed char * line)   { file = file; line = line; }
+void noaction2(char * file, char * line)   { file = file; line = line; }
 
 /* Echo the line without further action */
 void printline(char * line)               { printf("%s", line); }
@@ -179,8 +179,8 @@
 			perror(real_filename);
 		}
 		while(fgets(line, MAXLINESZ, fp)) {
-			signed char *p;
-			signed char *e;
+			char *p;
+			char *e;
 			if (((p = strstr(line, "EXPORT_SYMBOL_GPL")) != 0) ||
                             ((p = strstr(line, "EXPORT_SYMBOL")) != 0)) {
 				/* Skip EXPORT_SYMBOL{_GPL} */
@@ -253,7 +253,7 @@
  * Call kernel-doc with the following parameters:
  * kernel-doc -docbook -function function1 [-function function2]
  */
-void singfunc(char * filename, signed char * line)
+void singfunc(char * filename, char * line)
 {
 	char *vec[200]; /* Enough for specific functions */
         int i, idx = 0;
@@ -290,7 +290,7 @@
 void parse_file(FILE *infile)
 {
 	char line[MAXLINESZ];
-	signed char * s;
+	char * s;
 	while(fgets(line, MAXLINESZ, infile)) {
 		if (line[0] == '!') {
 			s = line + 2;
--- linux-2.6.12-rc5-mm1/scripts/basic/split-include.c.orig	2005-05-28 00:08:02.000000000 +0200
+++ linux-2.6.12-rc5-mm1/scripts/basic/split-include.c	2005-05-28 00:08:52.000000000 +0200
@@ -104,7 +104,7 @@
     /* Read config lines. */
     while (fgets(line, buffer_size, fp_config))
     {
-	const signed char * str_config;
+	const char * str_config;
 	int is_same;
 	int itarget;
 

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.11-jam20 (gcc 4.0.0 (4.0.0-3mdk for Mandriva Linux release 2006.0))


