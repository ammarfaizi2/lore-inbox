Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279768AbRKMWc6>; Tue, 13 Nov 2001 17:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279749AbRKMWct>; Tue, 13 Nov 2001 17:32:49 -0500
Received: from mailg.telia.com ([194.22.194.26]:52715 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S279754AbRKMWcg>;
	Tue, 13 Nov 2001 17:32:36 -0500
From: "Per Persson" <per.persson@gnosjo.pp.se>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] search_one_table()
Date: Tue, 13 Nov 2001 23:32:50 +0100
Message-ID: <NDBBJMOHILCIIKFHCBHAIEOECAAA.per.persson@gnosjo.pp.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found that gcc doesn't manage to do this rewrite itself. My micro-patch
saves a few bytes. Also the code becomes a little bit cleaner (IMHO).

Probably the same change could (and should) be made for the other
architectures too.

Per Persson
per.persson@gnosjo.pp.se


--- arch/i386/mm/extable.c.orig	Mon Nov 12 00:13:52 2001
+++ arch/i386/mm/extable.c	Tue Nov 13 17:39:42 2001
@@ -19,7 +19,7 @@
 		const struct exception_table_entry *mid;
 		long diff;

-		mid = (last - first) / 2 + first;
+		mid = (last + first) / 2
 		diff = mid->insn - value;
                 if (diff == 0)
                         return mid->fixup;

