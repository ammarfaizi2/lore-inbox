Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbTEZFnf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 01:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264276AbTEZFnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 01:43:35 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:59552 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264275AbTEZFnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 01:43:32 -0400
Date: Mon, 26 May 2003 01:07:22 -0400
From: Ben Collins <bcollins@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove dead code in 53c7xx driver
Message-ID: <20030526050722.GQ2657@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While doing my strncpy duty, I came across some dead code in
53c7xx.c. Removed.


Index: linux-2.5/drivers/scsi/53c7xx.c
===================================================================
--- linux-2.5/drivers/scsi/53c7xx.c	(revision 10182)
+++ linux-2.5/drivers/scsi/53c7xx.c	(working copy)
@@ -360,41 +360,8 @@
 	{"","","","","","","",""};
 
 #define MAX_SETUP_STRINGS (sizeof(setup_strings) / sizeof(char *))
-#define SETUP_BUFFER_SIZE 200
-static char setup_buffer[SETUP_BUFFER_SIZE];
 static char setup_used[MAX_SETUP_STRINGS];
 
-void ncr53c7xx_setup (char *str, int *ints)
-{
-   int i;
-   char *p1, *p2;
-
-   p1 = setup_buffer;
-   *p1 = '\0';
-   if (str)
-      strncpy(p1, str, SETUP_BUFFER_SIZE - strlen(setup_buffer));
-   setup_buffer[SETUP_BUFFER_SIZE - 1] = '\0';
-   p1 = setup_buffer;
-   i = 0;
-   while (*p1 && (i < MAX_SETUP_STRINGS)) {
-      p2 = strchr(p1, ',');
-      if (p2) {
-         *p2 = '\0';
-         if (p1 != p2)
-            setup_strings[i] = p1;
-         p1 = p2 + 1;
-         i++;
-         }
-      else {
-         setup_strings[i] = p1;
-         break;
-         }
-      }
-   for (i=0; i<MAX_SETUP_STRINGS; i++)
-      setup_used[i] = 0;
-}
-
-
 /* check_setup_strings() returns index if key found, 0 if not
  */
 
