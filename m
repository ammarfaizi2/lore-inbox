Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262499AbVBXUmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbVBXUmK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 15:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbVBXUmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 15:42:08 -0500
Received: from web52310.mail.yahoo.com ([206.190.39.105]:47803 "HELO
	web52310.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262499AbVBXUlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 15:41:23 -0500
Message-ID: <20050224204119.90365.qmail@web52310.mail.yahoo.com>
Date: Thu, 24 Feb 2005 21:41:19 +0100 (CET)
From: Albert Herranz <albert_herranz@yahoo.es>
Subject: [PATCH 2.6.11-rc4-mm1] kexec: ppc: fix NORET_TYPE
To: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>
Cc: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-561465975-1109277679=:90189"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-561465975-1109277679=:90189
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi,

On ppc machine_kexec.c, we must apply NORET_TYPE to
machine_kexec() as it does not return, and make it
noreturn (otherwise compiler complains).

NORET_TYPE is in fact not needed for
machine_kexec_simple().

Signed-off-by: Albert Herranz

Cheers,
Albert


		
______________________________________________ 
Renovamos el Correo Yahoo!: ¡250 MB GRATIS! 
Nuevos servicios, más seguridad 
http://correo.yahoo.es
--0-561465975-1109277679=:90189
Content-Type: text/plain; name="kexec-ppc-NORET_TYPE-fix.patch"
Content-Description: kexec-ppc-NORET_TYPE-fix.patch
Content-Disposition: inline; filename="kexec-ppc-NORET_TYPE-fix.patch"

--- a/arch/ppc/kernel/machine_kexec.c	2005-02-24 20:00:14.000000000 +0100
+++ b/arch/ppc/kernel/machine_kexec.c	2005-02-24 21:55:51.000000000 +0100
@@ -69,7 +69,7 @@ void machine_kexec_cleanup(struct kimage
  * Do not allocate memory (or fail in any way) in machine_kexec().
  * We are past the point of no return, committed to rebooting now.
  */
-void machine_kexec(struct kimage *image)
+NORET_TYPE void machine_kexec(struct kimage *image)
 {
 	if (ppc_md.machine_kexec) {
 		ppc_md.machine_kexec(image);
@@ -80,6 +80,7 @@ void machine_kexec(struct kimage *image)
 		 */
 		machine_restart(NULL);
 	}
+	for(;;);
 }
 
 
@@ -90,7 +91,7 @@ void machine_kexec(struct kimage *image)
  * jumps to it.
  * A platform specific function may just call this one.
  */
-NORET_TYPE void machine_kexec_simple(struct kimage *image)
+void machine_kexec_simple(struct kimage *image)
 {
 	unsigned long page_list;
 	unsigned long reboot_code_buffer, reboot_code_buffer_phys;

--0-561465975-1109277679=:90189--
