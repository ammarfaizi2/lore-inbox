Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137170AbRAHHM5>; Mon, 8 Jan 2001 02:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137153AbRAHHMq>; Mon, 8 Jan 2001 02:12:46 -0500
Received: from c252.h203149202.is.net.tw ([203.149.202.252]:49652 "EHLO
	mail.tahsda.org.tw") by vger.kernel.org with ESMTP
	id <S136990AbRAHHMN>; Mon, 8 Jan 2001 02:12:13 -0500
Date: Mon, 08 Jan 2001 15:11:41 +0800
From: Tommy Wu <tommy@teatime.com.tw>
To: mj@ucw.cz
Subject: 3CCFE575CT problem in 2.4.0, Maybe a PCI subsystem bug
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Reply-To: tommy@teatime.com.tw
Organization: TeaTime Development
Message-Id: <20010108150355.F06C.TOMMY@teatime.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.00.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  I've a 3CCFE575CT card. It is work fine in 2.2.18 kernel. 
  But when I change to kernel 2.4.0, I found it could not detect as 2.2.18. 

  I've report to pcmcia-cs maintainer, he suggest me to report this to here.
  
#---------------------------------------------------------------------- 
By: dahinds ( David Hinds ) 
      Maybe a PCI subsystem bug [ reply ]   
      2001-Jan-08 13:24 

I think you should try reporting it to Martin Mares, mj@ucw.cz, or post the problem on linux-kernel. He is the PCI subsystem maintainer. Point out to him
that the bus numbering for the CardBus bridge is bogus; I'm not sure if your BIOS or the kernel is at fault, but the kernel should correct this. With 2.2.18, the
PCMCIA drivers detected the problem and made up new bus numbers. 

You could also try configuring your kernel to have PCMCIA support built in. Those drivers are somewhat different from the drivers in the standalone
PCMCIA package and might behave differently. 

-- Dave 
#---------------------------------------------------------------------- 

  Here is my option.opts 
#---------------------------------------------------------------------- 
# System resources available for PCMCIA devices 

include port 0x100-0x4ff, port 0x800-0x8ff, port 0xc00-0xcff 
include memory 0xc0000-0xfffff 
include memory 0xa0000000-0xa0ffffff, memory 0x60000000-0x60ffffff 

# High port numbers do not always work... 
# include port 0x1000-0x17ff 

# Extra port range for IBM Token Ring 
include port 0xa00-0xaff 
#---------------------------------------------------------------------- 

  and here is my syslog for 2.4.0 kernel 
#---------------------------------------------------------------------- 
Jan 7 13:37:36 tp240 kernel: Linux PCMCIA Card Services 3.1.22 
Jan 7 13:37:36 tp240 kernel: kernel build: 2.4.0 #1 Sun Jan 7 12:13:36 CST 2001 
Jan 7 13:37:36 tp240 kernel: options: [pci] [cardbus] [apm] 
Jan 7 13:37:36 tp240 kernel: Intel PCIC probe: PCI: Found IRQ 11 for device 00:0a.0 
Jan 7 13:37:36 tp240 kernel: 
Jan 7 13:37:36 tp240 kernel: TI 1211 rev 00 PCI-to-CardBus at slot 00:0a, mem 0x10000000 
Jan 7 13:37:36 tp240 kernel: host opts [0]: [ring] [pci + serial irq] [pci irq 11] [lat 168/176] [bus 0/1] 
Jan 7 13:37:36 tp240 kernel: ISA irqs (scanned) = 3,4,7,9,10,15 PCI status changes 
Jan 7 13:37:36 tp240 cardmgr[177]: watching 1 sockets 
Jan 7 13:37:36 tp240 kernel: cs: IO port probe 0x0c00-0x0cff: clean. 
Jan 7 13:37:36 tp240 kernel: cs: IO port probe 0x0800-0x08ff: clean. 
Jan 7 13:37:36 tp240 kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x370-0x377 0x398-0x39f 0x3b8-0x3df 0x4d0-0x4d7 
Jan 7 13:37:36 tp240 kernel: cs: IO port probe 0x0a00-0x0aff: clean. 
Jan 7 13:37:36 tp240 kernel: cs: cb_alloc(bus 0): vendor 0x8086, device 0x7192 
Jan 7 13:37:36 tp240 cardmgr[177]: initializing socket 0 
Jan 7 13:37:36 tp240 cardmgr[177]: socket 0: Anonymous Memory 
Jan 7 13:37:36 tp240 anacron[186]: Anacron 2.1 started on 2001-01-07 
Jan 7 13:37:36 tp240 cardmgr[177]: executing: 'modprobe memory_cs' 
#---------------------------------------------------------------------- 

  and here is my syslog for 2.2.18 kernel 
#---------------------------------------------------------------------- 
Jan 7 14:24:04 tp240 kernel: Linux PCMCIA Card Services 3.1.22 
Jan 7 14:24:04 tp240 kernel: kernel build: 2.2.18 #1 Sun Jan 7 13:15:14 CST 2001 
Jan 7 14:24:04 tp240 kernel: options: [pci] [cardbus] [apm] 
Jan 7 14:24:04 tp240 kernel: PCI routing table version 1.0 at 0xfdf60 
Jan 7 14:24:04 tp240 kernel: 00:0a.0 -> irq 11 
Jan 7 14:24:04 tp240 kernel: Intel PCIC probe: 
Jan 7 14:24:04 tp240 kernel: TI 1211 rev 00 PCI-to-CardBus at slot 00:0a, mem 0x68000000 
Jan 7 14:24:04 tp240 kernel: host opts [0]: [ring] [pci + serial irq] [pci irq 11] [lat 168/176] [bus 32/34] 
Jan 7 14:24:04 tp240 kernel: ISA irqs (scanned) = 3,4,7,9,10,15 PCI status changes 
Jan 7 14:24:05 tp240 cardmgr[1752]: starting, version is 3.1.22 
Jan 7 14:24:05 tp240 cardmgr[1752]: watching 1 sockets 
Jan 7 14:24:05 tp240 kernel: cs: IO port probe 0x0c00-0x0cff: excluding 0xcf8-0xcff 
Jan 7 14:24:05 tp240 kernel: cs: IO port probe 0x0800-0x08ff: clean. 
Jan 7 14:24:05 tp240 kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x370-0x377 0x398-0x39f 0x3b8-0x3df 0x4d0-0x4d7 
Jan 7 14:24:05 tp240 kernel: cs: IO port probe 0x0a00-0x0aff: clean. 
Jan 7 14:24:05 tp240 kernel: cs: cb_alloc(bus 32): vendor 0x10b7, device 0x5257 
Jan 7 14:24:05 tp240 cardmgr[1752]: initializing socket 0 
Jan 7 14:24:05 tp240 cardmgr[1752]: socket 0: 3Com 3CCFE575CT/3CXFE575CT Fast EtherLink XL 
Jan 7 14:24:05 tp240 cardmgr[1752]: executing: 'modprobe cb_enabler' 
Jan 7 14:24:05 tp240 cardmgr[1752]: + modprobe: Can't locate module cb_enabler 
Jan 7 14:24:05 tp240 cardmgr[1752]: modprobe exited with status 255 
Jan 7 14:24:05 tp240 cardmgr[1752]: executing: 'insmod /lib/modules/2.2.18/pcmcia/cb_enabler.o' 
Jan 7 14:24:05 tp240 cardmgr[1752]: executing: 'modprobe 3c575_cb' 
Jan 7 14:24:06 tp240 cardmgr[1752]: + modprobe: Can't locate module 3c575_cb 
Jan 7 14:24:06 tp240 cardmgr[1752]: modprobe exited with status 255 
Jan 7 14:24:06 tp240 cardmgr[1752]: executing: 'insmod /lib/modules/2.2.18/pcmcia/3c575_cb.o' 
Jan 7 14:24:06 tp240 kernel: 3c59x.c:v0.99Q 5/16/2000 Donald Becker, becker@scyld.com 
Jan 7 14:24:06 tp240 kernel: http://www.scyld.com/network/vortex.html 
Jan 7 14:24:06 tp240 kernel: cs: cb_config(bus 32) 
Jan 7 14:24:06 tp240 kernel: fn 0 bar 1: io 0x200-0x27f 
Jan 7 14:24:06 tp240 kernel: fn 0 bar 2: mem 0x60021000-0x6002107f 
Jan 7 14:24:06 tp240 kernel: fn 0 bar 3: mem 0x60020000-0x6002007f 
Jan 7 14:24:06 tp240 kernel: fn 0 rom: mem 0x60000000-0x6001ffff 
Jan 7 14:24:06 tp240 kernel: irq 11 
Jan 7 14:24:06 tp240 kernel: cs: cb_enable(bus 32) 
Jan 7 14:24:06 tp240 kernel: bridge io map 0 (flags 0x21): 0x200-0x27f 
Jan 7 14:24:06 tp240 kernel: bridge mem map 0 (flags 0x1): 0x60000000-0x60021fff 
Jan 7 14:24:06 tp240 kernel: vortex_attach(device 20:00.0) 
Jan 7 14:24:06 tp240 kernel: eth0: 3Com 3CCFE575CT Tornado CardBus at 0x200, 00:50:04:b9:85:18, IRQ 11 
Jan 7 14:24:06 tp240 kernel: product code 'VP' rev 10.0 date 01-20-00 
Jan 7 14:24:06 tp240 kernel: eth0: CardBus functions mapped 60020000->cc0db000. 
Jan 7 14:24:06 tp240 kernel: 8K byte-wide RAM 5:3 Rx:Tx split, MII interface. 
Jan 7 14:24:06 tp240 kernel: MII transceiver found at address 0, status 7809. 
Jan 7 14:24:06 tp240 kernel: Enabling bus-master transmits and whole-frame receives. 
Jan 7 14:24:06 tp240 cardmgr[1752]: executing: './network start eth0' 
#---------------------------------------------------------------------- 

  What can I do for this ? 
  
-- 

    Tommy Wu
    mailto:tommy@teatime.com.tw
    http://www.teatime.com.tw/~tommy
    ICQ: 22766091
    Mobile Phone: +886 936 909490
    TeaTime BBS +886 2 3151964 24Hrs V.Everything


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
