Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932776AbVINViz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932776AbVINViz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 17:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932777AbVINViz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 17:38:55 -0400
Received: from outmail1.freedom2surf.net ([194.106.33.237]:34955 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S932776AbVINViy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 17:38:54 -0400
Message-ID: <4328983E.2090906@f2s.com>
Date: Wed, 14 Sep 2005 22:38:06 +0100
From: Ian Molton <spyro@f2s.com>
Organization: The Dragon Roost
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>, Domen Puncer <domen@coderock.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [Fwd: [PATCH] Remove arch/arm26/boot/compressed/hw-bse.c]
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought this was in -mm already. in case its not:

Signed-off-by: Ian Molton <spyro@f2s.com>

Cheers guys


-------- Original Message --------
Subject: [PATCH] Remove arch/arm26/boot/compressed/hw-bse.c
Date: Wed, 14 Sep 2005 23:53:25 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Ian Molton <spyro@f2s.com>
CC: linux-kernel@vger.kernel.org, Domen Puncer <domen@coderock.org>

From: Domen Puncer <domen@coderock.org>

Remove nowhere referenced file (egrep "hw-bse\." didn't find anything).

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

  arch/arm26/boot/compressed/hw-bse.c |   74 
------------------------------------
  1 files changed, 74 deletions(-)

--- a/arch/arm26/boot/compressed/hw-bse.c	2005-09-14 19:05:26.000000000 
+0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
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


