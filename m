Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbSKLPJg>; Tue, 12 Nov 2002 10:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261605AbSKLPJg>; Tue, 12 Nov 2002 10:09:36 -0500
Received: from calc.cheney.cx ([207.70.165.48]:1504 "EHLO calc.cheney.cx")
	by vger.kernel.org with ESMTP id <S261594AbSKLPJe>;
	Tue, 12 Nov 2002 10:09:34 -0500
Date: Tue, 12 Nov 2002 09:16:22 -0600
From: Chris Cheney <ccheney@debian.org>
To: linux-kernel@vger.kernel.org
Subject: ATI Radeon IGP 320M Linux support
Message-ID: <20021112151622.GC16414@cheney.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I recently purchased a Compaq Presario 900Z laptop and discovered it
used a ATI Radeon IGP 320M chipset.

http://mirror.ati.com/technology/hardware/radeonigp/rigp320m.html

>From the pci output it looks like it uses ALi parts but at least with
kernel 2.4.18 it will not boot properly (Yes, Windows XP runs on it).
I tried to install Debian on it (2.4.18 kernel) and at first it hangs
with a machine check exception unless nomce is passed, then it will
give errors like this:

(doing this repeatedly)
hdc: status error: status=0x20 { DeviceFault }
hdc: DMA disabled
hdc: ATAPI reset complete
hdc: status error: status=0x20 { DeviceFault }
hdc: ATAPI reset complete
hdc: status error: status=0x20 { DeviceFault }
end_request: I/O error, dev 16:00 (hdc), sector 0

If I run fdisk -l /dev/hda I see:

hda: status timeout: status=0x80 { Busy }
hda: DMA disabled
hda: drive not ready for command
ide0: reset timed-out, status=0x80
hda: status timeout: status=0x80 { Busy }
hda: drive not ready for command
ide0: reset timed-out, status=0x80
end_request: I/O error, dev 03:00 (hda), sector 0

I have tried installing gentoo 1.4rc1 and RedHat 8.0 and both of them
failed to install as well.

Here is /proc/pci output:

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: PCI device 1002:cab0 (ATI Technologies Inc) (rev 19).
      Master Capable.  Latency=64.
      Prefetchable 32 bit memory at 0xf8000000 [0xfbffffff].
      Prefetchable 32 bit memory at 0xf4400000 [0xf4400fff].
      I/O at 0x8090 [0x8093].
  Bus  0, device   1, function  0:
    PCI bridge: PCI device 1002:700f (ATI Technologies Inc) (rev 1).
      Master Capable.  Latency=99.  Min Gnt=12.
  Bus  0, device   2, function  0:
    USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 3).
      IRQ 11.
      Master Capable.  Latency=64.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xf4010000 [0xf4010fff].
  Bus  0, device  15, function  0:
    USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (#2) (rev 3).
      IRQ 11.
      Master Capable.  Latency=64.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xf4012000 [0xf4012fff].
  Bus  0, device   7, function  0:
    ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV] (rev 0).
  Bus  0, device   8, function  0:
    Multimedia audio controller: Acer Laboratories Inc. [ALi] M5451 PCI South Bridge Audio (rev 2).
      IRQ 5.
      Master Capable.  Latency=64.  Min Gnt=2.Max Lat=24.
      I/O at 0x8400 [0x84ff].
      Non-prefetchable 32 bit memory at 0xf4011000 [0xf4011fff].
  Bus  0, device  10, function  0:
    Class ffff: Texas Instruments PCI1410 PC card Cardbus Controller (rev 255).
      Master Capable.  Latency=255.  Min Gnt=255.Max Lat=255.
      Non-prefetchable 32 bit memory at 0xffbfe000 [0xffbfefff].
  Bus  0, device  11, function  0:
    Class ffff: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 255).
      IRQ 11.
      Master Capable.  Latency=255.  Min Gnt=255.Max Lat=255.
      I/O at 0x8800 [0x88ff].
      Non-prefetchable 32 bit memory at 0xf4013000 [0xf40130ff].
  Bus  0, device  12, function  0:
    Class ffff: Conexant HSF 56k HSFi Modem (rev 255).
      IRQ 10.
      Master Capable.  Latency=255.  Min Gnt=255.Max Lat=255.
      Non-prefetchable 32 bit memory at 0xf4000000 [0xf400ffff].
      I/O at 0x8098 [0x809f].
  Bus  0, device  16, function  0:
    IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev 196).
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=4.
      I/O at 0x8080 [0x808f].
  Bus  0, device  17, function  0:
    Bridge: Acer Laboratories Inc. [ALi] M7101 PMU (rev 0).
  Bus  1, device   5, function  0:
    VGA compatible controller: PCI device 1002:4336 (ATI Technologies Inc) (rev 0).
      IRQ 10.
      Master Capable.  Latency=66.  Min Gnt=8.
      Prefetchable 32 bit memory at 0xf6000000 [0xf7ffffff].
      I/O at 0x9000 [0x90ff].
      Non-prefetchable 32 bit memory at 0xf4100000 [0xf410ffff].


Does anyone have any ideas on how to make this work, and/or does it need
further kernel support?

Thanks,

Chris Cheney

PS - I am not subscribed to lkml please CC: any comments.
