Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314468AbSDRVo7>; Thu, 18 Apr 2002 17:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314471AbSDRVo6>; Thu, 18 Apr 2002 17:44:58 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:47620 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S314468AbSDRVo5>;
	Thu, 18 Apr 2002 17:44:57 -0400
Date: Thu, 18 Apr 2002 13:43:50 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1 of 2] PCI Hotplug Config.in fix
Message-ID: <20020418204350.GA7762@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here's a patch against 2.4.19-pre7 that fixes the pci hotplug Config.in
file so as to not build the IBM PCI Hotplug driver unless
CONFIG_X86_IO_APIC is enabled.

thanks,

greg k-h


diff -Nru a/drivers/hotplug/Config.in b/drivers/hotplug/Config.in
--- a/drivers/hotplug/Config.in	Thu Apr 18 09:15:02 2002
+++ b/drivers/hotplug/Config.in	Thu Apr 18 09:15:02 2002
@@ -8,7 +8,9 @@
 
 dep_tristate '  Compaq PCI Hotplug driver' CONFIG_HOTPLUG_PCI_COMPAQ $CONFIG_HOTPLUG_PCI $CONFIG_X86
 dep_mbool '    Save configuration into NVRAM on Compaq servers' CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM $CONFIG_HOTPLUG_PCI_COMPAQ
-dep_tristate '  IBM PCI Hotplug driver' CONFIG_HOTPLUG_PCI_IBM $CONFIG_HOTPLUG_PCI $CONFIG_X86_IO_APIC $CONFIG_X86
+if [ "$CONFIG_X86_IO_APIC" = "y" ]; then
+   dep_tristate '  IBM PCI Hotplug driver' CONFIG_HOTPLUG_PCI_IBM $CONFIG_HOTPLUG_PCI $CONFIG_X86_IO_APIC $CONFIG_X86
+fi
 dep_tristate '  ACPI PCI Hotplug driver' CONFIG_HOTPLUG_PCI_ACPI $CONFIG_ACPI $CONFIG_HOTPLUG_PCI
 
 endmenu

