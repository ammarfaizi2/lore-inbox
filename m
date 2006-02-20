Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932638AbWBTTZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638AbWBTTZT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 14:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932642AbWBTTZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 14:25:19 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:30226 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932638AbWBTTZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 14:25:17 -0500
Date: Mon, 20 Feb 2006 20:25:00 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -mm HOT-FIX] fix build on ia64 (modpost.c)
Message-ID: <20060220192500.GA17003@mars.ravnborg.org>
References: <20060220042615.5af1bddc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220042615.5af1bddc.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> - This kernel won't compile on ia64 (and possibly other architectures)
>   because the kbuild tree is using Elf_Rela in scripts/mod/modpost.c.  Is OK
>   on x86, x86_64 and powerpc.  Sam might send a hotfix?

Attached is a real hot-fix. It disables the new check entirely.

I like to learn:
1) Why IA64 is missing Elf64_Rela. Can someone drop me a copy of elf.h -
and include gcc + binutils version in the mail - thanks.

2) I also like to know if other architectures broke - so I can figure
out how to fix this.

I have tested this on X86_64/amd64 (gentoo based) only.

	Sam

	
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 844f84b..b87070a 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -451,6 +451,7 @@ static char *get_modinfo(void *modinfo, 
 	return NULL;
 }
 
+#if 0
 /**
  * Find symbol based on relocation record info.
  * In some cases the symbol supplied is a valid symbol so
@@ -616,7 +617,12 @@ static void check_sec_ref(struct module 
 		}
 	}
 }
-
+#endif
+static void check_sec_ref(struct module *mod, const char *modname,
+			  struct elf_info *elf,
+			  int section(const char*),
+			  int section_ref_ok(const char *))
+{}
 /**
  * Functions used only during module init is marked __init and is stored in
  * a .init.text section. Likewise data is marked __initdata and stored in
