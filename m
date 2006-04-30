Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWD3Vrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWD3Vrc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 17:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWD3Vrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 17:47:32 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:44814 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751223AbWD3Vrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 17:47:31 -0400
Date: Sun, 30 Apr 2006 23:47:32 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Pavel Roskin <proski@gnu.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Removing .tmp_versions considered harmful
Message-ID: <20060430214732.GB18257@mars.ravnborg.org>
References: <1145593342.2904.30.camel@dv> <20060421073216.GA17492@mars.ravnborg.org> <1145908527.2292.39.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145908527.2292.39.camel@dv>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 03:55:27PM -0400, Pavel Roskin wrote:
> Hello, Sam!
> 
> How about following patch?  Something needs to be done before 2.6.17.
> Complaints about .tmp_versions are almost in every list about wireless
> drivers I'm subscribed to.
> 
> I'm not asking to keep *.mod files, just please keep the .tmp_versions
> directory.
> 
> -------------------------------
> Remove *.mod files but not .tmp_versions for external builds
> 
> From: Pavel Roskin <proski@gnu.org>
> 
> When "make install" is run as root, .tmp_versions is re-created and
> becomes owned by root.  Subsequent "make" run by user fails because
> .tmp_versions cannot be removed.

What architecture?
For i386 and x86_64 make install no longer try to compile the kernel.

I have anyway added the following patch:



------------------

Remove *.mod files but not .tmp_versions for external builds

When "make install" is run as root, .tmp_versions is re-created and
becomes owned by root.  Subsequent "make" run by user fails because
.tmp_versions cannot be removed.

Signed-off-by: Pavel Roskin <proski@gnu.org>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

diff --git a/Makefile b/Makefile
index 6bf9962..8517f7b 100644
--- a/Makefile
+++ b/Makefile
@@ -796,8 +796,8 @@ prepare2: prepare3 outputmakefile
 prepare1: prepare2 include/linux/version.h include/asm \
                    include/config/MARKER
 ifneq ($(KBUILD_MODULES),)
-	$(Q)rm -rf $(MODVERDIR)
 	$(Q)mkdir -p $(MODVERDIR)
+	$(Q)rm -f $(MODVERDIR)/*
 endif
 
 archprepare: prepare1 scripts_basic
@@ -1086,8 +1086,8 @@ # We are always building modules
 KBUILD_MODULES := 1
 PHONY += crmodverdir
 crmodverdir:
-	$(Q)rm -rf $(MODVERDIR)
 	$(Q)mkdir -p $(MODVERDIR)
+	$(Q)rm -f $(MODVERDIR)/*
 
 PHONY += $(objtree)/Module.symvers
 $(objtree)/Module.symvers:
