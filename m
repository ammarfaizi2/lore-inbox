Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261768AbVADKy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbVADKy3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 05:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbVADKy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 05:54:29 -0500
Received: from imag.imag.fr ([129.88.30.1]:28407 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S261768AbVADKyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 05:54:18 -0500
Date: Tue, 4 Jan 2005 11:53:56 +0100 (MET)
From: "emmanuel.colbus@ensimag.imag.fr" <colbuse@ensisun.imag.fr>
X-X-Sender: colbuse@ensisun
To: linux-kernel@vger.kernel.org
cc: trovalds@osdl.org, <andrewm@uow.edu.au>
Subject: [PATCH]vt.c, kernel 2.6.10 (also applies to 2.4.28 and 2.2.26).
Message-ID: <Pine.GSO.4.40.0501040904430.2249-500000@ensisun>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-758783491-1104836036=:2249"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (imag.imag.fr [129.88.30.1]); Tue, 04 Jan 2005 11:53:58 +0100 (CET)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-758783491-1104836036=:2249
Content-Type: TEXT/PLAIN; charset=US-ASCII


There is a minor bug into the linux console driver.
It appeared in kernel 2.1.112 (but the ChangeLog is void about
this modification), and affects 2.2, 2.4 and 2.6 trees.

The point is about the DEC screen alignment test : the kernel is fulling
the text console with 'E's (witch is the correct behaviour) without
checking if the process who sent the screen alignment test sequence
is the owner of the current console.

In kernels 2.2.26 and 2.4.28, the file drivers/char/vt.c was called
drivers/char/console.c .

Notice : I've tested my patch on kernel 2.4, it works properly, and, since
it is a very little patch and very easy to understand (I think), I believe
it will also work with kernels 2.2 and 2.6, but I've made no test on them.
Please check my patch on 2.2 and 2.6 before applying it to these versions.

Checking can be done by login on vt1 and then typing :
$ chvt 2 && sleep 1 && echo -e "\033#8"
If vt2 gets full of 'E's, the kernel is broken.

Emmanuel Colbus

---559023410-758783491-1104836036=:2249
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.40.0501041153560.2249@ensisun>
Content-Description: DEC_alignment_screen_test_fix
Content-Disposition: attachment; filename=patch

LS0tIG9sZC9kcml2ZXJzL2NoYXIvdnQuYwkyMDA0LTEyLTI0IDIyOjM1OjI1
LjAwMDAwMDAwMCArMDEwMA0KKysrIHBhdGNoZWQvZHJpdmVycy9jaGFyL3Z0
LmMJMjAwNS0wMS0wNCAxMDozNzo0Ni4wMDAwMDAwMDAgKzAxMDANCkBAIC0x
ODQ3LDcgKzE4NDcsNyBAQA0KIAkJCWNzaV9KKGN1cnJjb25zLCAyKTsNCiAJ
CQl2aWRlb19lcmFzZV9jaGFyID0NCiAJCQkJKHZpZGVvX2VyYXNlX2NoYXIg
JiAweGZmMDApIHwgJyAnOw0KLQkJCWRvX3VwZGF0ZV9yZWdpb24oY3VycmNv
bnMsIG9yaWdpbiwgc2NyZWVuYnVmX3NpemUvMik7DQorCQkJdXBkYXRlX3Jl
Z2lvbihjdXJyY29ucywgb3JpZ2luLCBzY3JlZW5idWZfc2l6ZS8yKTsNCiAJ
CX0NCiAJCXJldHVybjsNCiAJY2FzZSBFU3NldEcwOg0K
---559023410-758783491-1104836036=:2249
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=README
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.40.0501041153561.2249@ensisun>
Content-Description: README
Content-Disposition: attachment; filename=README

REVDIHNjcmVlbiBhbGlnbm1lbnQgdGVzdCBidWcgZml4IEVtbWFudWVsIENv
bGJ1cyA8ZW1tYW51ZWwuY29sYnVzQGVuc2ltYWcuaW1hZy5mcj4NCg==
---559023410-758783491-1104836036=:2249
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=DEC_alignment_test_patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.40.0501041153562.2249@ensisun>
Content-Description: 2.4.28 patch
Content-Disposition: attachment; filename=DEC_alignment_test_patch

LS0tIG9sZC9kcml2ZXJzL2NoYXIvY29uc29sZS5jCTIwMDUtMDEtMDMgMTU6
NTE6MjIuMDAwMDAwMDAwICswMTAwDQorKysgcGF0Y2hlZC9kcml2ZXJzL2No
YXIvY29uc29sZS5jCTIwMDUtMDEtMDMgMTU6MzE6NDUuMDAwMDAwMDAwICsw
MTAwDQpAQCAtMTc4MSw3ICsxNzgxLDcgQEANCiAJCQljc2lfSihjdXJyY29u
cywgMik7DQogCQkJdmlkZW9fZXJhc2VfY2hhciA9DQogCQkJCSh2aWRlb19l
cmFzZV9jaGFyICYgMHhmZjAwKSB8ICcgJzsNCi0JCQlkb191cGRhdGVfcmVn
aW9uKGN1cnJjb25zLCBvcmlnaW4sIHNjcmVlbmJ1Zl9zaXplLzIpOw0KKwkJ
CXVwZGF0ZV9yZWdpb24oY3VycmNvbnMsIG9yaWdpbiwgc2NyZWVuYnVmX3Np
emUvMik7DQogCQl9DQogCQlyZXR1cm47DQogCWNhc2UgRVNzZXRHMDoNCg==
---559023410-758783491-1104836036=:2249
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="patch_2.2"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.40.0501041153563.2249@ensisun>
Content-Description: 2.2.26 patch
Content-Disposition: attachment; filename="patch_2.2"

LS0tIG9sZC9kcml2ZXJzL2NoYXIvY29uc29sZS5jCU1vbiBTZXAgMTYgMTg6
MjY6MTEgMjAwMg0KKysrIHBhdGNoZWQvZHJpdmVycy9jaGFyL2NvbnNvbGUu
YwlUdWUgSmFuICA0IDA5OjU0OjU4IDIwMDUNCkBAIC0xNzQyLDcgKzE3NDIs
NyBAQA0KIAkJCWNzaV9KKGN1cnJjb25zLCAyKTsNCiAJCQl2aWRlb19lcmFz
ZV9jaGFyID0NCiAJCQkJKHZpZGVvX2VyYXNlX2NoYXIgJiAweGZmMDApIHwg
JyAnOw0KLQkJCWRvX3VwZGF0ZV9yZWdpb24oY3VycmNvbnMsIG9yaWdpbiwg
c2NyZWVuYnVmX3NpemUvMik7DQorCQkJdXBkYXRlX3JlZ2lvbihjdXJyY29u
cywgb3JpZ2luLCBzY3JlZW5idWZfc2l6ZS8yKTsNCiAJCX0NCiAJCXJldHVy
bjsNCiAJY2FzZSBFU3NldEcwOg0K
---559023410-758783491-1104836036=:2249--
