Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965756AbWKEAYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965756AbWKEAYJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 19:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965761AbWKEAYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 19:24:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:24662 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965756AbWKEAYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 19:24:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=K2/0tU3oY19M3Q6sFP5MMXf24B3h2LEZPHLcsB2mY4Tw7bsKUtC4RIL8oC/YC6aOqCc1I7PQgRUqH5Y99gPw1S7EC/+q3JU8JSHtyBN1nop/XRiJIsG6SF/duiuDWJehS20T9RjWV0NtE2wIVuIpFJwTEj9P8k+gkYWCupAHc0Q=
Message-ID: <a36005b50611041624x1b9f2602h8d5b90b3337953e2@mail.gmail.com>
Date: Sat, 4 Nov 2006 16:24:06 -0800
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
Subject: [PATCH] conditionalize some x86-64 options
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shouldn't the X86_MCE{INTEL,AMD} option depend on the other
manufacturer's CPU not being explicitly selected?

Signed-off-by: Ulrich Drepper <drepper@redhat.com>


diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
index 010d226..f414fe2 100644
--- a/arch/x86_64/Kconfig
+++ b/arch/x86_64/Kconfig
@@ -470,7 +470,7 @@ config X86_MCE

 config X86_MCE_INTEL
        bool "Intel MCE features"
-       depends on X86_MCE && X86_LOCAL_APIC
+       depends on X86_MCE && X86_LOCAL_APIC && !MK8
        default y
        help
           Additional support for intel specific MCE features such as
@@ -478,7 +478,7 @@ config X86_MCE_INTEL

 config X86_MCE_AMD
        bool "AMD MCE features"
-       depends on X86_MCE && X86_LOCAL_APIC
+       depends on X86_MCE && X86_LOCAL_APIC && !MPSC
        default y
        help
           Additional support for AMD specific MCE features such as
