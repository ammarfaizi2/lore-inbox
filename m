Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUJLMv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUJLMv4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 08:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUJLMv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 08:51:56 -0400
Received: from nessie.weebeastie.net ([220.233.7.36]:22671 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S261232AbUJLMvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 08:51:54 -0400
Date: Tue, 12 Oct 2004 22:52:02 +1000
From: CaT <cat@zip.com.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Li, Shaohua" <shaohua.li@intel.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: promise controller resource alloc problems with ~2.6.8
Message-ID: <20041012125202.GA920@zip.com.au>
References: <16A54BF5D6E14E4D916CE26C9AD305754575A3@pdsmsx402.ccr.corp.intel.com> <Pine.LNX.4.58.0410100955120.3897@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410100955120.3897@ppc970.osdl.org>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 10, 2004 at 10:00:32AM -0700, Linus Torvalds wrote:
> which has a "insert_resource()" in it. That "insert_resource()" should be
> a "request_resource()" (and for you it won't matter, but other people will
> likely want to additionally apply Shaohua's patch to put in ACPI resources
> last).
> 
> Hope this clears it all up. Knock wood.

Well with all the fun and the mind bendiness of the results of my
earlier tests I thought that there might be a slim chance that something
got buggered up with the lifetime of patching that particular kernel
tree got on my system and since rc4 was out I decided to start afresh.

I untarred 2.6.5, patched to 2.6.9-rc4, turned on the PCI debugging as
per request, compiled and rebooted. End result?

PDC20267: IDE controller at PCI slot 0000:00:0d.0
IRQ for 0000:00:0d.0:0 -> PIRQ 60, mask 0ef8, excl 0000 -> newirq=11 -> got IRQ 11
PCI: Found IRQ 11 for device 0000:00:0d.0
PDC20267: chipset revision 2
PDC20267: 100% native mode on irq 11
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x1080-0x1087, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x1088-0x108f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: IC35L060AVV207-0, ATA DISK drive
ide2 at 0x10f0-0x10f7,0x1802 on irq 11
Probing IDE interface ide3...
hdh: ST3200822A, ATA DISK drive
ide3 at 0x10f8-0x10ff,0x1806 on irq 11

It worked!

Now thinking that I may have just right royally buggered up I compiled
rc3 again, starting from a totally fresh tree like I did with rc4 and
the problem was still there. No promise card. (phew... kinda)

So basically, something got fixed between rc3 and rc4. Personally, I
call shenanigans.

-- 
    Red herrings strewn hither and yon.
