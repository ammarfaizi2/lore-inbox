Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpBRe6JfQBzF6Tz60w0ZxmVDM2g==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sat, 03 Jan 2004 09:11:17 +0000
Message-ID: <00ca01c415a4$145e22f0$d100000a@sbs2003.local>
From: "Dmitry Torokhov" <dtor_core@ameritech.net>
X-Mailer: Microsoft CDO for Exchange 2000
To: <Administrator@osdl.org>
Subject: Re: [PATCH 7/7] SiS AUX port
Date: Mon, 29 Mar 2004 16:39:53 +0100
User-Agent: KMail/1.5.4
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Content-Class: urn:content-classes:message
References: <200401030350.43437.dtor_core@ameritech.net> <200401030402.16745.dtor_core@ameritech.net> <200401030403.03783.dtor_core@ameritech.net>
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
In-Reply-To: <200401030403.03783.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:39:54.0390 (UTC) FILETIME=[14F90360:01C415A4]

===================================================================


ChangeSet@1.1577, 2004-01-03 02:54:28-05:00, dtor_core@ameritech.net
  Input: Do not ignore AUX port if chipset fails to disable it
         (SiS seems to have trouble disabling AUX port, other
          than that the port works fine).


 i8042.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)


===================================================================



diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Sat Jan  3 03:10:31 2004
+++ b/drivers/input/serio/i8042.c	Sat Jan  3 03:10:31 2004
@@ -598,8 +598,10 @@
 	
 	if (i8042_command(&param, I8042_CMD_AUX_DISABLE))
 		return -1;
-	if (i8042_command(&param, I8042_CMD_CTL_RCTR) || (~param & I8042_CTR_AUXDIS))
-		return -1;	
+	if (i8042_command(&param, I8042_CMD_CTL_RCTR) || (~param & I8042_CTR_AUXDIS)) {
+		printk(KERN_WARNING "Failed to disable AUX port, but continuing anyway... Is this a SiS?\n");
+		printk(KERN_WARNING "If AUX port is really absent please use the 'i8042.noaux' option.\n");
+	}
 
 	if (i8042_command(&param, I8042_CMD_AUX_ENABLE))
 		return -1;
