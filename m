Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277063AbRJDBSA>; Wed, 3 Oct 2001 21:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277064AbRJDBRu>; Wed, 3 Oct 2001 21:17:50 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:63160 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S277063AbRJDBRi>;
	Wed, 3 Oct 2001 21:17:38 -0400
Date: Wed, 3 Oct 2001 21:15:20 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: <linux-kernel@vger.kernel.org>
cc: <netdev@oss.sgi.com>
Subject: Some NAPI results 
Message-ID: <Pine.GSO.4.30.0110032111100.8016-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Since we are discussing this, heres more data ;->


---------- Forwarded message ----------
Date: Wed, 3 Oct 2001 20:42:43 +0200
From: Robert Olsson <Robert.Olsson@data.slu.se>

Hello!

Anyway. Uppsala University (35.000 students, 4000 emploees)
has now SMP/NAPI in production.
But reniceed ksoftirqd to -10. Kernel 2.4.10poll SMP.


USER       PID %CPU %MEM  SIZE   RSS TTY STAT START   TIME COMMAND
root         1  0.0  0.0  1224   512  ?  S    18:08   0:03 init [5]
root         2  0.0  0.0     0     0  ?  SW   18:08   0:00 (keventd)
root         3 74.2  0.0     0     0  ?  RW<  18:08 100:02 (ksoftirqd_CPU0)
root         4 73.9  0.0     0     0  ?  SW<  18:08  99:39 (ksoftirqd_CPU1)
root         5  0.0  0.0     0     0  ?  SW   18:08   0:00 (kswapd)
root         6  0.0  0.0     0     0  ?  SW   18:08   0:00 (bdflush)
root         7  0.0  0.0     0     0  ?  SW   18:08   0:00 (kupdated)
root        52  0.0  0.0   796   192  ?  S    18:08   0:00 voff
root       570  0.3  7.4 38696 38184  ?  S    18:08   0:28 /sbin/gated
.


With real data packet load seems to be well distributed.
Plus some CPU TX collisions. :-)


L-uu1:/# cat /proc/net/softnet_stat
076b152d 00002382 076893e2 00000000 00000000 00000000 00000000 00000000 00060511
07678c10 0000247c 076a7e5c 00000000 00000000 00000000 00000000 00000000 00061b88

L-uu1:/# ipchains -L -n | wc -l
    465

L-uu1:/# cat /proc/net/drivers/tulip_eth0
eth0: UP Locked MII Full DuplexLink UP
Admin up    2 hour(s) 17 min 6 sec
Last input  NOW
Last output NOW
5min RX bit/s	94.5 M
5min TX bit/s	69.2 M
5min RX pkts/s	14981
5min TX pkts/s	13971
5min TX errors	0
5min RX errors	0
5min RX dropped	0
5min TX dropped	0
5min collisions	0
5min RX missed errors	0
NormalIntr	 24221027
AbnormalIntr	 1
RxIntr	 20983232
RxNoBuf	 280
RxDied	 0
RxJabber	 0
TxIntr	 15696981
TxDied	 0
TxNoBuf	 8512291
TimerIntr	 0
TotalIntr	 23459016     packets-per-int 5
TX-frees in IRQ/xmit 56077416/66612498 TX-queue stop  3731551
Fb: no 0 low 0 mod 0 high 0 drp 0
Poll start start/pkts	 1962176135/128376006
Poll exit done/not_done/oom	 701671/1961474461/0
Memory allocation failure (small skb)  0

L-uu1:/# cat /proc/interrupts
           CPU0       CPU1
  0:     412299     413160    IO-APIC-edge  timer
  1:         80         96    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          0          0    IO-APIC-edge  rtc
 14:      10791      10371    IO-APIC-edge  ide0
 15:         18        106    IO-APIC-edge  ide1
 16:    8568624    8569699   IO-APIC-level  eth1
 17:   11830639   11830125   IO-APIC-level  eth0, eth2


Cheers.


						--ro




