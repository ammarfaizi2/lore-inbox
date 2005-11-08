Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965222AbVKHOYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965222AbVKHOYq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 09:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965149AbVKHOYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 09:24:45 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:64070
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S965222AbVKHOYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 09:24:45 -0500
Message-Id: <4370C36D.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 08 Nov 2005 15:25:33 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andreas Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: [PATCH] x86-64: adjust page fault handling
References: <4370AFF0.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartA3819D4D.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartA3819D4D.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Adjust page fault protection error check before considering it to be
a vmalloc synchronization candidate.

From: Jan Beulich <jbeulich@novell.com>

(actual patch attached)


--=__PartA3819D4D.1__=
Content-Type: application/octet-stream; name="linux-2.6.14-x86_64-pagefault.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.14-x86_64-pagefault.patch"

QWRqdXN0IHBhZ2UgZmF1bHQgcHJvdGVjdGlvbiBlcnJvciBjaGVjayBiZWZvcmUgY29uc2lkZXJp
bmcgaXQgdG8gYmUKYSB2bWFsbG9jIHN5bmNocm9uaXphdGlvbiBjYW5kaWRhdGUuCgpGcm9tOiBK
YW4gQmV1bGljaCA8amJldWxpY2hAbm92ZWxsLmNvbT4KCi0tLSAyLjYuMTQvYXJjaC94ODZfNjQv
bW0vZmF1bHQuYwkyMDA1LTEwLTI4IDAyOjAyOjA4LjAwMDAwMDAwMCArMDIwMAorKysgMi42LjE0
LXg4Nl82NC1wYWdlZmF1bHQvYXJjaC94ODZfNjQvbW0vZmF1bHQuYwkyMDA1LTExLTA3IDE0OjI3
OjQyLjAwMDAwMDAwMCArMDEwMApAQCAtMjk0LDcgKzI5NCw4IEBAIGludCBleGNlcHRpb25fdHJh
Y2UgPSAxOwogICoJYml0IDAgPT0gMCBtZWFucyBubyBwYWdlIGZvdW5kLCAxIG1lYW5zIHByb3Rl
Y3Rpb24gZmF1bHQKICAqCWJpdCAxID09IDAgbWVhbnMgcmVhZCwgMSBtZWFucyB3cml0ZQogICoJ
Yml0IDIgPT0gMCBtZWFucyBrZXJuZWwsIDEgbWVhbnMgdXNlci1tb2RlCi0gKiAgICAgIGJpdCAz
ID09IDEgbWVhbnMgZmF1bHQgd2FzIGFuIGluc3RydWN0aW9uIGZldGNoCisgKgliaXQgMyA9PSAx
IG1lYW5zIHVzZSBvZiByZXNlcnZlZCBiaXQgZGV0ZWN0ZWQKKyAqCWJpdCA0ID09IDEgbWVhbnMg
ZmF1bHQgd2FzIGFuIGluc3RydWN0aW9uIGZldGNoCiAgKi8KIGFzbWxpbmthZ2Ugdm9pZCBfX2tw
cm9iZXMgZG9fcGFnZV9mYXVsdChzdHJ1Y3QgcHRfcmVncyAqcmVncywKIAkJCQkJdW5zaWduZWQg
bG9uZyBlcnJvcl9jb2RlKQpAQCAtMzQ5LDEwICszNTAsMTAgQEAgYXNtbGlua2FnZSB2b2lkIF9f
a3Byb2JlcyBkb19wYWdlX2ZhdWx0KAogCSAqCiAJICogVGhpcyB2ZXJpZmllcyB0aGF0IHRoZSBm
YXVsdCBoYXBwZW5zIGluIGtlcm5lbCBzcGFjZQogCSAqIChlcnJvcl9jb2RlICYgNCkgPT0gMCwg
YW5kIHRoYXQgdGhlIGZhdWx0IHdhcyBub3QgYQotCSAqIHByb3RlY3Rpb24gZXJyb3IgKGVycm9y
X2NvZGUgJiAxKSA9PSAwLgorCSAqIHByb3RlY3Rpb24gZXJyb3IgKGVycm9yX2NvZGUgJiA5KSA9
PSAwLgogCSAqLwogCWlmICh1bmxpa2VseShhZGRyZXNzID49IFRBU0tfU0laRTY0KSkgewotCQlp
ZiAoIShlcnJvcl9jb2RlICYgNSkgJiYKKwkJaWYgKCEoZXJyb3JfY29kZSAmIDB4ZCkgJiYKIAkJ
ICAgICAgKChhZGRyZXNzID49IFZNQUxMT0NfU1RBUlQgJiYgYWRkcmVzcyA8IFZNQUxMT0NfRU5E
KSB8fAogCQkgICAgICAgKGFkZHJlc3MgPj0gTU9EVUxFU19WQUREUiAmJiBhZGRyZXNzIDwgTU9E
VUxFU19FTkQpKSkgewogCQkJaWYgKHZtYWxsb2NfZmF1bHQoYWRkcmVzcykgPCAwKQo=

--=__PartA3819D4D.1__=--
