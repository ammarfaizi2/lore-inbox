Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319016AbSHFIMi>; Tue, 6 Aug 2002 04:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319017AbSHFIMi>; Tue, 6 Aug 2002 04:12:38 -0400
Received: from zeus.kernel.org ([204.152.189.113]:58496 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S319016AbSHFIMg> convert rfc822-to-8bit;
	Tue, 6 Aug 2002 04:12:36 -0400
X-AuthUser: tmi@wikon.de
Content-Type: text/plain; charset=US-ASCII
From: Thomas Mierau <tmi@wikon.de>
Organization: WIKON Kommunikationstechnik GmbH
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-ac4 IRQ messup?
Date: Tue, 6 Aug 2002 10:14:30 +0200
X-Mailer: KMail [version 1.4]
References: <Pine.LNX.4.44.0208052251170.21076-100000@korben.citd.de> <1028586383.18478.100.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1028586383.18478.100.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208061014.13619.tmi@wikon.de>
Cc: tmi@wikon.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I encounter a kind of strange problem which seems to be related to the timer 
problem. My machine is behaving differently when under load. Actually 
behaving better when under load.

I am testing the eth ports and thus I am pining on both internal ports and I 
am also pinging the box from another server on eth1.

Within 1 min I received 4.92062e+06 Interrupts on eth1(not bad for a 2 way 
ping) and  130 Interrupts on eth0 for the 1 way ping.

The timer interrupts are 5992 which I would say pretty good for a hand reading

You can also see completly different behavior on the ports and a jamming don't 
ask me where it is coming from. The box has no other task to preform.

Can anybody make any sense out of that ?
I changed the debug level for the eth driver. It returns every few seconds:
APIC error on CPU1 : 02(02)      (i know not an eth message, but it pops up at 			
APIC error on CPU0 : 02(02)       the same time)
vortex_error(), status = 0xe481
vortex_error(), status = 0xe281
vortex_error(), status = 0xe681
vortex_error(), status = 0xe081
The vortex error may be 1 to 4 messages and either one is possible in any 
combination


I attach the readings

/proc/interrupts at the start
           CPU0       CPU1
  0:    3163847    3164837    IO-APIC-edge  timer
  1:       2839       2811    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  5: 2603035427 2603245593   IO-APIC-level  eth1
  6:         36         36    IO-APIC-edge  floppy
  8:          0          2    IO-APIC-edge  rtc
 11:      70888      69025   IO-APIC-level  dpti0, eth0
 12:      12580      12617    IO-APIC-edge  PS/2 Mouse
 14:          2          2    IO-APIC-edge  ide0
NMI:          0          0
LOC:    6328682    6328831
ERR:        558
MIS:       1458

/proc/interrupts after 1 min
           CPU0       CPU1
  0:    3166842    3167834    IO-APIC-edge  timer
  1:       2898       2872    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  5: 2605498761 2605702882   IO-APIC-level  eth1
  6:         42         42    IO-APIC-edge  floppy
  8:          0          2    IO-APIC-edge  rtc
 11:      70951      69092   IO-APIC-level  dpti0, eth0
 12:      12580      12617    IO-APIC-edge  PS/2 Mouse
 14:          2          2    IO-APIC-edge  ide0
NMI:          0          0
LOC:    6334674    6334822
ERR:        558
MIS:       1458

the ifconfig output
eth0      Link encap:Ethernet  HWaddr 00:E0:81:21:FF:A2
          inet addr:192.168.47.11  Bcast:192.168.47.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:125798 errors:0 dropped:0 overruns:0 frame:0
          TX packets:188956 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:12327368 (11.7 Mb)  TX bytes:18517194 (17.6 Mb)
          Interrupt:11 Base address:0x2400

eth1      Link encap:Ethernet  HWaddr 00:E0:81:21:FF:A3
          inet addr:192.168.47.12  Bcast:192.168.47.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:126196 errors:0 dropped:0 overruns:0 frame:0
          TX packets:63016 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:12366600 (11.7 Mb)  TX bytes:6164576 (5.8 Mb)
          Interrupt:5 Base address:0x2480

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:8 errors:0 dropped:0 overruns:0 frame:0
          TX packets:8 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:400 (400.0 b)  TX bytes:400 (400.0 b)

the ping on eth0 
The blocks of 5 return at the same time , as the time differnce is always 1sec 
off look pretty nasty
PING 192.168.47.47 (192.168.47.47) from 192.168.47.11 eth0: 56(84) bytes of 
data.
64 bytes from 192.168.47.47: icmp_seq=1 ttl=255 time=912 ms
64 bytes from 192.168.47.47: icmp_seq=2 ttl=255 time=4912 ms
64 bytes from 192.168.47.47: icmp_seq=3 ttl=255 time=3912 ms
64 bytes from 192.168.47.47: icmp_seq=4 ttl=255 time=2912 ms
64 bytes from 192.168.47.47: icmp_seq=5 ttl=255 time=1912 ms
64 bytes from 192.168.47.47: icmp_seq=6 ttl=255 time=912 ms
64 bytes from 192.168.47.47: icmp_seq=7 ttl=255 time=4905 ms
64 bytes from 192.168.47.47: icmp_seq=8 ttl=255 time=3905 ms
64 bytes from 192.168.47.47: icmp_seq=9 ttl=255 time=2905 ms
64 bytes from 192.168.47.47: icmp_seq=10 ttl=255 time=1905 ms
64 bytes from 192.168.47.47: icmp_seq=11 ttl=255 time=905 ms
64 bytes from 192.168.47.47: icmp_seq=12 ttl=255 time=4912 ms
64 bytes from 192.168.47.47: icmp_seq=13 ttl=255 time=3911 ms
64 bytes from 192.168.47.47: icmp_seq=14 ttl=255 time=2912 ms
64 bytes from 192.168.47.47: icmp_seq=15 ttl=255 time=1912 ms
64 bytes from 192.168.47.47: icmp_seq=16 ttl=255 time=912 ms
64 bytes from 192.168.47.47: icmp_seq=17 ttl=255 time=4902 ms
64 bytes from 192.168.47.47: icmp_seq=18 ttl=255 time=3902 ms
64 bytes from 192.168.47.47: icmp_seq=19 ttl=255 time=2902 ms
64 bytes from 192.168.47.47: icmp_seq=20 ttl=255 time=1902 ms
64 bytes from 192.168.47.47: icmp_seq=21 ttl=255 time=902 ms

--- 192.168.47.47 ping statistics ---
22 packets transmitted, 21 received, 4% loss, time 21039ms
rtt min/avg/max/mdev = 902.583/2812.949/4912.193/1444.073 ms, pipe 5

The ping from eth1 looks a lot better, everything again in blocks of 5 just 
this time 4 good one's and 1 bad
PING 192.168.47.47 (192.168.47.47) from 192.168.47.12 eth1: 56(84) bytes of 
data.
64 bytes from 192.168.47.47: icmp_seq=1 ttl=255 time=0.169 ms
64 bytes from 192.168.47.47: icmp_seq=2 ttl=255 time=0.180 ms
64 bytes from 192.168.47.47: icmp_seq=3 ttl=255 time=0.173 ms
64 bytes from 192.168.47.47: icmp_seq=4 ttl=255 time=645 ms
64 bytes from 192.168.47.47: icmp_seq=5 ttl=255 time=0.181 ms
64 bytes from 192.168.47.47: icmp_seq=6 ttl=255 time=0.174 ms
64 bytes from 192.168.47.47: icmp_seq=7 ttl=255 time=0.169 ms
64 bytes from 192.168.47.47: icmp_seq=8 ttl=255 time=0.173 ms
64 bytes from 192.168.47.47: icmp_seq=9 ttl=255 time=654 ms
64 bytes from 192.168.47.47: icmp_seq=10 ttl=255 time=0.177 ms
64 bytes from 192.168.47.47: icmp_seq=11 ttl=255 time=0.171 ms
64 bytes from 192.168.47.47: icmp_seq=12 ttl=255 time=0.173 ms
64 bytes from 192.168.47.47: icmp_seq=13 ttl=255 time=0.171 ms
64 bytes from 192.168.47.47: icmp_seq=14 ttl=255 time=653 ms
64 bytes from 192.168.47.47: icmp_seq=15 ttl=255 time=0.171 ms
64 bytes from 192.168.47.47: icmp_seq=16 ttl=255 time=0.174 ms
64 bytes from 192.168.47.47: icmp_seq=17 ttl=255 time=0.173 ms
64 bytes from 192.168.47.47: icmp_seq=18 ttl=255 time=0.170 ms
64 bytes from 192.168.47.47: icmp_seq=19 ttl=255 time=672 ms
64 bytes from 192.168.47.47: icmp_seq=20 ttl=255 time=0.181 ms
64 bytes from 192.168.47.47: icmp_seq=21 ttl=255 time=0.174 ms
64 bytes from 192.168.47.47: icmp_seq=22 ttl=255 time=0.174 ms

--- 192.168.47.47 ping statistics ---
22 packets transmitted, 22 received, 0% loss, time 21066ms
rtt min/avg/max/mdev = 0.169/119.485/672.358/253.133 ms

and last but not least a list of attached PCI devices.
The eth driver used is the 3c59x from Donald Becker
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System 
Controller (rev 17).
      Master Capable.  Latency=64.
      Prefetchable 32 bit memory at 0xf8000000 [0xfbffffff].
      Prefetchable 32 bit memory at 0xf6200000 [0xf6200fff].
      I/O at 0x1010 [0x1013].
  Bus  0, device   1, function  0:
    PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP Bridge 
(rev 0).
      Master Capable.  Latency=64.  Min Gnt=4.
  Bus  0, device   7, function  0:
    ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 5).
  Bus  0, device   7, function  1:
    IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 4).
      Master Capable.  Latency=64.  
      I/O at 0x0 [0x7].
      I/O at 0x0 [0x3].
      I/O at 0xf000 [0xf00f].
  Bus  0, device   7, function  3:
    Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 3).
      Master Capable.  Latency=64.  
  Bus  0, device   9, function  0:
    I2O: Distributed Processing Technology SmartRAID V Controller (rev 1).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=1.Max Lat=1.
      Prefetchable 32 bit memory at 0xfc000000 [0xfdffffff].
  Bus  0, device   9, function  1:
    PCI bridge: Distributed Processing Technology PCI Bridge (rev 1).
      Master Capable.  Latency=64.  Min Gnt=4.
  Bus  0, device  16, function  0:
    PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 5).
      Master Capable.  Latency=99.  Min Gnt=12.
  Bus  3, device   4, function  0:
    Serial controller: Timedia Technology Co Ltd PCI2S550 (Dual 16550 UART) 
