Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269320AbUJFSby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269320AbUJFSby (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 14:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269352AbUJFSby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 14:31:54 -0400
Received: from mail0.lsil.com ([147.145.40.20]:62205 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S269320AbUJFSbh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 14:31:37 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E570230C999@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'James Bottomley'" <James.Bottomley@SteelEye.com>
Cc: "Mukker, Atul" <Atulm@lsil.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'bunk@fs.tum.de'" <bunk@fs.tum.de>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Matt_Domsch@dell.com'" <Matt_Domsch@dell.com>,
       "Ju, Seokmann" <sju@lsil.com>
Subject: RE: [PATCH 2/2]: megaraid 2.20.4: Fixes a data corruption bug
Date: Wed, 6 Oct 2004 14:23:50 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C4ABD1.A06C1950"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C4ABD1.A06C1950
Content-Type: text/plain;
	charset="iso-8859-1"

James,

Forgot to update the ChangeLog.megaraid in earlier patch. This second and
final patch
takes care of that.

Thanks,
Sreenivas


---

diff -Naur a/Documentation/scsi/ChangeLog.megaraid
b/Documentation/scsi/ChangeLog.megaraid
--- a/Documentation/scsi/ChangeLog.megaraid	2004-10-06
14:07:20.927247336 -0400
+++ b/Documentation/scsi/ChangeLog.megaraid	2004-10-06
14:12:27.154693688 -0400
@@ -1,3 +1,9 @@
+Release Date	: Wed Oct 06 11:15:29 EDT 2004 - Sreenivas Bagalkote
<sreenib@lsil.com>
+Current Version	: 2.20.4.0 (scsi module), 2.20.2.1 (cmm module)
+Older Version	: 2.20.4.0 (scsi module), 2.20.2.0 (cmm module)
+
+i.	Remove CONFIG_COMPAT around register_ioctl32_conversion
+
 Release Date	: Mon Sep 27 22:15:07 EDT 2004 - Atul Mukker
<atulm@lsil.com>
 Current Version	: 2.20.4.0 (scsi module), 2.20.2.0 (cmm module)
 Older Version	: 2.20.3.1 (scsi module), 2.20.2.0 (cmm module)

---

>-----Original Message-----
>From: Bagalkote, Sreenivas [mailto:sreenib@lsil.com]
>Sent: Wednesday, October 06, 2004 11:23 AM
>To: 'James Bottomley'
>Cc: Mukker, Atul; 'linux-kernel@vger.kernel.org';
>'linux-scsi@vger.kernel.org'; 'bunk@fs.tum.de'; 'Andrew Morton';
>'Matt_Domsch@dell.com'; Ju, Seokmann
>Subject: RE: [PATCH]: megaraid 2.20.4: Fixes a data corruption bug
>
>
>James,
>
>Here is the patch that removes the CONFIG_COMPAT.
>
>Thank you,
>Sreenivas
>
>---
>
>diff -Naur megaraid-compat/drivers/scsi/megaraid/megaraid_mm.c
>megaraid-nocompat/drivers/scsi/megaraid/megaraid_mm.c
>--- megaraid-compat/drivers/scsi/megaraid/megaraid_mm.c	
>2004-09-28
>17:33:58.000000000 -0400
>+++ megaraid-nocompat/drivers/scsi/megaraid/megaraid_mm.c	
>2004-10-06
>10:52:58.704174728 -0400
>@@ -10,7 +10,7 @@
>  *	   2 of the License, or (at your option) any later version.
>  *
>  * FILE		: megaraid_mm.c
>- * Version	: v2.20.2.0 (August 19 2004)
>+ * Version	: v2.20.2.1 (Oct 06 2004)
>  *
>  * Common management module
>  */
>@@ -60,7 +60,7 @@
> EXPORT_SYMBOL(mraid_mm_unregister_adp);
> 
> static int majorno;
>-static uint32_t drvr_ver	= 0x02200100;
>+static uint32_t drvr_ver	= 0x02200201;
> 
> static int adapters_count_g;
> static struct list_head adapters_list_g;
>@@ -1120,9 +1120,7 @@
> 
> 	INIT_LIST_HEAD(&adapters_list_g);
> 
>-#ifdef CONFIG_COMPAT
> 	register_ioctl32_conversion(MEGAIOCCMD, mraid_mm_compat_ioctl);
>-#endif
> 
> 	return 0;
> }
>diff -Naur megaraid-compat/drivers/scsi/megaraid/megaraid_mm.h
>megaraid-nocompat/drivers/scsi/megaraid/megaraid_mm.h
>--- megaraid-compat/drivers/scsi/megaraid/megaraid_mm.h	
>2004-09-28
>17:33:58.000000000 -0400
>+++ megaraid-nocompat/drivers/scsi/megaraid/megaraid_mm.h	
>2004-10-06
>11:12:53.064604344 -0400
>@@ -29,9 +29,9 @@
> #include "megaraid_ioctl.h"
> 
> 
>-#define LSI_COMMON_MOD_VERSION	"2.20.2.0"
>+#define LSI_COMMON_MOD_VERSION	"2.20.2.1"
> #define LSI_COMMON_MOD_EXT_VERSION	\
>-		"(Release Date: Thu Aug 19 09:58:33 EDT 2004)"
>+		"(Release Date: Wed Oct 06 11:15:29 EDT 2004)"
> 
> 
> #define LSI_DBGLVL			dbglevel
>
>---
>
>>-----Original Message-----
>>From: James Bottomley [mailto:James.Bottomley@SteelEye.com]
>>Sent: Tuesday, October 05, 2004 3:28 PM
>>To: Bagalkote, Sreenivas
>>Cc: Mukker, Atul; 'linux-kernel@vger.kernel.org';
>>'linux-scsi@vger.kernel.org'; 'bunk@fs.tum.de'; 'Andrew Morton';
>>'Matt_Domsch@dell.com'; Ju, Seokmann
>>Subject: RE: [PATCH]: megaraid 2.20.4: Fixes a data corruption bug
>>
>>
>>On Tue, 2004-10-05 at 14:15, Bagalkote, Sreenivas wrote:
>>> The latest megaraid driver on 
>>bk://linux-scsi.bkbits.net/scsi-misc-2.6 still
>>> has
>>> CONFIG_COMPAT around register_ioctl32_conversion. Will it 
>>remain in the
>>> source
>>> or should it go?
>>
>>I'd like to see a patch taking it out, please.
>>
>>James
>>
>>
>
>


------_=_NextPart_000_01C4ABD1.A06C1950
Content-Type: application/octet-stream;
	name="megaraid-nocompat2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="megaraid-nocompat2.patch"

diff -Naur a/Documentation/scsi/ChangeLog.megaraid =
b/Documentation/scsi/ChangeLog.megaraid=0A=
--- a/Documentation/scsi/ChangeLog.megaraid	2004-10-06 =
14:07:20.927247336 -0400=0A=
+++ b/Documentation/scsi/ChangeLog.megaraid	2004-10-06 =
14:12:27.154693688 -0400=0A=
@@ -1,3 +1,9 @@=0A=
+Release Date	: Wed Oct 06 11:15:29 EDT 2004 - Sreenivas Bagalkote =
<sreenib@lsil.com>=0A=
+Current Version	: 2.20.4.0 (scsi module), 2.20.2.1 (cmm module)=0A=
+Older Version	: 2.20.4.0 (scsi module), 2.20.2.0 (cmm module)=0A=
+=0A=
+i.	Remove CONFIG_COMPAT around register_ioctl32_conversion=0A=
+=0A=
 Release Date	: Mon Sep 27 22:15:07 EDT 2004 - Atul Mukker =
<atulm@lsil.com>=0A=
 Current Version	: 2.20.4.0 (scsi module), 2.20.2.0 (cmm module)=0A=
 Older Version	: 2.20.3.1 (scsi module), 2.20.2.0 (cmm module)=0A=

------_=_NextPart_000_01C4ABD1.A06C1950--
