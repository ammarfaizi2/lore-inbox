Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263361AbTC2AfV>; Fri, 28 Mar 2003 19:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263365AbTC2AfV>; Fri, 28 Mar 2003 19:35:21 -0500
Received: from smtp08.iddeo.es ([62.81.186.18]:12494 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id <S263361AbTC2AfT>;
	Fri, 28 Mar 2003 19:35:19 -0500
Date: Sat, 29 Mar 2003 01:46:30 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrew Morton <akpm@digeo.com>
Cc: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
Subject: Re: 3c59x gives HWaddr FF:FF:...
Message-ID: <20030329004630.GA2480@werewolf.able.es>
References: <20030328145159.GA4265@werewolf.able.es> <20030328124832.44243f83.akpm@digeo.com> <20030328230510.GA5124@werewolf.able.es> <20030328151624.67a3c8c5.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030328151624.67a3c8c5.akpm@digeo.com>; from akpm@digeo.com on Sat, Mar 29, 2003 at 00:16:24 +0100
X-Mailer: Balsa 2.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.29, Andrew Morton wrote:
> "J.A. Magallon" <jamagallon@able.es> wrote:
> >
> > > Please take the 2.4.20 3c59x.c and place that into the 2.5 tree and confirm
> > > that it does the same thing (it will).
> > > 
> > 
> > Hum, I suppose you want to say take the _2.5_ one and put into my _2.4_ tree ?
> 
> No, I didn't mean that.  But you can do that too.
> 
> > Some previous answer also talked about a more recent version in -ac.
> > (btw, can 2.5 be useful for something ? does not the driver depend on a new
> > arch of, for example, the PCI layer ? )
> 
> The netdevice interface hasn't been broken yet ;) 2.4 drivers (or at least
> 3c59x.c) still work OK in the 2.5 tree.
> 
> 
> > > Then try disabling APCI and/or otherwise fiddling with your power management
> > > options (maybe in BIOS too).
> > > 
> > 
> > I don't build ACPI, just APM power-off (SMP box).
> 
> Oh, OK.
> 
> As I say, it it probably power-management related.  Try enabling ACPI.  Try
> disabling APM.  Try altering the BIOS settings.
> 

I have an oldie 400GX. Just 'Enabled ACPI register' in the BIOS. But I did not
rebuilt the kernel to use ACPI. Anyways, I just got the patch for 3c59x from
-ac, and applied on mine, to upgrade to 1.1.18. Tests follow....

The 905C-TX does not work. I have tried with a couple more cards, a 905B and
a 980-TX. Both work (one older and one newer):

00:12.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24)
        Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
        Flags: bus master, medium devsel, latency 64, IRQ 5
        I/O ports at ec00 [size=128]
        Memory at febfef80 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at feba0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:12.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xec00. Vers LK1.1.18-ac
 <correct hw addr>, IRQ 5
  product code 4e47 rev 00.9 date 03-15-98
  Internal config register is 1800000, transceivers 0xa.
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 7849.
  Enabling bus-master transmits and whole-frame receives.
00:12.0: scatter/gather enabled. h/w checksums enabled

00:12.0 Ethernet controller: 3Com Corporation 3c980-TX 10/100baseTX NIC [Python-T] (rev 78)
        Subsystem: 3Com Corporation: Unknown device 1000
        Flags: bus master, medium devsel, latency 64, IRQ 5
        I/O ports at ec00 [size=128]
        Memory at febfef80 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at feba0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:12.0: 3Com PCI 3c982 Dual Port Server Cyclone at 0xec00. Vers LK1.1.18-ac
 <correct hw addr>, IRQ 5
  product code 4b50 rev 00.14 date 08-01-01
  Internal config register is 3800000, transceivers 0xa.
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 7809.
  Enabling bus-master transmits and whole-frame receives.
00:12.0: scatter/gather enabled. h/w checksums enabled

What is wrong now is the description given by the 1.1.18 version (I can swear
I only have one hole to plug the cable ;)). I will lookup the IDs in the
driver and lspci lists and compare....

So, 3 options:
- the 905C goes to trashcan
- the driver fails to initialize something (I dont trust this...)
- winblows messed the card eeprom...any way to tidy it up again ?

Thanks everybody...

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Bamboo) for i586
Linux 2.4.21-pre6-jam1 (gcc 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk))
