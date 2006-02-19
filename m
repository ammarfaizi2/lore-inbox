Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbWBSMto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWBSMto (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 07:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWBSMto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 07:49:44 -0500
Received: from 213-140-2-68.ip.fastwebnet.it ([213.140.2.68]:22982 "EHLO
	aa001msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932422AbWBSMtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 07:49:43 -0500
Date: Sun, 19 Feb 2006 13:50:37 +0100
From: Mattia Dongili <malattia@linux.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Sam Ravnborg <sam@mars.ravnborg.org>
Subject: [kbuild,-mm] [PATCH] workaround a cscope bug (make cscope segfaults)
Message-ID: <20060219125037.GA29662@inferi.kami.home>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Sam Ravnborg <sam@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.16-rc2-mm1-3 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Workaround a cscope bug where a trailing ':' in VPATH makes it segfault
and let it build the cross-reference succesfully.

VPATH=/home/mattia/devel/kernel/git/linux-2.6: cscope -b
[1]    17555 segmentation fault VPATH=/home/mattia/devel/kernel/git/linux-2.6: cscope -b

Signed-off-by: Mattia Dongili <malattia@linux.it>
---

'make cscope' segfaults with current kbuild.git (I'm using -rc3-mm1 actually
and the same problem appears in some previous versions too).
I'm running Debian's cscope-15.5+cvs20050816-1 (cscope --version says
16.0a).

I think it would be nice to have this workaround as cscope CVS doesn't
show much activity and its latest release dates somewhen in 2003.

As shown above, to reproduce the segfault here I just need to run
VPATH=/home/mattia/devel/kernel/git/linux-2.6: cscope -b
in the kernel source tree with the previously generated cscope.files,
the trailing ':' is what makes cscope die.

 Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

77d1a8a386df409709ad0b4f48a8b09ce08d990d
diff --git a/Makefile b/Makefile
index 111a699..e0f9108 100644
--- a/Makefile
+++ b/Makefile
@@ -138,7 +138,11 @@ objtree		:= $(CURDIR)
 src		:= $(srctree)
 obj		:= $(objtree)
 
+ifeq ($(KBUILD_EXTMOD),)
+VPATH		:= $(srctree)
+else
 VPATH		:= $(srctree):$(KBUILD_EXTMOD)
+endif
 
 export srctree objtree VPATH TOPDIR
 
-- 
1.2.1-dirty

-- 
mattia
:wq!

