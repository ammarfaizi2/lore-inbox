Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbTFVVk4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 17:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265932AbTFVVk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 17:40:56 -0400
Received: from p68.rivermarket.wintek.com ([208.13.56.68]:30337 "EHLO
	dust.p68.rivermarket.wintek.com") by vger.kernel.org with ESMTP
	id S264147AbTFVVky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 17:40:54 -0400
Date: Sun, 22 Jun 2003 16:58:19 -0500 (EST)
From: Alex Goddard <agoddard@purdue.edu>
To: Florin Iucha <florin@iucha.net>
Cc: Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.73
In-Reply-To: <Pine.LNX.4.56.0306221615230.11747@dust>
Message-ID: <Pine.LNX.4.56.0306221651470.16614@dust.p68.rivermarket.wintek.com>
References: <Pine.LNX.4.44.0306221150440.17823-100000@old-penguin.transmeta.com>
 <20030622204607.GA16386@iucha.net> <Pine.LNX.4.56.0306221615230.11747@dust>
X-GPG-PUBLIC_KEY: N/a
X-GPG-FINGERPRINT: BCBC 0868 DB78 22F3 A657 785D 6E3B 7ACB 584E B835
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463779740-441031664-1056319099=:16614"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463779740-441031664-1056319099=:16614
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Sun, 22 Jun 2003, Alex Goddard wrote:

> On Sun, 22 Jun 2003, Florin Iucha wrote:
> 
> > drivers/built-in.o(.text+0x3106): In function `pci_remove_bus_device':
> > : undefined reference to `pci_destroy_dev'
> > 
> > pci_destroy_dev is defined under CONFIG_HOTPLUG and used outside.
> > 
> > florin
> > 
> > PS: I think changeset referenced in 10560659712069@kroah.com
> > causes the problem.
> 
> An attempt at a fix.  It just moves pci_desroy_dev outside the #ifdef).  
> I have no idea if this is the correct way to fix this.  It compiles okay.

Ack.  Dumb-assed mistake in that one.  This one shouldn't die during
compile if CONFIG_HOTPLUG is turned on.  The other one defined 
pci_destroy_dev() twice because I'm dumb.

It does compile (with and without hotplug) and boot.

-- 
Alex Goddard
agoddard@purdue.edu
---1463779740-441031664-1056319099=:16614
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="hotplug.c.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.56.0306221658190.16614@dust.p68.rivermarket.wintek.com>
Content-Description: 
Content-Disposition: attachment; filename="hotplug.c.patch"

LS0tIGhvdHBsdWcuYy5vcmlnCTIwMDMtMDYtMjIgMTY6MDA6MjUuMDAwMDAw
MDAwIC0wNTAwDQorKysgaG90cGx1Zy5jCTIwMDMtMDYtMjIgMTY6NTQ6MzMu
MDAwMDAwMDAwIC0wNTAwDQpAQCAtMTEsNiArMTEsNyBAQA0KICNlbmRpZg0K
IA0KIHN0YXRpYyB2b2lkIHBjaV9mcmVlX3Jlc291cmNlcyhzdHJ1Y3QgcGNp
X2RldiAqZGV2KTsNCitzdGF0aWMgdm9pZCBwY2lfZGVzdHJveV9kZXYoc3Ry
dWN0IHBjaV9kZXYgKmRldik7DQogDQogI2lmZGVmIENPTkZJR19IT1RQTFVH
DQogaW50IHBjaV9ob3RwbHVnIChzdHJ1Y3QgZGV2aWNlICpkZXYsIGNoYXIg
KiplbnZwLCBpbnQgbnVtX2VudnAsDQpAQCAtMTczLDI0ICsxNzQsNiBAQCBp
bnQgcGNpX3Zpc2l0X2RldiAoc3RydWN0IHBjaV92aXNpdCAqZm4sDQogfQ0K
IEVYUE9SVF9TWU1CT0wocGNpX3Zpc2l0X2Rldik7DQogDQotc3RhdGljIHZv
aWQgcGNpX2Rlc3Ryb3lfZGV2KHN0cnVjdCBwY2lfZGV2ICpkZXYpDQotew0K
LQlwY2lfcHJvY19kZXRhY2hfZGV2aWNlKGRldik7DQotCWRldmljZV91bnJl
Z2lzdGVyKCZkZXYtPmRldik7DQotDQotCS8qIFJlbW92ZSB0aGUgZGV2aWNl
IGZyb20gdGhlIGRldmljZSBsaXN0cywgYW5kIHByZXZlbnQgYW55IGZ1cnRo
ZXINCi0JICogbGlzdCBhY2Nlc3NlcyBmcm9tIHRoaXMgZGV2aWNlICovDQot
CXNwaW5fbG9jaygmcGNpX2J1c19sb2NrKTsNCi0JbGlzdF9kZWwoJmRldi0+
YnVzX2xpc3QpOw0KLQlsaXN0X2RlbCgmZGV2LT5nbG9iYWxfbGlzdCk7DQot
CWRldi0+YnVzX2xpc3QubmV4dCA9IGRldi0+YnVzX2xpc3QucHJldiA9IE5V
TEw7DQotCWRldi0+Z2xvYmFsX2xpc3QubmV4dCA9IGRldi0+Z2xvYmFsX2xp
c3QucHJldiA9IE5VTEw7DQotCXNwaW5fdW5sb2NrKCZwY2lfYnVzX2xvY2sp
Ow0KLQ0KLQlwY2lfZnJlZV9yZXNvdXJjZXMoZGV2KTsNCi0JcGNpX2Rldl9w
dXQoZGV2KTsNCi19DQotDQogLyoqDQogICogcGNpX3JlbW92ZV9kZXZpY2Vf
c2FmZSAtIHJlbW92ZSBhbiB1bnVzZWQgaG90cGx1ZyBkZXZpY2UNCiAgKiBA
ZGV2OiB0aGUgZGV2aWNlIHRvIHJlbW92ZQ0KQEAgLTIxOSw2ICsyMDIsMjQg
QEAgaW50IHBjaV9ob3RwbHVnIChzdHJ1Y3QgZGV2aWNlICpkZXYsIGNoYQ0K
IA0KICNlbmRpZiAvKiBDT05GSUdfSE9UUExVRyAqLw0KIA0KK3N0YXRpYyB2
b2lkIHBjaV9kZXN0cm95X2RldihzdHJ1Y3QgcGNpX2RldiAqZGV2KQ0KK3sN
CisJcGNpX3Byb2NfZGV0YWNoX2RldmljZShkZXYpOw0KKwlkZXZpY2VfdW5y
ZWdpc3RlcigmZGV2LT5kZXYpOw0KKw0KKwkvKiBSZW1vdmUgdGhlIGRldmlj
ZSBmcm9tIHRoZSBkZXZpY2UgbGlzdHMsIGFuZCBwcmV2ZW50IGFueSBmdXJ0
aGVyDQorCSAqIGxpc3QgYWNjZXNzZXMgZnJvbSB0aGlzIGRldmljZSAqLw0K
KwlzcGluX2xvY2soJnBjaV9idXNfbG9jayk7DQorCWxpc3RfZGVsKCZkZXYt
PmJ1c19saXN0KTsNCisJbGlzdF9kZWwoJmRldi0+Z2xvYmFsX2xpc3QpOw0K
KwlkZXYtPmJ1c19saXN0Lm5leHQgPSBkZXYtPmJ1c19saXN0LnByZXYgPSBO
VUxMOw0KKwlkZXYtPmdsb2JhbF9saXN0Lm5leHQgPSBkZXYtPmdsb2JhbF9s
aXN0LnByZXYgPSBOVUxMOw0KKwlzcGluX3VubG9jaygmcGNpX2J1c19sb2Nr
KTsNCisNCisJcGNpX2ZyZWVfcmVzb3VyY2VzKGRldik7DQorCXBjaV9kZXZf
cHV0KGRldik7DQorfQ0KKw0KIHN0YXRpYyB2b2lkDQogcGNpX2ZyZWVfcmVz
b3VyY2VzKHN0cnVjdCBwY2lfZGV2ICpkZXYpDQogew0K

---1463779740-441031664-1056319099=:16614--
