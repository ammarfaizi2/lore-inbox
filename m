Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbTDIJaQ (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 05:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262947AbTDIJaQ (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 05:30:16 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:55302 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262941AbTDIJ3n (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 05:29:43 -0400
Message-ID: <3E93EB0E.4030609@aitel.hist.no>
Date: Wed, 09 Apr 2003 11:42:38 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org, vandrove@vc.cvut.cz,
       jsimmons@infradead.org
Subject: Re: 2.5.67-mm1 cause framebuffer crash at bootup
References: <20030408042239.053e1d23.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.67 works with framebuffer console, 2.5.67-mm1 dies before activating
graphichs mode on two different machines:

smp with matroxfb, also using a patch that makes matroxfb work in 2.5
up with radeonfb, also using patches that fixes the broken devfs in mm1.

I use devfs and preempt in both cases, and monolithic kernels without module
support.

2.5.67-mm1 works if I drop framebuffer support completely.

Here is the printed backtrace for the radeon case, the matrox case was 
similiar:

<a few lines scrolled off screen>
pcibios_enable_device
pci_enable_device_bars
pci_enable_device
radeonfb_pci_register
sysfs_new_inode
pci_device_probe
bus_match
device_attach
bus_add_device
kobject_add
device_add
pci_bus_add_devices
pci_bus_add_devices
pci_scan_bus_parented
pcibios_scan_root
pci_legacy_init
do_initcalls
init_workqueues
init+0x36
init+0x00
kernel_thread_helper
code: Bad EIP value <0>Kernel panic:attempt to kill init!

sysrq worked and let me reboot.  No filesystems were
mounted at this point.

Helge Hafting

