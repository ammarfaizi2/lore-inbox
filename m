Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160996AbWJNJCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160996AbWJNJCA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 05:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1160995AbWJNJCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 05:02:00 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:36881 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932137AbWJNJB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 05:01:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:x-google-sender-auth;
        b=W3O3ZTJ8gVlsSofKzxugqGpkudh4x5POn9s22zO+hl6CXV1PoVYI+s5lcwD15sx1JXNHIo5QyDEM9q6HboGcUq+gWZBP49uVUjwJDqZ7ppLdsYMl+BTaIivlHafTWf0KHlClCFmw3pMxT7ztEelwCsP2JHDHEvcmnXqEk4UGStY=
Message-ID: <86802c440610140201h5edd9ceay454cc192583a69c1@mail.gmail.com>
Date: Sat, 14 Oct 2006 02:01:57 -0700
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>, "Andi Kleen" <ak@muc.de>
Subject: [PATCH] x86_64: using irq_domain in ioapic_retrigger_irq
Cc: "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       yhlu.kernel@gmail.com
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_58362_8265911.1160816517929"
X-Google-Sender-Auth: c09f811eaf604cf4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_58362_8265911.1160816517929
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

using irq_domain[irq] to get cpu_mask for send_IPI_mask

Signed-off-by: Yinghai Lu <yinghai.lu@amd.com>

diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index 44b55f8..6a07bce 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -1254,13 +1254,12 @@ static unsigned int startup_ioapic_irq(u
 static int ioapic_retrigger_irq(unsigned int irq)
 {
        cpumask_t mask;
-       unsigned vector;
+       int vector;

        vector = irq_vector[irq];
-       cpus_clear(mask);
-       cpu_set(vector >> 8, mask);
+       mask = irq_domain[irq];

-       send_IPI_mask(mask, vector & 0xff);
+       send_IPI_mask(mask, vector);

        return 1;
 }

------=_Part_58362_8265911.1160816517929
Content-Type: text/x-patch; name=io_apic_irq_trigger.diff; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_et9s39io
Content-Disposition: attachment; filename="io_apic_irq_trigger.diff"

ZGlmZiAtLWdpdCBhL2FyY2gveDg2XzY0L2tlcm5lbC9pb19hcGljLmMgYi9hcmNoL3g4Nl82NC9r
ZXJuZWwvaW9fYXBpYy5jCmluZGV4IDQ0YjU1ZjguLjZhMDdiY2UgMTAwNjQ0Ci0tLSBhL2FyY2gv
eDg2XzY0L2tlcm5lbC9pb19hcGljLmMKKysrIGIvYXJjaC94ODZfNjQva2VybmVsL2lvX2FwaWMu
YwpAQCAtMTI1NCwxMyArMTI1NCwxMiBAQCBzdGF0aWMgdW5zaWduZWQgaW50IHN0YXJ0dXBfaW9h
cGljX2lycSh1CiBzdGF0aWMgaW50IGlvYXBpY19yZXRyaWdnZXJfaXJxKHVuc2lnbmVkIGludCBp
cnEpCiB7CiAJY3B1bWFza190IG1hc2s7Ci0JdW5zaWduZWQgdmVjdG9yOworCWludCB2ZWN0b3I7
CiAKIAl2ZWN0b3IgPSBpcnFfdmVjdG9yW2lycV07Ci0JY3B1c19jbGVhcihtYXNrKTsKLQljcHVf
c2V0KHZlY3RvciA+PiA4LCBtYXNrKTsKKwltYXNrID0gaXJxX2RvbWFpbltpcnFdOwogCi0Jc2Vu
ZF9JUElfbWFzayhtYXNrLCB2ZWN0b3IgJiAweGZmKTsKKwlzZW5kX0lQSV9tYXNrKG1hc2ssIHZl
Y3Rvcik7CiAKIAlyZXR1cm4gMTsKIH0K
------=_Part_58362_8265911.1160816517929--
