Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbUJ0GIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbUJ0GIH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 02:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbUJ0GIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 02:08:06 -0400
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:15510 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261662AbUJ0GHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 02:07:34 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm1
Date: Wed, 27 Oct 2004 01:07:27 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       dz@debian.org
References: <20041026213156.682f35ca.akpm@osdl.org> <200410270042.34224.dtor_core@ameritech.net>
In-Reply-To: <200410270042.34224.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410270107.29737.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 October 2004 12:42 am, Dmitry Torokhov wrote:
> On Tuesday 26 October 2004 11:31 pm, Andrew Morton wrote: 
> > +remove-module_parm-from-allyesconfig-almost.patch
> > 
> >  Move lots of MODULE_PARMs to module_param()
> > 
> 
> Please consider applying the patch below for parkbd instead of
> Rusty's changes. I find parameter names in form of parkbd.parkbd
> and parkbd.parkbd_mode extremely ugly.
> 
> The patch is against Linus's -bk.
> 

And please consider the one below for i8k - it exports "power_status"
parameter through sysfs.

Since it is not part of input system I'd rather not put it in my tree...

-- 
Dmitry


===================================================================


ChangeSet@1.1995, 2004-10-27 01:04:47-05:00, dtor_core@ameritech.net
  I8K: Switch to using module_param, allow switching 'power_status'
       through sysfs.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 Documentation/kernel-parameters.txt |    8 ++++++++
 drivers/char/i8k.c                  |   16 +++++++++-------
 2 files changed, 17 insertions(+), 7 deletions(-)


===================================================================



diff -Nru a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt	2004-10-27 01:05:54 -05:00
+++ b/Documentation/kernel-parameters.txt	2004-10-27 01:05:54 -05:00
@@ -490,6 +490,14 @@
 
 	i810=		[HW,DRM]
 
+	i8k.force	[HW] Activate i8k driver even if SMM BIOS signature
+			does not match list of supported models.
+	i8k.power_status
+			[HW] Report power status in /proc/i8k
+			(disabled by default)
+	i8k.restricted	[HW] Allow controlling fans only if SYS_ADMIN
+			capability is set.
+
 	ibmmcascsi=	[HW,MCA,SCSI] IBM MicroChannel SCSI adapter
 			See Documentation/mca.txt.
 
diff -Nru a/drivers/char/i8k.c b/drivers/char/i8k.c
--- a/drivers/char/i8k.c	2004-10-27 01:05:54 -05:00
+++ b/drivers/char/i8k.c	2004-10-27 01:05:54 -05:00
@@ -65,18 +65,20 @@
 static char bios_version [4]  = "?";
 static char serial_number[16] = "?";
 
-static int force = 0;
-static int restricted = 0;
-static int power_status = 0;
-
 MODULE_AUTHOR("Massimo Dal Zotto (dz@debian.org)");
 MODULE_DESCRIPTION("Driver for accessing SMM BIOS on Dell laptops");
 MODULE_LICENSE("GPL");
-MODULE_PARM(force, "i");
-MODULE_PARM(restricted, "i");
-MODULE_PARM(power_status, "i");
+
+static int force;
+module_param(force, bool, 0);
 MODULE_PARM_DESC(force, "Force loading without checking for supported models");
+
+static int restricted;
+module_param(restricted, bool, 0);
 MODULE_PARM_DESC(restricted, "Allow fan control if SYS_ADMIN capability set");
+
+static int power_status;
+module_param(power_status, bool, 600);
 MODULE_PARM_DESC(power_status, "Report power status in /proc/i8k");
 
 static ssize_t i8k_read(struct file *, char __user *, size_t, loff_t *);
