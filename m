Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266003AbUHTTW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266003AbUHTTW5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 15:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268662AbUHTTW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 15:22:57 -0400
Received: from chaos.analogic.com ([204.178.40.224]:17541 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266003AbUHTTWx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 15:22:53 -0400
Date: Fri, 20 Aug 2004 15:22:09 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Andreas Dilger <adilger@clusterfs.com>
cc: Jean-Luc Cooke <jlcooke@certainkey.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       "David S. Miller" <davem@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Theodore Ts'o" <tytso@mit.edu>,
       netdev@oss.sgi.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] enhanced version of net_random()
In-Reply-To: <20040820185956.GV8967@schnapps.adilger.int>
Message-ID: <Pine.LNX.4.53.0408201518250.25319@chaos>
References: <20040812104835.3b179f5a@dell_ss3.pdx.osdl.net>
 <20040820175952.GI5806@certainkey.com> <20040820185956.GV8967@schnapps.adilger.int>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1678434306-395776424-1093029729=:25319"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1678434306-395776424-1093029729=:25319
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Fri, 20 Aug 2004, Andreas Dilger wrote:

> On Aug 20, 2004  13:59 -0400, Jean-Luc Cooke wrote:
> > Is there a reason why get_random_bytes() is unsuitable?
> >
> > Keeping the number of PRNGs in the kernel to a minimum should a goal we can
> > all share.
>
> For some uses a decent PRNG is enough, and the overhead of get_random_bytes()
> is much too high.  We've needed something like this for a long time (something
> that gives decenly uniform numbers) and hacks to use useconds/cycles/etc do
> not cut it.  I for one welcome a simple in-kernel interface to
> e.g. get_urandom_bytes() (or net_random() as this is maybe inappropriately
> called) that is only pseudo-random but fast and efficient.
>
> Cheers, Andreas
> --
> Andreas Dilger

The attached code will certainly work on Intel machines. It is
in the public domain, having been modified by myself to produce
a very long sequence...

I wouldn't suggest converting it to 'C' because the rotation
takes many CPU instructions when one tries to do the test, shift,
and OR in 'C',

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


--1678434306-395776424-1093029729=:25319
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="rnd.S"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.53.0408201522090.25319@chaos>
Content-Description: 
Content-Disposition: attachment; filename="rnd.S"

DQojLT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09
LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tDQojDQojICAgRmls
ZSBybmQuUyAgICAgICAgICAgIENyZWF0ZWQgMDQtRkVCLTE5OTkgICAgICAg
IFJpY2hhcmQgQi4gSm9obnNvbg0KIw0KIyAgIFNpbXBsZSByYW5kb20gbnVt
YmVyIGdlbmVyYXRvci4gQmFzZWQgdXBvbiBBbGFuIFIuIE1pbGxlcidzDQoj
ICAgYWxnb3JpdGhtLiBQcm9mZXNzb3Igb2YgTWV0YWxsdXJneSwgVW5pdmVy
c2l0eSBvZiBOZXcgTWV4aWNvDQojICAgSW5zdGl0dXRlIG9mIE1pbmluZyBh
bmQgVGVjaG5vbG9neSwgY2lyY2EgMTk4MC4gUHVibGlzaGVkDQojICAgSW4g
dGhlIDgwODAvWi04MCBBc3NlbWJseSBMYW5ndWFnZSBtYW51YWwgaGUgd3Jv
dGUuDQojDQojICAgdW5zaWduZWQgc2l6ZV90IHJuZCgoc2l6ZV90ICopIHNl
ZWQpOw0KIw0KIyAgIFRoZSBzZWVkIGNhbiBiZSBpbml0aWFsaXplZCB3aXRo
IHRpbWUoJnNlZWQpOyBvbiBlYWNoIGJvb3QuDQojDQoNCk1BR0lDICA9IDB4
NzJiNjA3OGIgDQpJTlRQVFIgPSAweDA4DQpESVZJU1IgPSAweDBjDQouc2Vj
dGlvbgkudGV4dA0KLmdsb2JhbAkJcm5kDQoudHlwZQkJcm5kLEBmdW5jdGlv
bg0KLmFsaWduCTB4MDQNCnJuZDoJcHVzaGwJJWVieA0KCW1vdmwJSU5UUFRS
KCVlc3ApLCAlZWJ4DQoJbW92bAkoJWVieCksICVlYXgNCglyb3JsCSQzLCAl
ZWF4DQoJYWRkbAkkTUFHSUMsICVlYXgNCgltb3ZsCSVlYXgsICglZWJ4KQ0K
CXBvcGwJJWVieA0KICAgICAgICByZXQNCg0KIy09LT0tPS09LT0tPS09LT0t
PS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09
LT0tPS09LT0tPS09LQ0KIw0KIwlUaGlzIHJldHVybnMgYSByYW5kb20gbnVt
YmVyIGJldHdlZW4gMCBhbmQgb25lIGxlc3MgdGhhbiB0aGUNCiMJaW5wdXQg
ZGl2aXNvciwgaS5lLiBuIG1vZCByYW5kKHgpLg0KIw0KIwlzaXplX3QgbW9k
cm5kKChzaXplX3QgKikgc2VlZCwgc2l6ZV90IGRpdmlzb3IpOw0KIw0KLnR5
cGUJbW9kcm5kLEBmdW5jdGlvbg0KLmdsb2JhbAltb2RybmQNCi5hbGlnbgkw
eDA0DQoNCm1vZHJuZDoJcHVzaGwJJWVieA0KCW1vdmwJSU5UUFRSKCVlc3Ap
LCAlZWJ4DQoJbW92bAkoJWVieCksICVlYXgNCglyb3JsCSQzLCAlZWF4DQoJ
YWRkbAkkTUFHSUMsICVlYXgNCgltb3ZsCSVlYXgsICglZWJ4KQ0KCXhvcmwJ
JWVkeCwgJWVkeA0KCWRpdmwJRElWSVNSKCVlc3ApDQoJbW92bAklZWR4LCAl
ZWF4DQoJcG9wbAklZWJ4DQogICAgICAgIHJldA0KLmVuZA0KIy09LT0tPS09
LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0t
PS09LT0tPS09LT0tPS09LT0tPS09LQ0KIy09LT0tPS09LT0tPS09LT0tPS09
LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0t
PS09LT0tPS09LQ0KIy09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09
LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LQ0K

--1678434306-395776424-1093029729=:25319--
