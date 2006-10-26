Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752132AbWJZJFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbWJZJFP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 05:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752125AbWJZJFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 05:05:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:42414 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752124AbWJZJE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 05:04:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:references:x-google-sender-auth;
        b=bgPmcFDso3yB+8JSCs8lvD94MeVKF/Fm8rGDdKlh1OX9opSbqEvdzMZJGrLnn2O49GsfFJMwE5eehQsIanOtIsp3+S+a9Cv7g/x4M8n+X48lDIvvoUiSd7ufdDVuSPtyairzBdsRVvq7RTgaa6OOwWdMOWXebWWjtfm3qpg3wi0=
Message-ID: <86802c440610260204t4620d25t2d2e40895203b17@mail.gmail.com>
Date: Thu, 26 Oct 2006 02:04:57 -0700
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Andi Kleen" <ak@muc.de>
Subject: Re: [PATCH] x86_64 irq: reuse vector for __assign_irq_vector
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Andrew Morton" <akpm@osdl.org>, "Muli Ben-Yehuda" <muli@il.ibm.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Adrian Bunk" <bunk@stusta.de>
In-Reply-To: <20061024170503.GA71966@muc.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_40117_24358168.1161853497644"
References: <86802c440610232115r76d98803o4293cdafce1fd95c@mail.gmail.com>
	 <20061024170503.GA71966@muc.de>
X-Google-Sender-Auth: 075983ea2b371f06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_40117_24358168.1161853497644
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Andi,
please check the revised patch: It can be appied to current linus't tree.

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

It also check if new domain and old domain is equal, to avoid extra operation.


Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-off-by: Yinghai Lu <yinghai.lu@amd.com>

------=_Part_40117_24358168.1161853497644
Content-Type: text/x-patch; name=io_apic_reuse_vector_1026.diff; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_etqxhek7
Content-Disposition: attachment; filename="io_apic_reuse_vector_1026.diff"

