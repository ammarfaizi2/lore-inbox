Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965224AbVKHOXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965224AbVKHOXJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 09:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965222AbVKHOXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 09:23:09 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:37958
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S965225AbVKHOXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 09:23:05 -0500
Message-Id: <4370C30B.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 08 Nov 2005 15:23:55 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andreas Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: [PATCH] x86-64: adjust double fault handling
References: <4370AFF0.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part04263AEB.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part04263AEB.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Since a double fault always implies that kernel data structures are
corrupt, this fault should neither be handed to user mode handling,
nor should the handler allow resuming the faulting code stream (since
architecturally this isn't a fault, but an abort).

Note that this slightly depends on the previously submitted patch
adjusting the prototype of notify_die() (a compiler warning will
result
without that other patch).

From: Jan Beulich <jbeulich@novell.com>

(actual patch attached)


--=__Part04263AEB.1__=
Content-Type: application/octet-stream; name="linux-2.6.14-x86_64-doublefault.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.14-x86_64-doublefault.patch"

U2luY2UgYSBkb3VibGUgZmF1bHQgYWx3YXlzIGltcGxpZXMgdGhhdCBrZXJuZWwgZGF0YSBzdHJ1
Y3R1cmVzIGFyZQpjb3JydXB0LCB0aGlzIGZhdWx0IHNob3VsZCBuZWl0aGVyIGJlIGhhbmRlZCB0
byB1c2VyIG1vZGUgaGFuZGxpbmcsCm5vciBzaG91bGQgdGhlIGhhbmRsZXIgYWxsb3cgcmVzdW1p
bmcgdGhlIGZhdWx0aW5nIGNvZGUgc3RyZWFtIChzaW5jZQphcmNoaXRlY3R1cmFsbHkgdGhpcyBp
c24ndCBhIGZhdWx0LCBidXQgYW4gYWJvcnQpLgoKTm90ZSB0aGF0IHRoaXMgc2xpZ2h0bHkgZGVw
ZW5kcyBvbiB0aGUgcHJldmlvdXNseSBzdWJtaXR0ZWQgcGF0Y2gKYWRqdXN0aW5nIHRoZSBwcm90
b3R5cGUgb2Ygbm90aWZ5X2RpZSgpIChhIGNvbXBpbGVyIHdhcm5pbmcgd2lsbCByZXN1bHQKd2l0
aG91dCB0aGF0IG90aGVyIHBhdGNoKS4KCkZyb206IEphbiBCZXVsaWNoIDxqYmV1bGljaEBub3Zl
bGwuY29tPgoKLS0tIDIuNi4xNC9hcmNoL3g4Nl82NC9rZXJuZWwvdHJhcHMuYwkyMDA1LTEwLTI4
IDAyOjAyOjA4LjAwMDAwMDAwMCArMDIwMAorKysgMi42LjE0LXg4Nl82NC1kb3VibGVmYXVsdC9h
cmNoL3g4Nl82NC9rZXJuZWwvdHJhcHMuYwkyMDA1LTExLTA3IDA5OjMzOjUzLjAwMDAwMDAwMCAr
MDEwMApAQCAtNTA2LDcgKzUwNiwzNSBAQCBET19FUlJPUigxMSwgU0lHQlVTLCAgInNlZ21lbnQg
bm90IHByZXNlCiBET19FUlJPUl9JTkZPKDE3LCBTSUdCVVMsICJhbGlnbm1lbnQgY2hlY2siLCBh
bGlnbm1lbnRfY2hlY2ssIEJVU19BRFJBTE4sIDApCiBET19FUlJPUigxOCwgU0lHU0VHViwgInJl
c2VydmVkIiwgcmVzZXJ2ZWQpCiBET19FUlJPUigxMiwgU0lHQlVTLCAgInN0YWNrIHNlZ21lbnQi
LCBzdGFja19zZWdtZW50KQotRE9fRVJST1IoIDgsIFNJR1NFR1YsICJkb3VibGUgZmF1bHQiLCBk
b3VibGVfZmF1bHQpCisKK2FzbWxpbmthZ2Ugdm9pZCBkb19kb3VibGVfZmF1bHQoc3RydWN0IHB0
X3JlZ3MgKiByZWdzLCBsb25nIGVycm9yX2NvZGUpCit7CisJc3RhdGljIGNvbnN0IGNoYXIgc3Ry
W10gPSAiZG91YmxlIGZhdWx0IjsKKwlzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRzayA9IGN1cnJlbnQ7
CisKKwlub3RpZnlfZGllKERJRV9UUkFQLCBzdHIsIHJlZ3MsIGVycm9yX2NvZGUsIDgsIFNJR1NF
R1YpOworCisjaWZkZWYgQ09ORklHX0NIRUNLSU5HCisJeyAKKwkJdW5zaWduZWQgbG9uZyBnczsg
CisJCXN0cnVjdCB4ODY2NF9wZGEgKnBkYSA9IGNwdV9wZGEgKyBzYWZlX3NtcF9wcm9jZXNzb3Jf
aWQoKTsgCisJCXJkbXNybChNU1JfR1NfQkFTRSwgZ3MpOyAKKwkJaWYgKGdzICE9ICh1bnNpZ25l
ZCBsb25nKXBkYSkgeyAKKwkJCXdybXNybChNU1JfR1NfQkFTRSwgcGRhKTsgCisJCQlwcmludGso
IiVzOiB3cm9uZyBncyAlbHggZXhwZWN0ZWQgJXAgcmlwICVseFxuIiwKKwkJCSAgICAgICBzdHIs
IGdzLCBwZGEsIHJlZ3MtPnJpcCk7CisJCX0KKwl9CisjZW5kaWYKKworCXRzay0+dGhyZWFkLmVy
cm9yX2NvZGUgPSBlcnJvcl9jb2RlOworCXRzay0+dGhyZWFkLnRyYXBfbm8gPSA4OworCisJLyog
VGhpcyBpcyBhbHdheXMgYSBrZXJuZWwgdHJhcCBhbmQgbmV2ZXIgZml4YWJsZSAoYW5kIHRodXMg
bXVzdAorCSAgIG5ldmVyIHJldHVybikuICovCisJZm9yICg7OykKKwkJZGllKHN0ciwgcmVncywg
ZXJyb3JfY29kZSk7Cit9CiAKIGFzbWxpbmthZ2Ugdm9pZCBfX2twcm9iZXMgZG9fZ2VuZXJhbF9w
cm90ZWN0aW9uKHN0cnVjdCBwdF9yZWdzICogcmVncywKIAkJCQkJCWxvbmcgZXJyb3JfY29kZSkK

--=__Part04263AEB.1__=--
