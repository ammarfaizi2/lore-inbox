Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbTKTJuV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 04:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264287AbTKTJuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 04:50:20 -0500
Received: from sea2-dav12.sea2.hotmail.com ([207.68.164.116]:21508 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264286AbTKTJuG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 04:50:06 -0500
X-Originating-IP: [80.204.235.254]
X-Originating-Email: [pupilla@hotmail.com]
From: "Marco Berizzi" <pupilla@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: ipsec on kernel 2.6.0-test9
Date: Thu, 20 Nov 2003 10:50:50 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1123
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1123
Message-ID: <Sea2-DAV12g3Sv0YKpD0000510c@hotmail.com>
X-OriginalArrivalTime: 20 Nov 2003 09:50:05.0905 (UTC) FILETIME=[AD28DC10:01C3AF4B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody.
I'm playing with ipsec on linux 2.6.0-test9 + ipsec-tools-0.2.2
I would like to implement a simple esp-tunnel with ipcomp. This is my
setkey init file:

/usr/local/sbin/setkey -c <<EOF
flush;
spdflush;
spdadd 10.1.2.0/24 10.1.1.0/24 any -P in ipsec
    ipcomp/tunnel/172.16.1.247-172.16.1.226/require
    esp/tunnel/172.16.1.247-172.16.1.226/require;

spdadd 10.1.1.0/24 10.1.2.0/24 any -P out ipsec
    ipcomp/tunnel/172.16.1.226-172.16.1.247/require
    esp/tunnel/172.16.1.226-172.16.1.247/require;
EOF

The two Slackware 9.1 linux boxes have the same config (except for
the -P in/out).
These are the logs from the linux boxes:

Nov 20 10:39:09 k2 racoon: INFO: isakmp.c:1688:isakmp_post_acquire():
IPsec-SA request for 172.16.1.247 queued due to no phase1 found.
Nov 20 10:39:09 k2 racoon: INFO: isakmp.c:797:isakmp_ph1begin_i():
initiate new phase 1 negotiation: 172.16.1.226[500]<=>172.16.1.247[500]
Nov 20 10:39:09 k2 racoon: INFO: isakmp.c:802:isakmp_ph1begin_i(): begin
Identity Protection mode.
Nov 20 10:39:09 k2 racoon: INFO: vendorid.c:128:check_vendorid():
received Vendor ID: KAME/racoon
Nov 20 10:39:10 k2 racoon: INFO: vendorid.c:128:check_vendorid():
received Vendor ID: KAME/racoon
Nov 20 10:39:10 k2 racoon: INFO: isakmp.c:2418:log_ph1established():
ISAKMP-SA established 172.16.1.226[500]-172.16.1.247[500]
spi:bdbcb73da256a199:6a11589947e97349
Nov 20 10:39:11 k2 racoon: INFO: isakmp.c:941:isakmp_ph2begin_i():
initiate new phase 2 negotiation: 172.16.1.226[0]<=>172.16.1.247[0]
Nov 20 10:39:11 k2 racoon: ERROR: proposal.c:363:cmpsaprop_alloc():
IPComp SPI size promoted from 16bit to 32bit
Nov 20 10:39:11 k2 racoon: INFO: pfkey.c:1109:pk_recvupdate(): IPsec-SA
established: ESP/Tunnel 172.16.1.247->172.16.1.226
spi=187337237(0xb2a8a15)
Nov 20 10:39:11 k2 racoon: ERROR: pfkey.c:209:pfkey_handler(): pfkey
UPDATE failed: Invalid argument
Nov 20 10:39:11 k2 racoon: INFO: pfkey.c:1321:pk_recvadd(): IPsec-SA
established: ESP/Tunnel 172.16.1.226->172.16.1.247
spi=172072808(0xa419f68)
Nov 20 10:39:11 k2 racoon: ERROR: pfkey.c:209:pfkey_handler(): pfkey ADD
failed: Invalid argument
Nov 20 10:39:26 k2 racoon: ERROR: pfkey.c:740:pfkey_timeover():
172.16.1.247 give up to get IPsec-SA due to time up to wait.
Nov 20 10:39:35 k2 racoon: INFO: pfkey.c:1367:pk_recvexpire(): IPsec-SA
expired: ESP/Tunnel 172.16.1.247->172.16.1.226 spi=187337237(0xb2a8a15)
Nov 20 10:39:35 k2 racoon: INFO: pfkey.c:1367:pk_recvexpire(): IPsec-SA
expired: ESP/Tunnel 172.16.1.226->172.16.1.247 spi=172072808(0xa419f68)
Nov 20 10:39:41 k2 racoon: INFO: pfkey.c:1367:pk_recvexpire(): IPsec-SA
expired: IPCOMP/Tunnel 172.16.1.247->172.16.1.226
spi=65950044(0x3ee515c)
Nov 20 10:39:41 k2 racoon: INFO: pfkey.c:1367:pk_recvexpire(): IPsec-SA
expired: ESP/Tunnel 172.16.1.247->172.16.1.226 spi=187337237(0xb2a8a15)
Nov 20 10:39:41 k2 racoon: INFO: pfkey.c:1367:pk_recvexpire(): IPsec-SA
expired: ESP/Tunnel 172.16.1.226->172.16.1.247 spi=172072808(0xa419f68)
Nov 20 10:40:10 k2 racoon: INFO: isakmp.c:1520:isakmp_ph1expire():
ISAKMP-SA expired 172.16.1.226[500]-172.16.1.247[500]
spi:bdbcb73da256a199:6a11589947e97349
Nov 20 10:40:11 k2 racoon: INFO: isakmp.c:1568:isakmp_ph1delete():
ISAKMP-SA deleted 172.16.1.226[500]-172.16.1.247[500]
spi:bdbcb73da256a199:6a11589947e97349

*******************************************************
Nov 20 10:24:13 Cocorita racoon: INFO: isakmp.c:893:isakmp_ph1begin_r():
respond new phase 1 negotiation: 172.16.1.247[500]<=>172.16.1.226[500]
Nov 20 10:24:13 Cocorita racoon: INFO: isakmp.c:898:isakmp_ph1begin_r():
begin Identity Protection mode.
Nov 20 10:24:13 Cocorita racoon: INFO: vendorid.c:128:check_vendorid():
received Vendor ID: KAME/racoon
Nov 20 10:24:14 Cocorita racoon: INFO:
isakmp.c:2418:log_ph1established(): ISAKMP-SA established
172.16.1.247[500]-172.16.1.226[500]
spi:bdbcb73da256a199:6a11589947e97349
Nov 20 10:24:15 Cocorita racoon: INFO:
isakmp.c:1048:isakmp_ph2begin_r(): respond new phase 2 negotiation:
172.16.1.247[0]<=>172.16.1.226[0]
Nov 20 10:24:15 Cocorita racoon: ERROR:
proposal.c:363:cmpsaprop_alloc(): IPComp SPI size promoted from 16bit to
32bit
Nov 20 10:24:15 Cocorita racoon: INFO: pfkey.c:1109:pk_recvupdate():
IPsec-SA established: ESP/Tunnel 172.16.1.226->172.16.1.247
spi=172072808(0xa419f68)
Nov 20 10:24:15 Cocorita racoon: ERROR: pfkey.c:209:pfkey_handler():
pfkey UPDATE failed: Invalid argument
Nov 20 10:24:15 Cocorita racoon: INFO: pfkey.c:1321:pk_recvadd():
IPsec-SA established: ESP/Tunnel 172.16.1.247->172.16.1.226
spi=187337237(0xb2a8a15)
Nov 20 10:24:15 Cocorita racoon: ERROR: pfkey.c:209:pfkey_handler():
pfkey ADD failed: Invalid argument
Nov 20 10:24:30 Cocorita racoon: ERROR: pfkey.c:740:pfkey_timeover():
172.16.1.226 give up to get IPsec-SA due to time up to wait.
Nov 20 10:24:39 Cocorita racoon: INFO: pfkey.c:1367:pk_recvexpire():
IPsec-SA expired: ESP/Tunnel 172.16.1.226->172.16.1.247
spi=172072808(0xa419f68)
Nov 20 10:24:39 Cocorita racoon: INFO: pfkey.c:1367:pk_recvexpire():
IPsec-SA expired: ESP/Tunnel 172.16.1.247->172.16.1.226
spi=187337237(0xb2a8a15)
Nov 20 10:24:45 Cocorita racoon: INFO: pfkey.c:1367:pk_recvexpire():
IPsec-SA expired: IPCOMP/Tunnel 172.16.1.226->172.16.1.247
spi=44887369(0x2aced49)
Nov 20 10:24:45 Cocorita racoon: INFO: pfkey.c:1367:pk_recvexpire():
IPsec-SA expired: ESP/Tunnel 172.16.1.226->172.16.1.247
spi=172072808(0xa419f68)
Nov 20 10:24:45 Cocorita racoon: INFO: pfkey.c:1367:pk_recvexpire():
IPsec-SA expired: ESP/Tunnel 172.16.1.247->172.16.1.226
spi=187337237(0xb2a8a15)
Nov 20 10:25:14 Cocorita racoon: INFO: isakmp.c:1520:isakmp_ph1expire():
ISAKMP-SA expired 172.16.1.247[500]-172.16.1.226[500]
spi:bdbcb73da256a199:6a11589947e97349
Nov 20 10:25:15 Cocorita racoon: INFO: isakmp.c:1568:isakmp_ph1delete():
ISAKMP-SA deleted 172.16.1.247[500]-172.16.1.226[500]
spi:bdbcb73da256a199:6a11589947e97349
Nov 20 10:35:56 Cocorita -- MARK --

This the output from setkey -D on k2 box:

172.16.1.226 172.16.1.247
 esp mode=tunnel spi=79772695(0x04c13c17) reqid=0(0x00000000)
 E: rijndael-cbc  35aab288 5227f09b 2869d1a2 6d204592
 A: hmac-md5  fcf8955e 3d893cec 4dfc8e6b 22013b76
 seq=0x00000000 replay=4 flags=0x00000000 state=dying
 created: Nov 20 10:36:12 2003 current: Nov 20 10:36:41 2003
 diff: 29(s) hard: 30(s) soft: 24(s)
 last:                      hard: 0(s) soft: 0(s)
 current: 0(bytes) hard: 0(bytes) soft: 0(bytes)
 allocated: 0 hard: 0 soft: 0
 sadb_seq=3 pid=511 refcnt=0
172.16.1.247 172.16.1.226
 esp mode=tunnel spi=59236043(0x0387decb) reqid=0(0x00000000)
 E: rijndael-cbc  9c680284 555e4a4b 5504b2db be613e2b
 A: hmac-md5  c1c79615 4964a1d3 24e17192 8a83bebb
 seq=0x00000000 replay=4 flags=0x00000000 state=dying
 created: Nov 20 10:36:12 2003 current: Nov 20 10:36:41 2003
 diff: 29(s) hard: 30(s) soft: 24(s)
 last:                      hard: 0(s) soft: 0(s)
 current: 0(bytes) hard: 0(bytes) soft: 0(bytes)
 allocated: 0 hard: 0 soft: 0
 sadb_seq=1 pid=511 refcnt=0
172.16.1.247 172.16.1.226
 ipcomp mode=tunnel spi=80437850(0x04cb625a) reqid=0(0x00000000)
 C: none  seq=0x00000000 replay=0 flags=0x00000000 state=larval
 created: Nov 20 10:36:11 2003 current: Nov 20 10:36:41 2003
 diff: 30(s) hard: 30(s) soft: 0(s)
 last:                      hard: 0(s) soft: 0(s)
 current: 0(bytes) hard: 0(bytes) soft: 0(bytes)
 allocated: 0 hard: 0 soft: 0
 sadb_seq=0 pid=511 refcnt=0

Am I doing something wrong?  Without ipcomp things are working good.
My env: Slackware 9.1 gcc 3.2.3 kernel 2.6.0-test9 glibc 2.3.2
ipsec-tools-0.2.2 (Cocorita=172.16.1.247 K2=172.16.1.226 connected by
two 3C905 100Mbit/s)
Any feedback are welcome.
TIA.

PS: Please cc me. I'm not subscribed to the list

