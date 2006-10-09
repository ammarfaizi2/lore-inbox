Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932939AbWJIPjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932939AbWJIPjH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 11:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbWJIPjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 11:39:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:33895 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751887AbWJIPjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 11:39:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=G3phJbSTCScvYwsuUEDIyqd8C3EQWZuUHX+v201EiEmBT6OGL7uWLJaTgAAfqLaIVbrNfHF/Lm5ekBwf9yIVF/jXYGWMbzHdqVwATnZmnlVxT3iaISwX5jx4zpi+LOIaVckSbSvK8JRqtGFn4QWlCHDPdq5fCRcwdirxFYW9VE0=
Date: Mon, 9 Oct 2006 17:39:04 +0200
From: Luca Tettamanti <kronos.it@gmail.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.19-git] Fix menuconfig build failure due to missing stdbool.h
Message-ID: <20061009153903.GA7609@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/kconfig/lxdialog/util.c fails to build because it uses
true/false without including stdbool.h:

kronos:~/src/linux-2.6$ make O=../linux-build-git menuconfig
  GEN     /home/kronos/src/linux-build/Makefile
  HOSTCC  scripts/kconfig/lxdialog/util.o
/home/kronos/src/linux-2.6/scripts/kconfig/lxdialog/util.c: In function 'set_classic_theme':
/home/kronos/src/linux-2.6/scripts/kconfig/lxdialog/util.c:68: error: 'true' undeclared (first use in this function)
/home/kronos/src/linux-2.6/scripts/kconfig/lxdialog/util.c:68: error: (Each undeclared identifier is reported only once
/home/kronos/src/linux-2.6/scripts/kconfig/lxdialog/util.c:68: error: for each function it appears in.)
/home/kronos/src/linux-2.6/scripts/kconfig/lxdialog/util.c:70: error: 'false' undeclared (first use in this function)
/home/kronos/src/linux-2.6/scripts/kconfig/lxdialog/util.c: In function 'set_blackbg_theme':
/home/kronos/src/linux-2.6/scripts/kconfig/lxdialog/util.c:101: error: 'true' undeclared (first use in this function)
/home/kronos/src/linux-2.6/scripts/kconfig/lxdialog/util.c:102: error: 'false' undeclared (first use in this function)
/home/kronos/src/linux-2.6/scripts/kconfig/lxdialog/util.c: In function 'set_bluetitle_theme':
/home/kronos/src/linux-2.6/scripts/kconfig/lxdialog/util.c:144: error: 'true' undeclared (first use in this function)
make[2]: *** [scripts/kconfig/lxdialog/util.o] Error 1
make[1]: *** [menuconfig] Error 2
make: *** [menuconfig] Error 2

Add <stdbool.h> to dialog.h to fix the breakage.

Signed-Off-By: Luca Tettamanti <kronos.it@gmail.com>

---
Patch against current git tree, tested with gcc-3.4, gcc-4.0 and gcc-4.1
from Debian/unstable.

Btw, the bug was introduced by this merge:

commit b4a9071af62f95dc6d22040a0b37ac7225ce4d54
Merge: 8b2a1fd... 99c8b94...
Author: Linus Torvalds <torvalds@g5.osdl.org>
Date:   Tue Oct 3 08:51:38 2006 -0700

    Merge git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild

but I don't know how to extract the guilty commit from the merge...


diff --git a/scripts/kconfig/lxdialog/dialog.h b/scripts/kconfig/lxdialog/dialog.h
index 8dea47f..fd695e1 100644
--- a/scripts/kconfig/lxdialog/dialog.h
+++ b/scripts/kconfig/lxdialog/dialog.h
@@ -24,6 +24,7 @@ #include <unistd.h>
 #include <ctype.h>
 #include <stdlib.h>
 #include <string.h>
+#include <stdbool.h>
 
 #ifdef __sun__
 #define CURS_MACROS


Luca
-- 
La differenza fra l'intelligenza e la stupidita`?
All'intelligenza c'e` un limite.
