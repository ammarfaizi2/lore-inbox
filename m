Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbUCDSCU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 13:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbUCDSCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 13:02:20 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:6368 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262049AbUCDSCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 13:02:01 -0500
Date: Thu, 4 Mar 2004 19:01:55 +0100
From: Thomas Mueller <linux-kernel@tmueller.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6 much worse than 2.4 on poor wlan reception
Message-ID: <20040304180154.GA1893@tmueller.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-PGP-Key-FingerPrint: F921 8CA2 4BB6 CF07 4F5B 22FC CF8B A4C1 9570 2B3B
X-Operating-System: Debian Linux K2.4.20-mh10-686
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:2c17e390e92c60a8a0573432b44c4ce0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have big problems with kernel 2.6 and WLAN. Quite often the connection
interrupts completely, I can't transfer anything for minutes - making
2.6 unusable for me :-(
I'm only about 5 meters away from my AP, but unfortunately there's a
celeiling between me and the AP to the reception is poor.

My hardware is a SMC 2632 PCMCIA card (802.11b) in a IBM Thinkpad A30
and a SMC AP.

lspci:
02:00.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
02:00.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)

blade:~# cardctl ident
Socket 0:
  no product info available
Socket 1:
  product info: "SMC", "SMC2632W", "Version 01.02", ""
  manfid: 0x0156, 0x0002
  function: 6 (network)

The wireless-tools have version 26+27pre10-3, pcmcia-cs has 3.2.5, both
from Debian Sid. I have tried kernels 2.6.0, .1 and .2.
Every kernel 2.4 I've had running until now worked very well.

-----------------------------------------------------------
2.4.20:

blade:~# iwconfig eth1
eth1      IEEE 802.11-DS  ESSID:"WLAN"  Nickname:"Prism  I"
          Mode:Managed  Frequency:2.412GHz  Access Point:00:60:B3:17:F8:8C
          Bit Rate:11Mb/s   Tx-Power=15 dBm   Sensitivity:1/3
          Retry min limit:8   RTS thr:off   Fragment thr:off
          Encryption key:[ secret ]   Security mode:open
          Power Management:off
          Link Quality:1/92  Signal level:-101 dBm  Noise level:-149 dBm
          Rx invalid nwid:0  Rx invalid crypt:661  Rx invalid frag:0
          Tx excessive retries:2751  Invalid misc:0   Missed beacon:0

lsmod:
orinoco_cs              4776   1
orinoco                32068   0  [orinoco_cs]
hermes                  6244   0  [orinoco_cs orinoco]
ds                      7060   2  [orinoco_cs]
yenta_socket           10080   2
pcmcia_core            44928   0  [orinoco_cs ds yenta_socket]

tmm@blade:~$ netio -u 10.0.0.15
 NETIO - Network Throughput Benchmark, Version 1.21
(C) 1997-2003 Kai Uwe Rommel
 
UDP connection established.
Packet size  1k bytes:  557 KByte/s (0%) Tx,  261 KByte/s (73%) Rx.
Packet size  2k bytes:  553 KByte/s (0%) Tx,  89 KByte/s (90%) Rx.
Packet size  4k bytes:  626 KByte/s (0%) Tx,  61444 Byte/s (92%) Rx.
Packet size  8k bytes:  517 KByte/s (2%) Tx,  13393 Byte/s (98%) Rx.
Packet size 16k bytes:  565 KByte/s (3%) Tx,  10924 Byte/s (98%) Rx.
Packet size 32k bytes:  565 KByte/s (3%) Tx,  13787 Byte/s (98%) Rx.
Done.

-----------------------------------------------------------
2.6.2:

blade:~# iwconfig eth1
eth1      IEEE 802.11-DS  ESSID:"WLAN"  Nickname:"Prism  I"
          Mode:Managed  Frequency:2.412GHz  Access Point:00:60:B3:17:F8:8C
          Bit Rate:11Mb/s   Tx-Power=15 dBm   Sensitivity:1/3
          Retry min limit:8   RTS thr:off   Fragment thr:off
          Encryption key:[ secret ]   Security mode:open
          Power Management:off
          Link Quality:1/92  Signal level:-101 dBm  Noise level:-149 dBm
          Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
          Tx excessive retries:0  Invalid misc:0   Missed beacon:0

orinoco_cs              9192  1
orinoco                43980  1 orinoco_cs
hermes                  8512  2 orinoco_cs,orinoco
ds                     15940  5 orinoco_cs
i82365                 20876  1
pcmcia_core            71456  3 orinoco_cs,ds,i82365

tmm@blade:~$ netio -u 10.0.0.15
 
NETIO - Network Throughput Benchmark, Version 1.21
(C) 1997-2003 Kai Uwe Rommel
 
UDP connection established.
Packet size  1k bytes:  289 KByte/s (99%) Tx,  223 KByte/s (75%) Rx.
Packet size  2k bytes:  0 Byte/s (100%) Tx,  21 KByte/s (91%) Rx.
Packet size  4k bytes:  440 KByte/s (99%) Tx,  61333 Byte/s (94%) Rx.
Packet size  8k bytes:  382 KByte/s (96%) Tx,  14438 Byte/s (98%) Rx.
Packet size 16k bytes:  369 KByte/s (96%) Tx,  2365 Byte/s (98%) Rx.
Packet size 32k bytes:  239 KByte/s (98%) Tx,  3005 Byte/s (98%) Rx.
Done.

There was a break when netio transfered the 2k blocks.

My log is full of entries like this one:
Mar  1 17:54:12 blade kernel: eth1: New link status: AP Out of Range
(0004)
Mar  1 17:54:12 blade kernel: eth1: New link status: AP In Range (0005)
Mar  1 17:54:16 blade kernel: eth1: New link status: AP Out of Range
(0004)
Mar  1 17:54:16 blade kernel: eth1: New link status: AP In Range (0005)
Mar  1 17:54:19 blade kernel: eth1: New link status: AP Out of Range
(0004)
Mar  1 17:54:20 blade kernel: eth1: New link status: AP In Range (0005)
Mar  1 17:54:22 blade kernel: eth1: New link status: AP Out of Range
(0004)

Kernel 2.4 works far better in the poor reception situation I have,
anyone any idea what I could do without moving the AP or laptop?
When I'm near my AP everything works fine with 2.6 too.

BTW: removing the PCMCIA card when it's in use freezes my system
completely, that was no problem with 2.4.

Thanks a lot!


-- 
Thomas Mueller - http://www.tmueller.com for pgp key (95702B3B)
