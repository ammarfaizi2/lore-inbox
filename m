Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265236AbUBIOJs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 09:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbUBIOJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 09:09:48 -0500
Received: from gamma.utc.fr ([195.83.155.32]:20942 "EHLO gamma.utc.fr")
	by vger.kernel.org with ESMTP id S265236AbUBIOJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 09:09:46 -0500
Message-ID: <1076335524.402793a4d04e9@mailetu.utc.fr>
Date: Mon,  9 Feb 2004 15:05:24 +0100
From: eric.piel@tremplin-utc.net
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Slight optimisation of the uhci-hcd init code
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-MOQ10763355247f93030b838805640614669d3e99af9b"
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Spam-Checked-By: localhost
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format.

---MOQ10763355247f93030b838805640614669d3e99af9b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Hello,

While trying to understand why starting usb on my laptop made the bus master
activity full I came accross a strange code in uhci-hcd: a seven level nested
"if". The same thing can be achieved with a simgle ffz(). The attached patch
should give to the code a bit better looking, on my x86 it even saves 96 bytes,
cool ;-) 

hoping you like it,
Eric Piel


PS: still, I'm not sure it's normal to see ffffffff as "bus master activity" in
/proc/acpi/processor/CPU0/power as soon as uhci-hcd is loaded. In particular, it
prevents the processor to go to C3 state. Could you give me your pint of view?
---MOQ10763355247f93030b838805640614669d3e99af9b
Content-Type: text/x-patch; name="uhci-hcd-uses-ffz.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="uhci-hcd-uses-ffz.patch"

LS0tIGRyaXZlcnMvdXNiL2hvc3QvdWhjaS1oY2QuYy5vcmlnCTIwMDQtMDItMDggMTI6MzA6MjMu
NzMwOTM0NzQ0ICswMTAwCisrKyBkcml2ZXJzL3VzYi9ob3N0L3VoY2ktaGNkLmMJMjAwNC0wMi0w
OCAxMzoxMjoxMS43MjM2NjE4OTYgKzAxMDAKQEAgLTUyLDYgKzUyLDcgQEAKICNpbmNsdWRlIDxh
c20vaW8uaD4KICNpbmNsdWRlIDxhc20vaXJxLmg+CiAjaW5jbHVkZSA8YXNtL3N5c3RlbS5oPgor
I2luY2x1ZGUgPGFzbS9iaXRvcHMuaD4KIAogI2luY2x1ZGUgIi4uL2NvcmUvaGNkLmgiCiAjaW5j
bHVkZSAidWhjaS1oY2QuaCIKQEAgLTIyMTMsMTAgKzIyMTQsMTEgQEAKIHsKIAlzdHJ1Y3QgdWhj
aV9oY2QgKnVoY2kgPSBoY2RfdG9fdWhjaShoY2QpOwogCWludCByZXR2YWwgPSAtRUJVU1k7Ci0J
aW50IGksIHBvcnQ7CisJaW50IHBvcnQ7CiAJdW5zaWduZWQgaW9fc2l6ZTsKIAlkbWFfYWRkcl90
IGRtYV9oYW5kbGU7CiAJc3RydWN0IHVzYl9kZXZpY2UgKnVkZXY7CisJdW5zaWduZWQgbG9uZyBp
OwogI2lmZGVmIENPTkZJR19QUk9DX0ZTCiAJc3RydWN0IHByb2NfZGlyX2VudHJ5ICplbnQ7CiAj
ZW5kaWYKQEAgLTIzMjEsNyArMjMyMyw3IEBACiAJZm9yIChpID0gMDsgaSA8IFVIQ0lfTlVNX1NL
RUxRSDsgaSsrKSB7CiAJCXVoY2ktPnNrZWxxaFtpXSA9IHVoY2lfYWxsb2NfcWgodWhjaSwgdWRl
dik7CiAJCWlmICghdWhjaS0+c2tlbHFoW2ldKSB7Ci0JCQllcnIoInVuYWJsZSB0byBhbGxvY2F0
ZSBRSCAlZCIsIGkpOworCQkJZXJyKCJ1bmFibGUgdG8gYWxsb2NhdGUgUUggJWx1IiwgaSk7CiAJ
CQlnb3RvIGVycl9hbGxvY19za2VscWg7CiAJCX0KIAl9CkBAIC0yMzYwLDI4ICsyMzYyLDggQEAK
IAkgKiB1cyBhIHJlYXNvbmFibGUgZHluYW1pYyByYW5nZSBmb3IgaXJxIGxhdGVuY2llcy4KIAkg
Ki8KIAlmb3IgKGkgPSAwOyBpIDwgVUhDSV9OVU1GUkFNRVM7IGkrKykgewotCQlpbnQgaXJxID0g
MDsKLQotCQlpZiAoaSAmIDEpIHsKLQkJCWlycSsrOwotCQkJaWYgKGkgJiAyKSB7Ci0JCQkJaXJx
Kys7Ci0JCQkJaWYgKGkgJiA0KSB7IAotCQkJCQlpcnErKzsKLQkJCQkJaWYgKGkgJiA4KSB7IAot
CQkJCQkJaXJxKys7Ci0JCQkJCQlpZiAoaSAmIDE2KSB7Ci0JCQkJCQkJaXJxKys7Ci0JCQkJCQkJ
aWYgKGkgJiAzMikgewotCQkJCQkJCQlpcnErKzsKLQkJCQkJCQkJaWYgKGkgJiA2NCkKLQkJCQkJ
CQkJCWlycSsrOwotCQkJCQkJCX0KLQkJCQkJCX0KLQkJCQkJfQotCQkJCX0KLQkJCX0KLQkJfQor
CQl1bnNpZ25lZCBsb25nIGlycTsKKwkJaXJxID0gZmZ6KGkgJiAoKDE8PDcpIC0gMSkpOwogCiAJ
CS8qIE9ubHkgcGxhY2Ugd2UgZG9uJ3QgdXNlIHRoZSBmcmFtZSBsaXN0IHJvdXRpbmVzICovCiAJ
CXVoY2ktPmZsLT5mcmFtZVtpXSA9IGNwdV90b19sZTMyKHVoY2ktPnNrZWxxaFs3IC0gaXJxXS0+
ZG1hX2hhbmRsZSk7Cg==

---MOQ10763355247f93030b838805640614669d3e99af9b--

