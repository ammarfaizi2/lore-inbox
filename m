Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129641AbRAOIX7>; Mon, 15 Jan 2001 03:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129737AbRAOIXj>; Mon, 15 Jan 2001 03:23:39 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:21379 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129641AbRAOIXd>; Mon, 15 Jan 2001 03:23:33 -0500
From: Christoph Rohland <cr@sap.com>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [Patch] memparse should return long long
Organisation: SAP LinuxLab
Date: 15 Jan 2001 09:22:19 +0100
Message-ID: <qwwu271jkck.fsf@sap.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch lets memparse return a long long. This is needed
to use mem= on highmem machines.

Greetings
		Christoph

diff -uNr 2.4.0-ac/arch/i386/kernel/setup.c 2.4.0-ac-memparse/arch/i386/kernel/setup.c
--- 2.4.0-ac/arch/i386/kernel/setup.c	Tue Jan  2 21:57:54 2001
+++ 2.4.0-ac-memparse/arch/i386/kernel/setup.c	Sun Jan 14 22:21:52 2001
@@ -558,7 +558,7 @@
 				 * blow away any automatically generated
 				 * size
 				 */
-				unsigned long start_at, mem_size;
+				unsigned long long start_at, mem_size;
  
 				if (usermem == 0) {
 					/* first time in: zap the whitelist
diff -uNr 2.4.0-ac/include/linux/kernel.h 2.4.0-ac-memparse/include/linux/kernel.h
--- 2.4.0-ac/include/linux/kernel.h	Sun Dec 17 12:54:01 2000
+++ 2.4.0-ac-memparse/include/linux/kernel.h	Sun Jan 14 22:21:52 2001
@@ -62,7 +62,7 @@
 extern int vsprintf(char *buf, const char *, va_list);
 extern int get_option(char **str, int *pint);
 extern char *get_options(char *str, int nints, int *ints);
-extern unsigned long memparse(char *ptr, char **retptr);
+extern unsigned long long memparse(char *ptr, char **retptr);
 extern void dev_probe_lock(void);
 extern void dev_probe_unlock(void);
 
diff -uNr 2.4.0-ac/lib/cmdline.c 2.4.0-ac-memparse/lib/cmdline.c
--- 2.4.0-ac/lib/cmdline.c	Mon Aug 28 11:42:45 2000
+++ 2.4.0-ac-memparse/lib/cmdline.c	Mon Jan 15 09:06:14 2001
@@ -93,9 +93,9 @@
  *	megabyte, or one gigabyte, respectively.
  */
 
-unsigned long memparse (char *ptr, char **retptr)
+unsigned long long memparse (char *ptr, char **retptr)
 {
-	unsigned long ret = simple_strtoul (ptr, retptr, 0);
+	unsigned long long ret = simple_strtoul (ptr, retptr, 0);
 
 	switch (**retptr) {
 	case 'G':
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
