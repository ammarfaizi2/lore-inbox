Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267930AbUJSFMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267930AbUJSFMm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 01:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267974AbUJSFMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 01:12:42 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:19636 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267930AbUJSFMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 01:12:30 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] SCSI updates for 2.6.9
Date: Tue, 19 Oct 2004 00:12:25 -0500
User-Agent: KMail/1.6.2
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>, willy@debian.org,
       Linux1394-Devel <linux1394-devel@lists.sourceforge.net>,
       bcollins@debian.org
References: <1098137016.2011.339.camel@mulgrave> <200410182341.13648.dtor_core@ameritech.net>
In-Reply-To: <200410182341.13648.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410190012.28071.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 October 2004 11:41 pm, Dmitry Torokhov wrote:
> On Monday 18 October 2004 05:03 pm, James Bottomley wrote:
> 
> > Matthew Wilcox:
> >   o Add SPI-5 constants to scsi.h
> 
> This breaks Firewire SBP2 build:
> 
>   CC [M]  drivers/ieee1394/sbp2.o
> In file included from drivers/ieee1394/sbp2.c:78:
> drivers/ieee1394/sbp2.h:61:1: warning: "ABORT_TASK_SET" redefined
> In file included from drivers/scsi/scsi.h:31,
>                  from drivers/ieee1394/sbp2.c:67:
> include/scsi/scsi.h:255:1: warning: this is the location of the previous definition
> In file included from drivers/ieee1394/sbp2.c:78:
> drivers/ieee1394/sbp2.h:62:1: warning: "LOGICAL_UNIT_RESET" redefined
> In file included from drivers/scsi/scsi.h:31,
>                  from drivers/ieee1394/sbp2.c:67:
> include/scsi/scsi.h:267:1: warning: this is the location of the previous definition
> 
> It looks like firewire has its own set of commands with conflicting names.
> Who should win?
> 

I think something like the patch below shoudl work.

-- 
Dmitry


===================================================================


ChangeSet@1.1963, 2004-10-19 00:08:16-05:00, dtor_core@ameritech.net
  IEEE1394: SBP-2 - rename some constants to fix clash with new
            SCSI core defines.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 sbp2.c |    8 ++++----
 sbp2.h |   18 +++++++++---------
 2 files changed, 13 insertions(+), 13 deletions(-)


===================================================================



diff -Nru a/drivers/ieee1394/sbp2.c b/drivers/ieee1394/sbp2.c
--- a/drivers/ieee1394/sbp2.c	2004-10-19 00:10:58 -05:00
+++ b/drivers/ieee1394/sbp2.c	2004-10-19 00:10:58 -05:00
@@ -1088,7 +1088,7 @@
 	scsi_id->query_logins_orb->query_response_hi = ORB_SET_NODE_ID(hi->host->node_id);
 	SBP2_DEBUG("sbp2_query_logins: query_response_hi/lo initialized");
 
-	scsi_id->query_logins_orb->lun_misc = ORB_SET_FUNCTION(QUERY_LOGINS_REQUEST);
+	scsi_id->query_logins_orb->lun_misc = ORB_SET_FUNCTION(SBP2_QUERY_LOGINS_REQUEST);
 	scsi_id->query_logins_orb->lun_misc |= ORB_SET_NOTIFY(1);
 	if (scsi_id->sbp2_device_type_and_lun != SBP2_DEVICE_TYPE_LUN_UNINITIALIZED) {
 		scsi_id->query_logins_orb->lun_misc |= ORB_SET_LUN(scsi_id->sbp2_device_type_and_lun);
@@ -1199,7 +1199,7 @@
 	scsi_id->login_orb->login_response_hi = ORB_SET_NODE_ID(hi->host->node_id);
 	SBP2_DEBUG("sbp2_login_device: login_response_hi/lo initialized");
 
-	scsi_id->login_orb->lun_misc = ORB_SET_FUNCTION(LOGIN_REQUEST);
+	scsi_id->login_orb->lun_misc = ORB_SET_FUNCTION(SBP2_LOGIN_REQUEST);
 	scsi_id->login_orb->lun_misc |= ORB_SET_RECONNECT(0);	/* One second reconnect time */
 	scsi_id->login_orb->lun_misc |= ORB_SET_EXCLUSIVE(exclusive_login);	/* Exclusive access to device */
 	scsi_id->login_orb->lun_misc |= ORB_SET_NOTIFY(1);	/* Notify us of login complete */
@@ -1325,7 +1325,7 @@
 	scsi_id->logout_orb->reserved3 = 0x0;
 	scsi_id->logout_orb->reserved4 = 0x0;
 
-	scsi_id->logout_orb->login_ID_misc = ORB_SET_FUNCTION(LOGOUT_REQUEST);
+	scsi_id->logout_orb->login_ID_misc = ORB_SET_FUNCTION(SBP2_LOGOUT_REQUEST);
 	scsi_id->logout_orb->login_ID_misc |= ORB_SET_LOGIN_ID(scsi_id->login_response->length_login_ID);
 
 	/* Notify us when complete */
@@ -1390,7 +1390,7 @@
 	scsi_id->reconnect_orb->reserved3 = 0x0;
 	scsi_id->reconnect_orb->reserved4 = 0x0;
 
-	scsi_id->reconnect_orb->login_ID_misc = ORB_SET_FUNCTION(RECONNECT_REQUEST);
+	scsi_id->reconnect_orb->login_ID_misc = ORB_SET_FUNCTION(SBP2_RECONNECT_REQUEST);
 	scsi_id->reconnect_orb->login_ID_misc |=
 		ORB_SET_LOGIN_ID(scsi_id->login_response->length_login_ID);
 
diff -Nru a/drivers/ieee1394/sbp2.h b/drivers/ieee1394/sbp2.h
--- a/drivers/ieee1394/sbp2.h	2004-10-19 00:10:58 -05:00
+++ b/drivers/ieee1394/sbp2.h	2004-10-19 00:10:58 -05:00
@@ -52,15 +52,15 @@
 	u8 cdb[12];
 };
 
-#define LOGIN_REQUEST			0x0
-#define QUERY_LOGINS_REQUEST		0x1
-#define RECONNECT_REQUEST		0x3
-#define SET_PASSWORD_REQUEST		0x4
-#define LOGOUT_REQUEST			0x7
-#define ABORT_TASK_REQUEST		0xb
-#define ABORT_TASK_SET			0xc
-#define LOGICAL_UNIT_RESET		0xe
-#define TARGET_RESET_REQUEST		0xf
+#define SBP2_LOGIN_REQUEST		0x0
+#define SBP2_QUERY_LOGINS_REQUEST	0x1
+#define SBP2_RECONNECT_REQUEST		0x3
+#define SBP2_SET_PASSWORD_REQUEST	0x4
+#define SBP2_LOGOUT_REQUEST		0x7
+#define SBP2_ABORT_TASK_REQUEST		0xb
+#define SBP2_ABORT_TASK_SET		0xc
+#define SBP2_LOGICAL_UNIT_RESET		0xe
+#define SBP2_TARGET_RESET_REQUEST	0xf
 
 #define ORB_SET_LUN(value)                      (value & 0xffff)
 #define ORB_SET_FUNCTION(value)                 ((value & 0xf) << 16)
