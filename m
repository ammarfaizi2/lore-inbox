Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965322AbWFAVfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965322AbWFAVfp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 17:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965323AbWFAVfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 17:35:45 -0400
Received: from wx-out-0102.google.com ([66.249.82.202]:6496 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965322AbWFAVfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 17:35:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=niOdkWwyYK9a7m3d+PQBpjrQnBl1DkVYkqn8Gh0HEXtazHtWDGMMB0g0QapWXhdYWsMRg7rKV+4c0e2y/Tgw+N7EXMJgdYflf3MDpRDq349te7ZfbcX7y2hSiNbMEtIlhz7ruoeTCtZ2BFgqih8DTVNV6jH760Paju0lqyydMH0=
Message-ID: <5a4c581d0606011435y25742922sef07e7bf4857ad05@mail.gmail.com>
Date: Thu, 1 Jun 2006 23:35:43 +0200
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: 2.6.17-rc5-mm2 -- PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#02) (try 'pci=assign-busses')
Cc: "Andrew Morton" <akpm@osdl.org>, "Bernhard Kaindl" <bk@suse.de>,
       "Miles Lane" <miles.lane@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060601210754.GA18548@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0606010752n637c6411l805115f8170f0ebb@mail.gmail.com>
	 <20060601095335.c778bc98.akpm@osdl.org>
	 <20060601210754.GA18548@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/06, Greg KH <greg@kroah.com> wrote:
> On Thu, Jun 01, 2006 at 09:53:35AM -0700, Andrew Morton wrote:
> > On Thu, 1 Jun 2006 10:52:26 -0400
> > "Miles Lane" <miles.lane@gmail.com> wrote:
> >
> > > ACPI: setting ELCR to 0200 (from 0c38)
> > > PM: Adding info for No Bus:platform
> > > NET: Registered protocol family 16
> > > ACPI: bus type pci registered
> > > PCI: PCI BIOS revision 2.10 entry at 0xfd9c2, last bus=2
> > > Setting up standard PCI resources
> > > ACPI: Subsystem revision 20060310
> > > ACPI: Interpreter enabled
> > > ACPI: Using PIC for interrupt routing
> > > PM: Adding info for acpi:acpi
> > > ACPI: PCI Root Bridge [PCI0] (0000:00)
> > > PCI: Probing PCI hardware (bus 00)
> > > PM: Adding info for No Bus:pci0000:00
> > > Boot video device is 0000:00:02.0
> > > PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
> > > PCI quirk: region 1180-11bf claimed by ICH4 GPIO
> > > PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
> > > PCI: Transparent bridge - 0000:00:1e.0
> > > PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#02)
> > > (try 'pci=assign-busses')
> > > Please report the result to linux-kernel to fix this permanently
> >
> > I guess you're supposed to try 'pci=assign-busses'.
> >
> > Does the machine work OK without pci=assign-busses?
> >
> > Does the machine work OK with pci=assign-busses?
> >
> > Greg, what are we supposed to be doing here?  Grab the PCI IDs and add a
> > quirk somewhere?
>
> Not quite sure.  Bernhard, this was caused by your patch.  Any thoughts
> as to what should be done?
>
> thanks,

Another data point on different hw - my Dell D610 reports (2.6.15-rc5-git7):

PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 1080-10bf claimed by ICH6 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #04 (-#07) is hidden behind transparent bridge #03 (-#04)
(try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently

 and has also been working apparently fine forever without
 specifying pci=assign-busses at boot.

[asuardi@sandman ~]$ lspci
00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML
Express Processor to DRAM Controller (rev 03)
00:02.0 VGA compatible controller: Intel Corporation Mobile
915GM/GMS/910GML Express Graphics Controller (rev 03)
00:02.1 Display controller: Intel Corporation Mobile 915GM/GMS/910GML
Express Graphics Controller (rev 03)
00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) PCI Express Port 1 (rev 03)
00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #1 (rev 03)
00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #2 (rev 03)
00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #3 (rev 03)
00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #4 (rev 03)
00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB2 EHCI Controller (rev 03)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d3)
00:1e.2 Multimedia audio controller: Intel Corporation
82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Audio Controller (rev 03)
00:1e.3 Modem: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
AC'97 Modem Controller (rev 03)
00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface
Bridge (rev 03)
00:1f.2 IDE interface: Intel Corporation 82801FBM (ICH6M) SATA
Controller (rev 03)
00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
SMBus Controller (rev 03)
02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5751
Gigabit Ethernet PCI Express (rev 01)
03:01.0 CardBus bridge: Texas Instruments PCI6515 Cardbus Controller
03:01.5 Communication controller: Texas Instruments PCI6515 SmartCard
Controller03:03.0 Network controller: Intel Corporation PRO/Wireless
2200BG (rev 05)

--alessandro

 "I can't change what makes me high and I can't change what I believe in"
     (Heather Nova, "My Fidelity")
