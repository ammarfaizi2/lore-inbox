Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270003AbTGPBVS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 21:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270005AbTGPBVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 21:21:18 -0400
Received: from galaxy.lunarpages.com ([64.235.234.165]:7395 "EHLO
	galaxy.lunarpages.com") by vger.kernel.org with ESMTP
	id S270003AbTGPBVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 21:21:16 -0400
Message-ID: <3F14AF0F.2070900@genebrew.com>
Date: Tue, 15 Jul 2003 21:49:03 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030706
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Marcelo Penna Guerra <eu@marcelopenna.org>,
       Lars Duesing <ld@stud.fh-muenchen.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1: include/linux/pci.h inconsistency?
References: <1058195165.4131.6.camel@ws1.intern.stud.fh-muenchen.de> <200307151027.06474.eu@marcelopenna.org> <20030715144212.GB13207@gtf.org>
In-Reply-To: <20030715144212.GB13207@gtf.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.lunarpages.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - genebrew.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> I really would love some person with an nForce NIC to try and use
> amd8111e.c or pcnet32.c with their nForce2 NIC, and see what happens.

Added the IDs (0066 in my case, one of three according to Nvidia 
sources) to pci_ids.h and to the drivers. Assuming that is all that is 
needed, here's what happened:

amd8111e.c:

PCI: Setting latency timer of device 0000:00:04.0 to 64
eth1: AMD-8111e Driver Version: 3.0.3
eth1: [ Rev 0 ] PCI 10/100BaseT Ethernet 00:00:00:00:00:00

Loaded fine, but note the incorrect MAC address.

pcnet32.c (with debug=7):

PCI: Setting latency timer of device 0000:00:04.0 to 64
pcnet32.c:v1.27b 01.10.2002 tsbogend@alpha.franken.de
PCI: Setting latency timer of device 0000:00:04.0 to 64
pcnet32: io address range already allocated
pcnet32.c:v1.27b 01.10.2002 tsbogend@alpha.franken.de
kobject_register failed for pcnet32 (-17)
Call Trace:
  [<c01ab94c>] kobject_register+0x4c/0x60
  [<c01d93d4>] bus_add_driver+0x54/0xc0
  [<c01d9891>] driver_register+0x31/0x40
  [<c01b27ef>] pci_register_driver+0x6f/0xa0
  [<fc8b8044>] pcnet32_init_module+0x44/0x9e [pcnet32]
  [<c01310ca>] sys_init_module+0x14a/0x2a0
  [<c010930b>] syscall_call+0x7/0xb

Any other likely candidates? Is there any way to probe this?

Thanks,
Rahul

