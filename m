Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262144AbVBQNyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbVBQNyK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 08:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbVBQNyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 08:54:10 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:57506 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262144AbVBQNyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 08:54:03 -0500
Message-ID: <4214A1EC.4070102@yahoo.com.au>
Date: Fri, 18 Feb 2005 00:53:48 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] optimise copy page range
Content-Type: multipart/mixed;
 boundary="------------010604050301040907080908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010604050301040907080908
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Some of you have seen this before. Just resending because
I based my next patch on top of this one.

--------------010604050301040907080908
Content-Type: text/plain;
 name="mm-opt-cpr.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="mm-opt-cpr.patch"

CgpTdWdnZXN0ZWQgYnkgTGludXM6IG9wdGltaXNlIGEgY29uZGl0aW9uIGluIHRoZSBjbGVh
cl9wP2RfcmFuZ2UgZnVuY3Rpb25zLgpSZXN1bHRzIGluIG9uZSBsZXNzIGNvbmRpdGlvbmFs
IGJyYW5jaCBvbiBpMzg2IHdpdGggZ2NjLTMuNC40CgpTaWduZWQtb2ZmLWJ5OiBOaWNrIFBp
Z2dpbiA8bmlja3BpZ2dpbkB5YWhvby5jb20uYXU+CgoKLS0tCgogbGludXgtMi42LW5waWdn
aW4vbW0vbWVtb3J5LmMgfCAgICA5ICsrKysrKy0tLQogMSBmaWxlcyBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC1wdU4gbW0vbWVtb3J5LmN+bW0t
b3B0LWNwciBtbS9tZW1vcnkuYwotLS0gbGludXgtMi42L21tL21lbW9yeS5jfm1tLW9wdC1j
cHIJMjAwNS0wMi0xNiAxMzo0NToxMS4wMDAwMDAwMDAgKzExMDAKKysrIGxpbnV4LTIuNi1u
cGlnZ2luL21tL21lbW9yeS5jCTIwMDUtMDItMTYgMTM6NDU6MTEuMDAwMDAwMDAwICsxMTAw
CkBAIC05OCw3ICs5OCw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBjbGVhcl9wbWRfcmFuZ2Uo
c3RydWMKIAkJcG1kX2NsZWFyKHBtZCk7CiAJCXJldHVybjsKIAl9Ci0JaWYgKCEoc3RhcnQg
JiB+UE1EX01BU0spICYmICEoZW5kICYgflBNRF9NQVNLKSkgeworCWlmICghKChzdGFydCB8
IGVuZCkgJiB+UE1EX01BU0spKSB7CisJCS8qIE9ubHkgY2xlYXIgZnVsbCwgYWxpZ25lZCBy
YW5nZXMgKi8KIAkJcGFnZSA9IHBtZF9wYWdlKCpwbWQpOwogCQlwbWRfY2xlYXIocG1kKTsK
IAkJZGVjX3BhZ2Vfc3RhdGUobnJfcGFnZV90YWJsZV9wYWdlcyk7CkBAIC0xMzEsNyArMTMy
LDggQEAgc3RhdGljIGlubGluZSB2b2lkIGNsZWFyX3B1ZF9yYW5nZShzdHJ1YwogCQlhZGRy
ID0gbmV4dDsKIAl9IHdoaWxlIChhZGRyICYmIChhZGRyIDwgZW5kKSk7CiAKLQlpZiAoIShz
dGFydCAmIH5QVURfTUFTSykgJiYgIShlbmQgJiB+UFVEX01BU0spKSB7CisJaWYgKCEoKHN0
YXJ0IHwgZW5kKSAmIH5QVURfTUFTSykpIHsKKwkJLyogT25seSBjbGVhciBmdWxsLCBhbGln
bmVkIHJhbmdlcyAqLwogCQlwdWRfY2xlYXIocHVkKTsKIAkJcG1kX2ZyZWVfdGxiKHRsYiwg
X19wbWQpOwogCX0KQEAgLTE2Miw3ICsxNjQsOCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgY2xl
YXJfcGdkX3JhbmdlKHN0cnVjCiAJCWFkZHIgPSBuZXh0OwogCX0gd2hpbGUgKGFkZHIgJiYg
KGFkZHIgPCBlbmQpKTsKIAotCWlmICghKHN0YXJ0ICYgflBHRElSX01BU0spICYmICEoZW5k
ICYgflBHRElSX01BU0spKSB7CisJaWYgKCEoKHN0YXJ0IHwgZW5kKSAmIH5QR0RJUl9NQVNL
KSkgeworCQkvKiBPbmx5IGNsZWFyIGZ1bGwsIGFsaWduZWQgcmFuZ2VzICovCiAJCXBnZF9j
bGVhcihwZ2QpOwogCQlwdWRfZnJlZV90bGIodGxiLCBfX3B1ZCk7CiAJfQoKXwo=
--------------010604050301040907080908--

