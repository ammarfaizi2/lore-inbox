Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130855AbRARB6r>; Wed, 17 Jan 2001 20:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131657AbRARB6h>; Wed, 17 Jan 2001 20:58:37 -0500
Received: from argo.starforce.com ([216.158.56.82]:14022 "EHLO
	argo.starforce.com") by vger.kernel.org with ESMTP
	id <S130855AbRARB62>; Wed, 17 Jan 2001 20:58:28 -0500
Date: Wed, 17 Jan 2001 20:57:03 -0500 (EST)
From: Derek Wildstar <dwild@starforce.com>
To: <linux-kernel@vger.kernel.org>
Subject: (2.4.0->2.4.1-pre8) config problem with PCMCIA causing link error
Message-ID: <Pine.LNX.4.31.0101172039220.30790-200000@argo.starforce.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1629990344-305034261-979783023=:30790"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1629990344-305034261-979783023=:30790
Content-Type: TEXT/PLAIN; charset=US-ASCII

With 2.4.0 thru 2.4.1-pre8 (could possibly be sooner than 2.4.0)

PCMCIA_CONFIG_NETCARD is getting defined with CONFIG_PCMCIA, even when no
PCMCIA net cards are selected:


    458 # PCMCIA network device support
    459 #
    460 CONFIG_NET_PCMCIA=y
    461 # CONFIG_PCMCIA_NETCARD is not set

This causes the nonexistant drivers/net/pcmcia/pcmcia_net.o to try to be
linked.  It looks like this is hepenning because CONFIG_NET_PCMCIA is
defined, but then CONFIG_PCMCIA_NETCARD is defined elsewhere.

A patch is attached.

-dwild

---1629990344-305034261-979783023=:30790
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="pcmcia_config.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.31.0101172057030.30790@argo.starforce.com>
Content-Description: pcmcia_config.patch (against 2.4.1-pre8)
Content-Disposition: attachment; filename="pcmcia_config.patch"

LS0tIGxpbnV4LTIuNC4wL2RyaXZlcnMvbmV0L3BjbWNpYS9Db25maWcuaW4u
b3JpZwlXZWQgSmFuIDE3IDIwOjQ5OjI0IDIwMDENCisrKyBsaW51eC0yLjQu
MC9kcml2ZXJzL25ldC9wY21jaWEvQ29uZmlnLmluCVdlZCBKYW4gMTcgMjA6
NTE6MzcgMjAwMQ0KQEAgLTUsOCArNSw4IEBADQogbWFpbm1lbnVfb3B0aW9u
IG5leHRfY29tbWVudA0KIGNvbW1lbnQgJ1BDTUNJQSBuZXR3b3JrIGRldmlj
ZSBzdXBwb3J0Jw0KIA0KLWJvb2wgJ1BDTUNJQSBuZXR3b3JrIGRldmljZSBz
dXBwb3J0JyBDT05GSUdfTkVUX1BDTUNJQQ0KLWlmIFsgIiRDT05GSUdfTkVU
X1BDTUNJQSIgPSAieSIgXTsgdGhlbg0KK2Jvb2wgJ1BDTUNJQSBuZXR3b3Jr
IGRldmljZSBzdXBwb3J0JyBDT05GSUdfUENNQ0lBX05FVENBUkQNCitpZiBb
ICIkQ09ORklHX1BDTUNJQV9ORVRDQVJEIiA9ICJ5IiBdOyB0aGVuDQogICAg
ZGVwX3RyaXN0YXRlICcgIDNDb20gM2M1ODkgUENNQ0lBIHN1cHBvcnQnIENP
TkZJR19QQ01DSUFfM0M1ODkgJENPTkZJR19QQ01DSUENCiAgICBkZXBfdHJp
c3RhdGUgJyAgM0NvbSAzYzU3NCBQQ01DSUEgc3VwcG9ydCcgQ09ORklHX1BD
TUNJQV8zQzU3NCAkQ09ORklHX1BDTUNJQQ0KICAgIGRlcF90cmlzdGF0ZSAn
ICBGdWppdHN1IEZNVi1KMTh4IFBDTUNJQSBzdXBwb3J0JyBDT05GSUdfUENN
Q0lBX0ZNVkoxOFggJENPTkZJR19QQ01DSUENCkBAIC0zMSwxNCArMzEsNCBA
QA0KICAgICAgIGRlcF90cmlzdGF0ZSAnICAgIEFpcm9uZXQgNDUwMC80ODAw
IFBDTUNJQSBzdXBwb3J0JyBDT05GSUdfQUlST05FVDQ1MDBfQ1MgJENPTkZJ
R19BSVJPTkVUNDUwMCAkQ09ORklHX1BDTUNJQQ0KICAgIGZpDQogZmkNCi0N
Ci1pZiBbICIkQ09ORklHX1BDTUNJQV8zQzU4OSIgPSAieSIgLW8gIiRDT05G
SUdfUENNQ0lBXzNDNTc0IiA9ICJ5IiAtbyBcDQotICAgICAiJENPTkZJR19Q
Q01DSUFfRk1WSjE4WCIgPSAieSIgLW8gIiRDT05GSUdfUENNQ0lBX1BDTkVU
IiA9ICJ5IiAtbyBcDQotICAgICAiJENPTkZJR19QQ01DSUFfTk1DTEFOIiA9
ICJ5IiAtbyAiJENPTkZJR19QQ01DSUFfU01DOTFDOTIiID0gInkiIC1vIFwN
Ci0gICAgICIkQ09ORklHX1BDTUNJQV9YSVJDMlBTIiA9ICJ5IiAtbyAiJENP
TkZJR19QQ01DSUFfUkFZQ1MiID0gInkiIC1vIFwNCi0gICAgICIkQ09ORklH
X1BDTUNJQV9ORVRXQVZFIiA9ICJ5IiAtbyAiJENPTkZJR19QQ01DSUFfV0FW
RUxBTiIgPSAieSIgLW8gXA0KLSAgICAgIiRDT05GSUdfUENNQ0lBX1hJUlRV
TElQIiA9ICJ5IiBdOyB0aGVuDQotICAgZGVmaW5lX2Jvb2wgQ09ORklHX1BD
TUNJQV9ORVRDQVJEIHkNCi1maQ0KLQ0KIGVuZG1lbnUNCg==
---1629990344-305034261-979783023=:30790--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
