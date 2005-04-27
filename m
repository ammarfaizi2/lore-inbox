Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbVD0HBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbVD0HBI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 03:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVD0HBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 03:01:08 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:50559 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261732AbVD0Gzi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 02:55:38 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/6] I8K: pass through lindent
Date: Wed, 27 Apr 2005 01:52:17 -0500
User-Agent: KMail/1.8
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200504270149.13450.dtor_core@ameritech.net>
In-Reply-To: <200504270149.13450.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200504270152.17860.dtor_core@ameritech.net>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I8K: pass through Lindent to change 4 spaces identation to TABs

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 i8k.c |  954 +++++++++++++++++++++++++++++++++---------------------------------
 1 files changed, 477 insertions(+), 477 deletions(-)

Index: dtor/drivers/char/i8k.c
===================================================================
--- dtor.orig/drivers/char/i8k.c
+++ dtor/drivers/char/i8k.c
@@ -55,14 +55,14 @@
 #define DELL_SIGNATURE		"Dell Computer"
 
 static char *supported_models[] = {
-    "Inspiron",
-    "Latitude",
-    NULL
+	"Inspiron",
+	"Latitude",
+	NULL
 };
 
 static char system_vendor[48] = "?";
-static char product_name [48] = "?";
-static char bios_version [4]  = "?";
+static char product_name[48] = "?";
+static char bios_version[4] = "?";
 static char serial_number[16] = "?";
 
 MODULE_AUTHOR("Massimo Dal Zotto (dz@debian.org)");
@@ -86,64 +86,63 @@ static int i8k_ioctl(struct inode *, str
 		     unsigned long);
 
 static struct file_operations i8k_fops = {
-    .read	= i8k_read,
-    .ioctl	= i8k_ioctl,
+	.read = i8k_read,
+	.ioctl = i8k_ioctl,
 };
 
 typedef struct {
-    unsigned int eax;
-    unsigned int ebx __attribute__ ((packed));
-    unsigned int ecx __attribute__ ((packed));
-    unsigned int edx __attribute__ ((packed));
-    unsigned int esi __attribute__ ((packed));
-    unsigned int edi __attribute__ ((packed));
+	unsigned int eax;
+	unsigned int ebx __attribute__ ((packed));
+	unsigned int ecx __attribute__ ((packed));
+	unsigned int edx __attribute__ ((packed));
+	unsigned int esi __attribute__ ((packed));
+	unsigned int edi __attribute__ ((packed));
 } SMMRegisters;
 
 typedef struct {
-    u8	type;
-    u8	length;
-    u16	handle;
+	u8 type;
+	u8 length;
+	u16 handle;
 } DMIHeader;
 
 /*
  * Call the System Management Mode BIOS. Code provided by Jonathan Buzzard.
  */
