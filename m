Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264555AbTDXXtu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 19:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264568AbTDXXsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:48:51 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:44975 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264555AbTDXXpI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:45:08 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10512287472152@kroah.com>
Subject: Re: [PATCH] i2c driver changes for 2.5.68
In-Reply-To: <10512287472218@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 24 Apr 2003 16:59:07 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1179.3.10, 2003/04/24 13:38:03-07:00, greg@kroah.com

[PATCH] i2c: remove a lot of dupliated macros from i2c-sensor.h and use the current values in i2c.h


 drivers/i2c/chips/adm1021.c |    8 +--
 drivers/i2c/chips/it87.c    |    8 +--
 drivers/i2c/chips/lm75.c    |    8 +--
 drivers/i2c/chips/via686a.c |    8 +--
 drivers/i2c/chips/w83781d.c |   10 +--
 drivers/i2c/i2c-sensor.c    |   30 +++++------
 include/linux/i2c-sensor.h  |  113 ++++++++++++++------------------------------
 include/linux/i2c.h         |   20 +++++--
 8 files changed, 86 insertions(+), 119 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	Thu Apr 24 16:46:10 2003
+++ b/drivers/i2c/chips/adm1021.c	Thu Apr 24 16:46:10 2003
@@ -39,12 +39,12 @@
 #define ADM1021_ALARM_RTEMP_NA		0x04
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { SENSORS_I2C_END };
+static unsigned short normal_i2c[] = { I2C_CLIENT_END };
 static unsigned short normal_i2c_range[] = { 0x18, 0x1a, 0x29, 0x2b,
-	0x4c, 0x4e, SENSORS_I2C_END
+	0x4c, 0x4e, I2C_CLIENT_END
 };
-static unsigned int normal_isa[] = { SENSORS_ISA_END };
-static unsigned int normal_isa_range[] = { SENSORS_ISA_END };
+static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
+static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_8(adm1021, adm1023, max1617, max1617a, thmc10, lm84, gl523sm, mc1066);
diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Thu Apr 24 16:46:10 2003
+++ b/drivers/i2c/chips/it87.c	Thu Apr 24 16:46:10 2003
@@ -40,10 +40,10 @@
 
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { SENSORS_I2C_END };
-static unsigned short normal_i2c_range[] = { 0x20, 0x2f, SENSORS_I2C_END };
-static unsigned int normal_isa[] = { 0x0290, SENSORS_ISA_END };
-static unsigned int normal_isa_range[] = { SENSORS_ISA_END };
+static unsigned short normal_i2c[] = { I2C_CLIENT_END };
+static unsigned short normal_i2c_range[] = { 0x20, 0x2f, I2C_CLIENT_END };
+static unsigned int normal_isa[] = { 0x0290, I2C_CLIENT_ISA_END };
+static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_4(it87, it8705, it8712, sis950);
diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	Thu Apr 24 16:46:10 2003
+++ b/drivers/i2c/chips/lm75.c	Thu Apr 24 16:46:10 2003
@@ -28,10 +28,10 @@
 
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { SENSORS_I2C_END };
-static unsigned short normal_i2c_range[] = { 0x48, 0x4f, SENSORS_I2C_END };
-static unsigned int normal_isa[] = { SENSORS_ISA_END };
-static unsigned int normal_isa_range[] = { SENSORS_ISA_END };
+static unsigned short normal_i2c[] = { I2C_CLIENT_END };
+static unsigned short normal_i2c_range[] = { 0x48, 0x4f, I2C_CLIENT_END };
+static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
+static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_1(lm75);
diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	Thu Apr 24 16:46:10 2003
+++ b/drivers/i2c/chips/via686a.c	Thu Apr 24 16:46:10 2003
@@ -51,10 +51,10 @@
 /* Addresses to scan.
    Note that we can't determine the ISA address until we have initialized
    our module */
