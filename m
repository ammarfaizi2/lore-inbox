Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266474AbUJAUXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266474AbUJAUXF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 16:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266366AbUJAUVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 16:21:53 -0400
Received: from mail0.lsil.com ([147.145.40.20]:27090 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S266308AbUJAUQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:16:48 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E570230C985@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "Mukker, Atul" <Atulm@lsil.com>
Cc: "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'bunk@fs.tum.de'" <bunk@fs.tum.de>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Matt_Domsch@dell.com'" <Matt_Domsch@dell.com>,
       "Ju, Seokmann" <sju@lsil.com>
Subject: RE: [PATCH]: megaraid 2.20.4: Fixes a data corruption bug
Date: Fri, 1 Oct 2004 16:08:59 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James,

The submitted previous version of megaraid (2.20.3.1) had 
register_ioctl32_conversion & unregister_ioctl32_conversion 
defined to empty statements if CONFIG_COMPAT was _not_
defined.

But I think the preferred way was to have the occurances of 
(un)register_ioctl32_conversion in the code surrounded by 
#ifdef CONFIG_COMPAT ... #endif directly. In the kernel source
only register_ioctl32_conversion has these #ifdef .. #endif. The
unregister_ioctl32_conversion doesn't.

This patch should take care of that.

Thanks,
Sreenivas

---
diff -Naur linux-error/drivers/scsi/megaraid/megaraid_mm.c
linux-fixed/drivers/scsi/megaraid/megaraid_mm.c
--- linux-error/drivers/scsi/megaraid/megaraid_mm.c	2004-10-01
08:42:09.999572008 -0700
+++ linux-fixed/drivers/scsi/megaraid/megaraid_mm.c	2004-10-01
08:42:51.383280728 -0700
@@ -1151,7 +1151,9 @@
 	con_log(CL_DLEVEL1 , ("exiting common mod\n"));
 
 	unregister_chrdev(majorno, "megadev");
+#ifdef CONFIG_COMPAT
 	unregister_ioctl32_conversion(MEGAIOCCMD);
+#endif
 }
 
 module_init(mraid_mm_init);

---

>-----Original Message-----
>From: James Bottomley [mailto:James.Bottomley@SteelEye.com]
>Sent: Wednesday, September 29, 2004 11:16 PM
>To: Mukker, Atul
>Cc: Bagalkote, Sreenivas; 'linux-kernel@vger.kernel.org';
>'linux-scsi@vger.kernel.org'; 'bunk@fs.tum.de'; 'Andrew Morton';
>'Matt_Domsch@dell.com'
>Subject: RE: [PATCH]: megaraid 2.20.4: Fixes a data corruption bug
>
>
>On Wed, 2004-09-29 at 17:28, Mukker, Atul wrote:
>> Considering the criticality of this fix, we hope it make 
>into the 2.6.9
>> release candidate as soon as possible. Can you update us 
>with your views on
>> this.
>
>The attached patch is mangled by the emailer...do you have a pristine
>version?
>
>James
>
>
