Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264656AbTIIWBT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 18:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264658AbTIIWBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 18:01:19 -0400
Received: from shopwall.abacus.ch ([193.246.120.14]:20145 "EHLO
	shopwall.abacus.ch") by vger.kernel.org with ESMTP id S264656AbTIIWBJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 18:01:09 -0400
Message-ID: <3F5E4D93.9030804@your.toilet.ch>
Date: Wed, 10 Sep 2003 00:00:51 +0200
From: Remo Inverardi <invi@your.toilet.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030908 Debian/1.4-4
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: OHCI Host Controler Died
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: ---- Start SpamAssassin results
  -0.40 points, 5.5 required;
  *  0.0 -- User-Agent header indicates a non-spam MUA (Mozilla)
  * -0.4 -- BODY: Contains what looks like a quoted email text
  ---- End of SpamAssassin results
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running Debian SID with a custom Linux 2.6.0-test5 kernel on my
Compaq Evo N800v notebook. When running Windows XP in VMware, and
accessing an Aladdin eToken (cryptographic USB smartcard) from my
virtual machine, the USB host controller crashes immediately.

Here's the interesting part of lspci:

> 00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset
> \Host Bridge (rev 04)
> 00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset
> \AGP Bridge (rev 04)
> 00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev
> \42)
> 00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev
> \02)
> 00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev
> \02)
> 00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM
> \AC'97 Audio (rev 02)
> 01:00.0 VGA compatible controller: ATI Technologies Inc
> \Radeon Mobility M7 LW [Radeon Mobility 7500]
> 02:04.0 Communication controller: Conexant HSF 56k HSFi Modem
> \(rev 01)
> 02:06.0 CardBus bridge: Texas Instruments PCI1410 PC card
> \Cardbus Controller (rev 02)
> 02:08.0 Ethernet controller: Intel Corp. 82801CAM (ICH3)
> \PRO/100 VE (LOM) Ethernet Controller (rev 42)
> 02:0e.0 USB Controller: NEC Corporation USB (rev 41)
> 02:0e.1 USB Controller: NEC Corporation USB (rev 41)
> 02:0e.2 USB Controller: NEC Corporation USB 2.0 (rev 02)

Here's my kernel config:

> CONFIG_USB=y
> # CONFIG_USB_DEBUG is not set
> CONFIG_USB_DEVICEFS=y
> # CONFIG_USB_BANDWIDTH is not set
> # CONFIG_USB_DYNAMIC_MINORS is not set
> # CONFIG_USB_EHCI_HCD is not set
> CONFIG_USB_OHCI_HCD=y
> # CONFIG_USB_UHCI_HCD is not set

Here's the interesting part of syslog:

> Sep  9 11:37:23 invi-laptop kernel:
> hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
> hub 1-0:0: new USB device on port 1, assigned address 2
> ohci-hcd 0000:02:0e.0: OHCI Unrecoverable Error, disabled
> ohci-hcd 0000:02:0e.0: HC died; cleaning up
> usb 1-1: USB disconnect, address 2
> ohci-hcd 0000:02:0e.0: ed d4f76000 (#0) state 0(has tds)
> drivers/usb/core/message.c: error getting string descriptor 0
> \(error=-108)
> drivers/usb/core/mesage.c: error getting string descriptor 0
> \(error=-19)
> usbfs: USBDEVFS_CONTROL failed cmd vmware-vmx dev 2 rqt 128 rq 6 len
> \4 ret -19

By the way, if I insert the token when VMware is *not* running,
/proc/bus/usb shows that the token was detected correctly:

> T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
> B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
> D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=0000 ProdID=0000 Rev= 2.06
> S:  Manufacturer=Linux 2.6.0-test5 ohci-hcd
> S:  Product=OHCI Host Controller
> S:  SerialNumber=0000:02:0e.1
> C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
>
> T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 3
> B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
> D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=0000 ProdID=0000 Rev= 2.06
> S:  Manufacturer=Linux 2.6.0-test5 ohci-hcd
> S:  Product=OHCI Host Controller
> S:  SerialNumber=0000:02:0e.0
> C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
>
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=1.5 MxCh= 0
> D:  Ver= 1.00 Cls=ff(vend.) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=0529 ProdID=050c Rev= 1.00
> S:  Manufacturer=AKS
> S:  Product=eToken Pro 4154
> C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr= 60mA
> I:  If#= 0 Alt= 0 #EPs= 0 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)

Any ideas?

Thanks for your time, Remo


