Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752006AbWJYDqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbWJYDqe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 23:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbWJYDqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 23:46:34 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:50857 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752006AbWJYDqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 23:46:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:references:x-google-sender-auth;
        b=Cc70KehZJfviz3/gYjEDubX2HxThylq52ZyP1saS4/JQXUjAOsA0BZo/f1HQXjjJJ2uBNhpDVQWryOJR66Iudby0VRRAJU86VtyTRH+t7IM/2YI8LAF+1bX0d+m+aqfi5FhYEoMDUCQgLRhjAqfl3oBI3dLBQ1UA5HLd/xuXQxc=
Message-ID: <86802c440610242046g6ef06fcexf8776b5009cea23@mail.gmail.com>
Date: Tue, 24 Oct 2006 20:46:31 -0700
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Andi Kleen" <ak@muc.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       "Andrew Morton" <akpm@osdl.org>, "Muli Ben-Yehuda" <muli@il.ibm.com>
Subject: Re: [PATCH] x86_64 irq: reset more to default when clear irq_vector for destroy_irq
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA412D75C@ssvlexmb2.amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_19315_13627121.1161747991617"
References: <5986589C150B2F49A46483AC44C7BCA412D75C@ssvlexmb2.amd.com>
X-Google-Sender-Auth: 2c0b72e21e6a47b8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_19315_13627121.1161747991617
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

resend with gmail.

Clear the irq releated entries in irq_vector, irq_domain and vector_irq
instead of clearing irq_vector only. So when new irq is created, it
could reuse that vector. (actually is the second loop scanning from
FIRST_DEVICE_VECTOR+8). This could avoid the vectors are used up
with enough module inserting and removing

Cc: Eric W. Biedierman <ebiederm@xmission.com>
Signed-off-By: Yinghai Lu <yinghai.lu@amd.com>

------=_Part_19315_13627121.1161747991617
Content-Type: text/x-patch; name=io_apic_clear_irq_vector.diff; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_etp6by2y
Content-Disposition: attachment; filename="io_apic_clear_irq_vector.diff"

LS0tIGxpbnV4LTIuNi9hcmNoL3g4Nl82NC9rZXJuZWwvaW9fYXBpYy5jCTIwMDYtMTAtMjQgMTM6
NDA6NDguMDAwMDAwMDAwIC0wNzAwCisrKyBsaW51eC0yLjYueHgvYXJjaC94ODZfNjQva2VybmVs
L2lvX2FwaWMuYwkyMDA2LTEwLTI0IDE0OjAzOjA4LjAwMDAwMDAwMCAtMDcwMApAQCAtNzE2LDYg
KzcxNiwyMiBAQAogCXJldHVybiB2ZWN0b3I7CiB9CiAKK3N0YXRpYyB2b2lkIF9fY2xlYXJfaXJx
X3ZlY3RvcihpbnQgaXJxKQoreworCWludCBvbGRfdmVjdG9yID0gLTE7CisJaWYgKGlycV92ZWN0
b3JbaXJxXSA+IDApCisJCW9sZF92ZWN0b3IgPSBpcnFfdmVjdG9yW2lycV07CisJaWYgKG9sZF92
ZWN0b3IgPj0gMCkgeworCQljcHVtYXNrX3Qgb2xkX21hc2s7CisJCWludCBvbGRfY3B1OworCQlj
cHVzX2FuZChvbGRfbWFzaywgaXJxX2RvbWFpbltpcnFdLCBjcHVfb25saW5lX21hcCk7CisJCWZv
cl9lYWNoX2NwdV9tYXNrKG9sZF9jcHUsIG9sZF9tYXNrKQorCQkJcGVyX2NwdSh2ZWN0b3JfaXJx
LCBvbGRfY3B1KVtvbGRfdmVjdG9yXSA9IC0xOworCX0KKwlpcnFfdmVjdG9yW2lycV0gPSAwOwor
CWlycV9kb21haW5baXJxXSA9IENQVV9NQVNLX05PTkU7Cit9CisKIHZvaWQgX19zZXR1cF92ZWN0
b3JfaXJxKGludCBjcHUpCiB7CiAJLyogSW5pdGlhbGl6ZSB2ZWN0b3JfaXJxIG9uIGEgbmV3IGNw
dSAqLwpAQCAtMTgwMyw3ICsxODE5LDcgQEAKIAlkeW5hbWljX2lycV9jbGVhbnVwKGlycSk7CiAK
IAlzcGluX2xvY2tfaXJxc2F2ZSgmdmVjdG9yX2xvY2ssIGZsYWdzKTsKLQlpcnFfdmVjdG9yW2ly
cV0gPSAwOworCV9fY2xlYXJfaXJxX3ZlY3RvcihpcnEpOwogCXNwaW5fdW5sb2NrX2lycXJlc3Rv
cmUoJnZlY3Rvcl9sb2NrLCBmbGFncyk7CiB9CiAK
------=_Part_19315_13627121.1161747991617--
