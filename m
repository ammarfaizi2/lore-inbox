Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVBIJKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVBIJKR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 04:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVBIJKC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 04:10:02 -0500
Received: from lucidpixels.com ([66.45.37.187]:63632 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S261442AbVBIJJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 04:09:01 -0500
Date: Wed, 9 Feb 2005 04:08:49 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: Bukie Mabayoje <bukiemab@gte.net>
cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Question regarding e1000 driver and dropped packets (2.6.5 / 
 2.6.10)?
In-Reply-To: <4209BAB7.21DF8593@gte.net>
Message-ID: <Pine.LNX.4.62.0502090408150.28113@p500>
References: <Pine.LNX.4.62.0502081618060.2018@p500> <42095CA9.60811F6C@gte.net>
 <4209BAB7.21DF8593@gte.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As far as the temp stuff, it does support i2c over the smbus.

$ sensors
max1617-i2c-0-1a
Adapter: SMBus PIIX4 adapter at 0850
Board:       +48C  (low  =   -55C, high =  +127C)
CPU:         +49C  (low  =   -55C, high =  +110C)



Whether its recommended or not, not sure, I'll try later today w/out it.


On Tue, 8 Feb 2005, Bukie Mabayoje wrote:

>
>
> Bukie Mabayoje wrote:
>
>> Can you do a simple test?
>> Connect the two box to the same switch. ( No other box should be on the physical bus)
>> 1. Send packets from BoxA  ------->   BoxB  ( Record the stats)
>>
>> 2. Send packets from BoxB -------> BoxA    (Record the stats)
>>
>> 3. Send packets simultaneously  from  BoxB----->BoxA and BoxA  -----> BoxB  (Record the stats)
>>
>> if you can find a third box
>>
>> 4. Send packets [BoxA and BoxC] --------->   BoxB and BoxB -----> BoxA (Record the stats)
>>
>> 5. Send packets [BoxB and BoxC] ---------> BoxA and BoxA ------> BoxB (Record the stats)
>>
>> I don't understand why you received more packet on BoxB. A controlled test will help clarify any ambiguity.
>>       [BoxA]   RX packets:196787934 errors:4 dropped:0 overruns:0 frame:2
>>                     TX packets:101356779 errors:0 dropped:0 overruns:0 carrier:0
>>
>>      [BoxB]    RX packets:446380046 errors:1276833 dropped:1276833 overruns:1276833 frame:0
>>                     TX packets:572550636 errors:0 dropped:0 overruns:0 carrier:0
>>
>> Justin Piszcz wrote:
>>
>>> I have two identical machines [mobo/hardware wise]:
>>>
>>> Each machine is a Dell GX1p (500MHZ).
>>>
>>> I have two Intel Gigabit NICs, one in each box, hooked up to a GigE
>>> switch.
>>>
>>> Ethernet controller: Intel Corp. 82541GI/PI Gigabit Ethernet Controller
>>> Ethernet controller: Intel Corp. 82541GI/PI Gigabit Ethernet Controller
>>>
>>> I doubt its the kernel version; does anyone have any suggestions/ideas why
>>> one machine has virtually NO overruns/errors/drops and the other has tons?
>>>
>>> Also, (I doubt this to be the case but I'll ask anyway) - Is the way the
>>> NIC's are setup in the box next to other cards / alter their PCI/IRQ
>>> routing which would effect error/drop rates?
>>>
>>> IE:
>>>
>>> PCI1 - promise card / pata
>>> PCI2 - promise card / pata
>>> PCI3 - promise card / sata
>>> PCI4 - e1000 nic
>>> PCI5 - 4 port nic
>>
>> What matters is which INT# [A,B,C,D] line and/or combination  the PCI slot 1, 2, 3, 4 is using.
>> You can find out by running lspci -vv
>> If they are routed to the same system interrupt and  lastly, the interrupt priority issues.
>>
>>>
>>>
>>> Would it make sense to order them in a different direction?
>>
>> May not help in identifying the problem.
>>
>>>
>>>
>>> Also, is there a correlation between errors on the NIC and ERR
>>> in /proc/interrupts?
>>
>> Maybe......
>>
>>>
>>>
>>> Secondly, could loading lm-sensors/temperature modules be causing these
>>> problems?
>>
>> You don't have any overrun on this box.
>
> My Error. It may be related. Try without loading ln-sensor/temp modules.
> I don't think your mother board supports the i2c stuff you are loading.
> You have the Intel 440BX AGP chipset and there is not i2c interface on it.
>
>>
>>
>>>
>>>
>>> dmesg from box2 below:
>>>
>>> e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex
>>> eth1: Setting full-duplex based on MII#1 link partner capability of 45e1.
>>> eth2: Setting full-duplex based on MII#1 link partner capability of 45e1.
>>> nfs warning: mount version older than kernel
>>> nfs warning: mount version older than kernel
>>> nfs warning: mount version older than kernel
>>> nfs warning: mount version older than kernel
>>> i2c /dev entries driver
>>> piix4_smbus 0000:00:07.3: Found 0000:00:07.3 device
>>> piix4_smbus 0000:00:07.3: WARNING: SMBus interface has been FORCEFULLY
>>> ENABLED!
>>> mtrr: no MTRR for fd000000,800000 found
>>> spurious 8259A interrupt: IRQ7.
>>> spurious 8259A interrupt: IRQ15.
>>>
>>> I am currently out of ideas, if anyone can suggest anything, I'd be most
>>> greatful, thanks!
>>>
>>> On the first box, there are hardly any problems receiving packets:
>>>
>>> Note the errors & dropped on the receiving end:
>>>
>>> BOX1: (2.6.5)
>>>
>>> eth0      Link encap:Ethernet  HWaddr 00:0E:0C:00:CD:B1
>>>            inet addr:10.0.2.254  Bcast:10.0.2.255  Mask:255.255.255.0
>>>            inet6 addr: fe80::20e:cff:fe00:cdb1/64 Scope:Link
>>>            UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>>>            RX packets:196787934 errors:4 dropped:0 overruns:0 frame:2
>>>            TX packets:101356779 errors:0 dropped:0 overruns:0 carrier:0
>>>            collisions:0 txqueuelen:1000
>>>            RX bytes:2602045376 (2481.5 Mb)  TX bytes:4051930608 (3864.2 Mb)
>>>            Base address:0xcc80 Memory:ff020000-ff040000
>>>
>>> BOX1 MODULES:
>>>
>>> $ lsmod
>>> Module                  Size  Used by
>>> ip_nat_ftp              4016  0
>>> ip_conntrack_ftp       71088  1 ip_nat_ftp
>>>
>>> BOX2: (2.6.10)
>>>
>>> On another box (same physical HW) I get this:
>>>
>>> eth0      Link encap:Ethernet  HWaddr 00:0E:0C:00:D2:06
>>>            inet addr:10.0.2.253  Bcast:10.0.2.255  Mask:255.255.255.0
>>>            UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>>> ****-->   RX packets:446380046 errors:1276833 dropped:1276833 overruns:1276833 frame:0
>>>            TX packets:572550636 errors:0 dropped:0 overruns:0 carrier:0
>>>            collisions:0 txqueuelen:1000
>>>            RX bytes:2351750726 (2.1 GiB)  TX bytes:3659840330 (3.4 GiB)
>>>            Base address:0xd8c0 Memory:f8fa0000-f8fc0000
>>>
>>> BOX2 MODULES:
>>>
>>> $ lsmod
>>> Module                  Size  Used by
>>> ip_nat_irc              3408  0
>>> ip_conntrack_irc       70480  1 ip_nat_irc
>>> ip_nat_ftp              4112  0
>>> ip_conntrack_ftp       71344  1 ip_nat_ftp
>>> adm1021                11060  0
>>> i2c_piix4               6000  0
>>> i2c_sensor              2784  1 adm1021
>>> i2c_dev                 7680  0
>>> i2c_core               18224  4 adm1021,i2c_piix4,i2c_sensor,i2c_dev
>>>
>>> I have tried using different cable and ports on the switch, the result is
>>> the same.
>>>
>>> $ tar cvf /box2/4gb_of_stuff.tar 4gb_of_stuff  # then the numbers rise rapidly
>>>
>>> After copying only 1-2GB on BOX2, this is what I get:
>>>
>>> eth0      Link encap:Ethernet  HWaddr 00:0E:0C:00:D2:06
>>>            inet addr:10.0.2.253  Bcast:10.0.2.255  Mask:255.255.255.0
>>>            UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>>>            RX packets:1038733 errors:1459 dropped:1459 overruns:1459 frame:0
>>>            TX packets:560952 errors:0 dropped:0 overruns:0 carrier:0
>>>            collisions:0 txqueuelen:1000
>>>            RX bytes:1491121900 (1.3 GiB)  TX bytes:763420385 (728.0 MiB)
>>>            Base address:0xd8c0 Memory:f8fa0000-f8fc0000
>>>
>>> The only thing that is different is one has more HDD's and an extra PCI
>>> controller or so:
>>>
>>> BOX1 LSPCI:
>>>
>>> 00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
>>> (rev 03)
>>> 00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge
>>> (rev 03)
>>> 00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
>>> 00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
>>> 00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
>>> 00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
>>> 00:0d.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit Ethernet
>>> Controller
>>> 00:0e.0 Unknown mass storage controller: Promise Technology, Inc. 20268
>>> (rev 02)
>>> 00:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
>>> 00:11.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
>>> (rev 24)
>>> 01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP
>>> 1X/2X (rev 5c)
>>> 02:09.0 Communication controller: Individual Computers - Jens Schoenfeld
>>> Intel 537
>>> 02:0a.0 Ethernet controller: 3Com Corporation 3c590 10BaseT [Vortex]
>>>
>>> BOX2 LSPCI:
>>>
>>> 0000:00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host
>>> bridge (rev 03)
>>> 0000:00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP
>>> bridge (rev 03)
>>> 0000:00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
>>> 0000:00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
>>> 0000:00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
>>> 0000:00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
>>> 0000:00:0d.0 Unknown mass storage controller: Promise Technology, Inc.
>>> 20269 (rev 02)
>>> 0000:00:0e.0 Unknown mass storage controller: Promise Technology, Inc.
>>> 20269 (rev 02)
>>> 0000:00:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev
>>> 03)
>>> 0000:01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro
>>> AGP 1X/2X (rev 5c)
>>> 0000:02:09.0 Unknown mass storage controller: Promise Technology, Inc.
>>> PDC20375 (SATA150 TX2plus) (rev 02)
>>> 0000:02:0a.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit Ethernet
>>> Controller
>>> 0000:02:0b.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev
>>> 03)
>>> 0000:03:04.0 Ethernet controller: Digital Equipment Corporation DECchip
>>> 21140 [FasterNet] (rev 22)
>>> 0000:03:05.0 Ethernet controller: Digital Equipment Corporation DECchip
>>> 21140 [FasterNet] (rev 22)
>>> 0000:03:06.0 Ethernet controller: Digital Equipment Corporation DECchip
>>> 21140 [FasterNet] (rev 22)
>>> 0000:03:07.0 Ethernet controller: Digital Equipment Corporation DECchip
>>> 21140 [FasterNet] (rev 22)
>>>
>>> Please CC me as I am not on the list, thanks!
>>> -
>>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at  http://www.tux.org/lkml/
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>
