Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbULAXe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbULAXe0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 18:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbULAXeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 18:34:25 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:24234 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S261493AbULAXeI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 18:34:08 -0500
Message-ID: <41AE28EB.9090302@free.fr>
Date: Wed, 01 Dec 2004 21:26:19 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net
Cc: Adam Belay <ambx1@neo.rr.com>, "Li, Shaohua" <shaohua.li@intel.com>,
       Len Brown <len.brown@intel.com>
Subject: [ACPI] Re: Fw: ACPI bug causes cd-rom lock-ups (2.6.10-rc2)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >+/*
 >+ * We'd like PNP to call this routine for the
 >+ * single ISA_USED value for each legacy device.
 >+ * But instead it calls us with each POSSIBLE setting.
 >+ * There is no ISA_POSSIBLE weight, so we simply use
 >+ * the (small) PCI_USING penalty.
 >+ */

Couldn't be better to change the pnp core behaviour ?

In drivers/pnp/resource.c, pnp_register_irq_resource, instead of calling 
pcibios_penalize_isa_irq couldn't we call something like 
pcibios_penalize_possible_isa_irq ?

The pnp implemations already use pcibios_penalize_isa_irq [1] for the 
irq that are used.
So it seem it is call 2 times for the allocated resources...
Also don't we need to depenalize the irq, if we change the irq or 
disable the device ?

Matthieu CASTET


[1]
$grep -r penalize */*
pnpacpi/rsparser.c: 
pcibios_penalize_isa_irq(res->data.irq.interrupts[0]);
pnpacpi/rsparser.c: 
pcibios_penalize_isa_irq(res->data.extended_irq.interrupts[0]);
pnpbios/rsparser.c:             pcibios_penalize_isa_irq(irq);
