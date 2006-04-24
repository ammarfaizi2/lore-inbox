Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWDXTzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWDXTzd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 15:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWDXTzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 15:55:33 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:28865 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751197AbWDXTzc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 15:55:32 -0400
Subject: Re: Removing .tmp_versions considered harmful
From: Pavel Roskin <proski@gnu.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060421073216.GA17492@mars.ravnborg.org>
References: <1145593342.2904.30.camel@dv>
	 <20060421073216.GA17492@mars.ravnborg.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Apr 2006 15:55:27 -0400
Message-Id: <1145908527.2292.39.camel@dv>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Sam!

How about following patch?  Something needs to be done before 2.6.17.
Complaints about .tmp_versions are almost in every list about wireless
drivers I'm subscribed to.

I'm not asking to keep *.mod files, just please keep the .tmp_versions
directory.

-------------------------------
Remove *.mod files but not .tmp_versions for external builds

From: Pavel Roskin <proski@gnu.org>

When "make install" is run as root, .tmp_versions is re-created and
becomes owned by root.  Subsequent "make" run by user fails because
.tmp_versions cannot be removed.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index a940eae..6d7db09 100644
--- a/Makefile
+++ b/Makefile
@@ -1086,7 +1086,7 @@ # We are always building modules
 KBUILD_MODULES := 1
 PHONY += crmodverdir
 crmodverdir:
-	$(Q)rm -rf $(MODVERDIR)
+	$(Q)rm -f $(MODVERDIR)/*.mod
 	$(Q)mkdir -p $(MODVERDIR)
 
 PHONY += $(objtree)/Module.symvers



-- 
Regards,
Pavel Roskin

