Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318464AbSHEMnx>; Mon, 5 Aug 2002 08:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318467AbSHEMnx>; Mon, 5 Aug 2002 08:43:53 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:8112 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318464AbSHEMnw>;
	Mon, 5 Aug 2002 08:43:52 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15694.29516.215781.380474@argo.ozlabs.ibm.com>
Date: Mon, 5 Aug 2002 22:45:00 +1000 (EST)
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix mesh cfg in drivers/scsi/Config.in
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

We need this small change to drivers/scsi/Config.in.  It only affects
people using powermacs since the MESH hardware only exists on
powermacs and clones.

Thanks,
Paul.

diff -urN linux-2.5/drivers/scsi/Config.in pmac-2.5/drivers/scsi/Config.in
--- linux-2.5/drivers/scsi/Config.in	Mon Jun 24 23:59:08 2002
+++ pmac-2.5/drivers/scsi/Config.in	Wed Jun 26 02:10:03 2002
@@ -221,10 +221,11 @@
 if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
    dep_tristate 'SCSI debugging host simulator (EXPERIMENTAL)' CONFIG_SCSI_DEBUG $CONFIG_SCSI
 fi
-if [ "$CONFIG_PPC" = "y" ]; then
+if [ "$CONFIG_ALL_PPC" = "y" ]; then
    dep_tristate 'MESH (Power Mac internal SCSI) support' CONFIG_SCSI_MESH $CONFIG_SCSI
    if [ "$CONFIG_SCSI_MESH" != "n" ]; then
       int '  maximum synchronous transfer rate (MB/s) (0 = async)' CONFIG_SCSI_MESH_SYNC_RATE 5
+      int '  initial bus reset delay (ms) (0 = no reset)' CONFIG_SCSI_MESH_RESET_DELAY_MS 4000
    fi
    dep_tristate '53C94 (Power Mac external SCSI) support' CONFIG_SCSI_MAC53C94 $CONFIG_SCSI
 fi
