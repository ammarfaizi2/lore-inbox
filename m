Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbSLaKAz>; Tue, 31 Dec 2002 05:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261317AbSLaKAy>; Tue, 31 Dec 2002 05:00:54 -0500
Received: from [212.143.73.102] ([212.143.73.102]:18279 "EHLO
	hawk.exanet-il.co.il") by vger.kernel.org with ESMTP
	id <S261295AbSLaKAx> convert rfc822-to-8bit; Tue, 31 Dec 2002 05:00:53 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
content-class: urn:content-classes:message
Subject: A loopback route is spontaneously added with hidden arp patch?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Tue, 31 Dec 2002 12:08:27 +0200
Message-ID: <4913AB320D31DC4798D6FEF5F557351F1597DA@hawk.exanet-il.co.il>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: A loopback route is spontaneously added with hidden arp patch?
Thread-Index: AcKwtI++YDHmWM/0QdiN2yS675aNLQ==
From: "Nir Soffer" <nirs@exanet.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Yuval Yeret" <yuval@exanet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

I'm running 2.4.18-14 in a heavy network environment. The machine itself
is a dual CPU P3 (though I've seen the same thing on  other platforms
with different kernels). The kernel itself is patched with the hidden
arp patches and is running a proprietary IP load balancing module (from
www.ipmetrics.com ).

I've seen several times where the routing table has become corrupted in
such a way so all connections to 10.0.0.0 go to the loopback.

The output of ip route ls table all is:
local 10.0.18.230 dev lo  table local  proto kernel  scope host  src
10.0.18.230 
broadcast 127.255.255.255 dev lo  table local  proto kernel  scope link
src 127.0.0.1 
local 10.48.0.3 dev eth1  table local  proto kernel  scope host  src
10.48.0.3 
local 10.0.18.210 dev lo  table local  proto kernel  scope host  src
10.0.18.210 
local 10.16.0.3 dev eth0  table local  proto kernel  scope host  src
10.16.0.3 
local 10.0.18.220 dev lo  table local  proto kernel  scope host  src
10.0.18.220 
local 10.0.18.12 dev eth3  table local  proto kernel  scope host  src
10.0.18.12 
broadcast 127.0.0.0 dev lo  table local  proto kernel  scope link  src
127.0.0.1 
local 127.0.0.1 dev lo  table local  proto kernel  scope host  src
127.0.0.1 
local 10.0.0.0/8 dev lo  table local  proto kernel  scope host  src
10.0.18.210 
^^^^^^^^^^^
local 127.0.0.0/8 dev lo  table local  proto kernel  scope host  src
127.0.0.1 

As you can see, the second to last line is a route table entry that
routes everything to 10.0.0.0/8 to the loopback addr.

10.0.18.210 is an IP alias configured on the loopback interface, for use
with the hidden arp patch.

Has anyone ever encountered such a situtation, or does anyone have any
hints how we can solve this?

Thanks!
Nir.


--
Nir Soffer -=- Software Engineer, Exanet Inc. -=-
"The poor little kittens; They lost their mittens;
 And now you all must die. Mew, Mew, Mew, Mew, 
 And now you all must die." www.sluggy.com, 24/10/02
