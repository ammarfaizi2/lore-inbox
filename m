Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277319AbRJEGxb>; Fri, 5 Oct 2001 02:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277322AbRJEGxV>; Fri, 5 Oct 2001 02:53:21 -0400
Received: from wolf.ericsson.net.nz ([203.97.68.250]:61852 "EHLO
	wolf.ericsson.net.nz") by vger.kernel.org with ESMTP
	id <S277319AbRJEGxM>; Fri, 5 Oct 2001 02:53:12 -0400
Date: Fri, 5 Oct 2001 18:53:35 +1200 (NZST)
From: Mark Henson <kern@wolf.ericsson.net.nz>
To: Ben Greear <greearb@candelatech.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Throughput @100Mbs on link of ~10ms latency
In-Reply-To: <3BBD4D54.96A08A3D@candelatech.com>
Message-ID: <Pine.LNX.4.33.0110051827260.17218-100000@wolf.ericsson.net.nz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Oct 2001, Ben Greear wrote:

> printAndExec("echo $rmem_default > /proc/sys/net/core/rmem_default");
> printAndExec("echo $netdev_max_backlog > /proc/sys/net/core/netdev_max_backlog");
>

... thanks -

tried these parameters and saw no change in the throughput.  I am
thinking that the problem is at the receiving end rather than the transmit
end because with the FreeBSD machine at 1 end I got a much higher
throughput when sending to that machine.  (about 10 MBytes /sec)

I was suspicious of another problem with the FreeBSD machine which is why
I changed it out. (network occasionally locked up).  The distance between
the local ethernet switches is about 1200km of fibre.  Speed of light for
that distance is ~ 4ms.  Light in fibre I believe to be about 0.6 giving
around 6.5ms for light in this loop - so 9.5 ms RTT seems pretty good

The machines (Compaq Deskpro ~800MHz) are able to reliably produce
~10MBytes/sec using ncftp which is hardly calibrated but is atleast
indicative of the rate I should be getting.  Calculating transfer time of
26/27 secs of 106348240 gives me net of about 32Mbps

anyway thanks for your help

cheers
Mark


one machine is:

eth1      Link encap:Ethernet  HWaddr 00:04:76:B8:8B:DC
          inet addr:192.168.1.1  Bcast:192.168.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:11757991 errors:0 dropped:0 overruns:1 frame:0
          TX packets:11699364 errors:0 dropped:0 overruns:0 carrier:49
          collisions:274 txqueuelen:100
          Interrupt:5 Base address:0x1000

eth1: 3Com PCI 3cSOHO100-TX Hurricane at 0x1000,  00:04:76:b8:8b:dc, IRQ 5
   product code 4d4d rev 00.12 date 06-29-01
   8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
   MII transceiver found at address 24, status 7849.
   Enabling bus-master transmits and whole-frame receives.
 eth1: scatter/gather disabled. h/w checksums enabled
 eth1: using NWAY device table, not 8

the second is:

eth1      Link encap:Ethernet  HWaddr 00:01:03:39:ED:5F
          inet addr:192.168.1.3  Bcast:192.168.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:9567005 errors:0 dropped:0 overruns:0 frame:0
          TX packets:9652682 errors:0 dropped:0 overruns:0 carrier:607
          collisions:0 txqueuelen:100
          Interrupt:5 Base address:0x1000

eth1: 3Com PCI 3c980 10/100 Base-TX NIC(Python-T) at 0x1000,
00:01:03:39:ed:5f, IRQ 5
  product code 4b50 rev 00.14 date 03-12-01
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 7809.
  Enabling bus-master transmits and whole-frame receives.

>
> And of course, make sure you can get the performance with a known fast network
> (and near zero latency) first!!
>
> The e100 has some interesting options that seem to make it handle high packet
> counts better, as well as giving it bigger descriptor lists, but I haven't
> really benchmarked it..
>
> Ben
>
>


