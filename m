Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290288AbSAOVhk>; Tue, 15 Jan 2002 16:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290289AbSAOVhX>; Tue, 15 Jan 2002 16:37:23 -0500
Received: from 203-79-66-98.adsl-wns.paradise.net.nz ([203.79.66.98]:24194
	"HELO volcano.kiwa.co.nz") by vger.kernel.org with SMTP
	id <S290288AbSAOVhG>; Tue, 15 Jan 2002 16:37:06 -0500
Date: Wed, 16 Jan 2002 10:37:03 +1300
From: Nicholas Lee <nj.lee@plumtree.co.nz>
To: Ville Herva <vherva@niksula.hut.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disk corruption - Abit KT7, 2.2.19+ide patches
Message-ID: <20020115213703.GD598@inktiger.kiwa.co.nz>
Mail-Followup-To: Nicholas Lee <nj.lee@plumtree.co.nz>,
	Ville Herva <vherva@niksula.hut.fi>, linux-kernel@vger.kernel.org
In-Reply-To: <20020115202302.GA598@inktiger.kiwa.co.nz> <20020115205116.GH51648@niksula.cs.hut.fi> <20020115211032.GC598@inktiger.kiwa.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020115211032.GC598@inktiger.kiwa.co.nz>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Reposting as the linux mailing message bounced.

Problem with:
<linux-kernel@vger.rutgers.edu>:
128.6.14.121 does not like recipient.
Remote host said: 550 <linux-kernel@vger.rutgers.edu>... User unknown
Giving up on 128.6.14.121.


On Wed, Jan 16, 2002 at 10:10:32AM +1300, Nicholas Lee wrote:
> On Tue, Jan 15, 2002 at 10:51:16PM +0200, Ville Herva wrote:
> > 
> > We are seeing corruption on KT7-RAID as well. But it's HPT370 only, and
> > looks to be pci transfer corruption. It seems depended on which pci slots
> > are populated (short story - expect full coverage on linux-kernel later this
> > week as we finish our tests.)
> 
> Interesting. I'd had a feeling that its related to the PCI bus and
> network traffic.
> 
> 
> > We tried a number of bioses.
> > 
> > A question: what pci cards do you have and in which slots?
> 
> 
> Hoppa is the current problem machine, woodcut only has periodic problem
> notice even though it has the higher load and is in a different city.
> 
> 
> 
> [nic@woodcut:~] sudo lspci
> 00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 02)
> 00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305
> 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
> 00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10)
> 00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
> 00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
> 00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
> 00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RT8139 (rev 10)
> 00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RT8139 (rev 10)
> 00:11.0 VGA compatible controller: Number 9 Computer Company Imagine 128 T2R [Ticket to Ride]
> 
> 
> eth0      Interrupt:11 Base address:0xdc00 
> 
> 
> 00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RT8139 (rev 10)
> 	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
> 	Flags: bus master, medium devsel, latency 32, IRQ 11
> 	I/O ports at dc00
> 	Memory at d6811000 (32-bit, non-prefetchable)
> 
> 
> 
> nic@hoppa:~$ sudo lspci
> 00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 02)
> 00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305
> 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
> 00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10)
> 00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
> 00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
> 00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
> 00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RT8139 (rev 10)
> 01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 86C326 (rev d2)
> 
> 
> 00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RT8139 (rev 10)
> 	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
> 	Flags: bus master, medium devsel, latency 32, IRQ 11
> 	I/O ports at ec00
> 	Memory at e6800000 (32-bit, non-prefetchable)
> 
> eth0      Interrupt:11 Base address:0xec00 
> 
> 
> 
> > (Your problem may be - and propably is - a completely separate issue than
> > ours, but I'd like to know.)
> 
> Looks like the active NIC is in the same slot on both machines. 
> 
> > 
> > Alternatively, you may want to try 
> > (1) 2.2.20pre2 that notably includes Via chipset fixes
> > (2) The ide patch from Krzysztof Oledzki <ole@ans.pl>, which includes
> >     2.4 Via ide driver backport (http://www.ans.pl/ide)
> 
> I'll try this, but it'll have to be next week. Busy at the moment.
> 
> I suspect that the drive is now full of bad sectors, it might be
> troublesome compiling. 8-\
> 
> -- 
> Nicholas Lee - nj.lee at plumtree.co dot nz, somewhere on the fish Maui caught.
> gpg. 8072 4F86 EDCD 4FC1 18EF  5BDD 07B0 9597 6D58 D70C            icq. 1612865 
> 
>                          Quixotic Eccentricity

-- 
Nicholas Lee - nj.lee at plumtree.co dot nz, somewhere on the fish Maui caught.
gpg. 8072 4F86 EDCD 4FC1 18EF  5BDD 07B0 9597 6D58 D70C            icq. 1612865 

                         Quixotic Eccentricity
