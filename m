Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264060AbTDJQvu (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 12:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbTDJQvu (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 12:51:50 -0400
Received: from tao.natur.cuni.cz ([195.113.56.1]:41487 "EHLO tao.natur.cuni.cz")
	by vger.kernel.org with ESMTP id S264060AbTDJQvs (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 12:51:48 -0400
X-Obalka-From: mmokrejs@natur.cuni.cz
X-Obalka-To: <linux-kernel@vger.kernel.org>
Date: Thu, 10 Apr 2003 19:03:28 +0200 (CEST)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre6 problem with 8139too Fast Ethernet driver 0.9.26
Message-ID: <Pine.OSF.4.51.0304101852250.408246@tao.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I'm observing sporadic problems with my onboard network card:

$ ping 195.113.56.1
PING 195.113.56.1 (195.113.56.1): 56 octets data
64 octets from 195.113.56.1: icmp_seq=0 ttl=42 time=1068.2 ms
wrong data byte #0 should be 0x1c but was 0x1b1b b0 95 3e de 9 9 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 22
23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 195.113.56.1: icmp_seq=1 ttl=42 time=72.7 ms
64 octets from 195.113.56.1: icmp_seq=2 ttl=42 time=68.6 ms
64 octets from 195.113.56.1: icmp_seq=3 ttl=42 time=68.3 ms
64 octets from 195.113.56.1: icmp_seq=4 ttl=42 time=784.6 ms
64 octets from 195.113.56.1: icmp_seq=5 ttl=42 time=688.8 ms
64 octets from 195.113.56.1: icmp_seq=6 ttl=42 time=67.6 ms

--- 195.113.56.1 ping statistics ---
7 packets transmitted, 7 packets received, 0% packet loss
round-trip min/avg/max = 67.6/402.6/1068.2 ms
$


I saw these error with 2.4.19, 2.4.20 and most subsequequent testing releases. I
cannot say about older kernels, as I did not have that machine before. Could
anyone tell me what kind of information should I gather to make it reproducible
for you?

It seems at least now it appears when I do "mii-tool --reset" and continues:


64 octets from 195.113.56.1: icmp_seq=105 ttl=42 time=67.7 ms
64 octets from 195.113.56.1: icmp_seq=106 ttl=42 time=66.9 ms
64 octets from 195.113.56.1: icmp_seq=107 ttl=42 time=67.7 ms
64 octets from 195.113.56.1: icmp_seq=108 ttl=42 time=1371.9 ms
wrong data byte #0 should be 0x4f but was 0x4e4e b2 95 3e 52 af e 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 195.113.56.1: icmp_seq=109 ttl=42 time=802.2 ms
64 octets from 195.113.56.1: icmp_seq=110 ttl=42 time=67.0 ms
64 octets from 195.113.56.1: icmp_seq=111 ttl=42 time=66.4 ms
64 octets from 195.113.56.1: icmp_seq=112 ttl=42 time=67.2 ms
64 octets from 195.113.56.1: icmp_seq=113 ttl=42 time=69.1 ms
64 octets from 195.113.56.1: icmp_seq=114 ttl=42 time=67.4 ms
64 octets from 195.113.56.1: icmp_seq=115 ttl=42 time=1184.3 ms
wrong data byte #0 should be 0x56 but was 0x5555 b2 95 3e 5c af e 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 195.113.56.1: icmp_seq=116 ttl=42 time=192.6 ms
64 octets from 195.113.56.1: icmp_seq=117 ttl=42 time=66.7 ms
64 octets from 195.113.56.1: icmp_seq=118 ttl=42 time=67.5 ms
64 octets from 195.113.56.1: icmp_seq=119 ttl=42 time=1435.6 ms
wrong data byte #0 should be 0x5a but was 0x5959 b2 95 3e 60 af e 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 195.113.56.1: icmp_seq=120 ttl=42 time=1007.7 ms
wrong data byte #0 should be 0x5b but was 0x5a5a b2 95 3e 6c af e 0
        8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 22 23 24 25 26 27
        28 29 2a 2b 2c 2d 2e 2f
64 octets from 195.113.56.1: icmp_seq=121 ttl=42 time=68.6 ms
64 octets from 195.113.56.1: icmp_seq=122 ttl=42 time=67.8 ms


$ mii-tool --verbose
eth0: 10 Mbit, half duplex, link ok
  product info: vendor 00:00:00, model 0 rev 0
  basic mode:   10 Mbit, half duplex
  basic status: link ok
  capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  advertising:  100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
$

Any ideas? Please cc me in replies.
-- 
Martin Mokrejs <mmokrejs@natur.cuni.cz>, <m.mokrejs@gsf.de>
PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany
tel.: +49-89-3187 3683 , fax: +49-89-3187 3585
