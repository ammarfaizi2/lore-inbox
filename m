Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpBRUdsLVf3BvRdegK2yHJ1jxQA==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sat, 03 Jan 2004 09:18:04 +0000
Message-ID: <00c501c415a4$14548600$d100000a@sbs2003.local>
From: "Dmitry Torokhov" <dtor_core@ameritech.net>
X-Mailer: Microsoft CDO for Exchange 2000
To: <Administrator@osdl.org>
Subject: Re: [PATCH 2/7] i8042 option parsing
Date: Mon, 29 Mar 2004 16:39:53 +0100
User-Agent: KMail/1.5.4
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Content-Class: urn:content-classes:message
References: <200401030350.43437.dtor_core@ameritech.net> <200401030356.48071.dtor_core@ameritech.net>
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
In-Reply-To: <200401030356.48071.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:39:53.0359 (UTC) FILETIME=[145BB1F0:01C415A4]

===================================================================


ChangeSet@1.1572, 2004-01-02 02:46:43-05:00, dtor_core@ameritech.net
  Input: With Vojtech's approval adjusted i8042 option names by
         dropping i8042_ prefix.
  
         If i8042 is compiled as a module new option names are:
         direct, dumbkbd, noaux, nomux, reset, unlock
  
         If i8042 is build in the kernel the prefix "i8042." is
         required in front of an option, like "i8042.reset"


 Documentation/kernel-parameters.txt |   16 +++++++++-------
 drivers/input/serio/i8042.c         |   18 ++++++++++++------
 2 files changed, 21 insertions(+), 13 deletions(-)


===================================================================



diff -Nru a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt	Sat Jan  3 03:08:12 2004
+++ b/Documentation/kernel-parameters.txt	Sat Jan  3 03:08:12 2004
@@ -372,13 +372,15 @@
 
 	noirqbalance	[IA-32,SMP,KNL] Disable kernel irq balancing
 
-	i8042_direct	[HW] Keyboard has been put into non-translated mode 
-			by BIOS
-	i8042_dumbkbd	[HW] Don't attempt to blink the leds
-	i8042_noaux	[HW] Don't check for auxiliary (== mouse) port
-	i8042_nomux
-	i8042_reset	[HW] Reset the controller during init and cleanup
-	i8042_unlock	[HW] Unlock (ignore) the keylock
+	i8042.direct	[HW] Put keyboard port into non-translated mode 
+	i8042.dumbkbd	[HW] Pretend that controlled can only read data from
+			     keyboard and can not control its state
+			     (Don't attempt to blink the leds)
+	i8042.noaux	[HW] Don't check for auxiliary (== mouse) port
+	i8042.nomux	[HW] Don't check presence of an active multiplexing
+			     controller
+	i8042.reset	[HW] Reset the controller during init and cleanup
+	i8042.unlock	[HW] Unlock (ignore) the keylock
 
 	i810=		[HW,DRM]
 
diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Sat Jan  3 03:08:12 2004
+++ b/drivers/input/serio/i8042.c	Sat Jan  3 03:08:12 2004
@@ -29,22 +29,28 @@
 MODULE_LICENSE("GPL");
 
 static unsigned int i8042_noaux;
-module_param(i8042_noaux, bool, 0);
+module_param_named(noaux, i8042_noaux, bool, 0);
+MODULE_PARM_DESC(noaux, "Do not probe or use AUX (mouse) port.");
 
 static unsigned int i8042_nomux;
-module_param(i8042_nomux, bool, 0);
+module_param_named(nomux, i8042_nomux, bool, 0);
+MODULE_PARM_DESC(nomux, "Do not check whether an active multiplexing conrtoller is present.");
 
 static unsigned int i8042_unlock;
-module_param(i8042_unlock, bool, 0);
+module_param_named(unlock, i8042_unlock, bool, 0);
+MODULE_PARM_DESC(unlock, "Ignore keyboard lock.");
 
 static unsigned int i8042_reset;
-module_param(i8042_reset, bool, 0);
+module_param_named(reset, i8042_reset, bool, 0);
+MODULE_PARM_DESC(reset, "Reset controller during init and cleanup.");
 
 static unsigned int i8042_direct;
-module_param(i8042_direct, bool, 0);
+module_param_named(direct, i8042_direct, bool, 0);
+MODULE_PARM_DESC(direct, "Put keyboard port into non-translated mode.");
 
 static unsigned int i8042_dumbkbd;
-module_param(i8042_dumbkbd, bool, 0);
+module_param_named(dumbkbd, i8042_dumbkbd, bool, 0);
+MODULE_PARM_DESC(dumbkbd, "Pretend that controller can only read data from keyboard");
 
 #undef DEBUG
 #include "i8042.h"
