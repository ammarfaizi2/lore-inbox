Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266733AbUHIQtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266733AbUHIQtp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 12:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266732AbUHIQtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 12:49:45 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:10893 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S266731AbUHIQth
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 12:49:37 -0400
Subject: Re: 2.6.8-rc2-mm1: bluetooth broken?
From: Marcel Holtmann <marcel@holtmann.org>
To: Stephane Jourdois <stephane@rubis.org>
Cc: Filip Van Raemdonck <filipvr@xs4all.be>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <greg@kroah.com>,
       zaitcev@yahoo.com
In-Reply-To: <20040809151229.GA8651@diamant.rubis.org>
References: <20040808191912.GA620@elf.ucw.cz>
	 <1092003277.2773.45.camel@pegasus> <20040809095425.GA12667@debian>
	 <1092046959.21815.15.camel@pegasus>
	 <20040809120705.GA23073@diamant.rubis.org>
	 <1092057843.21815.21.camel@pegasus>
	 <20040809133452.GA24530@diamant.rubis.org>
	 <1092061267.4639.4.camel@pegasus> <20040809151229.GA8651@diamant.rubis.org>
Content-Type: text/plain
Message-Id: <1092070144.4564.6.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 09 Aug 2004 18:49:05 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephane,

> > Do "hciconfig -a" show your Bluetooth device? Do "/proc/bus/usb/devices"
> > has an entry for it? Check "dmesg" for any USB related error messages.
> 
> BTW I tried a vanilla 2.6.8-rc3, and it works.
> 
> 
> under 2.6.8-rc3-mm1 and  2.6.8-rc2-mm2 :
> 
> hciconfig -a gives nothing.
> 
> dmesg -s 1000000 | grep -i usb :
> ----
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> USB Universal Host Controller Interface driver v2.2
> uhci_hcd 0000:00:1d.0: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1
> uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
> hub 1-0:1.0: USB hub found
> uhci_hcd 0000:00:1d.1: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2
> uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
> usbcore: registered new driver ub
> hub 2-0:1.0: USB hub found
> uhci_hcd 0000:00:1d.2: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3
> uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
> hub 3-0:1.0: USB hub found
> uhci_hcd 0000:00:1d.3: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4
> uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
> hub 4-0:1.0: USB hub found
> usb 3-2: new full speed USB device using address 2
> usb 4-2: new full speed USB device using address 2
> ehci_hcd 0000:00:1d.7: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller
> ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
> ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
> hub 5-0:1.0: USB hub found
> usb 4-2: can't set config #1, error -71
> usb 3-2: USB disconnect, address 2
> usb 3-2: new full speed USB device using address 3
> usb 3-2: not running at top speed; connect to a high speed hub
> usb 4-2: new full speed USB device using address 4
> Bluetooth: HCI USB driver ver 2.7
> usbcore: registered new driver hci_usb
> ----
> 
> 
> under 2.6.8-rc3 :
> 
> hciconfig -a :
> ----
> hci0:   Type: USB
>         BD Address: 00:10:60:A2:F9:30 ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN 
>         RX bytes:24159 acl:1576 sco:0 events:160 errors:0
>         TX bytes:1221 acl:24 sco:0 commands:52 errors:0
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
>         Link policy: RSWITCH HOLD SNIFF PARK 
>         Link mode: SLAVE ACCEPT 
>         Name: 'diamant-0'
>         Class: 0x000100
>         Service Classes: Unspecified
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x33c LMP Ver: 1.1 (0x1) LMP Subver: 0x33c
>         Manufacturer: Cambridge Silicon Radio (10)
> ----
> 
> Here is relevant part of a
> diff -u proc_bus_usb_devices_2.6.8-rc2-mm2 proc_bus_usb_devices_2.6.8-rc3 :
> ----
> -T:  Bus=04 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  4 Spd=12  MxCh= 0
> +T:  Bus=04 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
>  D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
>  P:  Vendor=0a12 ProdID=0001 Rev= 8.28
>  C:* #Ifs= 3 Cfg#= 1 Atr=c0 MxPwr=  0mA
> -I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=ub
> +I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
>  E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
>  E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>  E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> -I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=ub
> +I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
>  E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>  E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> -I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=ub
> +I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
>  E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>  E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> -I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=ub
> +I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
>  E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>  E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> -I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=ub
> +I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
>  E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>  E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> -I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=ub
> +I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
>  E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>  E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> -I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=ub
> +I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
>  E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>  E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> -I:  If#= 2 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=ub
> +I:  If#= 2 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)
> ----
> 
> I have quite same diff ("usb-storage" under -rc3, "ub" under -mm) for my
> flash reader, which I tested under neither (I don't have any CF/SD card
> here).
> 
> It seems that the wrong driver is used under -mm... After reading
> bk-usb.patch, I see a new driver ub.c, which I enabled. With
> CONFIG_BLK_DEV_UB disabled, 2.6.8-rc3-mm2 works.
> 
> 
> So... my guess is that 2.6.8-rc2-mm* was broken, but as everything works
> now in 2.6.8-rc3-mm2 it doesn't matter.
> 
> As I understand it, there is a bug in BLK_DEV_UB which make it says it
> can handle hci devices, which is false. I'll leave BLK_DEV_UB disabled
> for now.

that is the real problem. I never compiled in this new driver. After
enabling it the machine did some very weird things. It must be somekind
of luck that your system was still working. Mine doesn't. The problem is
that the ub driver don't contain the terminating braces for the device
id entries. You need to apply the following patch to get everything back
to normal.

--- ub.c.orig   2004-08-09 18:40:38.000000000 +0200
+++ ub.c        2004-08-09 18:24:15.000000000 +0200
@@ -318,6 +318,7 @@
 static struct usb_device_id ub_usb_ids[] = {
        // { USB_DEVICE_VER(0x0781, 0x0002, 0x0009, 0x0009) },  /* SDDR-31 */
        { USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_SCSI, US_PR_BULK) },
+       { }
 };
 
 MODULE_DEVICE_TABLE(usb, ub_usb_ids);

Regards

Marcel


