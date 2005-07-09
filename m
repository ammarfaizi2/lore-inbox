Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVGICB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVGICB5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 22:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbVGICB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 22:01:57 -0400
Received: from web25801.mail.ukl.yahoo.com ([217.12.10.186]:21593 "HELO
	web25801.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261380AbVGICB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 22:01:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.es;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=amuRvYti5sc67pDx8OB13VF6iJmaMlAVUCeppa48pDJ8xgiq8j8Qv/3pBt+w4wxrVPxkTp8GS0E3BZKMmpdmfTRbFsXEJH5NJxn7F13K4CW9j+YfsY7sk4kBXFyqFJEE9PgxWoS8O8vvhHGoj8Ulh5hHsifSAdlktvoXfybw6RY=  ;
Message-ID: <20050709020148.64664.qmail@web25801.mail.ukl.yahoo.com>
Date: Sat, 9 Jul 2005 04:01:48 +0200 (CEST)
From: Albert Herranz <albert_herranz@yahoo.es>
Subject: [PATCH 2.6.13-rc2] kexec-ppc: fix for ksysfs crash_notes
To: Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@in.ibm.com>
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1269602165-1120874508=:63085"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1269602165-1120874508=:63085
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi,

Signed-off-by: Albert Herranz
<albert_herranz@yahoo.es>

The following patch prevents the crash dump helper
code  found within kexec from breaking ppc which still
lacks crash dump functionality.

As discussed in [1], ksysfs crash_notes attribute
handling was left under CONFIG_KEXEC for simplicity
although it is not strictly kexec related.

We provide here a dummy definition for crash_notes on
ppc.

Cheers,
Albert

[1]
http://lists.osdl.org/mailman/htdig/fastboot/2005-April/001324.html




		
______________________________________________ 
Renovamos el Correo Yahoo! 
Nuevos servicios, más seguridad 
http://correo.yahoo.es
--0-1269602165-1120874508=:63085
Content-Type: text/x-patch; name="kexec-ppc-ksysfs-crash_notes-fix.patch"
Content-Description: 1992546426-kexec-ppc-ksysfs-crash_notes-fix.patch
Content-Disposition: inline; filename="kexec-ppc-ksysfs-crash_notes-fix.patch"

--- a/include/asm-ppc/kexec.h	2005-07-09 00:44:31.000000000 +0200
+++ b/include/asm-ppc/kexec.h	2005-07-09 03:17:20.000000000 +0200
@@ -27,6 +27,8 @@
 
 #ifndef __ASSEMBLY__
 
+extern void *crash_notes;
+
 struct kimage;
 
 extern void machine_kexec_simple(struct kimage *image);
--- a/arch/ppc/kernel/machine_kexec.c	2005-07-09 00:44:25.000000000 +0200
+++ b/arch/ppc/kernel/machine_kexec.c	2005-07-09 03:45:18.000000000 +0200
@@ -28,6 +28,12 @@ typedef NORET_TYPE void (*relocate_new_k
 const extern unsigned char relocate_new_kernel[];
 const extern unsigned int relocate_new_kernel_size;
 
+/*
+ * Provide a dummy crash_notes definition while crash dump arrives to ppc.
+ * This prevents breakage of crash_notes attribute in kernel/ksysfs.c.
+ */
+void *crash_notes = NULL;
+
 void machine_shutdown(void)
 {
 	if (ppc_md.machine_shutdown)

--0-1269602165-1120874508=:63085--
