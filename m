Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129536AbRBXSqz>; Sat, 24 Feb 2001 13:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129545AbRBXSqh>; Sat, 24 Feb 2001 13:46:37 -0500
Received: from colorfullife.com ([216.156.138.34]:18190 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129536AbRBXSqT>;
	Sat, 24 Feb 2001 13:46:19 -0500
Message-ID: <000c01c09e92$25dd2e40$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: <pf-kernel@mirkwood.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Kernel 2.4.2 - kernel BUG at apic.c:220!
Date: Sat, 24 Feb 2001 19:45:43 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0005_01C09E9A.5FB4A3C0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0005_01C09E9A.5FB4A3C0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

> kernel BUG at apic.c:220!
>From apic.c:
<<<<<<<<<<<

        /*
         * Double-check wether this APIC is really registered.
         */
        if (!test_bit(GET_APIC_ID(apic_read(APIC_ID)),
&phys_cpu_present_map))
                BUG();
>>>>>>>>>>>
Really odd. That's usually a sign of a bad MP table.

Could you check your BIOS settings for an entry MP, or MPS, or
Multiprocessor Table?
Usually the options are 1.1 and 1.4 - just try the other one.

or try the attached patch - it prints 2 additional debug lines.

--
    Manfred



------=_NextPart_000_0005_01C09E9A.5FB4A3C0
Content-Type: application/octet-stream;
	name="patch.out"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch.out"

--- linux/arch/i386/kernel/apic.c.old	Tue Dec 05 21:43:48 2000
+++ linux/arch/i386/kernel/apic.c	Sat Feb 24 19:39:44 2001
@@ -216,8 +216,13 @@
 	/*
 	 * Double-check wether this APIC is really registered.
 	 */
-	if (!test_bit(GET_APIC_ID(apic_read(APIC_ID)), &phys_cpu_present_map))
+	if (!test_bit(GET_APIC_ID(apic_read(APIC_ID)), &phys_cpu_present_map)) =
{
+		printk(KERN_ERR "phys_cpu_present_map is %lxh.\n",
+					phys_cpu_present_map);
+		printk(KERN_ERR "Apic id is %ldh.\n",
+				GET_APIC_ID(apic_read(APIC_ID)));
 		BUG();
+	}
=20
 	/*
 	 * Intel recommends to set DFR, LDR and TPR before enabling

------=_NextPart_000_0005_01C09E9A.5FB4A3C0--

