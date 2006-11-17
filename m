Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933644AbWKQPCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933644AbWKQPCR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 10:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933646AbWKQPCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 10:02:17 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:30183 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S933644AbWKQPCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 10:02:16 -0500
Message-ID: <455DCEF7.3060906@s5r6.in-berlin.de>
Date: Fri, 17 Nov 2006 16:02:15 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Mattia Dongili <malattia@linux.it>, Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net, bcollins@debian.org
Subject: Re: 2.6.19-rc5-mm2
References: <20061114014125.dd315fff.akpm@osdl.org> <20061116171715.GA3645@inferi.kami.home> <455CAE0F.1080502@s5r6.in-berlin.de> <20061116203926.GA3314@inferi.kami.home> <455CEB48.5000906@s5r6.in-berlin.de> <20061117071650.GA4974@inferi.kami.home>
In-Reply-To: <20061117071650.GA4974@inferi.kami.home>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mattia Dongili wrote:
>>> http://oioio.altervista.org/linux/2.6.19-rc5-mm2-1-ko
and
http://oioio.altervista.org/linux/config-2.6.19-rc5-mm2-1
| # CONFIG_SYSFS_DEPRECATED is not set

| ieee1394: Node removed: ID:BUS[0-00:1023]  GUID[080046030227e7bb]
| ieee1394: Node removed: ID:BUS[20754571-38:0455]  GUID[00000000f8ee6067]
| BUG: unable to handle kernel NULL pointer dereference at virtual
address 000000a4
|  printing eip:
| c0238c60
| *pde = 00000000
| Oops: 0000 [#1]
| SMP
| last sysfs file: /devices/pci0000:00/0000:00:00.0/class
[...]
| EIP is at class_device_remove_attrs+0xd/0x34
| eax: f7e02b8c   ebx: 00000000   ecx: ffffffff   edx: 00000000
| esi: 00000000   edi: f7e02b8c   ebp: f7629e04   esp: f7629df8
| ds: 007b   es: 007b   ss: 0068
| Process rmmod (pid: 2419, ti=f7628000 task=f702a550 task.ti=f7628000)
| Stack: f7e02b8c f7e02b94 00000000 f7629e20 c0238d47 00000000 f7e02a30
f7e02b8c
|        f7e02a30 00000000 f7629e2c c0238d82 f7e029f4 f7629e54 f8d5da3d
f8d63087
|        013cb08b 00000026 000001c7 f8ee6067 00000000 00000000 f8d5da52
f7629e5c
| Call Trace:
|  [<c0238d47>] class_device_del+0xc0/0xf0
|  [<c0238d82>] class_device_unregister+0xb/0x15
|  [<f8d5da3d>] nodemgr_remove_ne+0x64/0x79 [ieee1394]
|  [<f8d5da5d>] __nodemgr_remove_host_dev+0xb/0xf [ieee1394]
|  [<c02366dc>] device_for_each_child+0x1d/0x46
|  [<f8d5dd82>] nodemgr_remove_host+0x36/0x5d [ieee1394]
|  [<f8d5b4f3>] __unregister_host+0x1b/0x9c [ieee1394]
|  [<f8d5b70b>] highlevel_remove_host+0x24/0x47 [ieee1394]
|  [<f8d5b14f>] hpsb_remove_host+0x3b/0x5c [ieee1394]
|  [<f8dcbf9d>] ohci1394_pci_remove+0x47/0x1c7 [ohci1394]
|  [<c01dd619>] pci_device_remove+0x19/0x39

Either the FireWire host's device->klist_children was overwritten before
the call to device_for_each_child (perhaps nodemgr didn't hold a
reference which it should have), or/and all of this is an issue with the
ongoing migration away from class_device.
-- 
Stefan Richter
-=====-=-==- =-== =---=
http://arcgraph.de/sr/
