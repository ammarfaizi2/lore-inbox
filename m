Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267424AbTAGQwm>; Tue, 7 Jan 2003 11:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267426AbTAGQwm>; Tue, 7 Jan 2003 11:52:42 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:32245 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267424AbTAGQwk>; Tue, 7 Jan 2003 11:52:40 -0500
Date: Tue, 7 Jan 2003 18:01:14 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre3
Message-ID: <20030107170113.GI6626@fs.tum.de>
References: <Pine.LNX.4.50L.0301061932140.8257-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50L.0301061932140.8257-100000@freak.distro.conectiva>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2003 at 07:32:37PM -0200, Marcelo Tosatti wrote:

> So here goes -pre3...
> 
> 
> Summary of changes from v2.4.21-pre2 to v2.4.21-pre3
> ============================================
>...
> Jean Tourrilhes <jt@bougret.hpl.hp.com>:
>...
>   o donauboe IrDA driver
>...

Please apply the patch below (stolen from 2.5) that does the following:
* C99 initializers
* fix public symbol name conflict (compile error if both donauboe and
                                   toshoboe are compiled statically
                                   into the kernel)
cu
Adrian

--- 1.1/drivers/net/irda/donauboe.c	Fri Oct 11 10:26:35 2002
+++ 1.2/drivers/net/irda/donauboe.c	Thu Nov  7 12:57:09 2002
@@ -1825,26 +1825,26 @@
   return 0;
 }
 
-static struct pci_driver toshoboe_pci_driver = {
-  name		: "toshoboe",
-  id_table	: toshoboe_pci_tbl,
-  probe		: toshoboe_open,
-  remove	: toshoboe_close,
-  suspend	: toshoboe_gotosleep,
-  resume	: toshoboe_wakeup 
+static struct pci_driver donauboe_pci_driver = {
+	.name		= "donauboe",
+	.id_table	= toshoboe_pci_tbl,
+	.probe		= toshoboe_open,
+	.remove		= toshoboe_close,
+	.suspend	= toshoboe_gotosleep,
+	.resume		= toshoboe_wakeup 
 };
 
-int __init
-toshoboe_init (void)
+static int __init
+donauboe_init (void)
 {
-  return pci_module_init(&toshoboe_pci_driver);
+  return pci_module_init(&donauboe_pci_driver);
 }
 
-STATIC void __exit
-toshoboe_cleanup (void)
+static void __exit
+donauboe_cleanup (void)
 {
-  pci_unregister_driver(&toshoboe_pci_driver);
+  pci_unregister_driver(&donauboe_pci_driver);
 }
 
-module_init(toshoboe_init);
-module_exit(toshoboe_cleanup);
+module_init(donauboe_init);
+module_exit(donauboe_cleanup);



