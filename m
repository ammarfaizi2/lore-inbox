Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269363AbUI3RJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269363AbUI3RJb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 13:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269358AbUI3RI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 13:08:58 -0400
Received: from mail0.lsil.com ([147.145.40.20]:50835 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S269357AbUI3RIS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 13:08:18 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E570230C97D@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "Mukker, Atul" <Atulm@lsil.com>
Cc: "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'bunk@fs.tum.de'" <bunk@fs.tum.de>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Matt_Domsch@dell.com'" <Matt_Domsch@dell.com>
Subject: [RESEND][PATCH]: megaraid 2.20.4: Fixes a data corruption bug
Date: Thu, 30 Sep 2004 13:00:16 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C4A70E.F57BF9A0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C4A70E.F57BF9A0
Content-Type: text/plain;
	charset="iso-8859-1"

Hello All,

I am resending this patch as an attachment.

Thanks,
Sreenivas



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


------_=_NextPart_000_01C4A70E.F57BF9A0
Content-Type: application/octet-stream;
	name="megaraid-2.20.4.0.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="megaraid-2.20.4.0.patch"

diff -Naur linux-2.6.9-rc2-mrbug/Documentation/scsi/ChangeLog.megaraid =
linux-2.6.9-rc2-fixed/Documentation/scsi/ChangeLog.megaraid=0A=
--- linux-2.6.9-rc2-mrbug/Documentation/scsi/ChangeLog.megaraid	=
2004-09-28 17:31:10.000000000 -0400=0A=
+++ linux-2.6.9-rc2-fixed/Documentation/scsi/ChangeLog.megaraid	=
2004-09-28 17:43:50.000000000 -0400=0A=
@@ -1,3 +1,11 @@=0A=
+Release Date	: Mon Sep 27 22:15:07 EDT 2004 - Atul Mukker =
<atulm@lsil.com>=0A=
+Current Version	: 2.20.4.0 (scsi module), 2.20.2.0 (cmm module)=0A=
+Older Version	: 2.20.3.1 (scsi module), 2.20.2.0 (cmm module)=0A=
+=0A=
+i.	Fix data corruption. Because of a typo in the driver, the IO =
packets=0A=
+	were wrongly shared by the ioctl path. This causes a whole IO =
command=0A=
+	to be replaced by an incoming ioctl command.=0A=
+=0A=
 Release Date	: Tue Aug 24 09:43:35 EDT 2004 - Atul Mukker =
<atulm@lsil.com>=0A=
 Current Version	: 2.20.3.1 (scsi module), 2.20.2.0 (cmm module)=0A=
 Older Version	: 2.20.3.0 (scsi module), 2.20.2.0 (cmm module)=0A=
diff -Naur linux-2.6.9-rc2-mrbug/drivers/scsi/megaraid/megaraid_mbox.c =
linux-2.6.9-rc2-fixed/drivers/scsi/megaraid/megaraid_mbox.c=0A=
--- linux-2.6.9-rc2-mrbug/drivers/scsi/megaraid/megaraid_mbox.c	=
2004-09-28 17:31:33.000000000 -0400=0A=
+++ linux-2.6.9-rc2-fixed/drivers/scsi/megaraid/megaraid_mbox.c	=
2004-09-28 17:43:50.000000000 -0400=0A=
@@ -10,7 +10,7 @@=0A=
  *	   2 of the License, or (at your option) any later version.=0A=
  *=0A=
  * FILE		: megaraid_mbox.c=0A=
- * Version	: v2.20.3.1 (August 24 2004)=0A=
+ * Version	: v2.20.4 (September 27 2004)=0A=
  *=0A=
  * Authors:=0A=
  * 	Atul Mukker		<Atul.Mukker@lsil.com>=0A=
@@ -197,7 +197,7 @@=0A=
  * ### global data ###=0A=
  */=0A=
 static uint8_t megaraid_mbox_version[8] =3D=0A=
-	{ 0x02, 0x20, 0x02, 0x00, 7, 22, 20, 4 };=0A=
+	{ 0x02, 0x20, 0x04, 0x00, 9, 27, 20, 4 };=0A=
 =0A=
 =0A=
 /*=0A=
@@ -3562,7 +3562,7 @@=0A=
 	for (i =3D 0; i < MBOX_MAX_USER_CMDS; i++) {=0A=
 =0A=
 		scb			=3D adapter->uscb_list + i;=0A=
-		ccb			=3D raid_dev->ccb_list + i;=0A=
+		ccb			=3D raid_dev->uccb_list + i;=0A=
 =0A=
 		scb->ccb		=3D (caddr_t)ccb;=0A=
 		ccb->mbox64		=3D raid_dev->umbox64 + i;=0A=
diff -Naur linux-2.6.9-rc2-mrbug/drivers/scsi/megaraid/megaraid_mbox.h =
linux-2.6.9-rc2-fixed/drivers/scsi/megaraid/megaraid_mbox.h=0A=
--- linux-2.6.9-rc2-mrbug/drivers/scsi/megaraid/megaraid_mbox.h	=
2004-09-28 17:31:33.000000000 -0400=0A=
+++ linux-2.6.9-rc2-fixed/drivers/scsi/megaraid/megaraid_mbox.h	=
2004-09-28 17:43:50.000000000 -0400=0A=
@@ -21,8 +21,8 @@=0A=
 #include "megaraid_ioctl.h"=0A=
 =0A=
 =0A=
-#define MEGARAID_VERSION	"2.20.3.1"=0A=
-#define MEGARAID_EXT_VERSION	"(Release Date: Tue Aug 24 09:43:35 EDT =
2004)"=0A=
+#define MEGARAID_VERSION	"2.20.4.0"=0A=
+#define MEGARAID_EXT_VERSION	"(Release Date: Mon Sep 27 22:15:07 EDT =
2004)"=0A=
 =0A=
 =0A=
 /*=0A=

------_=_NextPart_000_01C4A70E.F57BF9A0--
