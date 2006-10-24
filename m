Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965083AbWJXEPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbWJXEPe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 00:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965087AbWJXEPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 00:15:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:5164 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965083AbWJXEPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 00:15:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=f1ZmDJaeD/hwqQcamksU/7bff55lMjef+vsR40jbPIZrE7nvBsYENLl0mXGCVZD3nxyXvmMGoB3VyaxhDjbrtlmHjEqDpd7zvTUiEpAMe+kuIMDE4CQ879BgVYfgIqhKNIoeR3ZeIRDsn0p6ic3x2Wzh8VylMuYkgylVKlbGQSg=
Message-ID: <86802c440610232115r76d98803o4293cdafce1fd95c@mail.gmail.com>
Date: Mon, 23 Oct 2006 21:15:31 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: "Andi Kleen" <ak@muc.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       "Andrew Morton" <akpm@osdl.org>
Subject: [PATCH] x86_64 irq: reuse vector for __assign_irq_vector
Cc: "Muli Ben-Yehuda" <muli@il.ibm.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Adrian Bunk" <bunk@stusta.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_2177_31879920.1161663331902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_2177_31879920.1161663331902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

in phys flat mode, when using set_xxx_irq_affinity to irq balance from
one cpu to another,  _assign_irq_vector will get to increase last used
vector and get new vector. this will use up the vector if enough
set_xxx_irq_affintiy are called. and end with using same vector in
different cpu for different irq. (that is not what we want, we only
want to use same vector in different cpu for different irq when more
than 0x240 irq needed). To keep it simple, the vector should be reused
instead of getting new vector.

Also according to Eric's review, make it more generic to be used with
flat mode too.

This patch need to be applied over Eric's irq: cpu_online_map patch.


Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-off-by: Yinghai Lu <yinghai.lu@amd.com>

------=_Part_2177_31879920.1161663331902
Content-Type: text/x-patch; name=io_apic_reuse_vector.diff; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_etnrzxno
Content-Disposition: attachment; filename="io_apic_reuse_vector.diff"

