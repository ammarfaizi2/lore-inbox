Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263313AbTAEGw7>; Sun, 5 Jan 2003 01:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263321AbTAEGw7>; Sun, 5 Jan 2003 01:52:59 -0500
Received: from em-mta02.belbone.be ([195.13.2.54]:61941 "EHLO mta02.belbone.be")
	by vger.kernel.org with ESMTP id <S263313AbTAEGw6>;
	Sun, 5 Jan 2003 01:52:58 -0500
Message-ID: <3E17D82B.4090901@aquazul.com>
Date: Sun, 05 Jan 2003 08:00:59 +0100
From: Mourad De Clerck <mourad@aquazul.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: UDMA with Toshiba Host Bridge? (1179:0601 - 460CDT)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


I have this Toshiba Laptop here (a Satellite Pro 460CDT) that seems to be using a toshiba chipset instead of your garden variety intel/via/... chipset. It's running a bit sluggish, and the only thing I can really pinpoint is that it's not using UDMA for it's HD IO.

Now I was wondering if some kind soul ever whipped up a patch to support this specific chipset somewhere? I'm not sure if (accurate/complete) specs are available, the only thing I found was this page: http://linux.toshiba-dme.co.jp/linux/eng/develop.php3

I know it's an old machine, but I'd like to get some life out of it still if possible. 

Oh, and can anyone tell me exactly if mdma2 is really as slow as I think it is (compared to udma)? 


Thanks,


-- Mourad


Here's some info:

# lspci -v 

00:00.0 Host bridge: Toshiba America Info Systems 601 (rev a7)
	Flags: bus master, medium devsel, latency 0

00:04.0 VGA compatible controller: Chips and Technologies F65554 (rev c2) (prog-if 00 [VGA])
	Flags: stepping, medium devsel
	Memory at fe000000 (32-bit, non-prefetchable) [size=16M]
	Expansion ROM at <unassigned> [disabled] [size=256K]

00:0b.0 USB Controller: NEC Corporation USB (rev 01) (prog-if 10 [OHCI])
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at fdfff000 (32-bit, non-prefetchable) [size=4K]


# lspci -n

00:00.0 Class 0600: 1179:0601 (rev a7)
00:04.0 Class 0300: 102c:00e4 (rev c2)
00:0b.0 Class 0c03: 1033:0035 (rev 01)

# hdparm -i /dev/hda

/dev/hda:

 Model=IC25N010ATDA04-0, FwRev=DACOA70A, SerialNo=170171M6092
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=347kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=19640880
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 *mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 
 AdvancedPM=yes: mode=0x80 (128) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-5 T13 1321D revision 3:  2 3 4 5

# hdparm -d1 /dev/hda

/dev/hda:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation is not permitted
 using_dma    =  0 (off)





