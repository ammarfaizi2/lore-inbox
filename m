Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317205AbSFRAuK>; Mon, 17 Jun 2002 20:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317209AbSFRAuK>; Mon, 17 Jun 2002 20:50:10 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:52424 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317205AbSFRAuI>; Mon, 17 Jun 2002 20:50:08 -0400
Date: Tue, 18 Jun 2002 02:50:02 +0200
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Make CONFIG_ISA a choice for i386
Message-ID: <20020618025002.A10804@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now that most driver dirs honour CONFIG_ISA it makes sense to offer it 
as a user visible choice for i386.  Most users of modern PCs will 
define this as off. Also disables the old style CDROM support when
ISA support is not defined.

-Andi

--- linux/arch/i386/config.in	Mon Jun 10 14:31:20 2002
+++ linux-2.5.22-work/arch/i386/config.in	Tue Jun 18 02:46:39 2002
@@ -5,7 +5,6 @@
 mainmenu_name "Linux Kernel Configuration"
 
 define_bool CONFIG_X86 y
-define_bool CONFIG_ISA y
 define_bool CONFIG_SBUS n
 
 define_bool CONFIG_UID16 y
@@ -259,7 +258,9 @@
 
 source drivers/pci/Config.in
 
-bool 'EISA support' CONFIG_EISA
+bool 'ISA support' CONFIG_ISA
+
+dep_bool 'EISA support' CONFIG_EISA $CONFIG_ISA
 
 if [ "$CONFIG_VISWS" != "y" ]; then
    bool 'MCA support' CONFIG_MCA
@@ -357,7 +358,10 @@
 
 source drivers/isdn/Config.in
 
+if [ "$CONFIG_ISA" != "n" ]; then
+
 mainmenu_option next_comment
+
 comment 'Old CD-ROM drivers (not SCSI, not IDE)'
 
 bool 'Support non-SCSI/IDE/ATAPI CDROM drives' CONFIG_CD_NO_IDESCSI
@@ -365,6 +369,8 @@
    source drivers/cdrom/Config.in
 fi
 endmenu
+
+fi
 
 #
 # input before char - char/joystick depends on it. As does USB.