LS0tIGxpbnV4LTIuNi9hcmNoL3g4Nl82NC9rZXJuZWwvaW9fYXBpYy5jCTIwMDYtMTAtMjMgMTg6
NDQ6MDUuMDAwMDAwMDAwIC0wNzAwCisrKyBsaW51eC0yLjYueHgvYXJjaC94ODZfNjQva2VybmVs
L2lvX2FwaWMuYwkyMDA2LTEwLTIzIDE4OjEwOjA4LjAwMDAwMDAwMCAtMDcwMApAQCAtNjEzLDgg
KzYxMyw5IEBACiAJICogMHg4MCwgYmVjYXVzZSBpbnQgMHg4MCBpcyBobSwga2luZCBvZiBpbXBv
cnRhbnRpc2guIDspCiAJICovCiAJc3RhdGljIGludCBjdXJyZW50X3ZlY3RvciA9IEZJUlNUX0RF
VklDRV9WRUNUT1IsIGN1cnJlbnRfb2Zmc2V0ID0gMDsKLQlpbnQgb2xkX3ZlY3RvciA9IC0xOwot
CWludCBjcHU7CisJaW50IHZlY3RvciA9IC0xLCBvbGRfdmVjdG9yID0gLTE7CisJY3B1bWFza190
IGRvbWFpbiwgbmV3X21hc2s7CisJaW50IGNwdSwgbmV3X2NwdTsKIAogCUJVR19PTigodW5zaWdu
ZWQpaXJxID49IE5SX0lSUV9WRUNUT1JTKTsKIApAQCAtNjI0LDE1ICs2MjUsMzAgQEAKIAlpZiAo
aXJxX3ZlY3RvcltpcnFdID4gMCkKIAkJb2xkX3ZlY3RvciA9IGlycV92ZWN0b3JbaXJxXTsKIAlp
ZiAob2xkX3ZlY3RvciA+IDApIHsKLQkJY3B1c19hbmQoKnJlc3VsdCwgaXJxX2RvbWFpbltpcnFd
LCBtYXNrKTsKLQkJaWYgKCFjcHVzX2VtcHR5KCpyZXN1bHQpKQotCQkJcmV0dXJuIG9sZF92ZWN0
b3I7CisJCS8qIHRyeSB0byByZXVzZSB2ZWN0b3IgKi8KKwkJZm9yX2VhY2hfY3B1X21hc2soY3B1
LCBtYXNrKSB7CisJCQlpbnQgY2FuX3JldXNlID0gMTsKKwkJCWRvbWFpbiA9IHZlY3Rvcl9hbGxv
Y2F0aW9uX2RvbWFpbihjcHUpOworCQkJY3B1c19hbmQobmV3X21hc2ssIGRvbWFpbiwgY3B1X29u
bGluZV9tYXApOworCQkJZm9yX2VhY2hfY3B1X21hc2sobmV3X2NwdSwgbmV3X21hc2spIHsKKwkJ
CQlpbnQgb2xkX2lycTsKKwkJCQlvbGRfaXJxID0gcGVyX2NwdSh2ZWN0b3JfaXJxLCBuZXdfY3B1
KVtvbGRfdmVjdG9yXTsKKwkJCQlpZiAoIChvbGRfaXJxICE9IGlycSkgJiYgKG9sZF9pcnEgIT0g
LTEpKSB7CisJCQkJCWNhbl9yZXVzZSA9IDA7CisJCQkJCWJyZWFrOworCQkJCX0KKwkJCX0KKwor
CQkJaWYoIWNhbl9yZXVzZSkgY29udGludWU7CisKKwkJCXZlY3RvciA9IG9sZF92ZWN0b3I7CisJ
CQlnb3RvIGZvdW5kX29uZTsJCisJCX0KKwogCX0KIAogCWZvcl9lYWNoX2NwdV9tYXNrKGNwdSwg
bWFzaykgewotCQljcHVtYXNrX3QgZG9tYWluLCBuZXdfbWFzazsKLQkJaW50IG5ld19jcHU7Ci0J
CWludCB2ZWN0b3IsIG9mZnNldDsKKwkJaW50IG9mZnNldDsKIAogCQlkb21haW4gPSB2ZWN0b3Jf
YWxsb2NhdGlvbl9kb21haW4oY3B1KTsKIAkJY3B1c19hbmQobmV3X21hc2ssIGRvbWFpbiwgY3B1
X29ubGluZV9tYXApOwpAQCAtNjU2LDIxICs2NzIsMjcgQEAKIAkJLyogRm91bmQgb25lISAqLwog
CQljdXJyZW50X3ZlY3RvciA9IHZlY3RvcjsKIAkJY3VycmVudF9vZmZzZXQgPSBvZmZzZXQ7Ci0J
CWlmIChvbGRfdmVjdG9yID49IDApIHsKLQkJCWNwdW1hc2tfdCBvbGRfbWFzazsKLQkJCWludCBv
bGRfY3B1OwotCQkJY3B1c19hbmQob2xkX21hc2ssIGlycV9kb21haW5baXJxXSwgY3B1X29ubGlu
ZV9tYXApOwotCQkJZm9yX2VhY2hfY3B1X21hc2sob2xkX2NwdSwgb2xkX21hc2spCi0JCQkJcGVy
X2NwdSh2ZWN0b3JfaXJxLCBvbGRfY3B1KVtvbGRfdmVjdG9yXSA9IC0xOwotCQl9Ci0JCWZvcl9l
YWNoX2NwdV9tYXNrKG5ld19jcHUsIG5ld19tYXNrKQotCQkJcGVyX2NwdSh2ZWN0b3JfaXJxLCBu
ZXdfY3B1KVt2ZWN0b3JdID0gaXJxOwotCQlpcnFfdmVjdG9yW2lycV0gPSB2ZWN0b3I7Ci0JCWly
cV9kb21haW5baXJxXSA9IGRvbWFpbjsKLQkJY3B1c19hbmQoKnJlc3VsdCwgZG9tYWluLCBtYXNr
KTsKLQkJcmV0dXJuIHZlY3RvcjsKKwkJCisJCWdvdG8gZm91bmRfb25lOwogCX0KKwogCXJldHVy
biAtRU5PU1BDOworCitmb3VuZF9vbmU6CisJaWYgKG9sZF92ZWN0b3IgPj0gMCkgeworCQljcHVt
YXNrX3Qgb2xkX21hc2s7CisJCWludCBvbGRfY3B1OworCQljcHVzX2FuZChvbGRfbWFzaywgaXJx
X2RvbWFpbltpcnFdLCBjcHVfb25saW5lX21hcCk7CisJCWZvcl9lYWNoX2NwdV9tYXNrKG9sZF9j
cHUsIG9sZF9tYXNrKQorCQkJcGVyX2NwdSh2ZWN0b3JfaXJxLCBvbGRfY3B1KVtvbGRfdmVjdG9y
XSA9IC0xOworCX0KKwlmb3JfZWFjaF9jcHVfbWFzayhuZXdfY3B1LCBuZXdfbWFzaykKKwkJcGVy
X2NwdSh2ZWN0b3JfaXJxLCBuZXdfY3B1KVt2ZWN0b3JdID0gaXJxOworCWlycV92ZWN0b3JbaXJx
XSA9IHZlY3RvcjsKKwlpcnFfZG9tYWluW2lycV0gPSBkb21haW47CisJY3B1c19hbmQoKnJlc3Vs
dCwgZG9tYWluLCBtYXNrKTsKKwlyZXR1cm4gdmVjdG9yOworCiB9CiAKIHN0YXRpYyBpbnQgYXNz
aWduX2lycV92ZWN0b3IoaW50IGlycSwgY3B1bWFza190IG1hc2ssIGNwdW1hc2tfdCAqcmVzdWx0
KQo=
------=_Part_2177_31879920.1161663331902--
