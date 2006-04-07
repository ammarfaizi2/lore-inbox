Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWDGGD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWDGGD2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 02:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWDGGD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 02:03:28 -0400
Received: from wproxy.gmail.com ([64.233.184.235]:57205 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932271AbWDGGD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 02:03:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=jlmC2yyJokgs3JVyApJ8ZAKIQFtFbx9xkne1/OGbrvNRhqEGB8r5BFBaYF2sCQm86zHhTGybM7hv+93T4aj0TgOwuPPsRyx13XVoFOppI8LHBPRzLbmfGIOyzD8huVQqHEeAmi6rcCDv1QPGe/MHGqxMeVP4c/9hSjmAGgAFkEc=
Message-ID: <489ecd0c0604062303n562ab1bav27f8abca333a08c2@mail.gmail.com>
Date: Fri, 7 Apr 2006 14:03:24 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] use "#ifdef __KERNEL" to avoid compile error in input.h
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_36146_4062521.1144389804736"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_36146_4062521.1144389804736
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

    In linux/input.h, struct input_device_id uses type kernel_ulong_t,
which is defined in linux/mod_devicetable.h,  but which is only
included when __KERNEL__ is defined. So struct input_device_id should
also be exported only in kernel mode.

Signed-off-by: Luke Yang <luke.adi@gmail.com>

diff --git a/include/linux/input.h b/include/linux/input.h
index b0e612d..0319b65 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -805,6 +805,7 @@ #define FF_AUTOCENTER       0x61

 #define FF_MAX         0x7f

+#ifdef __KERNEL__
 struct input_device_id {

        kernel_ulong_t flags;
@@ -823,6 +824,7 @@ struct input_device_id {

        kernel_ulong_t driver_info;
 };
+#endif

 /*
  * Structure for hotplug & device<->driver matching.

Best regards,
Luke Yang, Blackfin Linux kernel maintainer
luke.adi@gmail.com

------=_Part_36146_4062521.1144389804736
Content-Type: text/x-patch; name=correct_kernel_mode_define_of_input_h.patch; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_elq4423s
Content-Disposition: attachment; filename="correct_kernel_mode_define_of_input_h.patch"

diff --git a/include/linux/input.h b/include/linux/input.h
index b0e612d..0319b65 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -805,6 +805,7 @@ #define FF_AUTOCENTER	0x61
 
 #define FF_MAX		0x7f
 
+#ifdef __KERNEL__
 struct input_device_id {
 
 	kernel_ulong_t flags;
@@ -823,6 +824,7 @@ struct input_device_id {
 
 	kernel_ulong_t driver_info;
 };
+#endif
 
 /*
  * Structure for hotplug & device<->driver matching.

------=_Part_36146_4062521.1144389804736--
