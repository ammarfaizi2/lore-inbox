Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265344AbUFHWOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265344AbUFHWOG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 18:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265348AbUFHWOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 18:14:05 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:2471 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S265344AbUFHWOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 18:14:01 -0400
Message-ID: <40C63A27.6030902@nortelnetworks.com>
Date: Tue, 08 Jun 2004 18:13:59 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>,
       linuxppc-dev@lists.linuxppc.org
Subject: help with pci probing at boot time
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm trying to boot an mcpn765 card with 2.6.5 and I seem to be running into PCI 
issues.

There is a calling sequence in the 765 boot that goes like this:

arch_initcall(ppc_init);
ppc_md.init()
mcpn765_init2()
mcpn765_setup_via_82c586b()

This last function tries to find a particular VIA bridge using 
pci_find_device(), and if it doesn't find it it dumps an error message and 
halts.  This is what I'm seeing.

I tried to figure out how the PCI probing thing worked (I have CONFIG_HOTPLUG=n) 
but I couldn't figure out the call chain. (pci_devices gets added to by 
pci_bus_add_devices, which gets called by pci_do_scan_bus and 
pci_scan_bus_parented, but neither of those seems to get called by anyone in the 
ppc kernel, and all other callers of pci_bus_add_devices are hotplug-related or 
in another architecture.)

I instrumented the PCI probing functions, and they do not seem to be called 
before the ppc_init path, which presents difficulties since pci_find_device() 
doesn't have the data it needs to actually do its job.

Any suggestions?

Chris
