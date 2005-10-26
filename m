Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbVJZQMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbVJZQMh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 12:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbVJZQMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 12:12:37 -0400
Received: from [85.204.20.249] ([85.204.20.249]:28168 "EHLO i-neo.ro")
	by vger.kernel.org with ESMTP id S964803AbVJZQMh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 12:12:37 -0400
Subject: "arp -s ip mac" doesn't work with newer kernels
From: "andrei.popa" <andrei.popa@i-neo.ro>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 26 Oct 2005 19:10:38 +0300
Message-Id: <1130343038.6285.7.camel@ierdnac>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"arp -s ip mac" doesn't work:
I assign a static MAC to an IP, and if that IP changes his MAC, the
connection with the server still works. In previous kernels if the MAC
was different from the MAC assigned in "arp -s IP MAC" the client didn't
see the server, so no traffic was done between the client and the
server.

inoxid ~ # uname -a
Linux inoxid 2.6.13.1-inoxid17 #4 SMP Sun Sep 18 07:37:20 EEST 2005 i686
Pentium III (Coppermine) GenuineIntel GNU/Linux

(static entry done with "arp -s 85.120.33.151 00:11:D8:5F:91:9B" )
inoxid ~ # arp -an 85.120.33.151
? (85.120.33.151) at 00:11:D8:5F:91:9B [ether] PERM on eth1

inoxid ~ # arping -I eth1 85.120.33.151
ARPING 85.120.33.151 from 85.120.33.1 eth1
Unicast reply from 85.120.33.151 [00:11:D8:5F:8A:BD]  1.685ms
Unicast reply from 85.120.33.151 [00:11:D8:5F:8A:BD]  1.893ms
Sent 2 probes (1 broadcast(s))
Received 2 response(s)

inoxid ~ # tcpdump -i eth1 -e src host 85.120.33.151 -n
tcpdump: verbose output suppressed, use -v or -vv for full protocol
decode
listening on eth1, link-type EN10MB (Ethernet), capture size 68 bytes
19:07:59.044205 00:11:d8:5f:8a:bd > 00:b0:d0:49:24:87, ethertype IPv4
(0x0800), length 1514: IP 85.120.33.151.25693 > 81.18.71.253.54062: .
3046778176:3046779636(1460) ack 3121120561 win 65256
19:07:59.044236 00:11:d8:5f:8a:bd > 00:b0:d0:49:24:87, ethertype IPv4
(0x0800), length 1514: IP 85.120.33.151.25693 > 81.18.71.253.54062: .
1460:2920(1460) ack 1 win 65256
19:07:59.048841 00:11:d8:5f:8a:bd > 00:b0:d0:49:24:87, ethertype IPv4
(0x0800), length 1514: IP 85.120.33.151.25693 > 84.234.110.106.3602: .
4280281117:4280282577(1460) ack 113703100 win 64982
19:07:59.048954 00:11:d8:5f:8a:bd > 00:b0:d0:49:24:87, ethertype IPv4
(0x0800), length 1514: IP 85.120.33.151.25693 > 84.234.110.106.3602: .
1460:2920(1460) ack 1 win 64982
19:07:59.052030 00:11:d8:5f:8a:bd > 00:b0:d0:49:24:87, ethertype IPv4
(0x0800), length 1514: IP 85.120.33.151.25693 > 84.234.110.106.3602: .
2920:4380(1460) ack 1 win 64982
19:07:59.052155 00:11:d8:5f:8a:bd > 00:b0:d0:49:24:87, ethertype IPv4
(0x0800), length 1514: IP 85.120.33.151.25693 > 84.234.110.106.3602: .
4380:5840(1460) ack 1 win 64982


