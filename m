Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266359AbUGAWkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266359AbUGAWkW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 18:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266358AbUGAWkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 18:40:22 -0400
Received: from havoc.gtf.org ([216.162.42.101]:64737 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266353AbUGAWkP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 18:40:15 -0400
Date: Thu, 1 Jul 2004 18:40:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, matt_domsch@dell.com
Subject: [BK PATCH] fix x86-64 build
Message-ID: <20040701224012.GA27162@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Please do a

	bk pull bk://gkernel.bkbits.net/misc-2.6

This will update the following files:

 include/asm-x86_64/bootsetup.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

through these ChangeSets:

<Matt_Domsch@dell.com> (04/07/01 1.1784)
   [PATCH] EDD: x86-64 build fix
   
   On Wed, Jun 30, 2004 at 01:22:21AM -0400, Jeff Garzik wrote:
   >   CC      arch/x86_64/kernel/setup.o
   > arch/x86_64/kernel/setup.c: In function `copy_edd':
   > arch/x86_64/kernel/setup.c:415: error: `EDD_MBR_SIGNATURE' undeclared=20
   > (first use in this function)
   > arch/x86_64/kernel/setup.c:415: error: (Each undeclared identifier is=20
   > reported only once
   > arch/x86_64/kernel/setup.c:415: error: for each function it appears in.)
   > arch/x86_64/kernel/setup.c:417: error: `EDD_MBR_SIG_NR' undeclared=20
   > (first use in this function)
   > make[1]: *** [arch/x86_64/kernel/setup.o] Error 1
   > make: *** [arch/x86_64/kernel] Error 2
   
   Arrgh.  On i386 it's in include/asm-i386/setup.h  On x86_64 it
   belongs in include/asm-x86_64/bootsetup.h.
   
   Patch below defines EDD_MBR_SIG_NR and EDD_MBR_SIGNATURE on x86_64.
   
   Signed-off-by: Matt_Domsch <Matt_Domsch@dell.com>

diff -Nru a/include/asm-x86_64/bootsetup.h b/include/asm-x86_64/bootsetup.h
--- a/include/asm-x86_64/bootsetup.h	2004-07-01 18:39:11 -04:00
+++ b/include/asm-x86_64/bootsetup.h	2004-07-01 18:39:11 -04:00
@@ -26,8 +26,9 @@
 #define INITRD_START (*(unsigned int *) (PARAM+0x218))
 #define INITRD_SIZE (*(unsigned int *) (PARAM+0x21c))
 #define EDID_INFO (*(struct edid_info *) (PARAM+0x440))
-#define DISK80_SIGNATURE (*(unsigned int*) (PARAM+DISK80_SIG_BUFFER))
 #define EDD_NR     (*(unsigned char *) (PARAM+EDDNR))
+#define EDD_MBR_SIG_NR (*(unsigned char *) (PARAM+EDD_MBR_SIG_NR_BUF))
+#define EDD_MBR_SIGNATURE ((unsigned int *) (PARAM+EDD_MBR_SIG_BUF))
 #define EDD_BUF     ((struct edd_info *) (PARAM+EDDBUF))
 #define COMMAND_LINE saved_command_line
 