-static unsigned short normal_i2c[] = { SENSORS_I2C_END };
-static unsigned short normal_i2c_range[] = { SENSORS_I2C_END };
-static unsigned int normal_isa[] = { 0x0000, SENSORS_ISA_END };
-static unsigned int normal_isa_range[] = { SENSORS_ISA_END };
+static unsigned short normal_i2c[] = { I2C_CLIENT_END };
+static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
+static unsigned int normal_isa[] = { 0x0000, I2C_CLIENT_ISA_END };
+static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_1(via686a);
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Thu Apr 24 16:46:10 2003
+++ b/drivers/i2c/chips/w83781d.c	Thu Apr 24 16:46:10 2003
@@ -46,14 +46,14 @@
 #define W83781D_RT			1
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { SENSORS_I2C_END };
-static unsigned short normal_i2c_range[] = { 0x20, 0x2f, SENSORS_I2C_END };
-static unsigned int normal_isa[] = { 0x0290, SENSORS_ISA_END };
-static unsigned int normal_isa_range[] = { SENSORS_ISA_END };
+static unsigned short normal_i2c[] = { I2C_CLIENT_END };
+static unsigned short normal_i2c_range[] = { 0x20, 0x2f, I2C_CLIENT_END };
+static unsigned int normal_isa[] = { 0x0290, I2C_CLIENT_ISA_END };
+static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_6(w83781d, w83782d, w83783s, w83627hf, as99127f, w83697hf);
-SENSORS_MODULE_PARM(force_subclients, "List of subclient addresses: "
+I2C_CLIENT_MODULE_PARM(force_subclients, "List of subclient addresses: "
 		    "{bus, clientaddr, subclientaddr1, subclientaddr2}");
 
 static int init = 1;
diff -Nru a/drivers/i2c/i2c-sensor.c b/drivers/i2c/i2c-sensor.c
--- a/drivers/i2c/i2c-sensor.c	Thu Apr 24 16:46:10 2003
+++ b/drivers/i2c/i2c-sensor.c	Thu Apr 24 16:46:10 2003
@@ -42,7 +42,7 @@
 	struct i2c_force_data *this_force;
 	int is_isa = i2c_is_isa_adapter(adapter);
 	int adapter_id =
-	    is_isa ? SENSORS_ISA_BUS : i2c_adapter_id(adapter);
+	    is_isa ? ANY_I2C_ISA_BUS : i2c_adapter_id(adapter);
 
 	/* Forget it if we can't probe using SMBUS_QUICK */
 	if ((!is_isa) &&
@@ -59,9 +59,9 @@
 		   detection at all */
 		found = 0;
 		for (i = 0; !found && (this_force = address_data->forces + i, this_force->force); i++) {
-			for (j = 0; !found && (this_force->force[j] != SENSORS_I2C_END); j += 2) {
+			for (j = 0; !found && (this_force->force[j] != I2C_CLIENT_END); j += 2) {
 				if ( ((adapter_id == this_force->force[j]) ||
-				      ((this_force->force[j] == SENSORS_ANY_I2C_BUS) && !is_isa)) &&
+				      ((this_force->force[j] == ANY_I2C_BUS) && !is_isa)) &&
 				      (addr == this_force->force[j + 1]) ) {
 					dev_dbg(&adapter->dev, "found force parameter for adapter %d, addr %04x\n", adapter_id, addr);
 					if ((err = found_proc(adapter, addr, this_force->kind)))
@@ -75,18 +75,18 @@
 
 		/* If this address is in one of the ignores, we can forget about it
 		   right now */
-		for (i = 0; !found && (address_data->ignore[i] != SENSORS_I2C_END); i += 2) {
+		for (i = 0; !found && (address_data->ignore[i] != I2C_CLIENT_END); i += 2) {
 			if ( ((adapter_id == address_data->ignore[i]) ||
-			      ((address_data->ignore[i] == SENSORS_ANY_I2C_BUS) &&
+			      ((address_data->ignore[i] == ANY_I2C_BUS) &&
 			       !is_isa)) &&
 			      (addr == address_data->ignore[i + 1])) {
 				dev_dbg(&adapter->dev, "found ignore parameter for adapter %d, addr %04x\n", adapter_id, addr);
 				found = 1;
 			}
 		}
-		for (i = 0; !found && (address_data->ignore_range[i] != SENSORS_I2C_END); i += 3) {
+		for (i = 0; !found && (address_data->ignore_range[i] != I2C_CLIENT_END); i += 3) {
 			if ( ((adapter_id == address_data->ignore_range[i]) ||
-			      ((address_data-> ignore_range[i] == SENSORS_ANY_I2C_BUS) & 
+			      ((address_data-> ignore_range[i] == ANY_I2C_BUS) & 
 			       !is_isa)) &&
 			     (addr >= address_data->ignore_range[i + 1]) &&
 			     (addr <= address_data->ignore_range[i + 2])) {
@@ -100,13 +100,13 @@
 		/* Now, we will do a detection, but only if it is in the normal or 
 		   probe entries */
 		if (is_isa) {
-			for (i = 0; !found && (address_data->normal_isa[i] != SENSORS_ISA_END); i += 1) {
+			for (i = 0; !found && (address_data->normal_isa[i] != I2C_CLIENT_ISA_END); i += 1) {
 				if (addr == address_data->normal_isa[i]) {
 					dev_dbg(&adapter->dev, "found normal isa entry for adapter %d, addr %04x\n", adapter_id, addr);
 					found = 1;
 				}
 			}
-			for (i = 0; !found && (address_data->normal_isa_range[i] != SENSORS_ISA_END); i += 3) {
+			for (i = 0; !found && (address_data->normal_isa_range[i] != I2C_CLIENT_ISA_END); i += 3) {
 				if ((addr >= address_data->normal_isa_range[i]) &&
 				    (addr <= address_data->normal_isa_range[i + 1]) &&
 				    ((addr - address_data->normal_isa_range[i]) % address_data->normal_isa_range[i + 2] == 0)) {
@@ -115,13 +115,13 @@
 				}
 			}
 		} else {
-			for (i = 0; !found && (address_data->normal_i2c[i] != SENSORS_I2C_END); i += 1) {
+			for (i = 0; !found && (address_data->normal_i2c[i] != I2C_CLIENT_END); i += 1) {
 				if (addr == address_data->normal_i2c[i]) {
 					found = 1;
 					dev_dbg(&adapter->dev, "found normal i2c entry for adapter %d, addr %02x", adapter_id, addr);
 				}
 			}
-			for (i = 0; !found && (address_data->normal_i2c_range[i] != SENSORS_I2C_END); i += 2) {
+			for (i = 0; !found && (address_data->normal_i2c_range[i] != I2C_CLIENT_END); i += 2) {
 				if ((addr >= address_data->normal_i2c_range[i]) &&
 				    (addr <= address_data->normal_i2c_range[i + 1])) {
 					dev_dbg(&adapter->dev, "found normal i2c_range entry for adapter %d, addr %04x\n", adapter_id, addr);
@@ -131,19 +131,19 @@
 		}
 
 		for (i = 0;
-		     !found && (address_data->probe[i] != SENSORS_I2C_END);
+		     !found && (address_data->probe[i] != I2C_CLIENT_END);
 		     i += 2) {
 			if (((adapter_id == address_data->probe[i]) ||
 			     ((address_data->
-			       probe[i] == SENSORS_ANY_I2C_BUS) & !is_isa))
+			       probe[i] == ANY_I2C_BUS) & !is_isa))
 			    && (addr == address_data->probe[i + 1])) {
 				dev_dbg(&adapter->dev, "found probe parameter for adapter %d, addr %04x\n", adapter_id, addr);
 				found = 1;
 			}
 		}
-		for (i = 0; !found && (address_data->probe_range[i] != SENSORS_I2C_END); i += 3) {
+		for (i = 0; !found && (address_data->probe_range[i] != I2C_CLIENT_END); i += 3) {
 			if ( ((adapter_id == address_data->probe_range[i]) ||
-			      ((address_data->probe_range[i] == SENSORS_ANY_I2C_BUS) & !is_isa)) &&
+			      ((address_data->probe_range[i] == ANY_I2C_BUS) & !is_isa)) &&
 			     (addr >= address_data->probe_range[i + 1]) &&
 			     (addr <= address_data->probe_range[i + 2])) {
 				found = 1;
diff -Nru a/include/linux/i2c-sensor.h b/include/linux/i2c-sensor.h
--- a/include/linux/i2c-sensor.h	Thu Apr 24 16:46:10 2003
+++ b/include/linux/i2c-sensor.h	Thu Apr 24 16:46:10 2003
@@ -29,8 +29,8 @@
    will still try to figure out what type of chip is present. This is useful
    if for some reasons the detect for SMBus or ISA address space filled
    fails.
-   probe: insmod parameter. Initialize this list with SENSORS_I2C_END values.
-     A list of pairs. The first value is a bus number (SENSORS_ISA_BUS for
+   probe: insmod parameter. Initialize this list with I2C_CLIENT_ISA_END values.
+     A list of pairs. The first value is a bus number (ANY_I2C_ISA_BUS for
      the ISA bus, -1 for any I2C bus), the second is the address. 
    kind: The kind of chip. 0 equals any chip.
 */
@@ -40,10 +40,10 @@
 };
 
 /* A structure containing the detect information.
-   normal_i2c: filled in by the module writer. Terminated by SENSORS_I2C_END.
+   normal_i2c: filled in by the module writer. Terminated by I2C_CLIENT_ISA_END.
      A list of I2C addresses which should normally be examined.
    normal_i2c_range: filled in by the module writer. Terminated by 
-     SENSORS_I2C_END
+     I2C_CLIENT_ISA_END
      A list of pairs of I2C addresses, each pair being an inclusive range of
      addresses which should normally be examined.
    normal_isa: filled in by the module writer. Terminated by SENSORS_ISA_END.
@@ -54,24 +54,24 @@
      range of addresses which should normally be examined. The third is the
      modulo parameter: only addresses which are 0 module this value relative
      to the first address of the range are actually considered.
-   probe: insmod parameter. Initialize this list with SENSORS_I2C_END values.
-     A list of pairs. The first value is a bus number (SENSORS_ISA_BUS for
+   probe: insmod parameter. Initialize this list with I2C_CLIENT_ISA_END values.
+     A list of pairs. The first value is a bus number (ANY_I2C_ISA_BUS for
      the ISA bus, -1 for any I2C bus), the second is the address. These
      addresses are also probed, as if they were in the 'normal' list.
-   probe_range: insmod parameter. Initialize this list with SENSORS_I2C_END 
+   probe_range: insmod parameter. Initialize this list with I2C_CLIENT_ISA_END 
      values.
-     A list of triples. The first value is a bus number (SENSORS_ISA_BUS for
+     A list of triples. The first value is a bus number (ANY_I2C_ISA_BUS for
      the ISA bus, -1 for any I2C bus), the second and third are addresses. 
      These form an inclusive range of addresses that are also probed, as
      if they were in the 'normal' list.
-   ignore: insmod parameter. Initialize this list with SENSORS_I2C_END values.
-     A list of pairs. The first value is a bus number (SENSORS_ISA_BUS for
+   ignore: insmod parameter. Initialize this list with I2C_CLIENT_ISA_END values.
+     A list of pairs. The first value is a bus number (ANY_I2C_ISA_BUS for
      the ISA bus, -1 for any I2C bus), the second is the I2C address. These
      addresses are never probed. This parameter overrules 'normal' and 
      'probe', but not the 'force' lists.
-   ignore_range: insmod parameter. Initialize this list with SENSORS_I2C_END 
+   ignore_range: insmod parameter. Initialize this list with I2C_CLIENT_ISA_END 
       values.
-     A list of triples. The first value is a bus number (SENSORS_ISA_BUS for
+     A list of triples. The first value is a bus number (ANY_I2C_ISA_BUS for
      the ISA bus, -1 for any I2C bus), the second and third are addresses. 
      These form an inclusive range of I2C addresses that are never probed.
      This parameter overrules 'normal' and 'probe', but not the 'force' lists.
@@ -90,74 +90,35 @@
 	struct i2c_force_data *forces;
 };
 
-/* Internal numbers to terminate lists */
-#define SENSORS_I2C_END 0xfffe
-#define SENSORS_ISA_END 0xfffefffe
-
-/* The numbers to use to set an ISA or I2C bus address */
-#define SENSORS_ISA_BUS 9191
-#define SENSORS_ANY_I2C_BUS 0xffff
-
-/* The length of the option lists */
-#define SENSORS_MAX_OPTS 48
-
-/* Default fill of many variables */
-#define SENSORS_DEFAULTS {SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
-                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
-                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
-                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
-                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
-                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
-                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
-                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
-                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
-                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
-                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
-                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
-                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
-                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
-                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
-                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END}
-
-/* This is ugly. We need to evaluate SENSORS_MAX_OPTS before it is 
-   stringified */
-#define SENSORS_MODPARM_AUX1(x) "1-" #x "h"
-#define SENSORS_MODPARM_AUX(x) SENSORS_MODPARM_AUX1(x)
-#define SENSORS_MODPARM SENSORS_MODPARM_AUX(SENSORS_MAX_OPTS)
-
-/* SENSORS_MODULE_PARM creates a module parameter, and puts it in the
-   module header */
-#define SENSORS_MODULE_PARM(var,desc) \
-  static unsigned short var[SENSORS_MAX_OPTS] = SENSORS_DEFAULTS; \
-  MODULE_PARM(var,SENSORS_MODPARM); \
-  MODULE_PARM_DESC(var,desc)
-
-/* SENSORS_MODULE_PARM creates a 'force_*' module parameter, and puts it in
-   the module header */
 #define SENSORS_MODULE_PARM_FORCE(name) \
-  SENSORS_MODULE_PARM(force_ ## name, \
+  I2C_CLIENT_MODULE_PARM(force_ ## name, \
                       "List of adapter,address pairs which are unquestionably" \
                       " assumed to contain a `" # name "' chip")
 
 
 /* This defines several insmod variables, and the addr_data structure */
 #define SENSORS_INSMOD \
-  SENSORS_MODULE_PARM(probe, \
+  I2C_CLIENT_MODULE_PARM(probe, \
                       "List of adapter,address pairs to scan additionally"); \
-  SENSORS_MODULE_PARM(probe_range, \
+  I2C_CLIENT_MODULE_PARM(probe_range, \
                       "List of adapter,start-addr,end-addr triples to scan " \
                       "additionally"); \
-  SENSORS_MODULE_PARM(ignore, \
+  I2C_CLIENT_MODULE_PARM(ignore, \
                       "List of adapter,address pairs not to scan"); \
-  SENSORS_MODULE_PARM(ignore_range, \
+  I2C_CLIENT_MODULE_PARM(ignore_range, \
                       "List of adapter,start-addr,end-addr triples not to " \
                       "scan"); \
-  static struct i2c_address_data addr_data = \
-                                       {normal_i2c, normal_i2c_range, \
-                                        normal_isa, normal_isa_range, \
-                                        probe, probe_range, \
-                                        ignore, ignore_range, \
-                                        forces}
+	static struct i2c_address_data addr_data = {			\
+			.normal_i2c =		normal_i2c,		\
+			.normal_i2c_range =	normal_i2c_range,	\
+			.normal_isa =		normal_isa,		\
+			.normal_isa_range =	normal_isa_range,	\
+			.probe =		probe,			\
+			.probe_range =		probe_range,		\
+			.ignore =		ignore,			\
+			.ignore_range =		ignore_range,		\
+			.forces =		forces,			\
+		}
 
 /* The following functions create an enum with the chip names as elements. 
    The first element of the enum is any_chip. These are the only macros
@@ -165,7 +126,7 @@
 
 #define SENSORS_INSMOD_0 \
   enum chips { any_chip }; \
-  SENSORS_MODULE_PARM(force, \
+  I2C_CLIENT_MODULE_PARM(force, \
                       "List of adapter,address pairs to boldly assume " \
                       "to be present"); \
   static struct i2c_force_data forces[] = {{force,any_chip},{NULL}}; \
@@ -173,7 +134,7 @@
 
 #define SENSORS_INSMOD_1(chip1) \
   enum chips { any_chip, chip1 }; \
-  SENSORS_MODULE_PARM(force, \
+  I2C_CLIENT_MODULE_PARM(force, \
                       "List of adapter,address pairs to boldly assume " \
                       "to be present"); \
   SENSORS_MODULE_PARM_FORCE(chip1); \
@@ -184,7 +145,7 @@
 
 #define SENSORS_INSMOD_2(chip1,chip2) \
   enum chips { any_chip, chip1, chip2 }; \
-  SENSORS_MODULE_PARM(force, \
+  I2C_CLIENT_MODULE_PARM(force, \
                       "List of adapter,address pairs to boldly assume " \
                       "to be present"); \
   SENSORS_MODULE_PARM_FORCE(chip1); \
@@ -197,7 +158,7 @@
 
 #define SENSORS_INSMOD_3(chip1,chip2,chip3) \
   enum chips { any_chip, chip1, chip2, chip3 }; \
-  SENSORS_MODULE_PARM(force, \
+  I2C_CLIENT_MODULE_PARM(force, \
                       "List of adapter,address pairs to boldly assume " \
                       "to be present"); \
   SENSORS_MODULE_PARM_FORCE(chip1); \
@@ -212,7 +173,7 @@
 
 #define SENSORS_INSMOD_4(chip1,chip2,chip3,chip4) \
   enum chips { any_chip, chip1, chip2, chip3, chip4 }; \
-  SENSORS_MODULE_PARM(force, \
+  I2C_CLIENT_MODULE_PARM(force, \
                       "List of adapter,address pairs to boldly assume " \
                       "to be present"); \
   SENSORS_MODULE_PARM_FORCE(chip1); \
@@ -229,7 +190,7 @@
 
 #define SENSORS_INSMOD_5(chip1,chip2,chip3,chip4,chip5) \
   enum chips { any_chip, chip1, chip2, chip3, chip4, chip5 }; \
-  SENSORS_MODULE_PARM(force, \
+  I2C_CLIENT_MODULE_PARM(force, \
                       "List of adapter,address pairs to boldly assume " \
                       "to be present"); \
   SENSORS_MODULE_PARM_FORCE(chip1); \
@@ -248,7 +209,7 @@
 
 #define SENSORS_INSMOD_6(chip1,chip2,chip3,chip4,chip5,chip6) \
   enum chips { any_chip, chip1, chip2, chip3, chip4, chip5, chip6 }; \
-  SENSORS_MODULE_PARM(force, \
+  I2C_CLIENT_MODULE_PARM(force, \
                       "List of adapter,address pairs to boldly assume " \
                       "to be present"); \
   SENSORS_MODULE_PARM_FORCE(chip1); \
@@ -269,7 +230,7 @@
 
 #define SENSORS_INSMOD_7(chip1,chip2,chip3,chip4,chip5,chip6,chip7) \
   enum chips { any_chip, chip1, chip2, chip3, chip4, chip5, chip6, chip7 }; \
-  SENSORS_MODULE_PARM(force, \
+  I2C_CLIENT_MODULE_PARM(force, \
                       "List of adapter,address pairs to boldly assume " \
                       "to be present"); \
   SENSORS_MODULE_PARM_FORCE(chip1); \
@@ -292,7 +253,7 @@
 
 #define SENSORS_INSMOD_8(chip1,chip2,chip3,chip4,chip5,chip6,chip7,chip8) \
   enum chips { any_chip, chip1, chip2, chip3, chip4, chip5, chip6, chip7, chip8 }; \
-  SENSORS_MODULE_PARM(force, \
+  I2C_CLIENT_MODULE_PARM(force, \
                       "List of adapter,address pairs to boldly assume " \
                       "to be present"); \
   SENSORS_MODULE_PARM_FORCE(chip1); \
diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	Thu Apr 24 16:46:10 2003
+++ b/include/linux/i2c.h	Thu Apr 24 16:46:10 2003
@@ -290,10 +290,12 @@
 };
 
 /* Internal numbers to terminate lists */
-#define I2C_CLIENT_END 0xfffe
+#define I2C_CLIENT_END		0xfffe
+#define I2C_CLIENT_ISA_END	0xfffefffe
 
 /* The numbers to use to set I2C bus address */
-#define ANY_I2C_BUS 0xffff
+#define ANY_I2C_BUS		0xffff
+#define ANY_I2C_ISA_BUS		9191
 
 /* The length of the option lists */
 #define I2C_CLIENT_MAX_OPTS 48
@@ -556,11 +558,15 @@
   I2C_CLIENT_MODULE_PARM(force, \
                       "List of adapter,address pairs to boldly assume " \
                       "to be present"); \
-  static struct i2c_client_address_data addr_data = \
-                                       {normal_i2c, normal_i2c_range, \
-                                        probe, probe_range, \
-                                        ignore, ignore_range, \
-                                        force}
+	static struct i2c_client_address_data addr_data = {		\
+			.normal_i2c = 		normal_i2c,		\
+			.normal_i2c_range =	normal_i2c_range,	\
+			.probe =		probe,			\
+			.probe_range =		probe_range,		\
+			.ignore =		ignore,			\
+			.ignore_range =		ignore_range,		\
+			.force =		force,			\
+		}
 
 /* Detect whether we are on the isa bus. If this returns true, all i2c
    access will fail! */

