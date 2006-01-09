Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbWAISAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbWAISAF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 13:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbWAISAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 13:00:01 -0500
Received: from smtp-out.google.com ([216.239.45.12]:3565 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S964884AbWAISAA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 13:00:00 -0500
Message-ID: <43C2A48F.6030407@google.com>
Date: Mon, 09 Jan 2006 09:59:43 -0800
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
Subject: Problems with 2.6.15-mm1 and mm2.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, so on -mm1 we get:

Unable to handle kernel NULL pointer dereference at virtual address 00000004
  printing eip:
c01fccd2
*pde = 0042d001
*pte = 00000000
Oops: 0000 [#1]
SMP
last sysfs file:
Modules linked in:
CPU:    0
EIP:    0060:[<c01fccd2>]    Not tainted VLI
EFLAGS: 00010286   (2.6.15-mm1-autokern1)
EIP is at pci_call_probe+0x1a/0xa1
eax: 00000000   ebx: ffffffed   ecx: e748a030   edx: c03a4680
esi: e7767800   edi: c03a4680   ebp: ffffffff   esp: e749fef0
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=e749e000 task=e748a030)
Stack: <0>ffffffed e7767800 c03a4680 c03a46ac c01fcd8c c03a4680 e7767800 
c03a441c
        <0>c03a4680 e7767800 c03a46ac c01fcdbf c03a4680 e7767800 
e7767800 00000000
        <0>e7767848 c021c265 e7767848 e7767848 00000000 c021c311 
c021c34a c03a46ac
Call Trace:
  [<c01fcd8c>] __pci_device_probe+0x33/0x47
  [<c01fcdbf>] pci_device_probe+0x1f/0x34
  [<c021c265>] driver_probe_device+0x3a/0x84
  [<c021c311>] __driver_attach+0x0/0x60
  [<c021c34a>] __driver_attach+0x39/0x60
  [<c021ba18>] bus_for_each_dev+0x47/0x6d
  [<c01f4d5a>] kobject_add+0x76/0x95
  [<c021c385>] driver_attach+0x14/0x18
  [<c021c311>] __driver_attach+0x0/0x60
  [<c021be30>] bus_add_driver+0x54/0x87
  [<c021c72c>] driver_register+0x3b/0x3e
  [<c01fcfa6>] __pci_register_driver+0x7e/0x8c
  [<c03f646d>] qla1280_init+0xc/0xf
  [<c03e4789>] do_initcalls+0x4b/0x99
  [<c0100393>] init+0x98/0x195
  [<c01002fb>] init+0x0/0x195
  [<c0100ea9>] kernel_thread_helper+0x5/0xb

from the NUMA-Q. http://test.kernel.org/19793/debug/console.log

------------------------------------------------------------------

on -mm2 I get the x86_64 seems to lock up (NFI why ... looking at it), 
the NUMA-Q and x440 panic (very similar to the above).

I think Andy figured out what was causing those panics. Can we drop 
those patches until they're fixed?

Thanks,

M.
