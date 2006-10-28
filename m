Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751842AbWJ1Foj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbWJ1Foj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 01:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbWJ1Foj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 01:44:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:20017 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751842AbWJ1Foi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 01:44:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:references:x-google-sender-auth;
        b=frOmuGuR4HoncGqAiU65rf1IKaZzwNdx1Y/sUZyddfC4SYThkNoUTUutRlpgg1et9YVmlhP0RFdVD9VtPhr6Bta+k+xxzG7Bf16LZqktRzWn7IQOI3X96vT8DTg8y1XJKBD5vUYYliUR5SOdGK6IgIDkNtJFKeQ1TIJTIoJo9wQ=
Message-ID: <86802c440610272244q750f35a7hcbed50e58546d97@mail.gmail.com>
Date: Fri, 27 Oct 2006 22:44:36 -0700
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] x86_64 irq: reset more to default when clear irq_vector for destroy_irq
Cc: "Muli Ben-Yehuda" <muli@il.ibm.com>, "Andi Kleen" <ak@muc.de>,
       "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <m1ejsuqnyf.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_69251_21055565.1162014276979"
References: <5986589C150B2F49A46483AC44C7BCA412D763@ssvlexmb2.amd.com>
	 <m1ejsuqnyf.fsf@ebiederm.dsl.xmission.com>
X-Google-Sender-Auth: 7ab9ccfd5d891123
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_69251_21055565.1162014276979
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

revised version according to Eric. and it can be applied clearly to
current Linus's Tree.

Clear the irq releated entries in irq_vector, irq_domain and vector_irq
instead of clearing irq_vector only. So when new irq is created, it
could reuse that vector. (actually is the second loop scanning from
FIRST_DEVICE_VECTOR+8). This could avoid the vectors are used up
with enough module inserting and removing

Cc: Eric W. Biedierman <ebiederm@xmission.com>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-off-By: Yinghai Lu <yinghai.lu@amd.com>

------=_Part_69251_21055565.1162014276979
Content-Type: text/x-patch; name=io_apic_clear_irq_vector_1027.diff; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ettl4wte
Content-Disposition: attachment; filename="io_apic_clear_irq_vector_1027.diff"

ZGlmZiAtLWdpdCBhL2FyY2gveDg2XzY0L2tlcm5lbC9pb19hcGljLmMgYi9hcmNoL3g4Nl82NC9r
ZXJuZWwvaW9fYXBpYy5jCmluZGV4IGZlNDI5ZTUuLjk3NjYzNGMgMTAwNjQ0Ci0tLSBhL2FyY2gv
eDg2XzY0L2tlcm5lbC9pb19hcGljLmMKKysrIGIvYXJjaC94ODZfNjQva2VybmVsL2lvX2FwaWMu
YwpAQCAtNjg0LDYgKzY4NCwyMiBAQCBzdGF0aWMgaW50IGFzc2lnbl9pcnFfdmVjdG9yKGludCBp
cnEsIGNwCiAJcmV0dXJuIHZlY3RvcjsKIH0KIAorc3RhdGljIHZvaWQgX19jbGVhcl9pcnFfdmVj
dG9yKGludCBpcnEpCit7CisJY3B1bWFza190IG1hc2s7CisJaW50IGNwdSwgdmVjdG9yOworCisJ
QlVHX09OKCFpcnFfdmVjdG9yW2lycV0pOworCisJdmVjdG9yID0gaXJxX3ZlY3RvcltpcnFdOwor
CWNwdXNfYW5kKG1hc2ssIGlycV9kb21haW5baXJxXSwgY3B1X29ubGluZV9tYXApOworCWZvcl9l
YWNoX2NwdV9tYXNrKGNwdSwgbWFzaykKKwkJcGVyX2NwdSh2ZWN0b3JfaXJxLCBjcHUpW3ZlY3Rv
cl0gPSAtMTsKKworCWlycV92ZWN0b3JbaXJxXSA9IDA7CisJaXJxX2RvbWFpbltpcnFdID0gQ1BV
X01BU0tfTk9ORTsKK30KKwogdm9pZCBfX3NldHVwX3ZlY3Rvcl9pcnEoaW50IGNwdSkKIHsKIAkv
KiBJbml0aWFsaXplIHZlY3Rvcl9pcnEgb24gYSBuZXcgY3B1ICovCkBAIC0xNzcxLDcgKzE3ODcs
NyBAQCB2b2lkIGRlc3Ryb3lfaXJxKHVuc2lnbmVkIGludCBpcnEpCiAJZHluYW1pY19pcnFfY2xl
YW51cChpcnEpOwogCiAJc3Bpbl9sb2NrX2lycXNhdmUoJnZlY3Rvcl9sb2NrLCBmbGFncyk7Ci0J
aXJxX3ZlY3RvcltpcnFdID0gMDsKKwlfX2NsZWFyX2lycV92ZWN0b3IoaXJxKTsKIAlzcGluX3Vu
bG9ja19pcnFyZXN0b3JlKCZ2ZWN0b3JfbG9jaywgZmxhZ3MpOwogfQogCg==
------=_Part_69251_21055565.1162014276979--
