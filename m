Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266913AbRGHQPF>; Sun, 8 Jul 2001 12:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266912AbRGHQOz>; Sun, 8 Jul 2001 12:14:55 -0400
Received: from eax.student.umd.edu ([129.2.236.2]:48656 "EHLO
	eax.student.umd.edu") by vger.kernel.org with ESMTP
	id <S266913AbRGHQOq>; Sun, 8 Jul 2001 12:14:46 -0400
Date: Sun, 8 Jul 2001 12:14:47 -0500 (EST)
From: Adam <adam@eax.com>
X-X-Sender: <adam@eax.student.umd.edu>
To: <linux-kernel@vger.kernel.org>
Subject: recvfrom and sockaddr_in.sin_port
Message-ID: <Pine.LNX.4.33.0107081155100.1430-200000@eax.student.umd.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="42009324-1390288157-994612487=:1430"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--42009324-1390288157-994612487=:1430
Content-Type: TEXT/PLAIN; charset=US-ASCII


hello,
	I'm using recvfrom, and upon return it should fill in
	from argument with sockaddr_in data structure. from
	ip(7) man page I get that it has format of :

        struct sockaddr_in {
             sa_family_t    sin_family; /* address family: AF_INET */
             u_int16_t      sin_port;   /* port in network byte order*/
             struct in_addr  sin_addr;  /* internet address */
        };

	for PF_INET type of socket. Now if I run the program the, data in
	the from field comes out as:

2  0  0  0  192  168  1  4  61  63  140  200  85  214  2

 |         |               |

AF_INET      :2
IP           :192.168.1.4

	and as show in above example and other repeated test, the port
	part is always set to 0. Shouldn't that be set to port number?

	on similar token the "padding" part after the IP is always set
	to the same pattern. Shouldn't it rather be zeroed, or be
	some random data?

	I have attached a simple program I used for generating those
	results.

-- 
Adam
http://www.eax.com      The Supreme Headquarters of the 32 bit registers


--42009324-1390288157-994612487=:1430
Content-Type: TEXT/x-csrc; name="test.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0107081214470.1430@eax.student.umd.edu>
Content-Description: 
Content-Disposition: attachment; filename="test.c"

I2luY2x1ZGUgPHN5cy90eXBlcy5oPg0KI2luY2x1ZGUgPHN5cy9zb2NrZXQu
aD4NCiNpbmNsdWRlIDxuZXRpbmV0L2luLmg+DQojaW5jbHVkZSA8bmV0ZGIu
aD4NCiNpbmNsdWRlIDxzdGRpby5oPg0KI2luY2x1ZGUgPGVycm5vLmg+DQoj
aW5jbHVkZSA8c3RyaW5nLmg+DQojaW5jbHVkZSA8c3RkbGliLmg+DQojaW5j
bHVkZSA8Y3R5cGUuaD4NCg0KaW50IG1haW4gKGludCBhcmdjLCBjaGFyICoq
YXJndikgew0KDQogIHNpemVfdCBidWZsZW4gPSAxMDI0Ow0KICBjaGFyIGJ1
ZltidWZsZW5dOw0KICBzdHJ1Y3Qgc29ja2FkZHJfaW4gZnJvbTsNCiAgc29j
a2xlbl90IGZyb21sZW4gPSBzaXplb2Yoc3RydWN0IHNvY2thZGRyX2luKTsN
CiAgaW50IGZsYWdzOw0KDQogIGludCByYXdzb2NrOw0KICBpbnQgYnl0ZXNy
ZWFkOw0KDQogIGludCBpOw0KICB1bnNpZ25lZCBjaGFyICogcHRyOw0KDQoN
CiAgcmF3c29jayA9IHNvY2tldChQRl9JTkVULFNPQ0tfUkFXLElQUFJPVE9f
VENQKTsNCg0KICBpZiAocmF3c29jayA9PSAtMSkNCiAgICBwZXJyb3IoInNv
Y2tldCgpOiIpOw0KDQogIGZsYWdzID0gIE1TR19XQUlUQUxMOw0KICBtZW1z
ZXQoJmZyb20sMCxmcm9tbGVuKTsNCg0KICBieXRlc3JlYWQgPSByZWN2ZnJv
bShyYXdzb2NrLCZidWYsYnVmbGVuLGZsYWdzLA0KCQkgICAgICAgKHN0cnVj
dCBzb2NrYWRkciopKCZmcm9tKSwmZnJvbWxlbik7DQoNCiAgcHRyID0gKHVu
c2lnbmVkIGNoYXIqKSZmcm9tOw0KICBmb3IoaT0wO2k8ZnJvbWxlbjtpKysp
IHsNCiAgICAgIHByaW50ZigiJWkgICIsKnB0cik7DQogICAgICBwdHIrKzsN
CiAgfQ0KICBwcmludGYoIlxuIik7DQoNCiAgaWYgKGJ5dGVzcmVhZCA9PSAt
MSkgew0KICAgIHByaW50ZigiZXJyICMgOiAlaSBcbiIsZXJybm8pOw0KICAg
IHBlcnJvcigicmVjdmZyb20oKToiKTsNCiAgICByZXR1cm4gLTE7DQogfQ0K
DQogDQogICAgaWYgKGFyZ2MgPT0yKSB7DQogICAgICBzdHJ1Y3QgaG9zdGVu
dCAqaG9zdDsNCg0KICAgICAgcHJpbnRmKCJtc2cgbGVuOiAlaSBcbiIsYnl0
ZXNyZWFkKTsNCiAgICAgIHByaW50ZigiZnJtIGxlbjogJWkgXG4iLGZyb21s
ZW4pOw0KICAgICAgcHJpbnRmKCJJUHY0IDogdHlwZTolaSBwb3J0OiVYIGFk
ZHI6JVggXG4iLCANCgkgICAgIGZyb20uc2luX2ZhbWlseSwNCgkgICAgIG50
b2hzKGZyb20uc2luX3BvcnQpLA0KCSAgICAgZnJvbS5zaW5fYWRkci5zX2Fk
ZHIpOw0KDQogICAgICBob3N0PWdldGhvc3RieWFkZHIoJihmcm9tLnNpbl9h
ZGRyLnNfYWRkciksDQoJCQkgZnJvbWxlbixmcm9tLnNpbl9mYW1pbHkpOw0K
DQogICAgICBpZiAoaG9zdCA9PSBOVUxMICkgew0KCXByaW50ZigiZXJyICMg
OiAlaSBcbiIsaF9lcnJubyk7DQoJaGVycm9yKCJnZXRob3N0YnlhZGRyKCk6
Iik7DQogICAgICB9DQoNCiAgICAgIHByaW50ZigiaG9zdDogKCIpOw0KDQog
ICAgICBwdHIgPSAodW5zaWduZWQgY2hhciopKCYoZnJvbS5zaW5fYWRkci5z
X2FkZHIpKTsNCiAgICAgIGZvcihpPTA7aTw0O2krKykgew0KCXByaW50Zigi
JWkiLCoocHRyKyspKTsNCglpZiAoaTwzKQ0KCSAgcHJpbnRmKCIuIik7DQog
ICAgICB9DQogICAgICANCiAgICAgIGlmIChob3N0ID09IE5VTEwpDQoJcHJp
bnRmKCIpIFxuIik7DQogICAgICBlbHNlDQoJcHJpbnRmKCIpICVzIFxuIixo
b3N0LT5oX25hbWUpOw0KDQoNCiAgICB9DQoNCg0KICByZXR1cm4gMDsNCg0K
fQ0K
--42009324-1390288157-994612487=:1430--
