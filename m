Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313089AbSDYMJQ>; Thu, 25 Apr 2002 08:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313090AbSDYMJP>; Thu, 25 Apr 2002 08:09:15 -0400
Received: from axp01.e18.physik.tu-muenchen.de ([129.187.154.129]:4359 "EHLO
	axp01.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S313089AbSDYMJO>; Thu, 25 Apr 2002 08:09:14 -0400
Date: Thu, 25 Apr 2002 14:09:08 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: Frank Louwers <frank@openminds.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: 2 NICs on same network
In-Reply-To: <20020423113935.A30329@openminds.be>
Message-ID: <Pine.LNX.4.44.0204251400160.19036-200000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1149134438-724443347-1019736548=:19036"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1149134438-724443347-1019736548=:19036
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi!

On Tue, 23 Apr 2002, Frank Louwers wrote:

> Hi,
> 
> We recently stummed across a rather annoying bug when 2 nics are on
> the same network.
> 
> Our situation is this: we have a server with 2 nics, each with a
> different IP on the same network, connected to the same switch. Let's
> assume eth0 has ip 1.2.3.1 and eth1 has 1.2.3.2, with a both with a
> netmask of 255.255.255.0.
> 
> Now the strange thing is that traffic for 1.2.3.2 arrives at eth0 no
> matter what!
> 
This is in perfect agreement with rfc1122, section 3.3.4.2. Linux uses the 
weak ES model, so the interface doesn't matter. There was once a patch 
floating around for 2.4.6 that made the kernel accept only arp coming from 
the 'right' interface. arp_self_only, or something. I have attached it, 
but I have no idea if it still applies/works.

Ciao,
					Roland

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+

---1149134438-724443347-1019736548=:19036
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="arp_self_only.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0204251409080.19036@pc40.e18.physik.tu-muenchen.de>
Content-Description: 
Content-Disposition: attachment; filename="arp_self_only.patch"

ZGlmZiAtTmF1ciAtLWV4Y2x1ZGU9LiogLS1leGNsdWRlPSoubyBsaW51eC0y
LjQuNi4xL25ldC9pcHY0L2FycC5jIGxpbnV4LTIuNC42L25ldC9pcHY0L2Fy
cC5jDQotLS0gbGludXgtMi40LjYuMS9uZXQvaXB2NC9hcnAuYyAgV2VkIE1h
eSAxNiAxOToyMTo0NSAyMDAxDQorKysgbGludXgtMi40LjYvbmV0L2lwdjQv
YXJwLmMgIFRodSBBdWcgIDkgMTY6MjA6NTcgMjAwMQ0KQEAgLTc2MCw2ICs3
NjAsOSBAQA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQg
ZG9udF9zZW5kID0gMDsNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgaWYgKElOX0RFVl9BUlBGSUxURVIoaW5fZGV2KSkNCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBkb250X3NlbmQgfD0gYXJwX2ZpbHRl
cihzaXAsdGlwLGRldik7DQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGlmIChJTl9ERVZfQVJQX1NFTEZfT05MWShpbl9kZXYpKQ0KKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChkZXYgIT0gaXBfZGV2
X2ZpbmQodGlwKSkNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBkb250X3NlbmQgPSAxOw0KICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBpZiAoIWRvbnRfc2VuZCkNCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBhcnBfc2VuZChBUlBPUF9SRVBMWSxFVEhfUF9B
UlAsc2lwLGRldix0aXAsc2hhLGRldi0+ZGV2X2FkZHIsc2hhKTsNCg0KZGlm
ZiAtTmF1ciAtLWV4Y2x1ZGU9LiogLS1leGNsdWRlPSoubyBsaW51eC0yLjQu
Ni4xL25ldC9pcHY0L2RldmluZXQuYyBsaW51eC0yLjQuNi9uZXQvaXB2NC9k
ZXZpbmV0LmMNCi0tLSBsaW51eC0yLjQuNi4xL25ldC9pcHY0L2RldmluZXQu
YyAgICBXZWQgTWF5IDE2IDE5OjIxOjQ1IDIwMDENCisrKyBsaW51eC0yLjQu
Ni9uZXQvaXB2NC9kZXZpbmV0LmMgICAgICBUaHUgQXVnICA5IDE2OjIwOjU3
IDIwMDENCkBAIC0xMDE2LDcgKzEwMTYsNyBAQA0KIHN0YXRpYyBzdHJ1Y3Qg
ZGV2aW5ldF9zeXNjdGxfdGFibGUNCiB7DQogICAgICAgIHN0cnVjdCBjdGxf
dGFibGVfaGVhZGVyICpzeXNjdGxfaGVhZGVyOw0KLSAgICAgICBjdGxfdGFi
bGUgZGV2aW5ldF92YXJzWzE0XTsNCisgICAgICAgY3RsX3RhYmxlIGRldmlu
ZXRfdmFyc1sxNV07DQogICAgICAgIGN0bF90YWJsZSBkZXZpbmV0X2Rldlsy
XTsNCiAgICAgICAgY3RsX3RhYmxlIGRldmluZXRfY29uZl9kaXJbMl07DQog
ICAgICAgIGN0bF90YWJsZSBkZXZpbmV0X3Byb3RvX2RpclsyXTsNCkBAIC0x
MDYyLDYgKzEwNjIsOSBAQA0KICAgICAgICB7TkVUX0lQVjRfQ09ORl9BUlBG
SUxURVIsICJhcnBfZmlsdGVyIiwNCiAgICAgICAgICZpcHY0X2RldmNvbmYu
YXJwX2ZpbHRlciwgc2l6ZW9mKGludCksIDA2NDQsIE5VTEwsDQogICAgICAg
ICAmcHJvY19kb2ludHZlY30sDQorICAgICAgICB7TkVUX0lQVjRfQ09ORl9B
UlBfU0VMRl9PTkxZLCAiYXJwX3NlbGZfb25seSIsDQorICAgICAgICAgJmlw
djRfZGV2Y29uZi5hcnBfc2VsZl9vbmx5LCBzaXplb2YoaW50KSwgMDY0NCwg
TlVMTCwNCisgICAgICAgICAmcHJvY19kb2ludHZlY30sDQogICAgICAgICB7
MH19LA0KDQogICAgICAgIHt7TkVUX1BST1RPX0NPTkZfQUxMLCAiYWxsIiwg
TlVMTCwgMCwgMDU1NSwgZGV2aW5ldF9zeXNjdGwuZGV2aW5ldF92YXJzfSx7
MH19LA0KDQo=
---1149134438-724443347-1019736548=:19036--
