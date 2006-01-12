Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161310AbWALVfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161310AbWALVfa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 16:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161311AbWALVf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 16:35:29 -0500
Received: from proxy3.nextra.sk ([195.168.1.138]:24595 "EHLO
	mailhub3.nextra.sk") by vger.kernel.org with ESMTP id S1161310AbWALVf3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 16:35:29 -0500
Message-ID: <43C6CB99.50302@rainbow-software.org>
Date: Thu, 12 Jan 2006 22:35:21 +0100
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: axboe@suse.de
Subject: ide-cd turning off DMA when verifying DVD-R
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I found this problem when burning DVDs using K3b (it uses growisofs to 
do the work) with LG GSA-4167B drive:
Burn process completes without any problems, then K3b ejects and reloads 
the tray, then it calculates MD5 checksum from the image. Then it starts 
reading the DVD back to calculate MD5 checksum of it. The moment it 
starts to read, this appears in dmesg:

hdd: irq timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hdd: DMA disabled
hdd: ATAPI reset complete

And then it slowly reads the DVD in PIO mode. After about a hour, it 
finishes with success. When I re-enable DMA mode ("hdparm -d1 /dev/hdd") 
immediately after it was disabled, it works fine in - there are no more 
errors in the log and the verification completes much sooner. I burnt 10 
DVDs and it always does exactly this.

Any ideas why it does this? And why ide-cd disables the DMA?

Kernel is 2.6.13, the drive is (firmware is the latest version):
/dev/hdd:

  Model=HL-DT-ST DVDRAM GSA-4167B, FwRev=DL12, SerialNo=7076348C2984
  Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
  RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
  BuffType=unknown, BuffSize=0kB, MaxMultSect=0
  (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
  PIO modes:  pio0 pio3 pio4
  DMA modes:  mdma0 mdma1 mdma2
  UDMA modes: udma0 udma1 *udma2
  AdvancedPM=no
  Drive conforms to: device does not report version:

  * signifies the current active mode

-- 
Ondrej Zary
