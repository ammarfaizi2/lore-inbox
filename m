Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312484AbSDNW4G>; Sun, 14 Apr 2002 18:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312488AbSDNW4F>; Sun, 14 Apr 2002 18:56:05 -0400
Received: from ucsu.Colorado.EDU ([128.138.129.83]:20392 "EHLO
	ucsu.colorado.edu") by vger.kernel.org with ESMTP
	id <S312484AbSDNW4E>; Sun, 14 Apr 2002 18:56:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Ivan G." <ivangurdiev@yahoo.com>
Reply-To: ivangurdiev@yahoo.com
Organization: ( )
To: Linus Torvalds <torvalds@transmeta.com>
Subject: 2.5.8 compile bugs
Date: Sun, 14 Apr 2002 16:48:35 -0600
X-Mailer: KMail [version 1.2]
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <02041416483500.07641@cobra.linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1) Script error, xconfig fails, apply to drivers/ide/Config.in

--- Config.in.bak       Sun Apr 14 16:13:29 2002
+++ Config.in   Sun Apr 14 16:13:44 2002
@@ -49,7 +49,7 @@
         define_bool CONFIG_BLK_DEV_IDEDMA $CONFIG_BLK_DEV_IDEDMA_PCI
         dep_bool '    ATA tagged command queueing' CONFIG_BLK_DEV_IDE_TCQ 
$CONFIG_BLK_DEV_IDEDMA_PCI
           dep_bool '      TCQ on by default' CONFIG_BLK_DEV_IDE_TCQ_DEFAULT 
$CONFIG_BLK_DEV_IDE_TCQ
-          if [ $CONFIG_BLK_DEV_IDE_TCQ_DEFAULT != "n" ]; then
+          if [ "$CONFIG_BLK_DEV_IDE_TCQ_DEFAULT" != "n" ]; then
                int '      Default queue depth' CONFIG_BLK_DEV_IDE_TCQ_DEPTH 
32
           fi
         dep_bool '    ATA Work(s) In Progress (EXPERIMENTAL)' 
CONFIG_IDEDMA_PCI_WIP $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_EXPERIMENTAL


To complement this pathetic bugfix, here's some other bug reports 

2) 
ERROR:
ide.c: In function `ide_teardown_commandlist':
ide.c:2704: structure has no member named `pci_dev'
ide.c: In function `ide_build_commandlist':
ide.c:2719: structure has no member named `pci_dev'
make[3]: *** [ide.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.8/drivers/ide'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.8/drivers/ide'
make[1]: *** [_subdir_ide] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.8/drivers'
make: *** [_dir_drivers] Error 2

CAUSE:
/usr/src/linux-2.5.8/include/linux/ide.h:

#ifdef CONFIG_BLK_DEV_IDEPCI
        struct pci_dev  *pci_dev;       /* for pci chipsets */
#endif

I don't use BLK_DEV_IDEPCI
yet I have an IDE hard drive so ide.c has to be compiled.


3)
Is the init bug fixed? I didn't finish the compile 
but it doesn't look like it.
In init/main.c setup_per_cpu_areas ends up undefined 
for uniprocessors (and called in start_kernel) , because of 
incorrect ifdef statements.............. result is compile error.

any replies: 
please cc to ivangurdiev@yahoo.com
I'm not subscribed
