Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVELIMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVELIMv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 04:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVELIMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 04:12:50 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:3867
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S261305AbVELIMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 04:12:34 -0400
Message-Id: <s2831dfd.009@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.4 
Date: Thu, 12 May 2005 10:12:46 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386 NMI on debug stack check correction
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part486B84EE.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part486B84EE.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Stack pointer comparisons for the NMI on debug stack check/fixup were
incorrect.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.12-rc4.base/arch/i386/kernel/entry.S	2005-05-11 =
17:27:52.217255616 +0200
+++ linux-2.6.12-rc4/arch/i386/kernel/entry.S	2005-05-11 17:50:36.2398926=
56 +0200
@@ -557,11 +557,10 @@ nmi_stack_fixup:
 nmi_debug_stack_check:
 	cmpw $__KERNEL_CS,16(%esp)
 	jne nmi_stack_correct
-	cmpl $debug - 1,(%esp)
-	jle nmi_stack_correct
+	cmpl $debug,(%esp)
+	jb nmi_stack_correct
 	cmpl $debug_esp_fix_insn,(%esp)
-	jle nmi_debug_stack_fixup
-nmi_debug_stack_fixup:
+	ja nmi_stack_correct
 	FIX_STACK(24,nmi_stack_correct, 1)
 	jmp nmi_stack_correct
=20



--=__Part486B84EE.0__=
Content-Type: text/plain; name="linux-2.6.12-rc4-i386-nmi.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="linux-2.6.12-rc4-i386-nmi.patch"

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Stack pointer comparisons for the NMI on debug stack check/fixup were
incorrect.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.12-rc4.base/arch/i386/kernel/entry.S	2005-05-11 17:27:52.217255616 +0200
+++ linux-2.6.12-rc4/arch/i386/kernel/entry.S	2005-05-11 17:50:36.239892656 +0200
@@ -557,11 +557,10 @@ nmi_stack_fixup:
 nmi_debug_stack_check:
 	cmpw $__KERNEL_CS,16(%esp)
 	jne nmi_stack_correct
-	cmpl $debug - 1,(%esp)
-	jle nmi_stack_correct
+	cmpl $debug,(%esp)
+	jb nmi_stack_correct
 	cmpl $debug_esp_fix_insn,(%esp)
-	jle nmi_debug_stack_fixup
-nmi_debug_stack_fixup:
+	ja nmi_stack_correct
 	FIX_STACK(24,nmi_stack_correct, 1)
 	jmp nmi_stack_correct
 

--=__Part486B84EE.0__=--
