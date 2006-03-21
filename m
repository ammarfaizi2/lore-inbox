Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751549AbWCUQgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbWCUQgS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWCUQfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:35:52 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:30476 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932425AbWCUQVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:11 -0500
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 18/46] kbuild: fix segfault in modpost
In-Reply-To: <11429580552016-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:55 +0100
Message-Id: <11429580551265-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do not try to look up section name until we know it is not a special
section. Otherwise we will address outside legal space and segfault.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/mod/modpost.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

8ea80ca4f583e377c902811d42626ccfce16913f
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index a7360c3..eeaf574 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -576,11 +576,11 @@ static void check_sec_ref(struct module 
 			r.r_offset = TO_NATIVE(rela->r_offset);
 			r.r_info   = TO_NATIVE(rela->r_info);
 			sym = elf->symtab_start + ELF_R_SYM(r.r_info);
-			secname = secstrings + sechdrs[sym->st_shndx].sh_name;
 			/* Skip special sections */
 			if (sym->st_shndx >= SHN_LORESERVE)
 				continue;
 
+			secname = secstrings + sechdrs[sym->st_shndx].sh_name;
 			if (section(secname))
 				warn_sec_mismatch(modname, name, elf, sym, r);
 		}
-- 
1.0.GIT


