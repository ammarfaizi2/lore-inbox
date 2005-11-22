Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbVKVVNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbVKVVNu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbVKVVNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:13:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44704 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965045AbVKVVNh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:13:37 -0500
Date: Tue, 22 Nov 2005 13:08:44 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, mac@melware.de
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Adrian Bunk <bunk@stusta.de>, kai.germaschewski@gmx.de,
       isdn4linux@listserv.isdn4linux.de, kkeil@suse.de,
       Armin Schindler <armin@melware.de>
Subject: [patch 20/23] drivers/isdn/hardware/eicon/os_4bri.c: correct the xdiLoadFile() signature
Message-ID: <20051122210844.GU28140@shell0.pdx.osdl.net>
References: <20051122205223.099537000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="drivers-isdn-hardware-eicon-os_4bri.c-correct-the-xdiloadfile-signature.patch"
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

It's not good if caller and callee disagree regarding the type of the
arguments.

In this case, this could cause problems on 64bit architectures.


Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Armin Schindler <armin@melware.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 drivers/isdn/hardware/eicon/os_4bri.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.14.2.orig/drivers/isdn/hardware/eicon/os_4bri.c
+++ linux-2.6.14.2/drivers/isdn/hardware/eicon/os_4bri.c
@@ -16,6 +16,7 @@
 #include "diva_pci.h"
 #include "mi_pc.h"
 #include "dsrv4bri.h"
+#include "helpers.h"
 
 static void *diva_xdiLoadFileFile = NULL;
 static dword diva_xdiLoadFileLength = 0;
@@ -815,7 +816,7 @@ diva_4bri_cmd_card_proc(struct _diva_os_
 	return (ret);
 }
 
-void *xdiLoadFile(char *FileName, unsigned long *FileLength,
+void *xdiLoadFile(char *FileName, dword *FileLength,
 		  unsigned long lim)
 {
 	void *ret = diva_xdiLoadFileFile;

--
