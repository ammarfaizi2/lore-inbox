Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265361AbSJaTXD>; Thu, 31 Oct 2002 14:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265364AbSJaTXD>; Thu, 31 Oct 2002 14:23:03 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:1106 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S265361AbSJaTXA>; Thu, 31 Oct 2002 14:23:00 -0500
Message-ID: <72B3FD82E303D611BD0100508BB29735046DFF69@orsmsx102.jf.intel.com>
From: "Lee, Jung-Ik" <jung-ik.lee@intel.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: RFC: bare pci configuration access functions ?
Date: Thu, 31 Oct 2002 11:29:19 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Need:
====
	Some kernel drivers/components such as hotplug pci/io-node drivers,
ACPI driver, some console drivers, etc **need bare pci configuration space
access** before either pci driver is initialized or struct pci_dev is
constructed.

ACPI needs this for ACPI/PCI population, hotplug pci driver for populating
hot-added pci hierarchy. As more drivers are cross ported over to wider
architectures, this would become wider need. Help me if others need this
too.


Current pci configuration access functions:
==========================================
	Current pci configuration access functions is based on "struct
pci_ops" from "struct pci_bus".
 pci_{read|write}_config_{byte|word|dword}(pci_dev, where, val);
 pci_bus_{read|write}_config_{byte|word|dword}(pci_bus, devfn, where, val);

Issue:
=====
	Current functions need pci_ops and pci_bus struct, which are not
constructed yet for the above cases.

Current solutions:
=================
(1) i386 and ia64 kernel provides global bare pci config access functions
like:
 pci_config_{read|write}(seg, bus, dev, func, where, size, val);
	Acpi driver uses these.

(2) Alternative is to allocate temporary pci_dev/pci_bus structs and copy
parent's or root's, and modify the struct.
	Hotplug pci driver uses this.


Question:
========
Will it be desirable to have bare global pci config access functions as seen
in i386/ia64 pci codes ? It's clean and needs just what it takes - seg, bus,
dev, func, where, value, and size.
Or, do we keep original functions with temporary structs ? It takes extra
care for temporary structs, but it's with pci context.

Request for comments.
thanks,
J.I.
