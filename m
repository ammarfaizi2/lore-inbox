Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVCEWtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVCEWtA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 17:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbVCEWsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 17:48:35 -0500
Received: from coderock.org ([193.77.147.115]:30373 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261299AbVCEWlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 17:41:51 -0500
Subject: [patch 1/4] delete unused file arch_arm26_boot_compressed_hw_bse.c
To: spyro@f2s.com
Cc: linux-kernel@vger.kernel.org, domen@coderock.org
From: domen@coderock.org
Date: Sat, 05 Mar 2005 23:41:45 +0100
Message-Id: <20050305224145.E90F71EE1E@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove nowhere referenced file. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj/arch/arm26/boot/compressed/hw-bse.c |   74 ---------------------------------
 1 files changed, 74 deletions(-)

diff -L arch/arm26/boot/compressed/hw-bse.c -puN arch/arm26/boot/compressed/hw-bse.c~remove_file-arch_arm26_boot_compressed_hw_bse.c /dev/null
--- kj/arch/arm26/boot/compressed/hw-bse.c
+++ /dev/null	2005-03-02 11:34:59.000000000 +0100
@@ -1,74 +0,0 @@
-/*
- * Bright Star Engineering Inc.
- *
- * code for readng parameters from the
- * parameter blocks of the boot block
- * flash memory
- *
- */
-
-static int strcmp(const char *s1, const char *s2)
-{
-  while (*s1 != '\0' && *s1 == *s2)
-    {
-      s1++;
-      s2++;
-    }
-
-  return (*(unsigned char *) s1) - (*(unsigned char *) s2);
-}
-
-struct pblk_t {
-  char type;
-  unsigned short size;
-};
-
-static char *bse_getflashparam(char *name) {
-  unsigned int esize;
-  char *q,*r;
-  unsigned char *p,*e;
-  struct pblk_t *thepb = (struct pblk_t *) 0x00004000;
-  struct pblk_t *altpb = (struct pblk_t *) 0x00006000;  
-  if (thepb->type&1) {
-    if (altpb->type&1) {
-      /* no valid param block */ 
-      return (char*)0;
-    } else {
-      /* altpb is valid */
-      struct pblk_t *tmp;
-      tmp = thepb;
-      thepb = altpb;
-      altpb = tmp;
-    }
-  }
-  p = (char*)thepb + sizeof(struct pblk_t);
-  e = p + thepb->size; 
-  while (p < e) {
-    q = p;
-    esize = *p;
-    if (esize == 0xFF) break;
-    if (esize == 0) break;
-    if (esize > 127) {
-      esize = (esize&0x7F)<<8 | p[1];
-      q++;
-    }
-    q++;
-    r=q;
-    if (*r && ((name == 0) || (!strcmp(name,r)))) {
-      while (*q++) ;
-      return q;
-    }
-    p+=esize;
-  }
-  return (char*)0;
-}
-
-void bse_setup(void) {
-  /* extract the linux cmdline from flash */
-  char *name=bse_getflashparam("linuxboot");
-  char *x = (char *)0xc0000100;
-  if (name) { 
-    while (*name) *x++=*name++;
-  }
-  *x=0;
-}
_
