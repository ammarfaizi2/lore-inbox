Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWDRWK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWDRWK2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 18:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWDRWK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 18:10:28 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:9226 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750749AbWDRWK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 18:10:27 -0400
Date: Wed, 19 Apr 2006 00:10:26 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>,
       Kristen Accardi <kristen.c.accardi@intel.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: [-mm patch] make pci/hotplug/acpiphp_glue.c:handle_hotplug_event_func() static
Message-ID: <20060418221026.GV11582@stusta.de>
References: <20060418031423.3cbef2f7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060418031423.3cbef2f7.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2006 at 03:14:23AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-rc1-mm2:
>...
> +acpiphp-use-new-dock-driver.patch
>...
>  ACPI fixes and features
>...

handle_hotplug_event_func() can now become static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/pci/hotplug/acpiphp.h      |    1 -
 drivers/pci/hotplug/acpiphp_glue.c |    5 ++++-
 2 files changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.17-rc1-mm3-full/drivers/pci/hotplug/acpiphp.h.old	2006-04-18 22:09:47.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/drivers/pci/hotplug/acpiphp.h	2006-04-18 22:09:58.000000000 +0200
@@ -203,7 +203,6 @@
 extern void acpiphp_glue_exit (void);
 extern int acpiphp_get_num_slots (void);
 typedef int (*acpiphp_callback)(struct acpiphp_slot *slot, void *data);
-void handle_hotplug_event_func(acpi_handle, u32, void*);
 
 extern int acpiphp_enable_slot (struct acpiphp_slot *slot);
 extern int acpiphp_disable_slot (struct acpiphp_slot *slot);
--- linux-2.6.17-rc1-mm3-full/drivers/pci/hotplug/acpiphp_glue.c.old	2006-04-18 22:10:26.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/drivers/pci/hotplug/acpiphp_glue.c	2006-04-18 22:11:01.000000000 +0200
@@ -59,6 +59,8 @@
 static void handle_hotplug_event_bridge (acpi_handle, u32, void *);
 static void acpiphp_sanitize_bus(struct pci_bus *bus);
 static void acpiphp_set_hpp_values(acpi_handle handle, struct pci_bus *bus);
+static void handle_hotplug_event_func(acpi_handle handle, u32 type,
+				      void *context);
 
 
 /*
@@ -1493,7 +1495,8 @@
  * handles ACPI event notification on slots
  *
  */
-void handle_hotplug_event_func(acpi_handle handle, u32 type, void *context)
+static void handle_hotplug_event_func(acpi_handle handle, u32 type,
+				      void *context)
 {
 	struct acpiphp_func *func;
 	char objname[64];

