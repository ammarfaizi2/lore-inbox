Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWJEVlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWJEVlh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWJEVlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:41:37 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:27987 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932243AbWJEVlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:41:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=HBEN1BjSaZW679O8eAB0MApeoU2fD3+l4al2R1XjQ+NcyGaLbK7jL1MuGSuXiv58f029BdjJDOwLkiWb7CmGcj3JCXS/oeii5D0VB3TgSJtgXjCXhGcWS6Nxn/aobvRtYKA1XXHE8JMcGzIGmrAdjFkgolNcL7+vtzJp8DnfyDI=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 01/14] uml: fix compilation options for USER_OBJS
Date: Thu, 05 Oct 2006 23:38:36 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20061005213836.17268.96038.stgit@memento.home.lan>
In-Reply-To: <20061005213212.17268.7409.stgit@memento.home.lan>
References: <20061005213212.17268.7409.stgit@memento.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Again, move inclusion of arch's Makefile after CFLAGS setting - I remember
merging the same patch eons ago in 2.6, so I added a comment.

I discovered this because debug info weren't enabled for USER_OBJS - they're
compiled with USER_CFLAGS which is calculated from CFLAGS (the whole thing is a
bit of an hack but fixing it is not easy, so we're leaving it as-is).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 Makefile |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index adb2c74..fc05890 100644
--- a/Makefile
+++ b/Makefile
@@ -489,8 +489,6 @@ else
 CFLAGS		+= -O2
 endif
 
-include $(srctree)/arch/$(ARCH)/Makefile
-
 ifdef CONFIG_FRAME_POINTER
 CFLAGS		+= -fno-omit-frame-pointer $(call cc-option,-fno-optimize-sibling-calls,)
 else
@@ -518,6 +516,10 @@ CFLAGS += $(call cc-option,-Wdeclaration
 # disable pointer signed / unsigned warnings in gcc 4.0
 CFLAGS += $(call cc-option,-Wno-pointer-sign,)
 
+# After setting CFLAGS correctly, read in arch's Makefile. UML needs to receive the
+# correct value of CFLAGS.
+include $(srctree)/arch/$(ARCH)/Makefile
+
 # Default kernel image to build when no specific target is given.
 # KBUILD_IMAGE may be overruled on the command line or
 # set in the environment
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
