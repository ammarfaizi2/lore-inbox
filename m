Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264277AbTDPJnt (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 05:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264279AbTDPJnt 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 05:43:49 -0400
Received: from dsl-170-219.dsl.cambrium.nl ([213.239.170.219]:677 "EHLO
	fratser") by vger.kernel.org with ESMTP id S264277AbTDPJnr 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 05:43:47 -0400
Date: Wed, 16 Apr 2003 11:55:51 +0200 (CEST)
From: John v/d Kamp <john@connectux.com>
X-X-Sender: john@fratser
To: linux-kernel@vger.kernel.org
Subject: [PATCH] DAC960_Release bug (2.4.x)
Message-ID: <Pine.LNX.4.53.0304161136270.18523@fratser>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-288770493-1050486951=:18523"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-288770493-1050486951=:18523
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

It seems the DAC960_Release function doesn't work correctly when
DAC960_Open is called with File->f_flags has O_NONBLOCK set. This causes
BLKRRPART to fail, as an unsigned int gets decreased below 0.
The File struct passed to DAC960_Release is NULL, so in Open the counters
aren't increased, but in Release they are decreased. I've added a simple
check that prevents the decrements if the counters are 0.

Allso, I've no idea why there are two counters. It seems that the
ControllerUsageCount is only used to increment and decrement.

--
John van der Kamp, ConnecTUX
--8323328-288770493-1050486951=:18523
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="dac960.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.53.0304161155510.18523@fratser>
Content-Description: 
Content-Disposition: attachment; filename="dac960.patch"

ZGlmZiAtdXIgbGludXgtMi40LjE5L2RyaXZlcnMvYmxvY2svREFDOTYwLmMg
cGF0Y2hlZC0yLjQuMTkvZHJpdmVycy9ibG9jay9EQUM5NjAuYw0KLS0tIGxp
bnV4LTIuNC4xOS9kcml2ZXJzL2Jsb2NrL0RBQzk2MC5jCTIwMDItMDktMTMg
MTc6NDE6MzAuMDAwMDAwMDAwICswMjAwDQorKysgcGF0Y2hlZC0yLjQuMTkv
ZHJpdmVycy9ibG9jay9EQUM5NjAuYwkyMDAzLTA0LTE2IDExOjA3OjE2LjAw
MDAwMDAwMCArMDIwMA0KQEAgLTUzOTgsOCArNTM5OCwxMCBAQA0KICAgLyoN
CiAgICAgRGVjcmVtZW50IHRoZSBMb2dpY2FsIERyaXZlIGFuZCBDb250cm9s
bGVyIFVzYWdlIENvdW50cy4NCiAgICovDQotICBDb250cm9sbGVyLT5Mb2dp
Y2FsRHJpdmVVc2FnZUNvdW50W0xvZ2ljYWxEcml2ZU51bWJlcl0tLTsNCi0g
IENvbnRyb2xsZXItPkNvbnRyb2xsZXJVc2FnZUNvdW50LS07DQorICBpZiAo
Q29udHJvbGxlci0+TG9naWNhbERyaXZlVXNhZ2VDb3VudFtMb2dpY2FsRHJp
dmVOdW1iZXJdID4gMCkNCisgICAgQ29udHJvbGxlci0+TG9naWNhbERyaXZl
VXNhZ2VDb3VudFtMb2dpY2FsRHJpdmVOdW1iZXJdLS07DQorICBpZiAoQ29u
dHJvbGxlci0+Q29udHJvbGxlclVzYWdlQ291bnQgPiAwKQ0KKyAgICBDb250
cm9sbGVyLT5Db250cm9sbGVyVXNhZ2VDb3VudC0tOw0KICAgcmV0dXJuIDA7
DQogfQ0K

--8323328-288770493-1050486951=:18523--
