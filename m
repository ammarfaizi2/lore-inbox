Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135201AbRDRPIV>; Wed, 18 Apr 2001 11:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135203AbRDRPIK>; Wed, 18 Apr 2001 11:08:10 -0400
Received: from [194.8.76.131] ([194.8.76.131]:63493 "HELO imap.camline.com")
	by vger.kernel.org with SMTP id <S135201AbRDRPIG>;
	Wed, 18 Apr 2001 11:08:06 -0400
Date: Wed, 18 Apr 2001 17:09:28 +0200 (CEST)
From: Matthias Hanisch <matze@camline.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [SCRIPT] Get potential __init functions from the kernel image
Message-ID: <Pine.LNX.4.10.10104181640380.10072-200000@homer.camline.com>
Organization: camLine Datensysteme fuer die Mikroelektronik
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463781119-1517877688-987606568=:10072"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463781119-1517877688-987606568=:10072
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi!

I got bored over Easter and wrote this little script to get all users of a
function using objdump on a vmlinux image.

"users" are functions that do ordinary calls to that function,
EXPORT_SYMBOL declarations, functions which get called by initcall and
setup functions.

Moreover a special character is prepended to each function - either if it
is a function in the .text.init segment or a normal .text function.

What is the benefit of this script?

I think there are a lot of benefits but I used it to get functions which
are not in the .text.init segment but should be moved to because the only
users of this function are initfuncs themselves.

To get a view of this invoke the script using

$ ./create_user_map <vmlinux image>

It creates a file user_map which contains the results. Additionally the
list of _potential_ __init functions in this image is displayed.

Why potential?

The primary reason is, that the information is taken from an image. Maybe
there are other callers of this function which are not compiled in. But
this can be verified easily using a find-xargs-grep combo on the kernel
source tree.

First results of this are already in the ac-tree, namely some aha1542_*
functions and rand_initialize().

I also sent another bunch of functions to Alan which are not included in
any tree yet, namely mcheck_init(), init_irq_proc(),
start_context_thread() and init_timervecs().

The other reason for _potential_ is, that there are function which use
exceptions and thus they cannot get into the .init section, namely
do_test_wp_bit().

I just wanted to provide this script to the community to encourage
everyone to run this on his latest image. Doing this, we can finally get
all functions which could be trown away after the initialization phase and
shrink the size of unswappable kernel memory.

Comments?

Have fun,

	Matze

P.S.: Maybe there are other interesting things to look at. E.g. all functions
      which are only exported using EXPORT_SYMBOL but only used in rare
      configurations. In this case, we could add a config option which
      disables this EXPORT_SYMBOL declarations and the linker would throw
      them away automatically.

-- 
Matthias Hanisch    mailto:matze@camline.com    phone: +49 8137 935-219

---1463781119-1517877688-987606568=:10072
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=create_user_map
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.10.10104181709280.10072@homer.camline.com>
Content-Description: 
Content-Disposition: attachment; filename=create_user_map

