Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310258AbSCaAjh>; Sat, 30 Mar 2002 19:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310241AbSCaAj2>; Sat, 30 Mar 2002 19:39:28 -0500
Received: from CPE-203-51-25-11.nsw.bigpond.net.au ([203.51.25.11]:63733 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S311203AbSCaAjQ>; Sat, 30 Mar 2002 19:39:16 -0500
Message-ID: <3CA65AAE.4917313E@eyal.emu.id.au>
Date: Sun, 31 Mar 2002 10:39:10 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre5: hotplug config
In-Reply-To: <Pine.LNX.4.21.0203291842530.6417-100000@freak.distro.conectiva>
Content-Type: multipart/mixed;
 boundary="------------85BC3090E144680B4E71D91C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------85BC3090E144680B4E71D91C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Marcelo Tosatti wrote:
> 
> Hi,
> 
> Here goes pre5.

While we are cleaning up configs, here is another one (I think
mentioned a while ago) that removes the unresolved ref to
	IO_APIC_get_PCI_irq_vector
from ibmphp.o if IO_APIC is not selected.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
--------------85BC3090E144680B4E71D91C
Content-Type: text/plain; charset=us-ascii;
 name="2.4.19-pre5-ibmphp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.19-pre5-ibmphp.patch"

--- linux/drivers/hotplug/Config.in.orig	Sun Mar 31 10:04:45 2002
+++ linux/drivers/hotplug/Config.in	Sun Mar 31 10:06:01 2002
@@ -8,7 +8,9 @@
 
 dep_tristate '  Compaq PCI Hotplug driver' CONFIG_HOTPLUG_PCI_COMPAQ $CONFIG_HOTPLUG_PCI $CONFIG_X86
 dep_mbool '    Save configuration into NVRAM on Compaq servers' CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM $CONFIG_HOTPLUG_PCI_COMPAQ
-dep_tristate '  IBM PCI Hotplug driver' CONFIG_HOTPLUG_PCI_IBM $CONFIG_HOTPLUG_PCI $CONFIG_X86_IO_APIC $CONFIG_X86
+if [ "$CONFIG_X86_IO_APIC" = "y" ]; then
+   dep_tristate '  IBM PCI Hotplug driver' CONFIG_HOTPLUG_PCI_IBM $CONFIG_HOTPLUG_PCI $CONFIG_X86
+fi
 dep_tristate '  ACPI PCI Hotplug driver' CONFIG_HOTPLUG_PCI_ACPI $CONFIG_ACPI $CONFIG_HOTPLUG_PCI
 
 endmenu

--------------85BC3090E144680B4E71D91C--

