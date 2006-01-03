Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbWACN3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWACN3J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWACN2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:28:22 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:45061 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932362AbWACNZi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:25:38 -0500
Subject: [PATCH 15/26] kbuild: escape '#' in .target.cmd files
In-Reply-To: <20060103132035.GA17485@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Tue, 3 Jan 2006 14:25:26 +0100
Message-Id: <11362947263762@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@mars.ravnborg.org>
Date: 1135549274 +0100

Commandlines are contained in the .<target>.cmd files and in case they
contain a '#' char make see this as start of comment.
Teach fixdep to escape the '#' char so make will assing the full commandline.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/basic/fixdep.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

4d99f93bdaa1ab49188cac67b4aae9180f8e3960
diff --git a/scripts/basic/fixdep.c b/scripts/basic/fixdep.c
index 0b61bea..679124b 100644
--- a/scripts/basic/fixdep.c
+++ b/scripts/basic/fixdep.c
@@ -130,9 +130,22 @@ void usage(void)
 	exit(1);
 }
 
+/*
+ * Print out the commandline prefixed with cmd_<target filename> :=
+ * If commandline contains '#' escape with '\' so make to not see
+ * the '#' as a start-of-comment symbol
+ **/
 void print_cmdline(void)
 {
-	printf("cmd_%s := %s\n\n", target, cmdline);
+	char *p = cmdline;
+
+	printf("cmd_%s := ", target);
+	for (; *p; p++) {
+		if (*p == '#')
+			printf("\\");
+		printf("%c", *p);
+	}
+	printf("\n\n");
 }
 
 char * str_config  = NULL;
-- 
1.0.6

