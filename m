Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265635AbSKASDw>; Fri, 1 Nov 2002 13:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265642AbSKASDw>; Fri, 1 Nov 2002 13:03:52 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:44957 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265635AbSKASDw>; Fri, 1 Nov 2002 13:03:52 -0500
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.45: fix fs capabilities initialization
Date: Fri, 01 Nov 2002 19:10:16 +0100
Message-ID: <87vg3h6u0n.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements filesystem capabilities. It allows to run
privileged executables without the need for suid root.

Changes:
- recognize new capability db immediately instead of after the next
  mount

The complete patch is available at:
<http://home.t-online.de/home/olaf.dietsche/linux/capability/>

Regards, Olaf.

diff -urN a/fs/fscaps.c b/fs/fscaps.c
--- a/fs/fscaps.c	Fri Nov  1 18:52:41 2002
+++ b/fs/fscaps.c	Fri Nov  1 02:06:15 2002
@@ -252,7 +252,7 @@
 		return;
 
 	if (__fscap_lookup(mnt, &nd))
-		return;
+		nd.dentry = NULL;
 
 	__info_init(mnt, nd.dentry);
 }
