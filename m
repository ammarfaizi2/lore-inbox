Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130588AbRCECKc>; Sun, 4 Mar 2001 21:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130600AbRCECKW>; Sun, 4 Mar 2001 21:10:22 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.59.198]:9523 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S130588AbRCECKK>; Sun, 4 Mar 2001 21:10:10 -0500
Message-ID: <3AA2F562.7070705@blue-labs.org>
Date: Sun, 04 Mar 2001 18:09:38 -0800
From: David <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-ac4 i686; en-US; 0.9) Gecko/20010303
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: USB problem, bug since 2.4.2-ac5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In ac5 the USB or related changes broke things for this system I 
upgraded, this bug still exists in ac11.

I get the following messages on the order of about 50/second.

usb-uhci.c: interrupt, status 20, frame# 0
usb-uhci.c: interrupt, status 30, frame# 0

They repeat forever evenly, 20-30-20-30..

Alan's announcment for -ac5 has listed in it:

Fix USB thread wakeup scheduling(Arjan van de Ven)

00:04.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
       Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
       Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
       Latency: 32 set
       Interrupt: pin D routed to IRQ 9
       Region 4: I/O ports at b400 [size=32]

The only USB device I have plugged in atm is:

input0: USB HID v1.00 Mouse [Logitech USB-PS/2 Mouse] on usb1:2.0

/proc/bus/usb has:

# cat devices
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=118/900 us (13%), #Int=  1, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=b400
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=1.5 MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046d ProdID=c001 Rev= 1.10
S:  Manufacturer=Logitech
S:  Product=USB-PS/2 Mouse
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr= 50mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl= 10ms

# cat drivers
        cpia
        usbdevfs
        hub
        hid
48- 63: usbscanner
        acm
  0- 15: usblp
        audio
80- 95: dc2xx
        ov511
        dsbr100
        bluetooth
        pegasus
        usb-storage

-d

