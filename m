Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbUDFMzq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 08:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263803AbUDFMzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 08:55:46 -0400
Received: from mail1.slu.se ([130.238.96.11]:21405 "EHLO mail1.slu.se")
	by vger.kernel.org with ESMTP id S263800AbUDFMzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 08:55:41 -0400
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5cX1WWKSdC"
Content-Transfer-Encoding: 7bit
Message-ID: <16498.43191.733850.18276@robur.slu.se>
Date: Tue, 6 Apr 2004 14:55:19 +0200
To: dipankar@in.ibm.com
Cc: Robert Olsson <Robert.Olsson@data.slu.se>,
       Andrea Arcangeli <andrea@suse.de>, "David S. Miller" <davem@redhat.com>,
       kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       paulmck@us.ibm.com, akpm@osdl.org
Subject: Re: route cache DoS testing and softirqs
In-Reply-To: <20040405212220.GH4003@in.ibm.com>
References: <200403302005.AAA00466@yakov.inr.ac.ru>
	<20040330211450.GI3808@dualathlon.random>
	<20040330133000.098761e2.davem@redhat.com>
	<20040330213742.GL3808@dualathlon.random>
	<20040331171023.GA4543@in.ibm.com>
	<16491.4593.718724.277551@robur.slu.se>
	<20040331203750.GB4543@in.ibm.com>
	<20040331212817.GQ2143@dualathlon.random>
	<20040331214342.GD4543@in.ibm.com>
	<16497.37720.607342.193544@robur.slu.se>
	<20040405212220.GH4003@in.ibm.com>
X-Mailer: VM 7.17 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5cX1WWKSdC
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit


Dipankar Sarma writes:

 > Looks better atleast. Can you apply the following patch (rs-throttle-rcu)
 > on top of rcu-softirq.patch in your tree and see if helps a little bit more ?
 > Please make sure to set the kernel paramenters rcupdate.maxbatch to 4
 > and rcupdate.plugticks to 0. You can make sure of those parameters
 > by looking at dmesg (rcu prints them out during boot). I just merged
 > it, but have not tested this patch yet.

OK!

Well not tested yet but I don't think we will get rid overflow totally in my 
setup. I've done a little experimental patch so *all* softirq's are run via 
ksoftirqd. 
 
 total    droppped tsquz    throttl  bh_enbl  ksoftird irqexit  other  
009bee0c 00000000 00004aa7 00000000 00000000 0336a637 00000078 00000000
0054d381 00000000 00004ca0 00000000 00000000 032f8e48 00000000 00000000

I still see dst overflows. But the priority of the ksoftird's can now control 
the user apps behavior even during softirq DoS.


--5cX1WWKSdC
Content-Type: application/octet-stream
Content-Disposition: attachment;
	filename="softirq_limit-040405.pat"
Content-Transfer-Encoding: base64

LS0tIGtlcm5lbC9zb2Z0aXJxLmMub3JpZwkyMDA0LTAzLTExIDAzOjU1OjI0LjAwMDAwMDAwMCAr
MDEwMAorKysga2VybmVsL3NvZnRpcnEuYwkyMDA0LTA0LTA1IDEyOjUyOjQwLjAwMDAwMDAwMCAr
MDIwMApAQCAtNTgsNiArNTgsMTQgQEAKIAkJd2FrZV91cF9wcm9jZXNzKHRzayk7CiB9CiAKK3N0
YXRpYyBpbmxpbmUgaW50IGNhbl9ydW5fa3NvZnRpcnFkKHZvaWQpCit7CisgICAgICAgLyogSW50
ZXJydXB0cyBhcmUgZGlzYWJsZWQ6IG5vIG5lZWQgdG8gc3RvcCBwcmVlbXB0aW9uICovCisgICAg
ICAgc3RydWN0IHRhc2tfc3RydWN0ICp0c2sgPSBfX2dldF9jcHVfdmFyKGtzb2Z0aXJxZCk7CisK
KyAgICAgICByZXR1cm4gdHNrICYmICEodHNrLT5zdGF0ZSAmICAoVEFTS19ERUFEIHwgVEFTS19a
T01CSUUpKTsKK30KKwogLyoKICAqIFdlIHJlc3RhcnQgc29mdGlycSBwcm9jZXNzaW5nIE1BWF9T
T0ZUSVJRX1JFU1RBUlQgdGltZXMsCiAgKiBhbmQgd2UgZmFsbCBiYWNrIHRvIHNvZnRpcnFkIGFm
dGVyIHRoYXQuCkBAIC02OSw3ICs3Nyw3IEBACiAgKi8KICNkZWZpbmUgTUFYX1NPRlRJUlFfUkVT
VEFSVCAxMAogCi1hc21saW5rYWdlIHZvaWQgZG9fc29mdGlycSh2b2lkKQorYXNtbGlua2FnZSB2
b2lkIF9fZG9fc29mdGlycShpbnQgZnJvbV9rc29mdGlycWQpCiB7CiAJaW50IG1heF9yZXN0YXJ0
ID0gTUFYX1NPRlRJUlFfUkVTVEFSVDsKIAlfX3UzMiBwZW5kaW5nOwpAQCAtODYsNiArOTQsOSBA
QAogCQlzdHJ1Y3Qgc29mdGlycV9hY3Rpb24gKmg7CiAKIAkJbG9jYWxfYmhfZGlzYWJsZSgpOwor
CisJCWlmIChmcm9tX2tzb2Z0aXJxZCAmJiBjYW5fcnVuX2tzb2Z0aXJxZCgpKQorCQkJICAgICBn
b3RvIGRvbmU7CiByZXN0YXJ0OgogCQkvKiBSZXNldCB0aGUgcGVuZGluZyBiaXRtYXNrIGJlZm9y
ZSBlbmFibGluZyBpcnFzICovCiAJCWxvY2FsX3NvZnRpcnFfcGVuZGluZygpID0gMDsKQEAgLTEw
Niw2ICsxMTcsNyBAQAogCQlwZW5kaW5nID0gbG9jYWxfc29mdGlycV9wZW5kaW5nKCk7CiAJCWlm
IChwZW5kaW5nICYmIC0tbWF4X3Jlc3RhcnQpCiAJCQlnb3RvIHJlc3RhcnQ7Citkb25lOgogCQlp
ZiAocGVuZGluZykKIAkJCXdha2V1cF9zb2Z0aXJxZCgpOwogCQlfX2xvY2FsX2JoX2VuYWJsZSgp
OwpAQCAtMTE0LDYgKzEyNiwxMSBAQAogCWxvY2FsX2lycV9yZXN0b3JlKGZsYWdzKTsKIH0KIAor
YXNtbGlua2FnZSB2b2lkIGRvX3NvZnRpcnEodm9pZCkgCit7CisJX19kb19zb2Z0aXJxKDApOwkK
K30KKwogRVhQT1JUX1NZTUJPTChkb19zb2Z0aXJxKTsKIAogdm9pZCBsb2NhbF9iaF9lbmFibGUo
dm9pZCkKQEAgLTMyNCw3ICszNDEsNyBAQAogCQlfX3NldF9jdXJyZW50X3N0YXRlKFRBU0tfUlVO
TklORyk7CiAKIAkJd2hpbGUgKGxvY2FsX3NvZnRpcnFfcGVuZGluZygpKSB7Ci0JCQlkb19zb2Z0
aXJxKCk7CisJCQlfX2RvX3NvZnRpcnEoMSk7CQogCQkJY29uZF9yZXNjaGVkKCk7CiAJCX0KIAo=
--5cX1WWKSdC
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit



Cheers.
					--ro
--5cX1WWKSdC--
