Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbVEZTkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbVEZTkl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 15:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVEZTj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 15:39:27 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:42205 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261724AbVEZTiL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 15:38:11 -0400
Message-ID: <4296259B.50908@g-house.de>
Date: Thu, 26 May 2005 21:38:03 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050522)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
Subject: __NR_ia32_restart_syscall undeclared 
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

compiling 2.6.12-rc4 and 2.6.12-rc5-mm1 too on x86_64 breaks with:

  CC      arch/x86_64/kernel/process.o
  CC      arch/x86_64/kernel/semaphore.o
  CC      arch/x86_64/kernel/signal.o
arch/x86_64/kernel/signal.c: In function `do_signal':
arch/x86_64/kernel/signal.c:460: error: `__NR_ia32_restart_syscall'
undeclared (first use in this function)
arch/x86_64/kernel/signal.c:460: error: (Each undeclared identifier is
reported only once
arch/x86_64/kernel/signal.c:460: error: for each function it appears in.)
make[1]: *** [arch/x86_64/kernel/signal.o] Error 1
make: *** [arch/x86_64/kernel] Error 2


including asm/ia32_unistd.h helps, but i don't know if it is the
Right Thing to do.

thank you,
Christian.


- --- linux-2.6-git/arch/x86_64/kernel/signal.c.orig      2005-05-22
15:37:50.262209040 +0200
+++ linux-2.6-git/arch/x86_64/kernel/signal.c   2005-05-22
15:38:46.886600824 +0200
@@ -28,6 +28,7 @@
 #include <asm/uaccess.h>
 #include <asm/i387.h>
 #include <asm/proto.h>
+#include <asm/ia32_unistd.h>

 /* #define DEBUG_SIG 1 */


- --
BOFH excuse #214:

Fluorescent lights are generating negative ions. If turning them off
doesn't work, take them out and put tin foil on the ends.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCliWa+A7rjkF8z0wRApzdAJ9q8+nb6U5uMwYQMSqYULnmEg8QPwCfT7C3
4Zv2kIryVCyyU3OZIj/lszY=
=Q8xL
-----END PGP SIGNATURE-----
