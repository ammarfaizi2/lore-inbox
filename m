Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262954AbVDHUy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbVDHUy6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 16:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbVDHUy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 16:54:58 -0400
Received: from alog0213.analogic.com ([208.224.220.228]:64226 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262954AbVDHUyu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 16:54:50 -0400
Date: Fri, 8 Apr 2005 16:54:07 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Jan Harkes <jaharkes@cs.cmu.edu>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.11 can't disable CAD
In-Reply-To: <Pine.LNX.4.61.0504080822150.8739@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0504081647260.6253@chaos.analogic.com>
References: <Pine.LNX.4.61.0504071102590.4871@chaos.analogic.com>
 <20050407202059.GA414@delft.aura.cs.cmu.edu> <Pine.LNX.4.61.0504071639060.4895@chaos.analogic.com>
 <20050407210144.GA8181@delft.aura.cs.cmu.edu> <Pine.LNX.4.61.0504080822150.8739@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1879706418-102673905-1112993647=:6253"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1879706418-102673905-1112993647=:6253
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed


It wasn't the kernel.

Many thanks to those who helped me track down this problem.
It seems that the 'C' runtime library was trapping the call
to reboot() which probably should have been _reboot() in
earlier code to prevent this. Anyway, the fix is to call
the kernel directly so it doesn't get blamed for something
it didn't do.

Simple external procedure is attached if anybody else is
interested. It ends up being only 0x30 bytes in length.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
--1879706418-102673905-1112993647=:6253
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="disable.S"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0504081654070.6253@chaos.analogic.com>
Content-Description: 
Content-Disposition: attachment; filename="disable.S"

Iy09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09
LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0NCiMNCiMgIENvcHly
aWdodChjKSAgMjAwNSAgQW5hbG9naWMgQ29ycG9yYXRpb24NCiMNCiMgIFRo
aXMgcHJvZ3JhbSBtYXkgYmUgZGlzdHJpYnV0ZWQgdW5kZXIgdGhlIEdOVSBQ
dWJsaWMgTGljZW5zZQ0KIyAgdmVyc2lvbiAyLCBhcyBwdWJsaXNoZWQgYnkg
dGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiwgSW5jLiwNCiMgIDU5IFRl
bXBsZSBQbGFjZSwgU3VpdGUgMzMwIEJvc3RvbiwgTUEsIDAyMTExLg0KIw0K
Iy09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09
LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0NCiMNCiMgICBEaXNh
YmxlIEN0bC1BbHQtRGVsDQojICAgVGVzdCBlbnZpcm9ubWVudCAnQycgcnVu
dGltZSBsaWJyYXJpZXMgYXJlIHNjcmV3aW5nIHdpdGgNCiMgICB0aGlzIHNv
IEkgaGF2ZSB0byBjYWxsIHRoZSBrZXJuZWwgZGlyZWN0bHkuIFRoaXMgaXMg
bm93DQojICAgaGFuZGxlZCBpbiBhc3NlbWJseS4NCiMNCiMtPS09LT0tPS09
LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0t
PS09LT0tPS09LT0tPS09LT0tPS09DQoNCi5leHRlcm4JX19zZXRfZXJybm8N
Ci5MUkVCT09UID0gODgNCi5MTUFHSUMxID0gMHhmZWUxZGVhZA0KLkxNQUdJ
QzIgPSA2NzIyNzQ3OTMNCi5MQ0FET0ZGID0gMHgwMDAwMDAwMA0KDQpkaXNh
YmxlX3NodXRkb3duOg0KCXB1c2hsCSVlYngJCSMgU2F2ZSBwcmVjaW91cyBy
ZWdpc3RlcnMNCglwdXNobAklZXNpDQoJbW92bAkkLkxSRUJPT1QsICVlYXgJ
IyBSZWJvb3QgY29tbWFuZA0KCW1vdmwJJC5MTUFHSUMxLCAlZWJ4CSMgRmly
c3QgbWFnaWMgcGFyYW1ldGVyDQoJbW92bAkkLkxNQUdJQzIsICVlY3gJIyBT
ZWNvbmQgbWFnaWMgcGFyYW1ldGVyDQoJbW92bAkkLkxDQURPRkYsICVlZHgJ
IyBDb21tYW5kDQoJeG9ybAklZXNpLCAlZXNpCSMgWmVybyBpZ25vcmVkIHBv
aW50ZXINCglpbnQJJDB4ODAJCSMgTWFrZSB0aGUgY2FsbA0KCXBvcGwJJWVz
aQkJIyBSZXN0b3JlIHByZWNpb3VzIHJlZ2lzdGVycw0KCXBvcGwJJWVieA0K
CW9ybAklZWF4LCVlYXgJIyBDaGVjayByZXR1cm4gdmFsdWUNCglqbnMJMWYJ
CSMgSXQncyBva2F5DQoJbmVnbAklZWF4CQkjIE1ha2UgcG9zaXRpdmUNCglw
dXNobAklZWF4DQoJY2FsbAlfX3NldF9lcnJubwkjIFNldCBuZXcgZXJybm8N
CglhZGRsCSQweDA0LCAlZXNwCSMgTGV2ZWwgc3RhY2sNCgltb3ZsCSQtMSwg
JWVheA0KMToJcmV0DQoNCi5zaXplCWRpc2FibGVfc2h1dGRvd24sLi1kaXNh
YmxlX3NodXRkb3duDQoudHlwZQlkaXNhYmxlX3NodXRkb3duLEBmdW5jdGlv
bg0KLmdsb2JhbAlkaXNhYmxlX3NodXRkb3duDQojLT0tPS09LT0tPS09LT0t
PS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09
LT0tPS09LT0tPS09LT0tPQ0KLmVuZA0KDQo=

--1879706418-102673905-1112993647=:6253--
