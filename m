Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751635AbWJWHCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635AbWJWHCr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 03:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbWJWHCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 03:02:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:58491 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751633AbWJWHCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 03:02:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:x-google-sender-auth;
        b=f3Gn7+6tibgdJv0L25dCGso38aQwVRDD7/7T1VoIXNdWrv5UTOwIwKQFEKsWcRa3SuY3LFUEBDV3uHXgQOiBbgEg6qiZMIKXOGeDeb7YKcDFLOHWSVZgmtJcQNVJC3ebg161rJgkwhwEqCtnXswmFl31uwotXV+pv+0TIoXCCyM=
Message-ID: <86802c440610230002x340e3f95pa8ee98caa02e7e@mail.gmail.com>
Date: Mon, 23 Oct 2006 00:02:44 -0700
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Andi Kleen" <ak@muc.de>, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH] x86_64 irq: reuse vector for set_xxx_irq_affinity in phys flat mode
Cc: "Muli Ben-Yehuda" <muli@il.ibm.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Adrian Bunk" <bunk@stusta.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_156448_9454192.1161586964045"
X-Google-Sender-Auth: e82ede9371677e85
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_156448_9454192.1161586964045
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

in phys flat mode, when using set_xxx_irq_affinity to irq balance from
one cpu to another,  _assign_irq_vector will get to increase last used
vector and get new vector. this will use up the vector if enough
set_xxx_irq_affintiy are called. and end with using same vector in
different cpu for different irq. (that is not what we want, we only
want to use same vector in different cpu for different irq when more
than 0x240 irq needed). To keep it simple, the vector should be resued
from one cpu to another instead of getting new vector.

Signed-off-by: Yinghai Lu <yinghai.lu@amd.com>

------=_Part_156448_9454192.1161586964045
Content-Type: text/x-patch; name=io_apic_c_reuse_vector.diff; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_etmilu4p
Content-Disposition: attachment; filename="io_apic_c_reuse_vector.diff"

ZGlmZiAtLWdpdCBhL2FyY2gveDg2XzY0L2tlcm5lbC9pb19hcGljLmMgYi9hcmNoL3g4Nl82NC9r
ZXJuZWwvaW9fYXBpYy5jCmluZGV4IGIwMDAwMTcuLjM5ODlmYTUgMTAwNjQ0Ci0tLSBhL2FyY2gv
eDg2XzY0L2tlcm5lbC9pb19hcGljLmMKKysrIGIvYXJjaC94ODZfNjQva2VybmVsL2lvX2FwaWMu
YwpAQCAtNjI0LDExICs2MjQsMzIgQEAgc3RhdGljIGludCBfX2Fzc2lnbl9pcnFfdmVjdG9yKGlu
dCBpcnEsIAogCWlmIChpcnFfdmVjdG9yW2lycV0gPiAwKQogCQlvbGRfdmVjdG9yID0gaXJxX3Zl
Y3RvcltpcnFdOwogCWlmIChvbGRfdmVjdG9yID4gMCkgeworCQljcHVtYXNrX3QgZG9tYWluLCBu
ZXdfbWFzaywgb2xkX21hc2s7CisJCWludCBuZXdfY3B1LCBvbGRfY3B1OwogCQljcHVzX2FuZCgq
cmVzdWx0LCBpcnFfZG9tYWluW2lycV0sIG1hc2spOwogCQlpZiAoIWNwdXNfZW1wdHkoKnJlc3Vs
dCkpCiAJCQlyZXR1cm4gb2xkX3ZlY3RvcjsKKworCQkvKiB0cnkgdG8gcmV1c2UgdmVjdG9yIGZv
ciBwaHlzIGZsYXQgKi8KKwkJZG9tYWluID0gdmVjdG9yX2FsbG9jYXRpb25fZG9tYWluKGNwdSk7
CisJCWNwdXNfYW5kKG5ld19tYXNrLCBkb21haW4sIGNwdV9vbmxpbmVfbWFwKTsKKwkJZm9yX2Vh
Y2hfY3B1X21hc2sobmV3X2NwdSwgbmV3X21hc2spCisJCQlpZiAocGVyX2NwdSh2ZWN0b3JfaXJx
LCBuZXdfY3B1KVtvbGRfdmVjdG9yXSAhPSAtMSkKKwkJCQlnb3RvIG5ld192ZWN0b3I7CisJCS8q
IFdlIGNhbiByZXVzZSBpdCAqLwkKKwkJY3B1c19hbmQob2xkX21hc2ssIGlycV9kb21haW5baXJx
XSwgY3B1X29ubGluZV9tYXApOworCQlmb3JfZWFjaF9jcHVfbWFzayhvbGRfY3B1LCBvbGRfbWFz
ayk7CisJCQlwZXJfY3B1KHZlY3Rvcl9pcnEsIG9sZF9jcHUpW29sZF92ZWN0b3JdID0gLTE7CisJ
CWZvcl9lYWNoX2NwdV9tYXNrKG5ld19jcHUsIG5ld19tYXNrKQorCQkJcGVyX2NwdSh2ZWN0b3Jf
aXJxLCBuZXdfY3B1KVtvbGRfdmVjdG9yXSA9IGlycTsKKwkJaXJxX2RvbWFpbltpcnFdID0gZG9t
YWluOworCQljcHVzX2FuZCgqcmVzdWx0LCBkb21haW4sIG1hc2spOworCQlyZXR1cm4gb2xkX3Zl
Y3RvcjsKKwkJCiAJfQogCituZXdfdmVjdG9yOgorCiAJZm9yX2VhY2hfY3B1X21hc2soY3B1LCBt
YXNrKSB7CiAJCWNwdW1hc2tfdCBkb21haW47CiAJCWludCBmaXJzdCwgbmV3X2NwdTsK
------=_Part_156448_9454192.1161586964045--
