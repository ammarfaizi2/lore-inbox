Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265977AbUA1Onw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 09:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265983AbUA1Onw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 09:43:52 -0500
Received: from hermes.py.intel.com ([146.152.216.3]:27803 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S265977AbUA1Onu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 09:43:50 -0500
Message-ID: <4017CA6C.1070301@intel.com>
Date: Wed, 28 Jan 2004 16:42:52 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
CC: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       torvalds@osdl.org, alan@lxorguk.ukuu.org.uk, greg@kroah.com,
       Andi Kleen <ak@colin2.muc.de>, akpm@osdl.org, mj@ucw.cz,
       "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
References: <6B09584CC3D2124DB45C3B592414FA83011A336E@bgsmsx402.gar.corp.intel.com>
In-Reply-To: <6B09584CC3D2124DB45C3B592414FA83011A336E@bgsmsx402.gar.corp.intel.com>
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My inputs:

- I do not like pci_express_read implemented as inline function. It is 
called only in one place. It is more appropriate, on my opinion, to 
merge all stuff added to include/asm-i386/pci.h , into 
arch/i386/pci/direct.c.

- if you will present 4k config space for all devices, it will save lots 
of work: you do not need to modify struct pci_dev, do not need almost 
all stuff in drivers/pci/proc.c. By presenting 4k config for PCI device 
you should not broke anything.

- Here and in _write function:
+static int pci_express_conf_read(int seg, int bus,
+        int devfn, int reg, int len, u32 *value)
+{
+    if (!value || (bus > 255) || (devfn > 255) || (reg > 4095)) {
+        printk(KERN_ERR "pci_express_conf_read: "
+                    "Invalid Parameter\n");
Worth to use
         printk(KERN_ERR "%s: Invalid Parameter\n",__FUNCTION__);

Durairaj, Sundarapandian wrote:

>Hi All, 
>
>Thanks for your comments. I am posting this patch after incorporating
>the review comments.
>
>Please find the attached patch file. Please review this and send your
>comments.
>
>Thanks,
>Sundar
>
>Note:
>This is the patch on PCI Express Enhanced configuration for 2.6.0 test11
>kernel following up to the Vladimir (Vladimir.Kondratiev@intel.com) and
>Harinarayanan (Harinarayanan.Seshadri@intel.com)  and my previous
>patches .
>I tested it on our i386 platform. 
>
>This patch also implements a mechanism for the kernel to find the
>chipset specific mmcfg base address. The kernel will detect the base
>address of the chipset through the ACPI table entry and based on that
>the PCI subsystem will be initialized.  
>  
>
