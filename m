Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270604AbTGTChO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 22:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270606AbTGTChN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 22:37:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65227 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270604AbTGTChF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 22:37:05 -0400
Message-ID: <3F1A03C5.8010705@pobox.com>
Date: Sat, 19 Jul 2003 22:51:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "James H. Cloos Jr." <cloos@jhcloos.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: libata driver update posted
References: <m3ispyx79n.fsf@lugabout.jhcloos.org>
In-Reply-To: <m3ispyx79n.fsf@lugabout.jhcloos.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James H. Cloos Jr. wrote:
> 00:1f.1 Class 0101: 8086:244a (rev 03)
>         Subsystem: 8086:4541
>         Flags: bus master, medium devsel, latency 0
>         I/O ports at bfa0 [size=16]
[...]
> root=/dev/sda3 failed to find the root fs.
[...]
> Is my controller among the supported PIIX/ICH PATA chipsets?


Yes, all you need to do is add another PCI id for your chipset to 
drivers/scsi/ata_piix.c:

+ { 0x8086, 0x244a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix4_pata },

Once I add cable detection (PATA is currently limited to UDMA/33), this 
PCI ID entry will change slightly, but the above should get you going.

Note again that ATAPI isn't supported yet...

	Jeff