ZGlmZiAtLWdpdCBhL2FyY2gveDg2XzY0L2tlcm5lbC9pb19hcGljLmMgYi9hcmNoL3g4Nl82NC9r
ZXJuZWwvaW9fYXBpYy5jCmluZGV4IGZlNDI5ZTUuLjUxNTM1ZTggMTAwNjQ0Ci0tLSBhL2FyY2gv
eDg2XzY0L2tlcm5lbC9pb19hcGljLmMKKysrIGIvYXJjaC94ODZfNjQva2VybmVsL2lvX2FwaWMu
YwpAQCAtNjEzLDggKzYxMyw5IEBAIHN0YXRpYyBpbnQgX19hc3NpZ25faXJxX3ZlY3RvcihpbnQg
aXJxLCAKIAkgKiAweDgwLCBiZWNhdXNlIGludCAweDgwIGlzIGhtLCBraW5kIG9mIGltcG9ydGFu
dGlzaC4gOykKIAkgKi8KIAlzdGF0aWMgaW50IGN1cnJlbnRfdmVjdG9yID0gRklSU1RfREVWSUNF
X1ZFQ1RPUiwgY3VycmVudF9vZmZzZXQgPSAwOwotCWludCBvbGRfdmVjdG9yID0gLTE7Ci0JaW50
IGNwdTsKKwlpbnQgdmVjdG9yID0gLTEsIG9sZF92ZWN0b3IgPSAtMTsKKwljcHVtYXNrX3QgZG9t
YWluLCBuZXdfbWFzazsKKwlpbnQgY3B1LCBuZXdfY3B1OwogCiAJQlVHX09OKCh1bnNpZ25lZClp
cnEgPj0gTlJfSVJRX1ZFQ1RPUlMpOwogCkBAIC02MjQsMTUgKzYyNSwzOCBAQCBzdGF0aWMgaW50
IF9fYXNzaWduX2lycV92ZWN0b3IoaW50IGlycSwgCiAJaWYgKGlycV92ZWN0b3JbaXJxXSA+IDAp
CiAJCW9sZF92ZWN0b3IgPSBpcnFfdmVjdG9yW2lycV07CiAJaWYgKG9sZF92ZWN0b3IgPiAwKSB7
Ci0JCWNwdXNfYW5kKCpyZXN1bHQsIGlycV9kb21haW5baXJxXSwgbWFzayk7Ci0JCWlmICghY3B1
c19lbXB0eSgqcmVzdWx0KSkKLQkJCXJldHVybiBvbGRfdmVjdG9yOworCQkvKiB0cnkgdG8gcmV1
c2UgdmVjdG9yICovCisJCWZvcl9lYWNoX2NwdV9tYXNrKGNwdSwgbWFzaykgeworCQkJaW50IGNh
bl9yZXVzZSA9IDE7CisKKwkJCWRvbWFpbiA9IHZlY3Rvcl9hbGxvY2F0aW9uX2RvbWFpbihjcHUp
OworCQkJY3B1c19hbmQobmV3X21hc2ssIGRvbWFpbiwgY3B1X29ubGluZV9tYXApOworCisJCQlp
ZiAoY3B1c19lcXVhbChkb21haW4sIGlycV9kb21haW5baXJxXSkpIHsKKwkJCQljcHVzX2FuZCgq
cmVzdWx0LCBpcnFfZG9tYWluW2lycV0sIG1hc2spOworCQkJCWlmICghY3B1c19lbXB0eSgqcmVz
dWx0KSkgIAorCQkJCQlyZXR1cm4gb2xkX3ZlY3RvcjsKKwkJCX0KKwkJCQorCQkJZm9yX2VhY2hf
Y3B1X21hc2sobmV3X2NwdSwgbmV3X21hc2spIHsKKwkJCQlpbnQgb2xkX2lycTsKKwkJCQlvbGRf
aXJxID0gcGVyX2NwdSh2ZWN0b3JfaXJxLCBuZXdfY3B1KVtvbGRfdmVjdG9yXTsKKwkJCQlpZiAo
IChvbGRfaXJxICE9IGlycSkgJiYgKG9sZF9pcnEgIT0gLTEpKSB7CisJCQkJCWNhbl9yZXVzZSA9
IDA7CisJCQkJCWJyZWFrOworCQkJCX0KKwkJCX0KKworCQkJaWYoIWNhbl9yZXVzZSkgCisJCQkJ
Y29udGludWU7CisKKwkJCXZlY3RvciA9IG9sZF92ZWN0b3I7CisJCQlnb3RvIGZvdW5kX29uZTsJ
CisJCX0KIAl9CiAKIAlmb3JfZWFjaF9jcHVfbWFzayhjcHUsIG1hc2spIHsKLQkJY3B1bWFza190
IGRvbWFpbiwgbmV3X21hc2s7Ci0JCWludCBuZXdfY3B1OwotCQlpbnQgdmVjdG9yLCBvZmZzZXQ7
CisJCWludCBvZmZzZXQ7CiAKIAkJZG9tYWluID0gdmVjdG9yX2FsbG9jYXRpb25fZG9tYWluKGNw
dSk7CiAJCWNwdXNfYW5kKG5ld19tYXNrLCBkb21haW4sIGNwdV9vbmxpbmVfbWFwKTsKQEAgLTY1
NiwyMSArNjgwLDI3IEBAIG5leHQ6CiAJCS8qIEZvdW5kIG9uZSEgKi8KIAkJY3VycmVudF92ZWN0
b3IgPSB2ZWN0b3I7CiAJCWN1cnJlbnRfb2Zmc2V0ID0gb2Zmc2V0OwotCQlpZiAob2xkX3ZlY3Rv
ciA+PSAwKSB7Ci0JCQljcHVtYXNrX3Qgb2xkX21hc2s7Ci0JCQlpbnQgb2xkX2NwdTsKLQkJCWNw
dXNfYW5kKG9sZF9tYXNrLCBpcnFfZG9tYWluW2lycV0sIGNwdV9vbmxpbmVfbWFwKTsKLQkJCWZv
cl9lYWNoX2NwdV9tYXNrKG9sZF9jcHUsIG9sZF9tYXNrKQotCQkJCXBlcl9jcHUodmVjdG9yX2ly
cSwgb2xkX2NwdSlbb2xkX3ZlY3Rvcl0gPSAtMTsKLQkJfQotCQlmb3JfZWFjaF9jcHVfbWFzayhu
ZXdfY3B1LCBuZXdfbWFzaykKLQkJCXBlcl9jcHUodmVjdG9yX2lycSwgbmV3X2NwdSlbdmVjdG9y
XSA9IGlycTsKLQkJaXJxX3ZlY3RvcltpcnFdID0gdmVjdG9yOwotCQlpcnFfZG9tYWluW2lycV0g
PSBkb21haW47Ci0JCWNwdXNfYW5kKCpyZXN1bHQsIGRvbWFpbiwgbWFzayk7Ci0JCXJldHVybiB2
ZWN0b3I7CisJCQorCQlnb3RvIGZvdW5kX29uZTsKIAl9CisKIAlyZXR1cm4gLUVOT1NQQzsKKwor
Zm91bmRfb25lOgorCWlmIChvbGRfdmVjdG9yID49IDApIHsKKwkJY3B1bWFza190IG9sZF9tYXNr
OworCQlpbnQgb2xkX2NwdTsKKwkJY3B1c19hbmQob2xkX21hc2ssIGlycV9kb21haW5baXJxXSwg
Y3B1X29ubGluZV9tYXApOworCQlmb3JfZWFjaF9jcHVfbWFzayhvbGRfY3B1LCBvbGRfbWFzaykK
KwkJCXBlcl9jcHUodmVjdG9yX2lycSwgb2xkX2NwdSlbb2xkX3ZlY3Rvcl0gPSAtMTsKKwl9CisJ
Zm9yX2VhY2hfY3B1X21hc2sobmV3X2NwdSwgbmV3X21hc2spCisJCXBlcl9jcHUodmVjdG9yX2ly
cSwgbmV3X2NwdSlbdmVjdG9yXSA9IGlycTsKKwlpcnFfdmVjdG9yW2lycV0gPSB2ZWN0b3I7CisJ
aXJxX2RvbWFpbltpcnFdID0gZG9tYWluOworCWNwdXNfYW5kKCpyZXN1bHQsIGRvbWFpbiwgbWFz
ayk7CisJcmV0dXJuIHZlY3RvcjsKKwogfQogCiBzdGF0aWMgaW50IGFzc2lnbl9pcnFfdmVjdG9y
KGludCBpcnEsIGNwdW1hc2tfdCBtYXNrLCBjcHVtYXNrX3QgKnJlc3VsdCkK
------=_Part_40117_24358168.1161853497644--
