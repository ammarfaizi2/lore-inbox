Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265806AbTBBX6Y>; Sun, 2 Feb 2003 18:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265828AbTBBX6Y>; Sun, 2 Feb 2003 18:58:24 -0500
Received: from 5.Red-80-32-157.pooles.rima-tde.net ([80.32.157.5]:31497 "EHLO
	smtp.newipnet.com") by vger.kernel.org with ESMTP
	id <S265806AbTBBX6R> convert rfc822-to-8bit; Sun, 2 Feb 2003 18:58:17 -0500
Message-ID: <200302030108240978.2B66BB7E@192.168.128.16>
In-Reply-To: <200302021958160177.2A4B5622@192.168.128.16>
References: <200302021958160177.2A4B5622@192.168.128.16>
X-Mailer: Calypso Version 3.30.00.00 (4)
Date: Mon, 03 Feb 2003 01:08:24 +0100
From: "Carlos Velasco" <carlosev@newipnet.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 Broken Path MTU Discovery?
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*Info added*

This issue is not shown when MTU in router is 600 or bigger.
If I set router MTU to 500 the problem is as show below.

Regards,
Carlos Velasco

*********** REPLY SEPARATOR  ***********

On 02/02/2003 at 19:58 Carlos Velasco wrote:

>Hi,
>
>I have an issue with Path MTU Discovery in linux 2.4.20 box, although I
>don't know if this is an kernel issue or a network driver issue (8139too).
>
>Network is connected to an outside Cisco router that has MTU set to 400
>for output.
>Linux has one ethernet interface, MTU set to 1500 (default).
>PMTU is activated:
>> cat /proc/sys/net/ipv4/ip_no_pmtu_disc 
>0
>
>Not using iproute2.
>
>Behaviour:
>1. Linux send packet with DF set and len > 400.
>2. Ciaco router sends icmp to linux box informing MTU is 400.
>3. Linux short the packet sent, but send it without DF set.
>¿Linux is giving up PMTU?
>¿Why linux is not adjusting mtu to 400 as advertised by router and use
>PMTU?
>
>As long as I know, fragmentation should be avoided in the internet, they
>tend to be blocked at firewalls and they consume resources in routers.
>
>I have reviewed the PMTU RFC:
>RFC 1191
>http://www.ietf.org/rfc/rfc1191.txt
>
>¿May be the Linux box is giving up PMTU? ¿Why? it now knows MTU is 400.
>I have others windows boxes in the network, they work fine with PMTU.
>
>The PMTU discovery process ends when the host's estimate of the PMTU
>   is low enough that its datagrams can be delivered without
>   fragmentation.  Or, the host may elect to end the discovery process
>   by ceasing to set the DF bit in the datagram headers; it may do so,
>   for example, because it is willing to have datagrams fragmented in
>   some circumstances.  Normally, the host continues to set DF in all
>   datagrams, so that if the route changes and the new PMTU is lower, it
>   will be discovered.
>
>
>Here are some sniffer traces taken by snort.
>Linux is 192.168.128.16, trying to connect to HTTP www.cnn.com
>(64.236.24.12):
>
>TCP Establishment
>=================
>
>02/02-19:42:19.003341 192.168.128.16:2175 -> 64.236.24.12:80
>TCP TTL:64 TOS:0x0 ID:61539 IpLen:20 DgmLen:60 DF
>******S* Seq: 0xE59FD9DD  Ack: 0x0  Win: 0x16D0  TcpLen: 40
>TCP Options (5) => MSS: 1460 SackOK TS: 6629822 0 NOP WS: 0 
>=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
>
>02/02-19:42:19.213587 64.236.24.12:80 -> 192.168.128.16:2175
>TCP TTL:62 TOS:0x0 ID:0 IpLen:20 DgmLen:60 DF
>***A**S* Seq: 0xE678E021  Ack: 0xE59FD9DE  Win: 0x16A0  TcpLen: 40
>TCP Options (5) => MSS: 1460 SackOK TS: 29413933 6629822 NOP WS: 0 
>=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
>
>02/02-19:42:19.213715 192.168.128.16:2175 -> 64.236.24.12:80
>TCP TTL:64 TOS:0x0 ID:61540 IpLen:20 DgmLen:52 DF
>***A**** Seq: 0xE59FD9DE  Ack: 0xE678E022  Win: 0x16D0  TcpLen: 32
>TCP Options (3) => NOP NOP TS: 6629843 29413933 
>=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
>
>
>HTTP REQUEST
>============
>
>02/02-19:42:19.216995 192.168.128.16:2175 -> 64.236.24.12:80
>TCP TTL:64 TOS:0x0 ID:61541 IpLen:20 DgmLen:604 DF
>***AP*** Seq: 0xE59FD9DE  Ack: 0xE678E022  Win: 0x16D0  TcpLen: 32
>TCP Options (3) => NOP NOP TS: 6629843 29413933 
>=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
>
>
>ROUTER INFORMS MTU IS 400 (ICMP)
>================================
>
>02/02-19:42:19.219745 192.168.128.200 -> 192.168.128.16
>ICMP TTL:255 TOS:0x0 ID:22656 IpLen:20 DgmLen:56
>Type:3  Code:4  DESTINATION UNREACHABLE: FRAGMENTATION NEEDED, DF SET
>NEXT LINK MTU: 400
>
>** ORIGINAL DATAGRAM DUMP:
>192.168.128.16:2175 -> 64.236.24.12:80
>TCP TTL:63 TOS:0x0 ID:61541 IpLen:20 DgmLen:604 DF
>Seq: 0xE59FD9DE  Ack: 0x2F204854
>** END OF DUMP
>=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
>
>
>LINUX SHORT LEN BY 52 bytes?
>DF NOT SET?
>GIVING OUT PMTU??
>============================
>
>02/02-19:42:19.220063 192.168.128.16:2175 -> 64.236.24.12:80
>TCP TTL:64 TOS:0x0 ID:3449 IpLen:20 DgmLen:552
>***A**** Seq: 0xE59FD9DE  Ack: 0xE678E022  Win: 0x16D0  TcpLen: 32
>TCP Options (3) => NOP NOP TS: 6629843 29413933 
>=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
>
>02/02-19:42:19.843267 192.168.128.16:2175 -> 64.236.24.12:80
>TCP TTL:64 TOS:0x0 ID:3450 IpLen:20 DgmLen:552
>***A**** Seq: 0xE59FD9DE  Ack: 0xE678E022  Win: 0x16D0  TcpLen: 32
>TCP Options (3) => NOP NOP TS: 6629906 29413933 
>=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
>
>02/02-19:42:21.103163 192.168.128.16:2175 -> 64.236.24.12:80
>TCP TTL:64 TOS:0x0 ID:3451 IpLen:20 DgmLen:552
>***A**** Seq: 0xE59FD9DE  Ack: 0xE678E022  Win: 0x16D0  TcpLen: 32
>TCP Options (3) => NOP NOP TS: 6630032 29413933 
>=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
>
>02/02-19:42:23.622973 192.168.128.16:2175 -> 64.236.24.12:80
>TCP TTL:64 TOS:0x0 ID:3452 IpLen:20 DgmLen:552
>***A**** Seq: 0xE59FD9DE  Ack: 0xE678E022  Win: 0x16D0  TcpLen: 32
>TCP Options (3) => NOP NOP TS: 6630284 29413933 
>=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
>
>
>AGAIN WITH DF SET??
>===================
>
>02/02-19:42:28.662657 192.168.128.16:2175 -> 64.236.24.12:80
>TCP TTL:64 TOS:0x0 ID:61542 IpLen:20 DgmLen:552 DF
>***A**** Seq: 0xE59FD9DE  Ack: 0xE678E022  Win: 0x16D0  TcpLen: 32
>TCP Options (3) => NOP NOP TS: 6630788 29413933 
>=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
>
>ROUTER INFORMS MTU IS 400 (ICMP)
>================================
>
>02/02-19:42:28.666355 192.168.128.200 -> 192.168.128.16
>ICMP TTL:255 TOS:0x0 ID:22657 IpLen:20 DgmLen:56
>Type:3  Code:4  DESTINATION UNREACHABLE: FRAGMENTATION NEEDED, DF SET
>NEXT LINK MTU: 400
>
>** ORIGINAL DATAGRAM DUMP:
>192.168.128.16:2175 -> 64.236.24.12:80
>TCP TTL:63 TOS:0x0 ID:61542 IpLen:20 DgmLen:552 DF
>Seq: 0xE59FD9DE  Ack: 0x2F204854
>** END OF DUMP
>=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
>
>
>DF NOT SET? (AGAIN)
>===================
>
>02/02-19:42:38.741842 192.168.128.16:2175 -> 64.236.24.12:80
>TCP TTL:64 TOS:0x0 ID:3453 IpLen:20 DgmLen:552
>***A**** Seq: 0xE59FD9DE  Ack: 0xE678E022  Win: 0x16D0  TcpLen: 32
>TCP Options (3) => NOP NOP TS: 6631796 29413933 
>=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
>
>02/02-19:42:58.900285 192.168.128.16:2175 -> 64.236.24.12:80
>TCP TTL:64 TOS:0x0 ID:3454 IpLen:20 DgmLen:552
>***A**** Seq: 0xE59FD9DE  Ack: 0xE678E022  Win: 0x16D0  TcpLen: 32
>TCP Options (3) => NOP NOP TS: 6633812 29413933 
>=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
>
>
>Regards,
>Carlos Velasco
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/



