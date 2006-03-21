Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030465AbWCUQYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030465AbWCUQYW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030435AbWCUQVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:21:30 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:29196 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030303AbWCUQVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:13 -0500
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 31/46] kbuild: fix section mismatch check for unwind on IA64
In-Reply-To: <11429580562637-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:56 +0100
Message-Id: <11429580562973-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Parameters to strstr() was reversed.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/mod/modpost.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

e835a39c1c1f023ef443f735b0e98b08660ae0e4
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index c4dc1d7..3b570b1 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -776,7 +776,7 @@ static int init_section_ref_ok(const cha
 		if (strncmp(*s, name, strlen(*s)) == 0)
 			return 1;
 	for (s = namelist3; *s; s++)
-		if (strstr(*s, name) != NULL)
+		if (strstr(name, *s) != NULL)
 			return 1;
 	return 0;
 }
@@ -842,7 +842,7 @@ static int exit_section_ref_ok(const cha
 		if (strncmp(*s, name, strlen(*s)) == 0)
 			return 1;
 	for (s = namelist3; *s; s++)
-		if (strstr(*s, name) != NULL)
+		if (strstr(name, *s) != NULL)
 			return 1;
 	return 0;
 }
-- 
1.0.GIT


