Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWJNHTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWJNHTh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 03:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWJNHTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 03:19:37 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:56220 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932127AbWJNHTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 03:19:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:x-google-sender-auth;
        b=KWP9Eg4jDTG69G/dv03oIqWsZ9mncRewmBdf1rxzP/VCFcEfjme8L/3sv6bvyCzJY9ibkuwDZuHehV9BJUJh6BJZuXqoRJKg25v54s1suzwrr1pgQDgfveGHEWjryRSlQ0sFlIiswPTRwpHqC9IcjjQ5doGcK9sqC8X6SDs1DDo=
Message-ID: <86802c440610140019u6697e4e5kbac442910c9e86c8@mail.gmail.com>
Date: Sat, 14 Oct 2006 00:19:35 -0700
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: ak@suse.de
Subject: [PATCH] remove duplicated cpu_mask_to_apicid in x86_64 smp.h
Cc: "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       yhlu.kernel@gmail.com
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_58046_6155189.1160810375088"
X-Google-Sender-Auth: ea509a48aa9a0f02
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_58046_6155189.1160810375088
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

inline function cpu_mask_to_apicid in smp.h is duplicated with macro
in mach_apic.h.

Signed-off-by: Yinghai Lu <yinghai.lu@amd.com>


diff --git a/include/asm-x86_64/smp.h b/include/asm-x86_64/smp.h
index d6b7c05..7ae7e7d 100644
--- a/include/asm-x86_64/smp.h
+++ b/include/asm-x86_64/smp.h
@@ -82,11 +82,6 @@ extern u8 x86_cpu_to_apicid[NR_CPUS];        /*
 extern u8 x86_cpu_to_log_apicid[NR_CPUS];
 extern u8 bios_cpu_apicid[];

-static inline unsigned int cpu_mask_to_apicid(cpumask_t cpumask)
-{
-       return cpus_addr(cpumask)[0];
-}
-
 static inline int cpu_present_to_apicid(int mps_cpu)
 {
        if (mps_cpu < NR_CPUS)

------=_Part_58046_6155189.1160810375088
Content-Type: text/x-patch; name=x86_64_smp_h.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_et9ob5gr
Content-Disposition: attachment; filename="x86_64_smp_h.diff"

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvYXNtLXg4Nl82NC9zbXAuaCBiL2luY2x1ZGUvYXNtLXg4Nl82
NC9zbXAuaAppbmRleCBkNmI3YzA1Li43YWU3ZTdkIDEwMDY0NAotLS0gYS9pbmNsdWRlL2FzbS14
ODZfNjQvc21wLmgKKysrIGIvaW5jbHVkZS9hc20teDg2XzY0L3NtcC5oCkBAIC04MiwxMSArODIs
NiBAQCBleHRlcm4gdTggeDg2X2NwdV90b19hcGljaWRbTlJfQ1BVU107CS8qCiBleHRlcm4gdTgg
eDg2X2NwdV90b19sb2dfYXBpY2lkW05SX0NQVVNdOwogZXh0ZXJuIHU4IGJpb3NfY3B1X2FwaWNp
ZFtdOwogCi1zdGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCBjcHVfbWFza190b19hcGljaWQoY3B1
bWFza190IGNwdW1hc2spCi17Ci0JcmV0dXJuIGNwdXNfYWRkcihjcHVtYXNrKVswXTsKLX0KLQog
c3RhdGljIGlubGluZSBpbnQgY3B1X3ByZXNlbnRfdG9fYXBpY2lkKGludCBtcHNfY3B1KQogewog
CWlmIChtcHNfY3B1IDwgTlJfQ1BVUykK
------=_Part_58046_6155189.1160810375088--
