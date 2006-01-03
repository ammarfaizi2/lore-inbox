Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWACNbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWACNbh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWACN35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:29:57 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:43013 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932355AbWACNZi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:25:38 -0500
Subject: [PATCH 13/26] kbuild: Fix crc-error warning on modules
In-Reply-To: <20060103132035.GA17485@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Tue, 3 Jan 2006 14:25:25 +0100
Message-Id: <11362947252019@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luke Yang <luke.adi@gmail.com>
Date: 1135132043 +0800

   This is the patch for the following issue:

 In include/linux/module.h, "__crc_" and "__ksymtab_" are hard
coded to be the   prefix for some kinds of symbols (CRC symbol and
ksymtab section). But in script /mod/modpost.c,
MODULE_SYMBOL_PREFIX##"__crc_" is used as the prefix to search CRC
symbols. So if an architecture (such as h8300 or Blackfin) defines
MODULE_SYMBOL_PREFIX as not NULL ("_"), modpost will always warn about
"no invalid crc".
  And it is the same with KSYMTAB_PFX.

Signed-off-by: Luke Yang <luke.adi@gmail.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/mod/modpost.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

9572b28faf72859c6b91891c627870cfa282d19d
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 3bed09e..8ce5a63 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -326,8 +326,8 @@ parse_elf_finish(struct elf_info *info)
 	release_file(info->hdr, info->size);
 }
 
-#define CRC_PFX     MODULE_SYMBOL_PREFIX "__crc_"
-#define KSYMTAB_PFX MODULE_SYMBOL_PREFIX "__ksymtab_"
+#define CRC_PFX     "__crc_"
+#define KSYMTAB_PFX "__ksymtab_"
 
 void
 handle_modversions(struct module *mod, struct elf_info *info,
-- 
1.0.6

