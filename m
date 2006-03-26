Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWCZSst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWCZSst (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 13:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWCZSst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 13:48:49 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:1723 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751099AbWCZSss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 13:48:48 -0500
Date: Sun, 26 Mar 2006 14:20:56 +0200 (CEST)
From: Jesper Dangaard Brouer <hawk@diku.dk>
To: Robert Olsson <Robert.Olsson@data.slu.se>
Cc: Jens Laas <jens.laas@data.slu.se>, Hans Liss <hans.liss@its.uu.se>,
       "David S. Miller" <davem@davemloft.net>,
       Stephen Hemminger <shemminger@osdl.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Patrick McHardy <kaber@trash.net>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: BUG in FIB trie v.0.404 kernel 2.6.16
In-Reply-To: <17446.27682.102290.341183@robur.slu.se>
Message-ID: <Pine.LNX.4.61.0603261415160.13351@ask.diku.dk>
References: <Pine.LNX.4.61.0603252254300.25755@ask.diku.dk>
 <17446.27682.102290.341183@robur.slu.se>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-511516320-2056589412-1143375656=:13351"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---511516320-2056589412-1143375656=:13351
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed



On Sun, 26 Mar 2006, Robert Olsson wrote:

> Jesper Dangaard Brouer writes:
>
> > BUG report for: FIB trie v.0.404
> > Kernel version: 2.6.16
> >
> > When booting the kernel, the following debug output is printed. I assume
> > its a bug in the FIB trie code, as it is printed right after the fib tree
> > code is activated, and some of the functions refer to the trie code.
>
> > Linux version 2.6.16-orig (hawk@host) (gcc version 3.3.4) #1 SMP PREEMPT Sat Mar 25 22:26:15 CET 2006
> > ...
> > IPv4 FIB: Using LC-trie version 0.404
> > Debug: sleeping function called from invalid context at mm/slab.c:2729
> > in_atomic():1, irqs_disabled():0
> >   [<c0103c4e>] show_trace+0x20/0x24
>
> Hello!
>
> I've have enabled debugging and was expecting to see this as well but I don't.
> I'll assume this disapears if you change GFP_KERNEL to GFP_ATOMIC for tnode
> and leaf allocations well replace throughout fib_trie.c
>
> Cheers.
> 					--ro

I solved the problem! :-)
Have attached a patch with the changes I made.

See you around!
   Jesper Brouer

--
-------------------------------------------------------------------
MSc. Master of Computer Science
Dept. of Computer Science, University of Copenhagen
-------------------------------------------------------------------
---511516320-2056589412-1143375656=:13351
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="fib_trie_GFP.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0603261420560.13351@ask.diku.dk>
Content-Description: fib_trie_GFP.patch
Content-Disposition: attachment; filename="fib_trie_GFP.patch"

