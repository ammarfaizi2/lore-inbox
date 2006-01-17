Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWAQTTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWAQTTb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 14:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWAQTTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 14:19:31 -0500
Received: from web25802.mail.ukl.yahoo.com ([217.12.10.187]:64949 "HELO
	web25802.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751257AbWAQTTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 14:19:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.es;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=TD7iKQAKZE+4k7f5VzueAXPzPeniNd/2oS+MYWtQqR4CiPO0PwgX7txL9dBsBXh4mwdMe5MszkVu2i5WWS3j7BvNCoxUB09WMEnp8HkI680x+jQZz0f4SSlVgkK8QYGbxUJqBoe2Hqsy9kEO0krJFJLCTfxZJGylNqzSDFPvkLA=  ;
Message-ID: <20060117191924.85950.qmail@web25802.mail.ukl.yahoo.com>
Date: Tue, 17 Jan 2006 20:19:23 +0100 (CET)
From: Albert Herranz <albert_herranz@yahoo.es>
Subject: [PATCH 2.6.16-rc1] powerpc: fix for kexec ppc32
To: fastboot@osdl.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-189009834-1137525563=:69180"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-189009834-1137525563=:69180
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi,

Signed-off-by: Albert Herranz
<albert_herranz@yahoo.es>

The following patch fixes kexec on ppc32.
o kexec.h is included from assembly code, thus C code
must be properly protected.
o (embedded) ppc32 systems use machine_kexec_simple
whose declaration vanished during a recent powerpc
merge change.

Cheers,
Albert



	
	
		
______________________________________________ 
LLama Gratis a cualquier PC del Mundo. 
Llamadas a fijos y móviles desde 1 céntimo por minuto. 
http://es.voice.yahoo.com
--0-189009834-1137525563=:69180
Content-Type: text/x-patch; name="kexec-ppc32-fix.patch"
Content-Description: 3855670793-kexec-ppc32-fix.patch
Content-Disposition: inline; filename="kexec-ppc32-fix.patch"

--- a/include/asm-powerpc/kexec.h	2006-01-17 19:08:34.000000000 +0100
+++ b/include/asm-powerpc/kexec.h	2006-01-17 19:10:45.000000000 +0100
@@ -33,6 +33,7 @@
 
 #ifdef CONFIG_KEXEC
 
+#ifndef __ASSEMBLY__
 #ifdef __powerpc64__
 /*
  * This function is responsible for capturing register states if coming
@@ -104,7 +105,6 @@ static inline void crash_setup_regs(stru
 					struct pt_regs *oldregs) { }
 #endif /* !__powerpc64 __ */
 
-#ifndef __ASSEMBLY__
 #define MAX_NOTE_BYTES 1024
 
 #ifdef __powerpc64__
@@ -121,6 +121,8 @@ extern void default_machine_kexec(struct
 extern int default_machine_kexec_prepare(struct kimage *image);
 extern void default_machine_crash_shutdown(struct pt_regs *regs);
 
+extern void machine_kexec_simple(struct kimage *image);
+
 #endif /* ! __ASSEMBLY__ */
 #endif /* CONFIG_KEXEC */
 #endif /* __KERNEL__ */

--0-189009834-1137525563=:69180--
