Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318022AbSHaUFe>; Sat, 31 Aug 2002 16:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318026AbSHaUFe>; Sat, 31 Aug 2002 16:05:34 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:52891 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S318022AbSHaUFd>; Sat, 31 Aug 2002 16:05:33 -0400
Message-ID: <3D712217.5030003@oracle.com>
Date: Sat, 31 Aug 2002 22:07:51 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Consulting Premium Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020606
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cijoml@volny.cz
CC: linux-kernel@vger.kernel.org
Subject: Re: smc-ircc freeze kernel
References: <E17l52I-0000NL-00@notas>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Semler wrote:
> Hello,
> 
> I use 2.4.19 kernel with notebook Dell Latitude CPx J650
> 
> I modprobe these modules:
> irlan                  19252   0 (unused)
> smc-ircc                6720   1
> irport                  4856   0 [smc-ircc]
> irda                   81744   1 [irlan smc-ircc irport]
> 
> kernel tells me:
> found SMC SuperIO Chip (devid=0x09 rev=08 base=0x03f0): FDC37N958FR
> SMC IrDA Controller found
>  IrCC version 1.1, firport 0x290, sirport 0x3e8 dma=3, irq=0
> IrDA: Registered device irda0
> 
> ifconfig tells me:
> irda0     Link encap:IrLAP  HWaddr 00:00:00:00
>           UP RUNNING NOARP  MTU:2048  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:8
>           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
>           Base address:0x3e8
> 
> then when I simply tells:
> ifconfig irda0 192.168.1.1 netmask 255.255.255.0
> my kernel freeze after 3 seconds and only numlock and scrolllock blinks
> 
> I dont have any other computer on other side at the moment I write ifconfig.

Works fine here on 2.4.20-pre5, gcc-3.2, Dell CPx750J with the
  same IR chipset you have.

[root@dolphin root]# cat /proc/version
Linux version 2.4.20-pre5 (asuardi@dolphin) (gcc version 3.2) #1 Fri Aug 
30 01:11:42 CEST 2002

[root@dolphin root]# ifconfig irda0
irda0     Link encap:IrLAP  HWaddr 5b:21:2a:64
           inet addr:192.168.1.1  Mask:255.255.255.0
           UP RUNNING NOARP  MTU:2048  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:5056 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:8
           RX bytes:0 (0.0 b)  TX bytes:158118 (154.4 Kb)
           Interrupt:4 Base address:0x3e8

[root@dolphin root]# findchip -v
Found SMC FDC37N958FR Controller at 0x3f0, DevID=0x01, Rev. 1
     SIR Base 0x3e8, FIR Base 0x290
     IRQ = 4, DMA = 3
     Enabled: yes, Suspended: no
     UART compatible: yes
     Half duplex delay = 3 us

[root@dolphin root]# lsmod | grep ir
smc-ircc                7584   1
irport                  5368   1  [smc-ircc]
ircomm                  8712   0  (unused)
irlan                  23028   1
irda                   93520   1  [smc-ircc irport ircomm irlan]


Ciao,

--alessandro

  "everything dies, baby that's a fact
    but maybe everything that dies someday comes back"
        (Bruce Springsteen, "Atlantic City")