(rev 1).
      IRQ 11.
      I/O at 0x2800 [0x281f].
      I/O at 0x2820 [0x282f].
      I/O at 0x2848 [0x284f].
      I/O at 0x2840 [0x2847].
      I/O at 0x2838 [0x283f].
      I/O at 0x2830 [0x2837].
  Bus  3, device   7, function  0:
    VGA compatible controller: ATI Technologies Inc Rage XL (rev 39).
      Master Capable.  Latency=66.  Min Gnt=8.
      Non-prefetchable 32 bit memory at 0xf5000000 [0xf5ffffff].
      I/O at 0x2000 [0x20ff].
      Non-prefetchable 32 bit memory at 0xf4001000 [0xf4001fff].
  Bus  3, device   8, function  0:
    Ethernet controller: 3Com Corporation 3c980-TX 10/100baseTX NIC [Python-T] 
(rev 120).
      IRQ 11.
      Master Capable.  Latency=80.  Min Gnt=10.Max Lat=10.
      I/O at 0x2400 [0x247f].
      Non-prefetchable 32 bit memory at 0xf4002000 [0xf400207f].
  Bus  3, device   9, function  0:
    Ethernet controller: 3Com Corporation 3c980-TX 10/100baseTX NIC [Python-T] 
(#2) (rev 120).
      IRQ 5.
      Master Capable.  Latency=80.  Min Gnt=10.Max Lat=10.
      I/O at 0x2480 [0x24ff].
      Non-prefetchable 32 bit memory at 0xf4002400 [0xf400247f].


