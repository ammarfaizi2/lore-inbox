Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315414AbSEBUp4>; Thu, 2 May 2002 16:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315415AbSEBUpz>; Thu, 2 May 2002 16:45:55 -0400
Received: from host.greatconnect.com ([209.239.40.135]:55556 "EHLO
	host.greatconnect.com") by vger.kernel.org with ESMTP
	id <S315414AbSEBUpx>; Thu, 2 May 2002 16:45:53 -0400
Message-ID: <3CD1A469.9040605@rackable.com>
Date: Thu, 02 May 2002 13:41:13 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: 2.4.19pres and IDE DMA
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I'm having issues with a Tyan 2720 and post 2.4.18 boards with a 
Maxtor 4G120J6.  Under 2.4.18 I can turn on dma via "hdparm -d 1". 
 Under 2.4.19pre7 I get "HDIO_SET_DMA fail ed: Operation not permitted". 
 On a side note the same thing occurs with the RH 2.4.18-0.13 kernel. 
 It appears both kernels merged an ide update from the ac kernel line.

PS-There is also some issue with a resource conflict that occurs under 
every kernel I've tried.


2.4.18:
bash-2.05# hdparm -d 1 /dev/hda

/dev/hda:
 setting using_dma to 1 (on)
 using_dma    =  1 (on)
bash-2.05# hdparm -d /dev/hda

/dev/hda:
 using_dma    =  1 (on)
bash-2.05#

2.4.19pre7

root@dev30> /sbin/hdparm /dev/hda

/dev/hda:
multcount    = 16 (on)
I/O support  =  0 (default 16-bit)
unmaskirq    =  0 (off)
using_dma    =  0 (off)
keepsettings =  0 (off)
nowerr       =  0 (off)
readonly     =  0 (off)
readahead    =  8 (on)
geometry     = 238216/255/63, sectors = 240121728, start = 0
busstate     =  1 (on)

root@dev30> /sbin/hdparm -d1 /dev/hda
/dev/hda:
setting using_dma to 1 (on)
HDIO_SET_DMA fail ed: Operation not permitted
using_dma    =  0 (off)


lspci strangeness: (both 2.4.19pre7, and 2.4.18)

00:1f.1 IDE interface: Intel Corporation: Unknown device 248b (rev 02) 
(prog-if
8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at <unassigned> [size=8]
        I/O ports at <unassigned> [size=4]
        I/O ports at <unassigned> [size=8]
        I/O ports at <unassigned> [size=4]
        I/O ports at ffa0 [size=16]
        Memory at 40000000 (32-bit, non-prefetchable) [disabled] [size=1K]

IDE intialization error: (both 2.4.19pre7, and 2.4.18)

PCI_IDE: unknown IDE controller on PCI bus 00 device f9,VID=8086,DID=248b
PCI: Device 00:1f.1 not available because of resource collision
PCI_IDE: (ide_setup_pci_device:) Could not enable device.





