Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265027AbTGHRM2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 13:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265038AbTGHRM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 13:12:27 -0400
Received: from mpls-qmqp-01.inet.qwest.net ([63.231.195.112]:17166 "HELO
	mpls-qmqp-01.inet.qwest.net") by vger.kernel.org with SMTP
	id S265027AbTGHRMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 13:12:19 -0400
Date: Tue, 8 Jul 2003 12:23:37 -0700
Message-ID: <001401c34586$6f955e20$6801a8c0@oemcomputer>
From: "Paul Albrecht" <palbrecht@qwest.net>
To: "Andi Kleen" <ak@suse.de>
Cc: niv@us.ibm.com, linux-kernel@vger.kernel.org,
       "netdev" <netdev@oss.sgi.com>
References: <3F08858E.8000907@us.ibm.com.suse.lists.linux.kernel><001a01c3441c$6fe111a0$6801a8c0@oemcomputer.suse.lists.linux.kernel><3F08B7E2.7040208@us.ibm.com.suse.lists.linux.kernel><000d01c3444f$e6439600$6801a8c0@oemcomputer.suse.lists.linux.kernel><3F090A4F.10004@us.ibm.com.suse.lists.linux.kernel><001401c344df$ccbc63c0$6801a8c0@oemcomputer.suse.lists.linux.kernel> <p73fzliqa91.fsf@oldwotan.suse.de>
Subject: Re: question about linux tcp request queue handling
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0011_01C3454B.C1D79260"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0011_01C3454B.C1D79260
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Andi Kleen writes:

>
> The 4.4BSD-Lite code described in Stevens is long outdated. All modern
> BSDs (and probably most other Unixes too) do it in a similar way to what
> Nivedita described. The keywords are "syn flood attack" and "DoS".
>

I have attached a copy of tcpdump output for two linux systems connected
over ether replaying the scenario for incoming request queue handling given
in Stevens's TCP/IP Illustrated Volume 1: The Protocols.  What I don't
understand about the third handshake is if the server is going to send the
syn/ack in response the client's initial syn then why does server repeatly
ignore the subsequent ack from the client?

------=_NextPart_000_0011_01C3454B.C1D79260
Content-Type: text/plain;
	name="trace.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="trace.txt"

01:12:09.622208 client.acme.net.1024 > server.acme.net.7777: S =
2730884988:2730884988(0) win 5840 <mss 1460,sackOK,timestamp 133507 =
0,nop,wscale 0> (DF)
01:12:09.623457 server.acme.net.7777 > client.acme.net.1024: S =
1682786145:1682786145(0) ack 2730884989 win 5792 <mss =
1460,sackOK,timestamp 42960 133507,nop,wscale 0> (DF)
01:12:09.623963 client.acme.net.1024 > server.acme.net.7777: . ack =
1682786146 win 5840 <nop,nop,timestamp 133508 42960> (DF)
01:12:11.858191 client.acme.net.1025 > server.acme.net.7777: S =
2743503110:2743503110(0) win 5840 <mss 1460,sackOK,timestamp 134652 =
0,nop,wscale 0> (DF)
01:12:11.858991 server.acme.net.7777 > client.acme.net.1025: S =
1690738882:1690738882(0) ack 2743503111 win 5792 <mss =
1460,sackOK,timestamp 43183 134652,nop,wscale 0> (DF)
01:12:11.859535 client.acme.net.1025 > server.acme.net.7777: . ack =
1690738883 win 5840 <nop,nop,timestamp 134653 43183> (DF)
01:12:13.909895 client.acme.net.1026 > server.acme.net.7777: S =
2736891141:2736891141(0) win 5840 <mss 1460,sackOK,timestamp 135702 =
0,nop,wscale 0> (DF)
01:12:13.910636 server.acme.net.7777 > client.acme.net.1026: S =
1692403887:1692403887(0) ack 2736891142 win 5792 <mss =
1460,sackOK,timestamp 43388 135702,nop,wscale 0> (DF)
01:12:13.911144 client.acme.net.1026 > server.acme.net.7777: . ack =
1692403888 win 5840 <nop,nop,timestamp 135703 43388> (DF)
01:12:17.502319 server.acme.net.7777 > client.acme.net.1026: S =
1692403887:1692403887(0) ack 2736891142 win 5792 <mss =
1460,sackOK,timestamp 43748 135703,nop,wscale 0> (DF)
01:12:17.502909 client.acme.net.1026 > server.acme.net.7777: . ack =
1692403888 win 5840 <nop,nop,timestamp 137542 43748,nop,nop,sack sack 1 =
{1692403887:1692403888} > (DF)
01:12:23.502350 server.acme.net.7777 > client.acme.net.1026: S =
1692403887:1692403887(0) ack 2736891142 win 5792 <mss =
1460,sackOK,timestamp 44348 137542,nop,wscale 0> (DF)
01:12:23.502969 client.acme.net.1026 > server.acme.net.7777: . ack =
1692403888 win 5840 <nop,nop,timestamp 140614 44348,nop,nop,sack sack 1 =
{1692403887:1692403888} > (DF)
01:12:35.702302 server.acme.net.7777 > client.acme.net.1026: S =
1692403887:1692403887(0) ack 2736891142 win 5792 <mss =
1460,sackOK,timestamp 45568 140614,nop,wscale 0> (DF)
01:12:35.702840 client.acme.net.1026 > server.acme.net.7777: . ack =
1692403888 win 5840 <nop,nop,timestamp 146859 45568,nop,nop,sack sack 1 =
{1692403887:1692403888} > (DF)
01:12:59.702343 server.acme.net.7777 > client.acme.net.1026: S =
1692403887:1692403887(0) ack 2736891142 win 5792 <mss =
1460,sackOK,timestamp 47968 146859,nop,wscale 0> (DF)
01:12:59.702994 client.acme.net.1026 > server.acme.net.7777: . ack =
1692403888 win 5840 <nop,nop,timestamp 159147 47968,nop,nop,sack sack 1 =
{1692403887:1692403888} > (DF)
------=_NextPart_000_0011_01C3454B.C1D79260--

