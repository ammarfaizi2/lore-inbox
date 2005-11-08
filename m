Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030255AbVKHQ4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbVKHQ4I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 11:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbVKHQ4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 11:56:08 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:18785
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1030255AbVKHQ4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 11:56:06 -0500
Message-Id: <4370E6EF.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 08 Nov 2005 17:57:03 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386: adjust page fault handling
References: <4370AEE1.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part4C6E72CF.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part4C6E72CF.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Adjust page fault protection error check before considering it to be
a vmalloc synchronization candidate.

From: Jan Beulich <jbeulich@novell.com>

(actual patch attached)


--=__Part4C6E72CF.0__=
Content-Type: application/octet-stream; name="linux-2.6.14-i386-pagefault.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.14-i386-pagefault.patch"

QWRqdXN0IHBhZ2UgZmF1bHQgcHJvdGVjdGlvbiBlcnJvciBjaGVjayBiZWZvcmUgY29uc2lkZXJp
bmcgaXQgdG8gYmUKYSB2bWFsbG9jIHN5bmNocm9uaXphdGlvbiBjYW5kaWRhdGUuCgpGcm9tOiBK
YW4gQmV1bGljaCA8amJldWxpY2hAbm92ZWxsLmNvbT4KCi0tLSAyLjYuMTQvYXJjaC9pMzg2L21t
L2ZhdWx0LmMJMjAwNS0xMC0yOCAwMjowMjowOC4wMDAwMDAwMDAgKzAyMDAKKysrIDIuNi4xNC1p
Mzg2LXBhZ2VmYXVsdC9hcmNoL2kzODYvbW0vZmF1bHQuYwkyMDA1LTExLTA0IDE2OjE5OjMzLjAw
MDAwMDAwMCArMDEwMApAQCAtMjIzLDYgKzIyMyw4IEBAIGZhc3RjYWxsIHZvaWQgZG9faW52YWxp
ZF9vcChzdHJ1Y3QgcHRfcmUKICAqCWJpdCAwID09IDAgbWVhbnMgbm8gcGFnZSBmb3VuZCwgMSBt
ZWFucyBwcm90ZWN0aW9uIGZhdWx0CiAgKgliaXQgMSA9PSAwIG1lYW5zIHJlYWQsIDEgbWVhbnMg
d3JpdGUKICAqCWJpdCAyID09IDAgbWVhbnMga2VybmVsLCAxIG1lYW5zIHVzZXItbW9kZQorICoJ
Yml0IDMgPT0gMSBtZWFucyB1c2Ugb2YgcmVzZXJ2ZWQgYml0IGRldGVjdGVkCisgKgliaXQgNCA9
PSAxIG1lYW5zIGZhdWx0IHdhcyBhbiBpbnN0cnVjdGlvbiBmZXRjaAogICovCiBmYXN0Y2FsbCB2
b2lkIF9fa3Byb2JlcyBkb19wYWdlX2ZhdWx0KHN0cnVjdCBwdF9yZWdzICpyZWdzLAogCQkJCSAg
ICAgIHVuc2lnbmVkIGxvbmcgZXJyb3JfY29kZSkKQEAgLTI1OSwxMCArMjYxLDEwIEBAIGZhc3Rj
YWxsIHZvaWQgX19rcHJvYmVzIGRvX3BhZ2VfZmF1bHQoc3QKIAkgKgogCSAqIFRoaXMgdmVyaWZp
ZXMgdGhhdCB0aGUgZmF1bHQgaGFwcGVucyBpbiBrZXJuZWwgc3BhY2UKIAkgKiAoZXJyb3JfY29k
ZSAmIDQpID09IDAsIGFuZCB0aGF0IHRoZSBmYXVsdCB3YXMgbm90IGEKLQkgKiBwcm90ZWN0aW9u
IGVycm9yIChlcnJvcl9jb2RlICYgMSkgPT0gMC4KKwkgKiBwcm90ZWN0aW9uIGVycm9yIChlcnJv
cl9jb2RlICYgOSkgPT0gMC4KIAkgKi8KIAlpZiAodW5saWtlbHkoYWRkcmVzcyA+PSBUQVNLX1NJ
WkUpKSB7IAotCQlpZiAoIShlcnJvcl9jb2RlICYgNSkpCisJCWlmICghKGVycm9yX2NvZGUgJiAw
eGQpKQogCQkJZ290byB2bWFsbG9jX2ZhdWx0OwogCQkvKiAKIAkJICogRG9uJ3QgdGFrZSB0aGUg
bW0gc2VtYXBob3JlIGhlcmUuIElmIHdlIGZpeHVwIGEgcHJlZmV0Y2gK

--=__Part4C6E72CF.0__=--