IyEvYmluL3NoDQoNCmlmIFsgJCMgLWx0IDEgXTsgdGhlbg0KCWVjaG8gIlVz
YWdlOiAkMCA8dm1saW51eC1pbWFnZT4iDQoJZXhpdCAxDQpmaQ0KDQppbWFn
ZT0kMQ0KDQppZiBbICEgLXIgJGltYWdlIF07IHRoZW4NCgllY2hvICJJbWFn
ZSAkaW1hZ2Ugbm90IHJlYWRhYmxlIg0KCWV4aXQgMQ0KZmkNCg0Kb2JqZHVt
cCAtaEQgJGltYWdlIHwgYXdrICcNCkJFR0lOIHsNCglpbml0X3N0YXJ0PSJm
ZmZmZmZmZiINCglpbml0X2VuZD0iZmZmZmZmZmYiDQp9DQoNCi8gLnRleHQu
aW5pdC8gew0KCSMNCgkjIEdldCB0aGUgc3RhcnQgYWRkcmVzcyBvZiBpbml0
IHNlY3Rpb24gb2Ygc2VjdGlvbiBoZWFkZXIgaW5mb3JtYXRpb24NCgkjDQoN
CglpZiAoaW5pdF9zdGFydCA9PSAiZmZmZmZmZmYiKSB7DQoJCWluaXRfc3Rh
cnQ9JDQNCgkJcHJpbnRmKCJTdGFydCBvZiBpbml0IHNlY3Rpb246ICVzXG4i
LCBpbml0X3N0YXJ0KSA+PiAiL2Rldi90dHkiDQoJfQ0KfQ0KDQoNCi8gLmRh
dGEucGFnZV9hbGlnbmVkLyB7DQoJIw0KCSMgR2V0IHRoZSBlbmQgYWRkcmVz
cyBvZiBpbml0IHNlY3Rpb24gb2Ygc2VjdGlvbiBoZWFkZXIgaW5mb3JtYXRp
b24NCgkjDQoNCglpZiAoaW5pdF9lbmQgPT0gImZmZmZmZmZmIikgew0KCQlp
bml0X2VuZD0kNA0KCQlwcmludGYoIkVuZCBvZiBpbml0IHNlY3Rpb246ICVz
XG4iLCBpbml0X2VuZCkgPj4gIi9kZXYvdHR5Ig0KCX0NCn0NCg0KLz46JC8g
ew0KCSMNCgkjIFN0YXJ0IG9mIGEgZnVuY3Rpb24NCgkjDQoNCgljdXJyZW50
X2Z1bmMgPSAkMg0KCWdzdWIoIls8PjpdIiwgIiIsIGN1cnJlbnRfZnVuYykN
Cglpbl9hZGRyZXNzID0gJDENCg0KCWlmIChpbl9hZGRyZXNzID49IGluaXRf
c3RhcnQgJiYgaW5fYWRkcmVzcyA8IGluaXRfZW5kKQ0KCQlmdW5jdGlvbl9w
cmVmaXggPSAiQCI7DQoJZWxzZQ0KCQlmdW5jdGlvbl9wcmVmaXggPSAiJiI7
DQoNCglleHBvcnRfZGVmaW5pdGlvbiA9IGluZGV4KGN1cnJlbnRfZnVuYywg
Il9fa3N0cnRhYl8iKTsNCglpbml0X2NhbGwgPSBpbmRleChjdXJyZW50X2Z1
bmMsICJfX2luaXRjYWxsXyIpOw0KCXNldHVwX2NhbGwgPSBpbmRleChjdXJy
ZW50X2Z1bmMsICJfX3NldHVwXyIpOw0KCQ0KCWlmIChleHBvcnRfZGVmaW5p
dGlvbikgew0KCQljdXJyZW50X2Z1bmMgPSBzdWJzdHIoY3VycmVudF9mdW5j
LCBleHBvcnRfZGVmaW5pdGlvbiArIDEwKQ0KCQljdXJyZW50X2Z1bmMgPSBm
dW5jdGlvbl9wcmVmaXggY3VycmVudF9mdW5jDQoJCXVzZXJbY3VycmVudF9m
dW5jXSA9IHVzZXJbY3VycmVudF9mdW5jXSAiIEVYUE9SVCINCgl9IGVsc2Ug
aWYgKGluaXRfY2FsbCkgew0KCQljdXJyZW50X2Z1bmMgPSBzdWJzdHIoY3Vy
cmVudF9mdW5jLCBpbml0X2NhbGwgKyAxMSkNCgkJY3VycmVudF9mdW5jID0g
ZnVuY3Rpb25fcHJlZml4IGN1cnJlbnRfZnVuYw0KCQl1c2VyW2N1cnJlbnRf
ZnVuY10gPSB1c2VyW2N1cnJlbnRfZnVuY10gIiBJTklUQ0FMTCINCgl9IGVs
c2UgaWYgKHNldHVwX2NhbGwpIHsNCgkJY3VycmVudF9mdW5jID0gc3Vic3Ry
KGN1cnJlbnRfZnVuYywgc2V0dXBfY2FsbCArIDgpDQoJCWN1cnJlbnRfZnVu
YyA9IGZ1bmN0aW9uX3ByZWZpeCBjdXJyZW50X2Z1bmMNCgkJdXNlcltjdXJy
ZW50X2Z1bmNdID0gdXNlcltjdXJyZW50X2Z1bmNdICIgU0VUVVBDQUxMIg0K
CX0gZWxzZSB7DQoJCWN1cnJlbnRfZnVuYyA9IGZ1bmN0aW9uX3ByZWZpeCBj
dXJyZW50X2Z1bmMNCgkJdXNlcltjdXJyZW50X2Z1bmNdID0gIjogIiB1c2Vy
W2N1cnJlbnRfZnVuY10NCgl9DQoNCglwcmludGYoIiVzOiAlc1xuIiwgaW5f
YWRkcmVzcywgY3VycmVudF9mdW5jKSA+PiAiL2Rldi90dHkiDQp9DQoNCi9j
YWxsIC8gew0KCSMNCgkjIEEgY2FsbCBpbnN0cnVjdGlvbiBvZiBhIGZ1bmN0
aW9uDQoJIw0KDQoJc3RtdCA9IHN1YnN0cigkMCwgaW5kZXgoJDAsICJjYWxs
ICIpKQ0KCW51bSA9IHNwbGl0KHN0bXQsIGNvbCk7DQoJaWYgKG51bSA9PSAz
KSB7DQoJCW5hbWUgPSBjb2xbM10NCgkJYWRkcmVzcyA9IGNvbFsyXQ0KDQoJ
CWdzdWIoIls8Pl0iLCAiIiwgbmFtZSkNCgkJaWYgKGFkZHJlc3MgPj0gaW5p
dF9zdGFydCAmJiBhZGRyZXNzIDwgaW5pdF9lbmQpDQoJCQluYW1lID0gIkAi
IG5hbWUNCgkJZWxzZQ0KCQkJbmFtZSA9ICImIiBuYW1lDQoNCgkJdXNlcltu
YW1lXSA9IHVzZXJbbmFtZV0gIiAiIGN1cnJlbnRfZnVuYw0KCX0NCn0NCg0K
RU5EIHsNCglmb3IgKGZuYyBpbiB1c2VyKQ0KCQlwcmludGYoIiVzJXNcbiIs
IGZuYywgdXNlcltmbmNdKQ0KfQ0KJyA+IHVzZXJfbWFwDQoNCmVjaG8gIiIN
CmVjaG8gIiINCmVjaG8gIkxpc3Qgb2YgYWxsIGZ1bmN0aW9ucyB3aXRoIHRo
ZWlyIHVzZXJzIGFyZSBpbiBmaWxlIHVzZXJfbWFwLiINCmVjaG8gIiAgRnVu
Y3Rpb24gcHJlZml4ICdAJyBtZWFuczogZnVuY3Rpb24gaXMgaW4gLnRleHQu
aW5pdCBzZWN0aW9uIg0KZWNobyAiICBGdW5jdGlvbiBwcmVmaXggJyYnIG1l
YW5zOiBmdW5jdGlvbiBpcyBpbiBvcmRpbmFyeSAudGV4dCBzZWN0aW9uIg0K
ZWNobyAiIg0KZWNobyAiVE9ETyBMaXN0OiINCmVjaG8gIjEuIERlYWwgd2l0
aCBjb2xsaXNpb25zIGluIGZ1bmN0aW9uIG5hbWUgc3BhY2UiDQplY2hvICIy
LiBEZWFsIHdpdGggZGF0YSINCmVjaG8gIjMuIERlYWwgd2l0aCBmdW5jdGlv
biBwb2ludGVycyBpbiBzdHJ1Y3RzIG9yIGZ1bmN0aW9uIHBhcmFtZXRlcnMi
DQplY2hvICIiDQplY2hvICIiDQoNCmVjaG8gIkxpc3Qgb2YgYWxsIHBvdGVu
dGlhbCBpbml0IGZ1bmN0aW9uczoiDQplY2hvICItLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tIg0KZ3JlcCAiXiYiIHVzZXJfbWFwIHwg
Y3V0IC1jMi0gfCBncmVwIC12ICImIiB8IGdyZXAgLXYgIjogJCIgfCBncmVw
IC12IEVYUE9SVA0KDQo=
---1463781119-1517877688-987606568=:10072--
