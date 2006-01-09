Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbWAIP3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWAIP3F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 10:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWAIP3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 10:29:04 -0500
Received: from EXCHG2003.microtech-ks.com ([65.16.27.37]:58804 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S932295AbWAIP3D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 10:29:03 -0500
From: "Roger Heflin" <rheflin@atipa.com>
To: "'Lukasz Trabinski'" <lukasz@wsisiz.edu.pl>,
       <linux-kernel@vger.kernel.org>
Cc: <linux-netdev@vger.kernel.org>
Subject: RE: e1000_watchdog_task: NIC Link is Up/Down on kernels 2.4.15 2.4.14
Date: Mon, 9 Jan 2006 09:38:53 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcYSNrkf9gOilP+jR7GifLqNnXYd6gC+3/QQ
In-Reply-To: <Pine.LNX.4.64.0601052121270.8434@lt.wsisiz.edu.pl>
Message-ID: <EXCHG2003KvPEkGhAj500000a0f@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 09 Jan 2006 15:22:44.0494 (UTC) FILETIME=[8A069AE0:01C61530]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Lukasz Trabinski
> Sent: Thursday, January 05, 2006 2:30 PM
> To: linux-kernel@vger.kernel.org
> Cc: linux-netdev@vger.kernel.org
> Subject: e1000_watchdog_task: NIC Link is Up/Down on kernels 
> 2.4.15 2.4.14
> 
> Hello
> 
> I have machine with build in ethernet interafce, system is 
> Linux Fedora Core 4.
> Ethernet controller: Intel Corporation 82541GI/PI Gigabit 
> Ethernet Controller. It's connected to cisco Catalyst 4000 switch:
> 
> #show interface GigabitEthernet3/5
> 
> GigabitEthernet3/5 is up, line protocol is up (connected)
>    Hardware is Gigabit Ethernet Port, address is xxx
>    Description: xxx
>    MTU 1500 bytes, BW 1000000 Kbit, DLY 10 usec,
>       reliability 255/255, txload 1/255, rxload 1/255
>    Encapsulation ARPA, loopback not set
>    Keepalive set (10 sec)
>    Full-duplex, 1000Mb/s, link type is auto, media type is 
> 10/100/1000-TX
>    input flow-control is off, output flow-control is off
> 
> 
> configuration on switch interface:
> 
> interface GigabitEthernet3/5
>   switchport mode access
>   switchport nonegotiate
>   logging event link-status
>   no cdp enable
> end
> 
> 
> 
> on linux machine:
> 
> [root@w3cache ~]# ethtool eth0
> Settings for eth0:
>          Supported ports: [ TP ]
>          Supported link modes:   10baseT/Half 10baseT/Full
>                                  100baseT/Half 100baseT/Full
>                                  1000baseT/Full
>          Supports auto-negotiation: Yes
>          Advertised link modes:  10baseT/Half 10baseT/Full
>                                  100baseT/Half 100baseT/Full
>                                  1000baseT/Full
>          Advertised auto-negotiation: Yes
>          Speed: 1000Mb/s
>          Duplex: Full
>          Port: Twisted Pair
>          PHYAD: 0
>          Transceiver: internal
>          Auto-negotiation: on
>          Supports Wake-on: umbg
>          Wake-on: g
>          Current message level: 0x00000007 (7)
>          Link detected: yes
> 
> Some times I observe flaping eth0 interface:
> 
> Jan  5 18:31:19 w3cache kernel: e1000: eth0: 
> e1000_watchdog_task: NIC Link is Down Jan  5 18:31:21 w3cache 
> kernel: e1000: eth0: e1000_watchdog_task: NIC Link is Up 1000 
> Mbps Full Duplex Jan  5 18:31:25 w3cache kernel: e1000: eth0: 
> e1000_watchdog_task: NIC Link is Down Jan  5 18:31:27 w3cache 
> kernel: e1000: eth0: e1000_watchdog_task: NIC Link is Up 1000 
> Mbps Full Duplex Jan  5 18:56:30 w3cache kernel: e1000: eth0: 
> e1000_watchdog_task: NIC Link is Down Jan  5 18:56:33 w3cache 
> kernel: e1000: eth0: e1000_watchdog_task: NIC Link is Up 1000 
> Mbps Full Duplex
> 
> Patchcords and other physical layer is OK. Tested kernels
> kernel-2.6.14-1.1653_FC4 and latest vanilla 2.4.15. I have 
> tried set full duplex, speed 1000 on switch but it's happan again.
> On cisco switch i don't have seen any flaps this interface or 
> any errors.
> 
> Any idea? Thank You.
> 
> I have also commited this problem to redhat bugzilla:
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=177043
> 
> 
> --
> £T

LT,

What kind of motherboard are you using?

If an E1000 overheats it will look like it is being disconnected, and they
appear to need to be under load.

Things that make it more likely to overheat are:
	cases with bad airflow
	certain motherboards with no heat sink in the e1000 chipset
	higher elevations (thinner air).

We have fixed a number of machines with this issue by adding a heatsink/fan
near the ethernet chip, and we have got at least one MB manufacturer to
duplicate
the issue, and add a heat sink on their motherboads to correct the issue.

                                               Roger

