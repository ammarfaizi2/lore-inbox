Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316861AbSFDWHo>; Tue, 4 Jun 2002 18:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316863AbSFDWHo>; Tue, 4 Jun 2002 18:07:44 -0400
Received: from air-2.osdl.org ([65.201.151.6]:1928 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S316861AbSFDWHm>;
	Tue, 4 Jun 2002 18:07:42 -0400
Date: Tue, 4 Jun 2002 15:03:33 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: "David S. Miller" <davem@redhat.com>
cc: <anton@samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.19] Oops during PCI scan on Alpha
In-Reply-To: <20020604.143453.35012407.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0206041502200.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> We're talking in circles and the fixes you're proposing are not
> going to fix the bug, just create new versions of the old bug.

Go crazy. Also available from bk://linux.bkbits.net/linux-2.5

	-pat

ChangeSet@1.418, 2002-06-04 14:58:08-07:00, mochel@osdl.org
  s/subsys_initcall/postcore_initcall/ for sys_bys and pci, so they get initialized early enough for arch and subsys initcalls to use them.
  

 drivers/base/sys.c       |    2 +-
 drivers/pci/pci-driver.c |    2 +-
 2 files changed, 2 insertions, 2 deletions


ChangeSet@1.417, 2002-06-04 14:57:10-07:00, mochel@osdl.org
  Change unused_initcall to postcore_initcall for things that must be initialized early, but not too early (after the core is done)

 include/linux/init.h |    4 ++--
 1 files changed, 2 insertions, 2 deletions


diff -Nru a/drivers/base/sys.c b/drivers/base/sys.c
--- a/drivers/base/sys.c	Tue Jun  4 15:01:14 2002
+++ b/drivers/base/sys.c	Tue Jun  4 15:01:14 2002
@@ -44,6 +44,6 @@
        return device_register(&system_bus);
 }
 
-subsys_initcall(sys_bus_init);
+postcore_initcall(sys_bus_init);
 EXPORT_SYMBOL(register_sys_device);
 EXPORT_SYMBOL(unregister_sys_device);
diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	Tue Jun  4 15:01:14 2002
+++ b/drivers/pci/pci-driver.c	Tue Jun  4 15:01:14 2002
@@ -204,7 +204,7 @@
 	return bus_register(&pci_bus_type);
 }
 
-subsys_initcall(pci_driver_init);
+postcore_initcall(pci_driver_init);
 
 EXPORT_SYMBOL(pci_match_device);
 EXPORT_SYMBOL(pci_register_driver);
diff -Nru a/include/linux/init.h b/include/linux/init.h
--- a/include/linux/init.h	Tue Jun  4 15:01:14 2002
+++ b/include/linux/init.h	Tue Jun  4 15:01:14 2002
@@ -61,7 +61,7 @@
 	static initcall_t __initcall_##fn __attribute__ ((unused,__section__ (".initcall" level ".init"))) = fn
 
 #define core_initcall(fn)		__define_initcall("1",fn)
-#define unused_initcall(fn)		__define_initcall("2",fn)
+#define postcore_initcall(fn)		__define_initcall("2",fn)
 #define arch_initcall(fn)		__define_initcall("3",fn)
 #define subsys_initcall(fn)		__define_initcall("4",fn)
 #define fs_initcall(fn)			__define_initcall("5",fn)
@@ -160,7 +160,7 @@
 #define __setup(str,func) /* nothing */
 
 #define core_initcall(fn)		module_init(fn)
-#define unused_initcall(fn)		module_init(fn)
+#define postcore_initcall(fn)		module_init(fn)
 #define arch_initcall(fn)		module_init(fn)
 #define subsys_initcall(fn)		module_init(fn)
 #define fs_initcall(fn)			module_init(fn)

