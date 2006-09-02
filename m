Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751660AbWIBWpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbWIBWpY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 18:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbWIBWpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 18:45:24 -0400
Received: from khc.piap.pl ([195.187.100.11]:31185 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751660AbWIBWpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 18:45:23 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.18-rc5 + pata-drivers on MSI K9N Ultra report, AMD64
References: <m3psee58lg.fsf@defiant.localdomain>
	<1157234944.6271.400.camel@localhost.localdomain>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 03 Sep 2006 00:45:20 +0200
In-Reply-To: <1157234944.6271.400.camel@localhost.localdomain> (Alan Cox's message of "Sat, 02 Sep 2006 23:09:03 +0100")
Message-ID: <m3lkp1anwf.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> scsi3 : pata_amd
>> ata4: port is slow to respond, please be patient
>> ata4: port failed to respond (30 secs)
>
> Please send me an lspci -vxxx. This might be BIOS or might be us
> misparsing disable/enable bits.

(removed CC: netdev)

Hmmm... is it that 0x62, isn't it?

        static struct pci_bits amd_enable_bits[] = {
                { 0x40, 1, 0x02, 0x02 },
                { 0x40, 1, 0x01, 0x01 }
        };

        if (!pci_test_config_bits(pdev, &amd_enable_bits[ap->port_no])) {
                ata_port_disable(ap);
                printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);

Perhaps this code isn't called at all? It looks I can debug it if you
want so (i.e., if there is no obvious visible bug here).

00:04.0 IDE interface: nVidia Corporation MCP55 IDE (rev a1) (prog-if 8a [Master
 SecP PriP])
        Subsystem: Unknown device f462:7250
        Flags: bus master, 66MHz, fast devsel, latency 0
        I/O ports at ffa0 [size=16]
        Capabilities: [44] Power Management version 2
00: de 10 6e 03 05 00 b0 00 a1 8a 01 01 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: a1 ff 00 00 00 00 00 00 00 00 00 00 62 f4 50 72
30: 00 00 00 00 44 00 00 00 00 00 00 00 00 00 03 01
40: 62 f4 50 72 01 00 02 00 00 00 00 00 00 00 00 00
    ^^
50: 02 f0 04 00 00 00 00 00 a8 a8 a8 20 3f 00 ff 20
60: 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 60 a0 bb 3e 00 00 02 10 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 01
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00
-- 
Krzysztof Halasa

-- 
VGER BF report: U 0.500121
