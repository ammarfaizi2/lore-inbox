Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314906AbSECSLA>; Fri, 3 May 2002 14:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314981AbSECSK7>; Fri, 3 May 2002 14:10:59 -0400
Received: from pc132.utati.net ([216.143.22.132]:31390 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S314906AbSECSKu>; Fri, 3 May 2002 14:10:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: linux-kernel@vger.kernel.org
Subject: sis900 ethernet driver/IP stack getting REALLY confused...
Date: Fri, 3 May 2002 08:12:20 -0400
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020503183407.AA9FC644@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The sis900 driver in 2.4.18 works fine until I unplug and plug back in the 
cat5 cable.  Then suddenly, packets start disappearing for 10 to 15 seconds 
and then suddenly getting delivered (way late) out of nowhere, which confuses 
IP to no end and apparently makes "ping" think the packet is corrupted.

If I reboot the box (shutdown -r now), the problem seems to stops manifesting 
until I twiddle with the ethernet link status again.  (The first time this 
happened I thought it was a hardware problem, and it did go away when I 
plugged in an rtl8139 card and started using that instead, but now it's 
happened on another system and it really does look like some kind of a device 
driver problem...)

Here's an example run of ping when the problem is manifesting.  Notice the 
sequence numbers and delay timestamps.  (We've tried swapping in three 
different switches from two different manufacturers in between, so that's not 
the problem...)  I think ping's getting confused by receiving 15 second-old 
packets...

Help?

Rob

--------------------------------------------------

root@lithium:~# ping 216.143.22.140
PING 216.143.22.140 (216.143.22.140): 56 octets data
64 octets from 216.143.22.140: icmp_seq=0 ttl=254 time=0.7 ms
64 octets from 216.143.22.140: icmp_seq=1 ttl=254 time=0.5 ms
64 octets from 216.143.22.140: icmp_seq=2 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=3 ttl=254 time=0.5 ms
64 octets from 216.143.22.140: icmp_seq=4 ttl=254 time=0.5 ms
64 octets from 216.143.22.140: icmp_seq=11 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=12 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=13 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=14 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=15 ttl=254 time=0.7 ms
64 octets from 216.143.22.140: icmp_seq=5 ttl=254 time=10000.8 ms
wrong data byte #0 should be 0xf9 but was 0xefef 7c d2 3c 77 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=6 ttl=254 time=9000.9 ms
wrong data byte #0 should be 0xf9 but was 0xf0f0 7c d2 3c 74 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=7 ttl=254 time=8001.0 ms
wrong data byte #0 should be 0xf9 but was 0xf1f1 7c d2 3c 78 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=8 ttl=254 time=7001.2 ms
wrong data byte #0 should be 0xf9 but was 0xf2f2 7c d2 3c 72 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=9 ttl=254 time=6001.3 ms
wrong data byte #0 should be 0xf9 but was 0xf3f3 7c d2 3c 71 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=10 ttl=254 time=5001.4 ms
wrong data byte #0 should be 0xf9 but was 0xf4f4 7c d2 3c 88 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=26 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=27 ttl=254 time=0.5 ms
64 octets from 216.143.22.140: icmp_seq=28 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=29 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=30 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=31 ttl=254 time=0.8 ms
64 octets from 216.143.22.140: icmp_seq=16 ttl=254 time=15000.9 ms
wrong data byte #0 should be 0x9 but was 0xfafa 7c d2 3c 7c 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=17 ttl=254 time=14001.0 ms
wrong data byte #0 should be 0x9 but was 0xfbfb 7c d2 3c 76 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=18 ttl=254 time=13001.2 ms
wrong data byte #0 should be 0x9 but was 0xfcfc 7c d2 3c 71 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=19 ttl=254 time=12001.3 ms
wrong data byte #0 should be 0x9 but was 0xfdfd 7c d2 3c 71 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=20 ttl=254 time=11001.4 ms
wrong data byte #0 should be 0x9 but was 0xfefe 7c d2 3c 71 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=21 ttl=254 time=10001.5 ms
wrong data byte #0 should be 0x9 but was 0xffff 7c d2 3c 73 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=22 ttl=254 time=9001.7 ms
wrong data byte #0 should be 0x9 but was 0x00 7d d2 3c 72 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=23 ttl=254 time=8001.8 ms
wrong data byte #0 should be 0x9 but was 0x11 7d d2 3c 71 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=24 ttl=254 time=7001.9 ms
wrong data byte #0 should be 0x9 but was 0x22 7d d2 3c 71 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=25 ttl=254 time=6002.0 ms
wrong data byte #0 should be 0x9 but was 0x33 7d d2 3c 71 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=42 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=43 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=44 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=45 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=46 ttl=254 time=0.8 ms
64 octets from 216.143.22.140: icmp_seq=32 ttl=254 time=14000.9 ms
wrong data byte #0 should be 0x18 but was 0xaa 7d d2 3c 7d 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=33 ttl=254 time=13001.1 ms
wrong data byte #0 should be 0x18 but was 0xbb 7d d2 3c 73 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=34 ttl=254 time=12001.2 ms
wrong data byte #0 should be 0x18 but was 0xcc 7d d2 3c 71 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=35 ttl=254 time=11001.3 ms
wrong data byte #0 should be 0x18 but was 0xdd 7d d2 3c 70 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=36 ttl=254 time=10001.4 ms
wrong data byte #0 should be 0x18 but was 0xee 7d d2 3c 72 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=37 ttl=254 time=9001.5 ms
wrong data byte #0 should be 0x18 but was 0xff 7d d2 3c 77 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=38 ttl=254 time=8001.7 ms
wrong data byte #0 should be 0x18 but was 0x1010 7d d2 3c 72 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=39 ttl=254 time=7001.8 ms
wrong data byte #0 should be 0x18 but was 0x1111 7d d2 3c 71 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=40 ttl=254 time=6001.9 ms
wrong data byte #0 should be 0x18 but was 0x1212 7d d2 3c 70 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=41 ttl=254 time=5002.0 ms
wrong data byte #0 should be 0x18 but was 0x1313 7d d2 3c 72 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=57 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=58 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=59 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=60 ttl=254 time=0.7 ms
64 octets from 216.143.22.140: icmp_seq=47 ttl=254 time=13000.8 ms
wrong data byte #0 should be 0x26 but was 0x1919 7d d2 3c 81 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=48 ttl=254 time=12001.0 ms
wrong data byte #0 should be 0x26 but was 0x1a1a 7d d2 3c 77 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=49 ttl=254 time=11001.1 ms
wrong data byte #0 should be 0x26 but was 0x1b1b 7d d2 3c 72 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=50 ttl=254 time=10001.2 ms
wrong data byte #0 should be 0x26 but was 0x1c1c 7d d2 3c 74 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=51 ttl=254 time=9001.3 ms
wrong data byte #0 should be 0x26 but was 0x1d1d 7d d2 3c 75 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=52 ttl=254 time=8001.5 ms
wrong data byte #0 should be 0x26 but was 0x1e1e 7d d2 3c 73 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=53 ttl=254 time=7001.6 ms
wrong data byte #0 should be 0x26 but was 0x1f1f 7d d2 3c 74 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=54 ttl=254 time=6001.7 ms
wrong data byte #0 should be 0x26 but was 0x2020 7d d2 3c 72 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=55 ttl=254 time=5001.8 ms
wrong data byte #0 should be 0x26 but was 0x2121 7d d2 3c 71 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=56 ttl=254 time=4002.0 ms
wrong data byte #0 should be 0x26 but was 0x2222 7d d2 3c 73 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=67 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=68 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=69 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=70 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=71 ttl=254 time=1.1 ms
64 octets from 216.143.22.140: icmp_seq=61 ttl=254 time=10001.2 ms
wrong data byte #0 should be 0x31 but was 0x2727 7d d2 3c 7d 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=62 ttl=254 time=9001.3 ms
wrong data byte #0 should be 0x31 but was 0x2828 7d d2 3c 74 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=63 ttl=254 time=8001.5 ms
wrong data byte #0 should be 0x31 but was 0x2929 7d d2 3c 74 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=64 ttl=254 time=7001.6 ms
wrong data byte #0 should be 0x31 but was 0x2a2a 7d d2 3c 72 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=65 ttl=254 time=6001.7 ms
wrong data byte #0 should be 0x31 but was 0x2b2b 7d d2 3c 75 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=66 ttl=254 time=5001.8 ms
wrong data byte #0 should be 0x31 but was 0x2c2c 7d d2 3c 73 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=79 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=80 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=81 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=82 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=83 ttl=254 time=0.7 ms
64 octets from 216.143.22.140: icmp_seq=72 ttl=254 time=11000.8 ms
wrong data byte #0 should be 0x3d but was 0x3232 7d d2 3c 7c 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=73 ttl=254 time=10001.0 ms
wrong data byte #0 should be 0x3d but was 0x3333 7d d2 3c 7a 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=74 ttl=254 time=9001.1 ms
wrong data byte #0 should be 0x3d but was 0x3434 7d d2 3c 72 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=75 ttl=254 time=8001.2 ms
wrong data byte #0 should be 0x3d but was 0x3535 7d d2 3c 72 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=76 ttl=254 time=7001.3 ms
wrong data byte #0 should be 0x3d but was 0x3636 7d d2 3c 73 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=77 ttl=254 time=6001.5 ms
wrong data byte #0 should be 0x3d but was 0x3737 7d d2 3c 72 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=78 ttl=254 time=5001.6 ms
wrong data byte #0 should be 0x3d but was 0x3838 7d d2 3c 74 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=94 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=95 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=96 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=97 ttl=254 time=0.8 ms
64 octets from 216.143.22.140: icmp_seq=84 ttl=254 time=13000.9 ms
wrong data byte #0 should be 0x4b but was 0x3e3e 7d d2 3c 7e 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=85 ttl=254 time=12001.0 ms
wrong data byte #0 should be 0x4b but was 0x3f3f 7d d2 3c 71 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=86 ttl=254 time=11001.1 ms
wrong data byte #0 should be 0x4b but was 0x4040 7d d2 3c 72 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=87 ttl=254 time=10001.3 ms
wrong data byte #0 should be 0x4b but was 0x4141 7d d2 3c 71 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=88 ttl=254 time=9001.4 ms
wrong data byte #0 should be 0x4b but was 0x4242 7d d2 3c 71 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=89 ttl=254 time=8001.5 ms
wrong data byte #0 should be 0x4b but was 0x4343 7d d2 3c 76 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=90 ttl=254 time=7001.6 ms
wrong data byte #0 should be 0x4b but was 0x4444 7d d2 3c 71 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=91 ttl=254 time=6001.8 ms
wrong data byte #0 should be 0x4b but was 0x4545 7d d2 3c 73 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=92 ttl=254 time=5001.9 ms
wrong data byte #0 should be 0x4b but was 0x4646 7d d2 3c 76 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=93 ttl=254 time=4002.0 ms
wrong data byte #0 should be 0x4b but was 0x4747 7d d2 3c 77 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=108 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=109 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=110 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=111 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=112 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=113 ttl=254 time=0.8 ms
64 octets from 216.143.22.140: icmp_seq=98 ttl=254 time=15000.9 ms
wrong data byte #0 should be 0x5b but was 0x4c4c 7d d2 3c 7f 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=99 ttl=254 time=14001.1 ms
wrong data byte #0 should be 0x5b but was 0x4d4d 7d d2 3c 71 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=100 ttl=254 time=13001.2 ms
wrong data byte #0 should be 0x5b but was 0x4e4e 7d d2 3c 71 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=101 ttl=254 time=12001.3 ms
wrong data byte #0 should be 0x5b but was 0x4f4f 7d d2 3c 73 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=102 ttl=254 time=11001.5 ms
wrong data byte #0 should be 0x5b but was 0x5050 7d d2 3c 71 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=103 ttl=254 time=10001.6 ms
wrong data byte #0 should be 0x5b but was 0x5151 7d d2 3c 77 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=104 ttl=254 time=9001.7 ms
wrong data byte #0 should be 0x5b but was 0x5252 7d d2 3c 71 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=105 ttl=254 time=8001.8 ms
wrong data byte #0 should be 0x5b but was 0x5353 7d d2 3c 71 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=106 ttl=254 time=7001.9 ms
wrong data byte #0 should be 0x5b but was 0x5454 7d d2 3c 73 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=107 ttl=254 time=6002.1 ms
wrong data byte #0 should be 0x5b but was 0x5555 7d d2 3c 71 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=123 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=124 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=125 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=126 ttl=254 time=0.4 ms
64 octets from 216.143.22.140: icmp_seq=127 ttl=254 time=0.7 ms
64 octets from 216.143.22.140: icmp_seq=114 ttl=254 time=13000.8 ms
wrong data byte #0 should be 0x69 but was 0x5c5c 7d d2 3c 7f 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=115 ttl=254 time=12001.0 ms
wrong data byte #0 should be 0x69 but was 0x5d5d 7d d2 3c 71 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=116 ttl=254 time=11001.1 ms
wrong data byte #0 should be 0x69 but was 0x5e5e 7d d2 3c 72 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=117 ttl=254 time=10001.2 ms
wrong data byte #0 should be 0x69 but was 0x5f5f 7d d2 3c 71 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=118 ttl=254 time=9001.3 ms
wrong data byte #0 should be 0x69 but was 0x6060 7d d2 3c 8d 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=119 ttl=254 time=8001.5 ms
wrong data byte #0 should be 0x69 but was 0x6161 7d d2 3c 73 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=120 ttl=254 time=7001.6 ms
wrong data byte #0 should be 0x69 but was 0x6262 7d d2 3c 70 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=121 ttl=254 time=6001.7 ms
wrong data byte #0 should be 0x69 but was 0x6363 7d d2 3c 73 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 216.143.22.140: icmp_seq=122 ttl=254 time=5001.8 ms
wrong data byte #0 should be 0x69 but was 0x6464 7d d2 3c 78 6e 4 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 
22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f

--- 216.143.22.140 ping statistics ---
134 packets transmitted, 128 packets received, 4% packet loss
round-trip min/avg/max = 0.4/5485.4/15000.9 ms
root@lithium:~#
