Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965129AbWACXnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965129AbWACXnZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbWACX1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:27:10 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:55515 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964971AbWACX04
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:26:56 -0500
To: torvalds@osdl.org
Subject: [PATCH 06/41] m68k: oktagon makefile fix
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1EtvYN-0003LY-Fz@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 23:26:55 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1133440277 -0500

oktagon_esp is described as modular.  However, drivers/scsi/Makefile doesn't
handle it right - it's multi-object module, with one of the parts being
built from .S.  Current makefile tries to declare each part a module of
its own; that not only wouldn't work (oktagon_io.o doesn't have the right
parts for that), it actually doesn't even build since kbuild doesn't believe
in single-object modules built from .S.  Turned into proper multi-object
module...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/scsi/Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

1c3f2c3e5fb1c3851ae70bd0d25fc3fc161ac52b
diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
index f062ea0..6e0c059 100644
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -45,7 +45,7 @@ obj-$(CONFIG_CYBERSTORMII_SCSI)	+= NCR53
 obj-$(CONFIG_BLZ2060_SCSI)	+= NCR53C9x.o	blz2060.o
 obj-$(CONFIG_BLZ1230_SCSI)	+= NCR53C9x.o	blz1230.o
 obj-$(CONFIG_FASTLANE_SCSI)	+= NCR53C9x.o	fastlane.o
-obj-$(CONFIG_OKTAGON_SCSI)	+= NCR53C9x.o	oktagon_esp.o	oktagon_io.o
+obj-$(CONFIG_OKTAGON_SCSI)	+= NCR53C9x.o	oktagon_esp_mod.o
 obj-$(CONFIG_ATARI_SCSI)	+= atari_scsi.o
 obj-$(CONFIG_MAC_SCSI)		+= mac_scsi.o
 obj-$(CONFIG_SCSI_MAC_ESP)	+= mac_esp.o	NCR53C9x.o
@@ -164,6 +164,7 @@ CFLAGS_ncr53c8xx.o	:= $(ncr53c8xx-flags-
 zalon7xx-objs	:= zalon.o ncr53c8xx.o
 NCR_Q720_mod-objs	:= NCR_Q720.o ncr53c8xx.o
 libata-objs	:= libata-core.o libata-scsi.o
+oktagon_esp_mod-objs	:= oktagon_esp.o oktagon_io.o
 
 # Files generated that shall be removed upon make clean
 clean-files :=	53c7xx_d.h 53c700_d.h	\
-- 
0.99.9.GIT

