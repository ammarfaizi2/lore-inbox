Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbULEQT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbULEQT0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 11:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbULEQT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 11:19:26 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:34857 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261239AbULEQTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 11:19:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=hn7ODEH00Ev1GUJytZF3/+BASW2KPyaUi8aG7J8emIyXRNOdfbhqxkdqQsxBvbZDktlA5Qrhyh23NVrt4GhuEwHi2jzmjGJmTylcvtCyUXyUh7PqbcOBFx9lzANgcJoeoRxMBJCz2MATf/qrHUtXl9TFZV0J069Ic01OhpafBOM=
Message-ID: <58cb370e04120508191488d4a2@mail.gmail.com>
Date: Sun, 5 Dec 2004 17:19:11 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Nico Schottelius <nico-kernel@schottelius.org>,
       linux-kernel@vger.kernel.org, Andre Hedrick <andre@linux-ide.org>,
       Frank Tiernan <frankt@promise.com>
Subject: Re: [BUG] pdc202xx_new and ACPI fails
In-Reply-To: <20041205005946.GA7695@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041205005946.GA7695@schottelius.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Dec 2004 01:59:46 +0100, Nico Schottelius
<nico-kernel@schottelius.org> wrote:
> Hello dear developers,
> 
> when loading pdc202xx_new on a 2.6.9 kernel with ACPI on the moprobe
>  call will never return and prints many errors [0].
> 
> The controller is a Promise Technology, Inc. PDC20270 (FastTrak100 LP/TX2/TX4) (rev 02).
> 
> If loading the driver without the forced option, it says deactivated
> by BIOS.
> 
> On the other hand, when loading with apm onlyi and enabling forced,
> it works fine [1].
> 
> So my questions:
> 
> - Why does it fail with ACPI?

Because ACPI assigns wrong IRQ line for the second PCI device
(ports ide4 and ide5).

> - Is it possible to fix that? If, how?

Maybe. ;-)
Please forward this mail to ACPI maintainer.

> - Is it possible to make forced enabling a module option?like force_against_bios=0|1
> - Where in which bios (controller/Mainboard) should one activate the ports?

They are marked as disabled for use of Windows software RAID driver,

Juse use forced option or -mm kernels
(they contain patch for automatic ignoring of BIOS settings).

> Greetings,
> 
> Nico
> 
> [0]: see attached dmesg.eiche
> 
> [1]:
> PDC20270: IDE controller at PCI slot 0000:02:01.0
> PDC20270: chipset revision 2
> PDC20270: ROM enabled at 0xdfee0000
> PDC20270: 100% native mode on irq 10
>     ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:pio, hdf:pio
>     ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdg:pio, hdh:pio
>     ide4: BM-DMA at 0xa800-0xa807, BIOS settings: hdi:pio, hdj:pio
>     ide5: BM-DMA at 0xa808-0xa80f, BIOS settings: hdk:pio, hdl:pio
> Probing IDE interface ide2...
> Probing IDE interface ide3...
> hdh: IDE DVD-ROM 16X, ATAPI CD/DVD-ROM drive
> ide3 at 0xc400-0xc407,0xc002 on irq 10
> Probing IDE interface ide4...
> Probing IDE interface ide5...
> hdk: WDC WD1200BB-00GUA0, ATA DISK drive
> ide5 at 0xb000-0xb007,0xac02 on irq 10
> hdk: max request size: 1024KiB
> hdk: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
> hdk: cache flushes supported
>  /dev/ide/host4/bus1/target0/lun0: unknown partition table