LS0tIGxpbnV4LTIuNi4xNi1vcmlnL25ldC9pcHY0L2ZpYl90cmllLmMJMjAw
Ni0wMy0yMCAwNjo1MzoyOS4wMDAwMDAwMDAgKzAxMDANCisrKyBsaW51eC0y
LjYuMTYtdGVzdC9uZXQvaXB2NC9maWJfdHJpZS5jCTIwMDYtMDMtMjYgMTM6
MzY6MzEuMDAwMDAwMDAwICswMjAwDQpAQCAtNTAsNyArNTAsNyBAQA0KICAq
CQlQYXRyaWNrIE1jSGFyZHkgPGthYmVyQHRyYXNoLm5ldD4NCiAgKi8NCiAN
Ci0jZGVmaW5lIFZFUlNJT04gIjAuNDA0Ig0KKyNkZWZpbmUgVkVSU0lPTiAi
MC40MDUiDQogDQogI2luY2x1ZGUgPGxpbnV4L2NvbmZpZy5oPg0KICNpbmNs
dWRlIDxhc20vdWFjY2Vzcy5oPg0KQEAgLTMzNCw5ICszMzQsOSBAQCBzdGF0
aWMgc3RydWN0IHRub2RlICp0bm9kZV9hbGxvYyh1bnNpZ25lDQogCXN0cnVj
dCBwYWdlICpwYWdlczsNCiANCiAJaWYgKHNpemUgPD0gUEFHRV9TSVpFKQ0K
LQkJcmV0dXJuIGtjYWxsb2Moc2l6ZSwgMSwgR0ZQX0tFUk5FTCk7DQorCQly
ZXR1cm4ga2NhbGxvYyhzaXplLCAxLCBHRlBfQVRPTUlDKTsNCiANCi0JcGFn
ZXMgPSBhbGxvY19wYWdlcyhHRlBfS0VSTkVMfF9fR0ZQX1pFUk8sIGdldF9v
cmRlcihzaXplKSk7DQorCXBhZ2VzID0gYWxsb2NfcGFnZXMoR0ZQX0FUT01J
Q3xfX0dGUF9aRVJPLCBnZXRfb3JkZXIoc2l6ZSkpOw0KIAlpZiAoIXBhZ2Vz
KQ0KIAkJcmV0dXJuIE5VTEw7DQogDQpAQCAtMzYyLDcgKzM2Miw3IEBAIHN0
YXRpYyBpbmxpbmUgdm9pZCB0bm9kZV9mcmVlKHN0cnVjdCB0bm8NCiANCiBz
dGF0aWMgc3RydWN0IGxlYWYgKmxlYWZfbmV3KHZvaWQpDQogew0KLQlzdHJ1
Y3QgbGVhZiAqbCA9IGttYWxsb2Moc2l6ZW9mKHN0cnVjdCBsZWFmKSwgIEdG
UF9LRVJORUwpOw0KKwlzdHJ1Y3QgbGVhZiAqbCA9IGttYWxsb2Moc2l6ZW9m
KHN0cnVjdCBsZWFmKSwgIEdGUF9BVE9NSUMpOw0KIAlpZiAobCkgew0KIAkJ
bC0+cGFyZW50ID0gVF9MRUFGOw0KIAkJSU5JVF9ITElTVF9IRUFEKCZsLT5s
aXN0KTsNCkBAIC0zNzIsNyArMzcyLDcgQEAgc3RhdGljIHN0cnVjdCBsZWFm
ICpsZWFmX25ldyh2b2lkKQ0KIA0KIHN0YXRpYyBzdHJ1Y3QgbGVhZl9pbmZv
ICpsZWFmX2luZm9fbmV3KGludCBwbGVuKQ0KIHsNCi0Jc3RydWN0IGxlYWZf
aW5mbyAqbGkgPSBrbWFsbG9jKHNpemVvZihzdHJ1Y3QgbGVhZl9pbmZvKSwg
IEdGUF9LRVJORUwpOw0KKwlzdHJ1Y3QgbGVhZl9pbmZvICpsaSA9IGttYWxs
b2Moc2l6ZW9mKHN0cnVjdCBsZWFmX2luZm8pLCAgR0ZQX0FUT01JQyk7DQog
CWlmIChsaSkgew0KIAkJbGktPnBsZW4gPSBwbGVuOw0KIAkJSU5JVF9MSVNU
X0hFQUQoJmxpLT5mYWxoKTsNCkBAIC0xOTU5LDcgKzE5NTksNyBAQCBzdHJ1
Y3QgZmliX3RhYmxlICogX19pbml0IGZpYl9oYXNoX2luaXQoDQogCQkJCQkJ
ICBOVUxMLCBOVUxMKTsNCiANCiAJdGIgPSBrbWFsbG9jKHNpemVvZihzdHJ1
Y3QgZmliX3RhYmxlKSArIHNpemVvZihzdHJ1Y3QgdHJpZSksDQotCQkgICAg
IEdGUF9LRVJORUwpOw0KKwkJICAgICBHRlBfQVRPTUlDKTsNCiAJaWYgKHRi
ID09IE5VTEwpDQogCQlyZXR1cm4gTlVMTDsNCiANCkBAIC0yMTM3LDcgKzIx
MzcsNyBAQCBzdGF0aWMgaW50IGZpYl90cmllc3RhdF9zZXFfc2hvdyhzdHJ1
Y3QgDQogew0KIAlzdHJ1Y3QgdHJpZV9zdGF0ICpzdGF0Ow0KIA0KLQlzdGF0
ID0ga21hbGxvYyhzaXplb2YoKnN0YXQpLCBHRlBfS0VSTkVMKTsNCisJc3Rh
dCA9IGttYWxsb2Moc2l6ZW9mKCpzdGF0KSwgR0ZQX0FUT01JQyk7DQogCWlm
ICghc3RhdCkNCiAJCXJldHVybiAtRU5PTUVNOw0KIA0KQEAgLTIzMzYsNyAr
MjMzNiw3IEBAIHN0YXRpYyBpbnQgZmliX3RyaWVfc2VxX29wZW4oc3RydWN0
IGlub2QNCiB7DQogCXN0cnVjdCBzZXFfZmlsZSAqc2VxOw0KIAlpbnQgcmMg
PSAtRU5PTUVNOw0KLQlzdHJ1Y3QgZmliX3RyaWVfaXRlciAqcyA9IGttYWxs
b2Moc2l6ZW9mKCpzKSwgR0ZQX0tFUk5FTCk7DQorCXN0cnVjdCBmaWJfdHJp
ZV9pdGVyICpzID0ga21hbGxvYyhzaXplb2YoKnMpLCBHRlBfQVRPTUlDKTsN
CiANCiAJaWYgKCFzKQ0KIAkJZ290byBvdXQ7DQpAQCAtMjQ1Nyw3ICsyNDU3
LDcgQEAgc3RhdGljIGludCBmaWJfcm91dGVfc2VxX29wZW4oc3RydWN0IGlu
bw0KIHsNCiAJc3RydWN0IHNlcV9maWxlICpzZXE7DQogCWludCByYyA9IC1F
Tk9NRU07DQotCXN0cnVjdCBmaWJfdHJpZV9pdGVyICpzID0ga21hbGxvYyhz
aXplb2YoKnMpLCBHRlBfS0VSTkVMKTsNCisJc3RydWN0IGZpYl90cmllX2l0
ZXIgKnMgPSBrbWFsbG9jKHNpemVvZigqcyksIEdGUF9BVE9NSUMpOw0KIA0K
IAlpZiAoIXMpDQogCQlnb3RvIG91dDsNCg==

---511516320-2056589412-1143375656=:13351--