-static int i8k_smm(SMMRegisters *regs)
+static int i8k_smm(SMMRegisters * regs)
 {
-    int rc;
-    int eax = regs->eax;
+	int rc;
+	int eax = regs->eax;
 
-    asm("pushl %%eax\n\t" \
-	"movl 0(%%eax),%%edx\n\t" \
-	"push %%edx\n\t" \
-	"movl 4(%%eax),%%ebx\n\t" \
-	"movl 8(%%eax),%%ecx\n\t" \
-	"movl 12(%%eax),%%edx\n\t" \
-	"movl 16(%%eax),%%esi\n\t" \
-	"movl 20(%%eax),%%edi\n\t" \
-	"popl %%eax\n\t" \
-	"out %%al,$0xb2\n\t" \
-	"out %%al,$0x84\n\t" \
-	"xchgl %%eax,(%%esp)\n\t"
-	"movl %%ebx,4(%%eax)\n\t" \
-	"movl %%ecx,8(%%eax)\n\t" \
-	"movl %%edx,12(%%eax)\n\t" \
-	"movl %%esi,16(%%eax)\n\t" \
-	"movl %%edi,20(%%eax)\n\t" \
-	"popl %%edx\n\t" \
-	"movl %%edx,0(%%eax)\n\t" \
-	"lahf\n\t" \
-	"shrl $8,%%eax\n\t" \
-	"andl $1,%%eax\n" \
-	: "=a" (rc)
-	: "a" (regs)
-	: "%ebx", "%ecx", "%edx", "%esi", "%edi", "memory");
-
-    if ((rc != 0) || ((regs->eax & 0xffff) == 0xffff) || (regs->eax == eax)) {
-	return -EINVAL;
-    }
+	asm("pushl %%eax\n\t"
+	    "movl 0(%%eax),%%edx\n\t"
+	    "push %%edx\n\t"
+	    "movl 4(%%eax),%%ebx\n\t"
+	    "movl 8(%%eax),%%ecx\n\t"
+	    "movl 12(%%eax),%%edx\n\t"
+	    "movl 16(%%eax),%%esi\n\t"
+	    "movl 20(%%eax),%%edi\n\t"
+	    "popl %%eax\n\t"
+	    "out %%al,$0xb2\n\t"
+	    "out %%al,$0x84\n\t"
+	    "xchgl %%eax,(%%esp)\n\t"
+	    "movl %%ebx,4(%%eax)\n\t"
+	    "movl %%ecx,8(%%eax)\n\t"
+	    "movl %%edx,12(%%eax)\n\t"
+	    "movl %%esi,16(%%eax)\n\t"
+	    "movl %%edi,20(%%eax)\n\t"
+	    "popl %%edx\n\t"
+	    "movl %%edx,0(%%eax)\n\t"
+	    "lahf\n\t"
+	    "shrl $8,%%eax\n\t"
+	    "andl $1,%%eax\n":"=a"(rc)
+	    :    "a"(regs)
+	    :    "%ebx", "%ecx", "%edx", "%esi", "%edi", "memory");
 
-    return 0;
+	if ((rc != 0) || ((regs->eax & 0xffff) == 0xffff) || (regs->eax == eax)) {
+		return -EINVAL;
+	}
+
+	return 0;
 }
 
 /*
@@ -152,15 +151,15 @@ static int i8k_smm(SMMRegisters *regs)
  */
 static int i8k_get_bios_version(void)
 {
-    SMMRegisters regs = { 0, 0, 0, 0, 0, 0 };
-    int rc;
+	SMMRegisters regs = { 0, 0, 0, 0, 0, 0 };
+	int rc;
 
-    regs.eax = I8K_SMM_BIOS_VERSION;
-    if ((rc=i8k_smm(&regs)) < 0) {
-	return rc;
-    }
+	regs.eax = I8K_SMM_BIOS_VERSION;
+	if ((rc = i8k_smm(&regs)) < 0) {
+		return rc;
+	}
 
-    return regs.eax;
+	return regs.eax;
 }
 
 /*
@@ -168,8 +167,8 @@ static int i8k_get_bios_version(void)
  */
 static int i8k_get_serial_number(unsigned char *buff)
 {
-    strlcpy(buff, serial_number, sizeof(serial_number));
-    return 0;
+	strlcpy(buff, serial_number, sizeof(serial_number));
+	return 0;
 }
 
 /*
@@ -177,24 +176,24 @@ static int i8k_get_serial_number(unsigne
  */
 static int i8k_get_fn_status(void)
 {
-    SMMRegisters regs = { 0, 0, 0, 0, 0, 0 };
-    int rc;
+	SMMRegisters regs = { 0, 0, 0, 0, 0, 0 };
+	int rc;
 
-    regs.eax = I8K_SMM_FN_STATUS;
-    if ((rc=i8k_smm(&regs)) < 0) {
-	return rc;
-    }
-
-    switch ((regs.eax >> I8K_FN_SHIFT) & I8K_FN_MASK) {
-    case I8K_FN_UP:
-	return I8K_VOL_UP;
-    case I8K_FN_DOWN:
-	return I8K_VOL_DOWN;
-    case I8K_FN_MUTE:
-	return I8K_VOL_MUTE;
-    default:
-	return 0;
-    }
+	regs.eax = I8K_SMM_FN_STATUS;
+	if ((rc = i8k_smm(&regs)) < 0) {
+		return rc;
+	}
+
+	switch ((regs.eax >> I8K_FN_SHIFT) & I8K_FN_MASK) {
+	case I8K_FN_UP:
+		return I8K_VOL_UP;
+	case I8K_FN_DOWN:
+		return I8K_VOL_DOWN;
+	case I8K_FN_MUTE:
+		return I8K_VOL_MUTE;
+	default:
+		return 0;
+	}
 }
 
 /*
@@ -202,20 +201,20 @@ static int i8k_get_fn_status(void)
  */
 static int i8k_get_power_status(void)
 {
-    SMMRegisters regs = { 0, 0, 0, 0, 0, 0 };
-    int rc;
+	SMMRegisters regs = { 0, 0, 0, 0, 0, 0 };
+	int rc;
+
+	regs.eax = I8K_SMM_POWER_STATUS;
+	if ((rc = i8k_smm(&regs)) < 0) {
+		return rc;
+	}
 
-    regs.eax = I8K_SMM_POWER_STATUS;
-    if ((rc=i8k_smm(&regs)) < 0) {
-	return rc;
-    }
-
-    switch (regs.eax & 0xff) {
-    case I8K_POWER_AC:
-	return I8K_AC;
-    default:
-	return I8K_BATTERY;
-    }
+	switch (regs.eax & 0xff) {
+	case I8K_POWER_AC:
+		return I8K_AC;
+	default:
+		return I8K_BATTERY;
+	}
 }
 
 /*
@@ -223,16 +222,16 @@ static int i8k_get_power_status(void)
  */
 static int i8k_get_fan_status(int fan)
 {
-    SMMRegisters regs = { 0, 0, 0, 0, 0, 0 };
-    int rc;
+	SMMRegisters regs = { 0, 0, 0, 0, 0, 0 };
+	int rc;
 
-    regs.eax = I8K_SMM_GET_FAN;
-    regs.ebx = fan & 0xff;
-    if ((rc=i8k_smm(&regs)) < 0) {
-	return rc;
-    }
+	regs.eax = I8K_SMM_GET_FAN;
+	regs.ebx = fan & 0xff;
+	if ((rc = i8k_smm(&regs)) < 0) {
+		return rc;
+	}
 
-    return (regs.eax & 0xff);
+	return (regs.eax & 0xff);
 }
 
 /*
@@ -240,16 +239,16 @@ static int i8k_get_fan_status(int fan)
  */
 static int i8k_get_fan_speed(int fan)
 {
-    SMMRegisters regs = { 0, 0, 0, 0, 0, 0 };
-    int rc;
+	SMMRegisters regs = { 0, 0, 0, 0, 0, 0 };
+	int rc;
 
-    regs.eax = I8K_SMM_GET_SPEED;
-    regs.ebx = fan & 0xff;
-    if ((rc=i8k_smm(&regs)) < 0) {
-	return rc;
-    }
+	regs.eax = I8K_SMM_GET_SPEED;
+	regs.ebx = fan & 0xff;
+	if ((rc = i8k_smm(&regs)) < 0) {
+		return rc;
+	}
 
-    return (regs.eax & 0xffff) * I8K_FAN_MULT;
+	return (regs.eax & 0xffff) * I8K_FAN_MULT;
 }
 
 /*
@@ -257,18 +256,18 @@ static int i8k_get_fan_speed(int fan)
  */
 static int i8k_set_fan(int fan, int speed)
 {
-    SMMRegisters regs = { 0, 0, 0, 0, 0, 0 };
-    int rc;
+	SMMRegisters regs = { 0, 0, 0, 0, 0, 0 };
+	int rc;
 
-    speed = (speed < 0) ? 0 : ((speed > I8K_FAN_MAX) ? I8K_FAN_MAX : speed);
+	speed = (speed < 0) ? 0 : ((speed > I8K_FAN_MAX) ? I8K_FAN_MAX : speed);
 
-    regs.eax = I8K_SMM_SET_FAN;
-    regs.ebx = (fan & 0xff) | (speed << 8);
-    if ((rc=i8k_smm(&regs)) < 0) {
-	return rc;
-    }
+	regs.eax = I8K_SMM_SET_FAN;
+	regs.ebx = (fan & 0xff) | (speed << 8);
+	if ((rc = i8k_smm(&regs)) < 0) {
+		return rc;
+	}
 
-    return (i8k_get_fan_status(fan));
+	return (i8k_get_fan_status(fan));
 }
 
 /*
@@ -276,143 +275,143 @@ static int i8k_set_fan(int fan, int spee
  */
 static int i8k_get_cpu_temp(void)
 {
-    SMMRegisters regs = { 0, 0, 0, 0, 0, 0 };
-    int rc;
-    int temp;
+	SMMRegisters regs = { 0, 0, 0, 0, 0, 0 };
+	int rc;
+	int temp;
 
 #ifdef I8K_TEMPERATURE_BUG
-    static int prev = 0;
+	static int prev = 0;
 #endif
 
-    regs.eax = I8K_SMM_GET_TEMP;
-    if ((rc=i8k_smm(&regs)) < 0) {
-	return rc;
-    }
-    temp = regs.eax & 0xff;
+	regs.eax = I8K_SMM_GET_TEMP;
+	if ((rc = i8k_smm(&regs)) < 0) {
+		return rc;
+	}
+	temp = regs.eax & 0xff;
 
 #ifdef I8K_TEMPERATURE_BUG
-    /*
-     * Sometimes the temperature sensor returns 0x99, which is out of range.
-     * In this case we return (once) the previous cached value. For example:
-     # 1003655137 00000058 00005a4b
-     # 1003655138 00000099 00003a80 <--- 0x99 = 153 degrees
-     # 1003655139 00000054 00005c52
-     */
-    if (temp > I8K_MAX_TEMP) {
-	temp = prev;
-	prev = I8K_MAX_TEMP;
-    } else {
-	prev = temp;
-    }
+	/*
+	 * Sometimes the temperature sensor returns 0x99, which is out of range.
+	 * In this case we return (once) the previous cached value. For example:
+	 # 1003655137 00000058 00005a4b
+	 # 1003655138 00000099 00003a80 <--- 0x99 = 153 degrees
+	 # 1003655139 00000054 00005c52
+	 */
+	if (temp > I8K_MAX_TEMP) {
+		temp = prev;
+		prev = I8K_MAX_TEMP;
+	} else {
+		prev = temp;
+	}
 #endif
 
-    return temp;
+	return temp;
 }
 
 static int i8k_get_dell_signature(void)
 {
-    SMMRegisters regs = { 0, 0, 0, 0, 0, 0 };
-    int rc;
+	SMMRegisters regs = { 0, 0, 0, 0, 0, 0 };
+	int rc;
 
-    regs.eax = I8K_SMM_GET_DELL_SIG;
-    if ((rc=i8k_smm(&regs)) < 0) {
-	return rc;
-    }
+	regs.eax = I8K_SMM_GET_DELL_SIG;
+	if ((rc = i8k_smm(&regs)) < 0) {
+		return rc;
+	}
 
-    if ((regs.eax == 1145651527) && (regs.edx == 1145392204)) {
-	return 0;
-    } else {
-	return -1;
-    }
+	if ((regs.eax == 1145651527) && (regs.edx == 1145392204)) {
+		return 0;
+	} else {
+		return -1;
+	}
 }
 
 static int i8k_ioctl(struct inode *ip, struct file *fp, unsigned int cmd,
 		     unsigned long arg)
 {
-    int val;
-    int speed;
-    unsigned char buff[16];
-    int __user *argp = (int __user *)arg;
-
-    if (!argp)
-	return -EINVAL;
-
-    switch (cmd) {
-    case I8K_BIOS_VERSION:
-	val = i8k_get_bios_version();
-	break;
-
-    case I8K_MACHINE_ID:
-	memset(buff, 0, 16);
-	val = i8k_get_serial_number(buff);
-	break;
-
-    case I8K_FN_STATUS:
-	val = i8k_get_fn_status();
-	break;
-
-    case I8K_POWER_STATUS:
-	val = i8k_get_power_status();
-	break;
-
-    case I8K_GET_TEMP:
-	val = i8k_get_cpu_temp();
-	break;
-
-    case I8K_GET_SPEED:
-	if (copy_from_user(&val, argp, sizeof(int))) {
-	    return -EFAULT;
-	}
-	val = i8k_get_fan_speed(val);
-	break;
-
-    case I8K_GET_FAN:
-	if (copy_from_user(&val, argp, sizeof(int))) {
-	    return -EFAULT;
-	}
-	val = i8k_get_fan_status(val);
-	break;
-
-    case I8K_SET_FAN:
-	if (restricted && !capable(CAP_SYS_ADMIN)) {
-	    return -EPERM;
-	}
-	if (copy_from_user(&val, argp, sizeof(int))) {
-	    return -EFAULT;
-	}
-	if (copy_from_user(&speed, argp+1, sizeof(int))) {
-	    return -EFAULT;
-	}
-	val = i8k_set_fan(val, speed);
-	break;
-
-    default:
-	return -EINVAL;
-    }
-
-    if (val < 0) {
-	return val;
-    }
-
-    switch (cmd) {
-    case I8K_BIOS_VERSION:
-	if (copy_to_user(argp, &val, 4)) {
-	    return -EFAULT;
-	}
-	break;
-    case I8K_MACHINE_ID:
-	if (copy_to_user(argp, buff, 16)) {
-	    return -EFAULT;
-	}
-	break;
-    default:
-	if (copy_to_user(argp, &val, sizeof(int))) {
-	    return -EFAULT;
+	int val;
+	int speed;
+	unsigned char buff[16];
+	int __user *argp = (int __user *)arg;
+
+	if (!argp)
+		return -EINVAL;
+
+	switch (cmd) {
+	case I8K_BIOS_VERSION:
+		val = i8k_get_bios_version();
+		break;
+
+	case I8K_MACHINE_ID:
+		memset(buff, 0, 16);
+		val = i8k_get_serial_number(buff);
+		break;
+
+	case I8K_FN_STATUS:
+		val = i8k_get_fn_status();
+		break;
+
+	case I8K_POWER_STATUS:
+		val = i8k_get_power_status();
+		break;
+
+	case I8K_GET_TEMP:
+		val = i8k_get_cpu_temp();
+		break;
+
+	case I8K_GET_SPEED:
+		if (copy_from_user(&val, argp, sizeof(int))) {
+			return -EFAULT;
+		}
+		val = i8k_get_fan_speed(val);
+		break;
+
+	case I8K_GET_FAN:
+		if (copy_from_user(&val, argp, sizeof(int))) {
+			return -EFAULT;
+		}
+		val = i8k_get_fan_status(val);
+		break;
+
+	case I8K_SET_FAN:
+		if (restricted && !capable(CAP_SYS_ADMIN)) {
+			return -EPERM;
+		}
+		if (copy_from_user(&val, argp, sizeof(int))) {
+			return -EFAULT;
+		}
+		if (copy_from_user(&speed, argp + 1, sizeof(int))) {
+			return -EFAULT;
+		}
+		val = i8k_set_fan(val, speed);
+		break;
+
+	default:
+		return -EINVAL;
 	}
-	break;
-    }
 
-    return 0;
+	if (val < 0) {
+		return val;
+	}
+
+	switch (cmd) {
+	case I8K_BIOS_VERSION:
+		if (copy_to_user(argp, &val, 4)) {
+			return -EFAULT;
+		}
+		break;
+	case I8K_MACHINE_ID:
+		if (copy_to_user(argp, buff, 16)) {
+			return -EFAULT;
+		}
+		break;
+	default:
+		if (copy_to_user(argp, &val, sizeof(int))) {
+			return -EFAULT;
+		}
+		break;
+	}
+
+	return 0;
 }
 
 /*
@@ -420,90 +419,87 @@ static int i8k_ioctl(struct inode *ip, s
  */
 static int i8k_get_info(char *buffer, char **start, off_t fpos, int length)
 {
-    int n, fn_key, cpu_temp, ac_power;
-    int left_fan, right_fan, left_speed, right_speed;
+	int n, fn_key, cpu_temp, ac_power;
+	int left_fan, right_fan, left_speed, right_speed;
+
+	cpu_temp	= i8k_get_cpu_temp();			/* 11100 탎 */
+	left_fan	= i8k_get_fan_status(I8K_FAN_LEFT);	/*   580 탎 */
+	right_fan	= i8k_get_fan_status(I8K_FAN_RIGHT);	/*   580 탎 */
+	left_speed	= i8k_get_fan_speed(I8K_FAN_LEFT);	/*   580 탎 */
+	right_speed	= i8k_get_fan_speed(I8K_FAN_RIGHT);	/*   580 탎 */
+	fn_key		= i8k_get_fn_status();			/*   750 탎 */
+	if (power_status) {
+		ac_power = i8k_get_power_status();		/* 14700 탎 */
+	} else {
+		ac_power = -1;
+	}
 
-    cpu_temp     = i8k_get_cpu_temp();			/* 11100 탎 */
-    left_fan     = i8k_get_fan_status(I8K_FAN_LEFT);	/*   580 탎 */
-    right_fan    = i8k_get_fan_status(I8K_FAN_RIGHT);	/*   580 탎 */
-    left_speed   = i8k_get_fan_speed(I8K_FAN_LEFT);	/*   580 탎 */
-    right_speed  = i8k_get_fan_speed(I8K_FAN_RIGHT);	/*   580 탎 */
-    fn_key       = i8k_get_fn_status();			/*   750 탎 */
-    if (power_status) {
-	ac_power = i8k_get_power_status();		/* 14700 탎 */
-    } else {
-	ac_power = -1;
-    }
-
-    /*
-     * Info:
-     *
-     * 1)  Format version (this will change if format changes)
-     * 2)  BIOS version
-     * 3)  BIOS machine ID
-     * 4)  Cpu temperature
-     * 5)  Left fan status
-     * 6)  Right fan status
-     * 7)  Left fan speed
-     * 8)  Right fan speed
-     * 9)  AC power
-     * 10) Fn Key status
-     */
-    n = sprintf(buffer, "%s %s %s %d %d %d %d %d %d %d\n",
-		I8K_PROC_FMT,
-		bios_version,
-		serial_number,
-		cpu_temp,
-		left_fan,
-		right_fan,
-		left_speed,
-		right_speed,
-		ac_power,
-		fn_key);
-
-    return n;
+	/*
+	 * Info:
+	 *
+	 * 1)  Format version (this will change if format changes)
+	 * 2)  BIOS version
+	 * 3)  BIOS machine ID
+	 * 4)  Cpu temperature
+	 * 5)  Left fan status
+	 * 6)  Right fan status
+	 * 7)  Left fan speed
+	 * 8)  Right fan speed
+	 * 9)  AC power
+	 * 10) Fn Key status
+	 */
+	n = sprintf(buffer, "%s %s %s %d %d %d %d %d %d %d\n",
+		    I8K_PROC_FMT,
+		    bios_version,
+		    serial_number,
+		    cpu_temp,
+		    left_fan,
+		    right_fan, left_speed, right_speed, ac_power, fn_key);
+
+	return n;
 }
 
-static ssize_t i8k_read(struct file *f, char __user *buffer, size_t len, loff_t *fpos)
+static ssize_t i8k_read(struct file *f, char __user * buffer, size_t len,
+			loff_t * fpos)
 {
-    int n;
-    char info[128];
+	int n;
+	char info[128];
 
-    n = i8k_get_info(info, NULL, 0, 128);
-    if (n <= 0) {
-	return n;
-    }
+	n = i8k_get_info(info, NULL, 0, 128);
+	if (n <= 0) {
+		return n;
+	}
 
-    if (*fpos >= n) {
-	return 0;
-    }
+	if (*fpos >= n) {
+		return 0;
+	}
 
-    if ((*fpos + len) >= n) {
-	len = n - *fpos;
-    }
+	if ((*fpos + len) >= n) {
+		len = n - *fpos;
+	}
 
-    if (copy_to_user(buffer, info, len) != 0) {
-	return -EFAULT;
-    }
+	if (copy_to_user(buffer, info, len) != 0) {
+		return -EFAULT;
+	}
 
-    *fpos += len;
-    return len;
+	*fpos += len;
+	return len;
 }
 
-static char* __init string_trim(char *s, int size)
+static char *__init string_trim(char *s, int size)
 {
-    int len;
-    char *p;
+	int len;
+	char *p;
 
-    if ((len = strlen(s)) > size) {
-	len = size;
-    }
+	if ((len = strlen(s)) > size) {
+		len = size;
+	}
 
-    for (p=s+len-1; len && (*p==' '); len--,p--) {
-	*p = '\0';
-    }
+	for (p = s + len - 1; len && (*p == ' '); len--, p--) {
+		*p = '\0';
+	}
 
-    return s;
+	return s;
 }
 
 /* DMI code, stolen from arch/i386/kernel/dmi_scan.c */
@@ -515,111 +511,112 @@ static char* __init string_trim(char *s,
  *                |                       |
  *                +-----------------------+
  */
-static char* __init dmi_string(DMIHeader *dmi, u8 s)
+static char *__init dmi_string(DMIHeader * dmi, u8 s)
 {
-    u8 *p;
+	u8 *p;
 
-    if (!s) {
-	return "";
-    }
-    s--;
-
-    p = (u8 *)dmi + dmi->length;
-    while (s > 0) {
-	p += strlen(p);
-	p++;
+	if (!s) {
+		return "";
+	}
 	s--;
-    }
 
-    return p;
+	p = (u8 *) dmi + dmi->length;
+	while (s > 0) {
+		p += strlen(p);
+		p++;
+		s--;
+	}
+
+	return p;
 }
 
-static void __init dmi_decode(DMIHeader *dmi)
+static void __init dmi_decode(DMIHeader * dmi)
 {
-    u8 *data = (u8 *) dmi;
-    char *p;
+	u8 *data = (u8 *) dmi;
+	char *p;
 
 #ifdef I8K_DEBUG
-    int i;
-    printk("%08x ", (int)data);
-    for (i=0; i<data[1] && i<64; i++) {
-	printk("%02x ", data[i]);
-    }
-    printk("\n");
+	int i;
+	printk("%08x ", (int)data);
+	for (i = 0; i < data[1] && i < 64; i++) {
+		printk("%02x ", data[i]);
+	}
+	printk("\n");
 #endif
 
-    switch (dmi->type) {
-    case  0:	/* BIOS Information */
-	p = dmi_string(dmi,data[5]);
-	if (*p) {
-	    strlcpy(bios_version, p, sizeof(bios_version));
-	    string_trim(bios_version, sizeof(bios_version));
-	}
-	break;	
-    case 1:	/* System Information */
-	p = dmi_string(dmi,data[4]);
-	if (*p) {
-	    strlcpy(system_vendor, p, sizeof(system_vendor));
-	    string_trim(system_vendor, sizeof(system_vendor));
-	}
-	p = dmi_string(dmi,data[5]);
-	if (*p) {
-	    strlcpy(product_name, p, sizeof(product_name));
-	    string_trim(product_name, sizeof(product_name));
-	}
-	p = dmi_string(dmi,data[7]);
-	if (*p) {
-	    strlcpy(serial_number, p, sizeof(serial_number));
-	    string_trim(serial_number, sizeof(serial_number));
-	}
-	break;
-    }
-}
-
-static int __init dmi_table(u32 base, int len, int num, void (*fn)(DMIHeader*))
-{
-    u8 *buf;
-    u8 *data;
-    DMIHeader *dmi;
-    int i = 1;
+	switch (dmi->type) {
+	case 0:		/* BIOS Information */
+		p = dmi_string(dmi, data[5]);
+		if (*p) {
+			strlcpy(bios_version, p, sizeof(bios_version));
+			string_trim(bios_version, sizeof(bios_version));
+		}
+		break;
+	case 1:		/* System Information */
+		p = dmi_string(dmi, data[4]);
+		if (*p) {
+			strlcpy(system_vendor, p, sizeof(system_vendor));
+			string_trim(system_vendor, sizeof(system_vendor));
+		}
+		p = dmi_string(dmi, data[5]);
+		if (*p) {
+			strlcpy(product_name, p, sizeof(product_name));
+			string_trim(product_name, sizeof(product_name));
+		}
+		p = dmi_string(dmi, data[7]);
+		if (*p) {
+			strlcpy(serial_number, p, sizeof(serial_number));
+			string_trim(serial_number, sizeof(serial_number));
+		}
+		break;
+	}
+}
 
-    buf = ioremap(base, len);
-    if (buf == NULL) {
-	return -1;
-    }
-    data = buf;
+static int __init dmi_table(u32 base, int len, int num,
+			    void (*fn) (DMIHeader *))
+{
+	u8 *buf;
+	u8 *data;
+	DMIHeader *dmi;
+	int i = 1;
 
-    /*
-     * Stop when we see al the items the table claimed to have
-     * or we run off the end of the table (also happens)
-     */
-    while ((i<num) && ((data-buf) < len)) {
-	dmi = (DMIHeader *)data;
-	/*
-	 * Avoid misparsing crud if the length of the last
-	 * record is crap
-	 */
-	if ((data-buf+dmi->length) >= len) {
-	    break;
+	buf = ioremap(base, len);
+	if (buf == NULL) {
+		return -1;
 	}
-	fn(dmi);
-	data += dmi->length;
+	data = buf;
+
 	/*
-	 * Don't go off the end of the data if there is
-	 * stuff looking like string fill past the end
+	 * Stop when we see al the items the table claimed to have
+	 * or we run off the end of the table (also happens)
 	 */
-	while (((data-buf) < len) && (*data || data[1])) {
-	    data++;
+	while ((i < num) && ((data - buf) < len)) {
+		dmi = (DMIHeader *) data;
+		/*
+		 * Avoid misparsing crud if the length of the last
+		 * record is crap
+		 */
+		if ((data - buf + dmi->length) >= len) {
+			break;
+		}
+		fn(dmi);
+		data += dmi->length;
+		/*
+		 * Don't go off the end of the data if there is
+		 * stuff looking like string fill past the end
+		 */
+		while (((data - buf) < len) && (*data || data[1])) {
+			data++;
+		}
+		data += 2;
+		i++;
 	}
-	data += 2;
-	i++;
-    }
-    iounmap(buf);
+	iounmap(buf);
 
-    return 0;
+	return 0;
 }
 
-static int __init dmi_iterate(void (*decode)(DMIHeader *))
+static int __init dmi_iterate(void (*decode) (DMIHeader *))
 {
 	unsigned char buf[20];
 	void __iomem *p = ioremap(0xe0000, 0x20000), *q;
@@ -629,20 +626,20 @@ static int __init dmi_iterate(void (*dec
 
 	for (q = p; q < p + 0x20000; q += 16) {
 		memcpy_fromio(buf, q, 20);
-		if (memcmp(buf, "_DMI_", 5)==0) {
-			u16 num  = buf[13]<<8  | buf[12];
-			u16 len  = buf [7]<<8  | buf [6];
-			u32 base = buf[11]<<24 | buf[10]<<16 | buf[9]<<8 | buf[8];
+		if (memcmp(buf, "_DMI_", 5) == 0) {
+			u16 num  = buf[13] << 8 | buf[12];
+			u16 len  = buf[7] << 8 | buf[6];
+			u32 base = buf[11] << 24 | buf[10] << 16 | buf[9] << 8 | buf[8];
 #ifdef I8K_DEBUG
 			printk(KERN_INFO "DMI %d.%d present.\n",
-			   buf[14]>>4, buf[14]&0x0F);
+			       buf[14] >> 4, buf[14] & 0x0F);
 			printk(KERN_INFO "%d structures occupying %d bytes.\n",
-			   buf[13]<<8 | buf[12],
-			   buf [7]<<8 | buf[6]);
+			       buf[13] << 8 | buf[12], buf[7] << 8 | buf[6]);
 			printk(KERN_INFO "DMI table at 0x%08X.\n",
-			   buf[11]<<24 | buf[10]<<16 | buf[9]<<8 | buf[8]);
+			       buf[11] << 24 | buf[10] << 16 | buf[9] << 8 |
+			       buf[8]);
 #endif
-			if (dmi_table(base, len, num, decode)==0) {
+			if (dmi_table(base, len, num, decode) == 0) {
 				iounmap(p);
 				return 0;
 			}
@@ -651,6 +648,7 @@ static int __init dmi_iterate(void (*dec
 	iounmap(p);
 	return -1;
 }
+
 /* end of DMI code */
 
 /*
@@ -658,29 +656,30 @@ static int __init dmi_iterate(void (*dec
  */
 static int __init i8k_dmi_probe(void)
 {
-    char **p;
-
-    if (dmi_iterate(dmi_decode) != 0) {
-	printk(KERN_INFO "i8k: unable to get DMI information\n");
-	return -ENODEV;
-    }
+	char **p;
 
-    if (strncmp(system_vendor,DELL_SIGNATURE,strlen(DELL_SIGNATURE)) != 0) {
-	printk(KERN_INFO "i8k: not running on a Dell system\n");
-	return -ENODEV;
-    }
+	if (dmi_iterate(dmi_decode) != 0) {
+		printk(KERN_INFO "i8k: unable to get DMI information\n");
+		return -ENODEV;
+	}
 
-    for (p=supported_models; ; p++) {
-	if (!*p) {
-	    printk(KERN_INFO "i8k: unsupported model: %s\n", product_name);
-	    return -ENODEV;
+	if (strncmp(system_vendor, DELL_SIGNATURE, strlen(DELL_SIGNATURE)) != 0) {
+		printk(KERN_INFO "i8k: not running on a Dell system\n");
+		return -ENODEV;
 	}
-	if (strncmp(product_name,*p,strlen(*p)) == 0) {
-	    break;
+
+	for (p = supported_models;; p++) {
+		if (!*p) {
+			printk(KERN_INFO "i8k: unsupported model: %s\n",
+			       product_name);
+			return -ENODEV;
+		}
+		if (strncmp(product_name, *p, strlen(*p)) == 0) {
+			break;
+		}
 	}
-    }
 
-    return 0;
+	return 0;
 }
 
 /*
@@ -688,59 +687,60 @@ static int __init i8k_dmi_probe(void)
  */
 static int __init i8k_probe(void)
 {
-    char buff[4];
-    int version;
-    int smm_found = 0;
-
-    /*
-     * Get DMI information
-     */
-    if (i8k_dmi_probe() != 0) {
-	printk(KERN_INFO "i8k: vendor=%s, model=%s, version=%s\n",
-	       system_vendor, product_name, bios_version);
-    }
-
-    /*
-     * Get SMM Dell signature
-     */
-    if (i8k_get_dell_signature() != 0) {
-	printk(KERN_INFO "i8k: unable to get SMM Dell signature\n");
-    } else {
-	smm_found = 1;
-    }
-
-    /*
-     * Get SMM BIOS version.
-     */
-    version = i8k_get_bios_version();
-    if (version <= 0) {
-	printk(KERN_INFO "i8k: unable to get SMM BIOS version\n");
-    } else {
-	smm_found = 1;
-	buff[0] = (version >> 16) & 0xff;
-	buff[1] = (version >>  8) & 0xff;
-	buff[2] = (version)       & 0xff;
-	buff[3] = '\0';
+	char buff[4];
+	int version;
+	int smm_found = 0;
+
 	/*
-	 * If DMI BIOS version is unknown use SMM BIOS version.
+	 * Get DMI information
 	 */
-	if (bios_version[0] == '?') {
-	    strcpy(bios_version, buff);
+	if (i8k_dmi_probe() != 0) {
+		printk(KERN_INFO "i8k: vendor=%s, model=%s, version=%s\n",
+		       system_vendor, product_name, bios_version);
 	}
+
 	/*
-	 * Check if the two versions match.
+	 * Get SMM Dell signature
 	 */
-	if (strncmp(buff,bios_version,sizeof(bios_version)) != 0) {
-	    printk(KERN_INFO "i8k: BIOS version mismatch: %s != %s\n",
-		   buff, bios_version);
+	if (i8k_get_dell_signature() != 0) {
+		printk(KERN_INFO "i8k: unable to get SMM Dell signature\n");
+	} else {
+		smm_found = 1;
 	}
-    }
 
-    if (!smm_found && !force) {
-	return -ENODEV;
-    }
+	/*
+	 * Get SMM BIOS version.
+	 */
+	version = i8k_get_bios_version();
+	if (version <= 0) {
+		printk(KERN_INFO "i8k: unable to get SMM BIOS version\n");
+	} else {
+		smm_found = 1;
+		buff[0] = (version >> 16) & 0xff;
+		buff[1] = (version >> 8) & 0xff;
+		buff[2] = (version) & 0xff;
+		buff[3] = '\0';
+		/*
+		 * If DMI BIOS version is unknown use SMM BIOS version.
+		 */
+		if (bios_version[0] == '?') {
+			strcpy(bios_version, buff);
+		}
+		/*
+		 * Check if the two versions match.
+		 */
+		if (strncmp(buff, bios_version, sizeof(bios_version)) != 0) {
+			printk(KERN_INFO
+			       "i8k: BIOS version mismatch: %s != %s\n", buff,
+			       bios_version);
+		}
+	}
 
-    return 0;
+	if (!smm_found && !force) {
+		return -ENODEV;
+	}
+
+	return 0;
 }
 
 #ifdef MODULE
@@ -748,40 +748,40 @@ static
 #endif
 int __init i8k_init(void)
 {
-    struct proc_dir_entry *proc_i8k;
+	struct proc_dir_entry *proc_i8k;
 
-    /* Are we running on an supported laptop? */
-    if (i8k_probe() != 0) {
-	return -ENODEV;
-    }
-
-    /* Register the proc entry */
-    proc_i8k = create_proc_info_entry("i8k", 0, NULL, i8k_get_info);
-    if (!proc_i8k) {
-	return -ENOENT;
-    }
-    proc_i8k->proc_fops = &i8k_fops;
-    proc_i8k->owner = THIS_MODULE;
-
-    printk(KERN_INFO
-	   "Dell laptop SMM driver v%s Massimo Dal Zotto (dz@debian.org)\n",
-	   I8K_VERSION);
+	/* Are we running on an supported laptop? */
+	if (i8k_probe() != 0) {
+		return -ENODEV;
+	}
+
+	/* Register the proc entry */
+	proc_i8k = create_proc_info_entry("i8k", 0, NULL, i8k_get_info);
+	if (!proc_i8k) {
+		return -ENOENT;
+	}
+	proc_i8k->proc_fops = &i8k_fops;
+	proc_i8k->owner = THIS_MODULE;
 
-    return 0;
+	printk(KERN_INFO
+	       "Dell laptop SMM driver v%s Massimo Dal Zotto (dz@debian.org)\n",
+	       I8K_VERSION);
+
+	return 0;
 }
 
 #ifdef MODULE
 int init_module(void)
 {
-    return i8k_init();
+	return i8k_init();
 }
 
 void cleanup_module(void)
 {
-    /* Remove the proc entry */
-    remove_proc_entry("i8k", NULL);
+	/* Remove the proc entry */
+	remove_proc_entry("i8k", NULL);
 
-    printk(KERN_INFO "i8k: module unloaded\n");
+	printk(KERN_INFO "i8k: module unloaded\n");
 }
 #endif
 
