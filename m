Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262804AbVFVG5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262804AbVFVG5J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 02:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262840AbVFVGgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:36:54 -0400
Received: from mail.kroah.org ([69.55.234.183]:23452 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262794AbVFVFWD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:22:03 -0400
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Coding style cleanups to via686a
In-Reply-To: <1119417465463@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:45 -0700
Message-Id: <1119417465718@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 8BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: Coding style cleanups to via686a

The via686a hardware monitoring driver has infamous coding style at the
moment. I'd like to clean up the mess before I start working on other
changes to this driver. Is the following patch acceptable? No code
change, only coding style (indentation, alignments, trailing white
space, a few parentheses and a typo).

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit be8992c249e42398ee905450688c135ab761674c
tree 29f41874649a86f5616301ca78eae96b79a8c5eb
parent 68188ba7de2db9999ff08a4544a78b2f10eb08bd
author Jean Delvare <khali@linux-fr.org> Mon, 16 May 2005 19:00:52 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:51:58 -0700

 drivers/i2c/chips/via686a.c |  274 ++++++++++++++++++++++---------------------
 1 files changed, 139 insertions(+), 135 deletions(-)

diff --git a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c
+++ b/drivers/i2c/chips/via686a.c
@@ -1,12 +1,12 @@
 /*
     via686a.c - Part of lm_sensors, Linux kernel modules
                 for hardware monitoring
-                
+
     Copyright (c) 1998 - 2002  Frodo Looijaard <frodol@dds.nl>,
                         Kyösti Mälkki <kmalkki@cc.hut.fi>,
 			Mark Studebaker <mdsxyz123@yahoo.com>,
 			and Bob Dougherty <bobd@stanford.edu>
-    (Some conversion-factor data were contributed by Jonathan Teh Soon Yew 
+    (Some conversion-factor data were contributed by Jonathan Teh Soon Yew
     <j.teh@iname.com> and Alex van Kaam <darkside@chello.nl>.)
 
     This program is free software; you can redistribute it and/or modify
@@ -64,19 +64,19 @@ SENSORS_INSMOD_1(via686a);
 /* Many VIA686A constants specified below */
 
 /* Length of ISA address segment */
-#define VIA686A_EXTENT 0x80
-#define VIA686A_BASE_REG 0x70
-#define VIA686A_ENABLE_REG 0x74
+#define VIA686A_EXTENT		0x80
+#define VIA686A_BASE_REG	0x70
+#define VIA686A_ENABLE_REG	0x74
 
 /* The VIA686A registers */
 /* ins numbered 0-4 */
-#define VIA686A_REG_IN_MAX(nr) (0x2b + ((nr) * 2))
-#define VIA686A_REG_IN_MIN(nr) (0x2c + ((nr) * 2))
-#define VIA686A_REG_IN(nr)     (0x22 + (nr))
+#define VIA686A_REG_IN_MAX(nr)	(0x2b + ((nr) * 2))
+#define VIA686A_REG_IN_MIN(nr)	(0x2c + ((nr) * 2))
+#define VIA686A_REG_IN(nr)	(0x22 + (nr))
 
 /* fans numbered 1-2 */
-#define VIA686A_REG_FAN_MIN(nr) (0x3a + (nr))
-#define VIA686A_REG_FAN(nr)     (0x28 + (nr))
+#define VIA686A_REG_FAN_MIN(nr)	(0x3a + (nr))
+#define VIA686A_REG_FAN(nr)	(0x28 + (nr))
 
 /* the following values are as speced by VIA: */
 static const u8 regtemp[] = { 0x20, 0x21, 0x1f };
@@ -87,26 +87,28 @@ static const u8 reghyst[] = { 0x3a, 0x3e
 #define VIA686A_REG_TEMP(nr)		(regtemp[nr])
 #define VIA686A_REG_TEMP_OVER(nr)	(regover[nr])
 #define VIA686A_REG_TEMP_HYST(nr)	(reghyst[nr])
-#define VIA686A_REG_TEMP_LOW1	0x4b	// bits 7-6
-#define VIA686A_REG_TEMP_LOW23	0x49	// 2 = bits 5-4, 3 = bits 7-6
-
-#define VIA686A_REG_ALARM1 0x41
-#define VIA686A_REG_ALARM2 0x42
-#define VIA686A_REG_FANDIV 0x47
-#define VIA686A_REG_CONFIG 0x40
-/* The following register sets temp interrupt mode (bits 1-0 for temp1, 
+/* bits 7-6 */
+#define VIA686A_REG_TEMP_LOW1	0x4b
+/* 2 = bits 5-4, 3 = bits 7-6 */
+#define VIA686A_REG_TEMP_LOW23	0x49
+
+#define VIA686A_REG_ALARM1	0x41
+#define VIA686A_REG_ALARM2	0x42
+#define VIA686A_REG_FANDIV	0x47
+#define VIA686A_REG_CONFIG	0x40
+/* The following register sets temp interrupt mode (bits 1-0 for temp1,
  3-2 for temp2, 5-4 for temp3).  Modes are:
     00 interrupt stays as long as value is out-of-range
     01 interrupt is cleared once register is read (default)
     10 comparator mode- like 00, but ignores hysteresis
     11 same as 00 */
-#define VIA686A_REG_TEMP_MODE 0x4b
+#define VIA686A_REG_TEMP_MODE		0x4b
 /* We'll just assume that you want to set all 3 simultaneously: */
-#define VIA686A_TEMP_MODE_MASK 0x3F
-#define VIA686A_TEMP_MODE_CONTINUOUS (0x00)
+#define VIA686A_TEMP_MODE_MASK		0x3F
+#define VIA686A_TEMP_MODE_CONTINUOUS	0x00
 
 /* Conversions. Limit checking is only done on the TO_REG
-   variants. 
+   variants.
 
 ********* VOLTAGE CONVERSIONS (Bob Dougherty) ********
  From HWMon.cpp (Copyright 1998-2000 Jonathan Teh Soon Yew):
@@ -119,7 +121,7 @@ static const u8 reghyst[] = { 0x3a, 0x3e
  That is:
  volts = (25*regVal+133)*factor
  regVal = (volts/factor-133)/25
- (These conversions were contributed by Jonathan Teh Soon Yew 
+ (These conversions were contributed by Jonathan Teh Soon Yew
  <j.teh@iname.com>) */
 static inline u8 IN_TO_REG(long val, int inNum)
 {
@@ -180,55 +182,55 @@ static inline u8 FAN_TO_REG(long rpm, in
       else
               return double(temp)*0.924-127.33;
 
- A fifth-order polynomial fits the unofficial data (provided by Alex van 
- Kaam <darkside@chello.nl>) a bit better.  It also give more reasonable 
- numbers on my machine (ie. they agree with what my BIOS tells me).  
+ A fifth-order polynomial fits the unofficial data (provided by Alex van
+ Kaam <darkside@chello.nl>) a bit better.  It also give more reasonable
+ numbers on my machine (ie. they agree with what my BIOS tells me).
  Here's the fifth-order fit to the 8-bit data:
- temp = 1.625093e-10*val^5 - 1.001632e-07*val^4 + 2.457653e-05*val^3 - 
+ temp = 1.625093e-10*val^5 - 1.001632e-07*val^4 + 2.457653e-05*val^3 -
         2.967619e-03*val^2 + 2.175144e-01*val - 7.090067e+0.
 
- (2000-10-25- RFD: thanks to Uwe Andersen <uandersen@mayah.com> for 
+ (2000-10-25- RFD: thanks to Uwe Andersen <uandersen@mayah.com> for
  finding my typos in this formula!)
 
- Alas, none of the elegant function-fit solutions will work because we 
- aren't allowed to use floating point in the kernel and doing it with 
- integers doesn't rpovide enough precision.  So we'll do boring old 
- look-up table stuff.  The unofficial data (see below) have effectively 
- 7-bit resolution (they are rounded to the nearest degree).  I'm assuming 
- that the transfer function of the device is monotonic and smooth, so a 
- smooth function fit to the data will allow us to get better precision.  
+ Alas, none of the elegant function-fit solutions will work because we
+ aren't allowed to use floating point in the kernel and doing it with
+ integers doesn't provide enough precision.  So we'll do boring old
+ look-up table stuff.  The unofficial data (see below) have effectively
+ 7-bit resolution (they are rounded to the nearest degree).  I'm assuming
+ that the transfer function of the device is monotonic and smooth, so a
+ smooth function fit to the data will allow us to get better precision.
  I used the 5th-order poly fit described above and solved for
- VIA register values 0-255.  I *10 before rounding, so we get tenth-degree 
- precision.  (I could have done all 1024 values for our 10-bit readings, 
- but the function is very linear in the useful range (0-80 deg C), so 
- we'll just use linear interpolation for 10-bit readings.)  So, tempLUT 
+ VIA register values 0-255.  I *10 before rounding, so we get tenth-degree
+ precision.  (I could have done all 1024 values for our 10-bit readings,
+ but the function is very linear in the useful range (0-80 deg C), so
+ we'll just use linear interpolation for 10-bit readings.)  So, tempLUT
  is the temp at via register values 0-255: */
 static const long tempLUT[] =
-    { -709, -688, -667, -646, -627, -607, -589, -570, -553, -536, -519,
-	    -503, -487, -471, -456, -442, -428, -414, -400, -387, -375,
-	    -362, -350, -339, -327, -316, -305, -295, -285, -275, -265,
-	    -255, -246, -237, -229, -220, -212, -204, -196, -188, -180,
-	    -173, -166, -159, -152, -145, -139, -132, -126, -120, -114,
-	    -108, -102, -96, -91, -85, -80, -74, -69, -64, -59, -54, -49,
-	    -44, -39, -34, -29, -25, -20, -15, -11, -6, -2, 3, 7, 12, 16,
-	    20, 25, 29, 33, 37, 42, 46, 50, 54, 59, 63, 67, 71, 75, 79, 84,
-	    88, 92, 96, 100, 104, 109, 113, 117, 121, 125, 130, 134, 138,
-	    142, 146, 151, 155, 159, 163, 168, 172, 176, 181, 185, 189,
-	    193, 198, 202, 206, 211, 215, 219, 224, 228, 232, 237, 241,
-	    245, 250, 254, 259, 263, 267, 272, 276, 281, 285, 290, 294,
-	    299, 303, 307, 312, 316, 321, 325, 330, 334, 339, 344, 348,
-	    353, 357, 362, 366, 371, 376, 380, 385, 390, 395, 399, 404,
-	    409, 414, 419, 423, 428, 433, 438, 443, 449, 454, 459, 464,
-	    469, 475, 480, 486, 491, 497, 502, 508, 514, 520, 526, 532,
-	    538, 544, 551, 557, 564, 571, 578, 584, 592, 599, 606, 614,
-	    621, 629, 637, 645, 654, 662, 671, 680, 689, 698, 708, 718,
-	    728, 738, 749, 759, 770, 782, 793, 805, 818, 830, 843, 856,
-	    870, 883, 898, 912, 927, 943, 958, 975, 991, 1008, 1026, 1044,
-	    1062, 1081, 1101, 1121, 1141, 1162, 1184, 1206, 1229, 1252,
-	    1276, 1301, 1326, 1352, 1378, 1406, 1434, 1462
+{ -709, -688, -667, -646, -627, -607, -589, -570, -553, -536, -519,
+	-503, -487, -471, -456, -442, -428, -414, -400, -387, -375,
+	-362, -350, -339, -327, -316, -305, -295, -285, -275, -265,
+	-255, -246, -237, -229, -220, -212, -204, -196, -188, -180,
+	-173, -166, -159, -152, -145, -139, -132, -126, -120, -114,
+	-108, -102, -96, -91, -85, -80, -74, -69, -64, -59, -54, -49,
+	-44, -39, -34, -29, -25, -20, -15, -11, -6, -2, 3, 7, 12, 16,
+	20, 25, 29, 33, 37, 42, 46, 50, 54, 59, 63, 67, 71, 75, 79, 84,
+	88, 92, 96, 100, 104, 109, 113, 117, 121, 125, 130, 134, 138,
+	142, 146, 151, 155, 159, 163, 168, 172, 176, 181, 185, 189,
+	193, 198, 202, 206, 211, 215, 219, 224, 228, 232, 237, 241,
+	245, 250, 254, 259, 263, 267, 272, 276, 281, 285, 290, 294,
+	299, 303, 307, 312, 316, 321, 325, 330, 334, 339, 344, 348,
+	353, 357, 362, 366, 371, 376, 380, 385, 390, 395, 399, 404,
+	409, 414, 419, 423, 428, 433, 438, 443, 449, 454, 459, 464,
+	469, 475, 480, 486, 491, 497, 502, 508, 514, 520, 526, 532,
+	538, 544, 551, 557, 564, 571, 578, 584, 592, 599, 606, 614,
+	621, 629, 637, 645, 654, 662, 671, 680, 689, 698, 708, 718,
+	728, 738, 749, 759, 770, 782, 793, 805, 818, 830, 843, 856,
+	870, 883, 898, 912, 927, 943, 958, 975, 991, 1008, 1026, 1044,
+	1062, 1081, 1101, 1121, 1141, 1162, 1184, 1206, 1229, 1252,
+	1276, 1301, 1326, 1352, 1378, 1406, 1434, 1462
 };
 
-/* the original LUT values from Alex van Kaam <darkside@chello.nl> 
+/* the original LUT values from Alex van Kaam <darkside@chello.nl>
    (for via register values 12-240):
 {-50,-49,-47,-45,-43,-41,-39,-38,-37,-35,-34,-33,-32,-31,
 -30,-29,-28,-27,-26,-25,-24,-24,-23,-22,-21,-20,-20,-19,-18,-17,-17,-16,-15,
@@ -243,26 +245,26 @@ static const long tempLUT[] =
 
 
  Here's the reverse LUT.  I got it by doing a 6-th order poly fit (needed
- an extra term for a good fit to these inverse data!) and then 
- solving for each temp value from -50 to 110 (the useable range for 
- this chip).  Here's the fit: 
- viaRegVal = -1.160370e-10*val^6 +3.193693e-08*val^5 - 1.464447e-06*val^4 
+ an extra term for a good fit to these inverse data!) and then
+ solving for each temp value from -50 to 110 (the useable range for
+ this chip).  Here's the fit:
+ viaRegVal = -1.160370e-10*val^6 +3.193693e-08*val^5 - 1.464447e-06*val^4
  - 2.525453e-04*val^3 + 1.424593e-02*val^2 + 2.148941e+00*val +7.275808e+01)
  Note that n=161: */
 static const u8 viaLUT[] =
-    { 12, 12, 13, 14, 14, 15, 16, 16, 17, 18, 18, 19, 20, 20, 21, 22, 23,
-	    23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 35, 36, 37, 39, 40,
-	    41, 43, 45, 46, 48, 49, 51, 53, 55, 57, 59, 60, 62, 64, 66,
-	    69, 71, 73, 75, 77, 79, 82, 84, 86, 88, 91, 93, 95, 98, 100,
-	    103, 105, 107, 110, 112, 115, 117, 119, 122, 124, 126, 129,
-	    131, 134, 136, 138, 140, 143, 145, 147, 150, 152, 154, 156,
-	    158, 160, 162, 164, 166, 168, 170, 172, 174, 176, 178, 180,
-	    182, 183, 185, 187, 188, 190, 192, 193, 195, 196, 198, 199,
-	    200, 202, 203, 205, 206, 207, 208, 209, 210, 211, 212, 213,
-	    214, 215, 216, 217, 218, 219, 220, 221, 222, 222, 223, 224,
-	    225, 226, 226, 227, 228, 228, 229, 230, 230, 231, 232, 232,
-	    233, 233, 234, 235, 235, 236, 236, 237, 237, 238, 238, 239,
-	    239, 240
+{ 12, 12, 13, 14, 14, 15, 16, 16, 17, 18, 18, 19, 20, 20, 21, 22, 23,
+	23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 35, 36, 37, 39, 40,
+	41, 43, 45, 46, 48, 49, 51, 53, 55, 57, 59, 60, 62, 64, 66,
+	69, 71, 73, 75, 77, 79, 82, 84, 86, 88, 91, 93, 95, 98, 100,
+	103, 105, 107, 110, 112, 115, 117, 119, 122, 124, 126, 129,
+	131, 134, 136, 138, 140, 143, 145, 147, 150, 152, 154, 156,
+	158, 160, 162, 164, 166, 168, 170, 172, 174, 176, 178, 180,
+	182, 183, 185, 187, 188, 190, 192, 193, 195, 196, 198, 199,
+	200, 202, 203, 205, 206, 207, 208, 209, 210, 211, 212, 213,
+	214, 215, 216, 217, 218, 219, 220, 221, 222, 222, 223, 224,
+	225, 226, 226, 227, 228, 228, 229, 230, 230, 231, 232, 232,
+	233, 233, 234, 235, 235, 236, 236, 237, 237, 238, 238, 239,
+	239, 240
 };
 
 /* Converting temps to (8-bit) hyst and over registers
@@ -270,7 +272,7 @@ static const u8 viaLUT[] =
    The +50 is because the temps start at -50 */
 static inline u8 TEMP_TO_REG(long val)
 {
-	return viaLUT[val <= -50000 ? 0 : val >= 110000 ? 160 : 
+	return viaLUT[val <= -50000 ? 0 : val >= 110000 ? 160 :
 		      (val < 0 ? val - 500 : val + 500) / 1000 + 50];
 }
 
@@ -289,7 +291,7 @@ static inline long TEMP_FROM_REG10(u16 v
 
 	/* do some linear interpolation */
 	return (tempLUT[eightBits] * (4 - twoBits) +
-	        tempLUT[eightBits + 1] * twoBits) * 25;
+		tempLUT[eightBits + 1] * twoBits) * 25;
 }
 
 #define DIV_FROM_REG(val) (1 << (val))
@@ -354,28 +356,28 @@ static ssize_t show_in_max(struct device
 	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in_max[nr], nr));
 }
 
-static ssize_t set_in_min(struct device *dev, const char *buf, 
+static ssize_t set_in_min(struct device *dev, const char *buf,
 		size_t count, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	down(&data->update_lock);
-	data->in_min[nr] = IN_TO_REG(val,nr);
-	via686a_write_value(client, VIA686A_REG_IN_MIN(nr), 
+	data->in_min[nr] = IN_TO_REG(val, nr);
+	via686a_write_value(client, VIA686A_REG_IN_MIN(nr),
 			data->in_min[nr]);
 	up(&data->update_lock);
 	return count;
 }
-static ssize_t set_in_max(struct device *dev, const char *buf, 
+static ssize_t set_in_max(struct device *dev, const char *buf,
 		size_t count, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	down(&data->update_lock);
-	data->in_max[nr] = IN_TO_REG(val,nr);
-	via686a_write_value(client, VIA686A_REG_IN_MAX(nr), 
+	data->in_max[nr] = IN_TO_REG(val, nr);
+	via686a_write_value(client, VIA686A_REG_IN_MAX(nr),
 			data->in_max[nr]);
 	up(&data->update_lock);
 	return count;
@@ -431,7 +433,7 @@ static ssize_t show_temp_hyst(struct dev
 	struct via686a_data *data = via686a_update_device(dev);
 	return sprintf(buf, "%ld\n", TEMP_FROM_REG(data->temp_hyst[nr]));
 }
-static ssize_t set_temp_over(struct device *dev, const char *buf, 
+static ssize_t set_temp_over(struct device *dev, const char *buf,
 		size_t count, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
@@ -443,7 +445,7 @@ static ssize_t set_temp_over(struct devi
 	up(&data->update_lock);
 	return count;
 }
-static ssize_t set_temp_hyst(struct device *dev, const char *buf, 
+static ssize_t set_temp_hyst(struct device *dev, const char *buf,
 		size_t count, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
@@ -484,7 +486,7 @@ static DEVICE_ATTR(temp##offset##_input,
 static DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR, 		\
 		show_temp_##offset##_over, set_temp_##offset##_over);	\
 static DEVICE_ATTR(temp##offset##_max_hyst, S_IRUGO | S_IWUSR, 		\
-		show_temp_##offset##_hyst, set_temp_##offset##_hyst);	
+		show_temp_##offset##_hyst, set_temp_##offset##_hyst);
 
 show_temp_offset(1);
 show_temp_offset(2);
@@ -493,19 +495,19 @@ show_temp_offset(3);
 /* 2 Fans */
 static ssize_t show_fan(struct device *dev, char *buf, int nr) {
 	struct via686a_data *data = via686a_update_device(dev);
-	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan[nr], 
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[nr],
 				DIV_FROM_REG(data->fan_div[nr])) );
 }
 static ssize_t show_fan_min(struct device *dev, char *buf, int nr) {
 	struct via686a_data *data = via686a_update_device(dev);
-	return sprintf(buf,"%d\n",
+	return sprintf(buf, "%d\n",
 		FAN_FROM_REG(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr])) );
 }
 static ssize_t show_fan_div(struct device *dev, char *buf, int nr) {
 	struct via686a_data *data = via686a_update_device(dev);
-	return sprintf(buf,"%d\n", DIV_FROM_REG(data->fan_div[nr]) );
+	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[nr]) );
 }
-static ssize_t set_fan_min(struct device *dev, const char *buf, 
+static ssize_t set_fan_min(struct device *dev, const char *buf,
 		size_t count, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
@@ -517,7 +519,7 @@ static ssize_t set_fan_min(struct device
 	up(&data->update_lock);
 	return count;
 }
-static ssize_t set_fan_div(struct device *dev, const char *buf, 
+static ssize_t set_fan_div(struct device *dev, const char *buf,
 		size_t count, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
@@ -608,11 +610,12 @@ static int via686a_detect(struct i2c_ada
 	}
 
 	/* 8231 requires multiple of 256, we enforce that on 686 as well */
-	if(force_addr)
+	if (force_addr)
 		address = force_addr & 0xFF00;
 
-	if(force_addr) {
-		dev_warn(&adapter->dev,"forcing ISA address 0x%04X\n", address);
+	if (force_addr) {
+		dev_warn(&adapter->dev, "forcing ISA address 0x%04X\n",
+			 address);
 		if (PCIBIOS_SUCCESSFUL !=
 		    pci_write_config_word(s_bridge, VIA686A_BASE_REG, address))
 			return -ENODEV;
@@ -621,17 +624,17 @@ static int via686a_detect(struct i2c_ada
 	    pci_read_config_word(s_bridge, VIA686A_ENABLE_REG, &val))
 		return -ENODEV;
 	if (!(val & 0x0001)) {
-		dev_warn(&adapter->dev,"enabling sensors\n");
+		dev_warn(&adapter->dev, "enabling sensors\n");
 		if (PCIBIOS_SUCCESSFUL !=
 		    pci_write_config_word(s_bridge, VIA686A_ENABLE_REG,
-		                      val | 0x0001))
+					  val | 0x0001))
 			return -ENODEV;
 	}
 
 	/* Reserve the ISA region */
 	if (!request_region(address, VIA686A_EXTENT, via686a_driver.name)) {
-		dev_err(&adapter->dev,"region 0x%x already in use!\n",
-		       address);
+		dev_err(&adapter->dev, "region 0x%x already in use!\n",
+			address);
 		return -ENODEV;
 	}
 
@@ -656,7 +659,7 @@ static int via686a_detect(struct i2c_ada
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
 		goto ERROR3;
-	
+
 	/* Initialize the VIA686A chip */
 	via686a_init_client(new_client);
 
@@ -695,9 +698,9 @@ static int via686a_detect(struct i2c_ada
 
 	return 0;
 
-      ERROR3:
+ERROR3:
 	kfree(data);
-      ERROR0:
+ERROR0:
 	release_region(address, VIA686A_EXTENT);
 	return err;
 }
@@ -728,7 +731,7 @@ static void via686a_init_client(struct i
 	via686a_write_value(client, VIA686A_REG_CONFIG, (reg|0x01)&0x7F);
 
 	/* Configure temp interrupt mode for continuous-interrupt operation */
-	via686a_write_value(client, VIA686A_REG_TEMP_MODE, 
+	via686a_write_value(client, VIA686A_REG_TEMP_MODE,
 			    via686a_read_value(client, VIA686A_REG_TEMP_MODE) &
 			    !(VIA686A_TEMP_MODE_MASK | VIA686A_TEMP_MODE_CONTINUOUS));
 }
@@ -768,7 +771,7 @@ static struct via686a_data *via686a_upda
 			    via686a_read_value(client,
 					       VIA686A_REG_TEMP_HYST(i));
 		}
-		/* add in lower 2 bits 
+		/* add in lower 2 bits
 		   temp1 uses bits 7-6 of VIA686A_REG_TEMP_LOW1
 		   temp2 uses bits 5-4 of VIA686A_REG_TEMP_LOW23
 		   temp3 uses bits 7-6 of VIA686A_REG_TEMP_LOW23
@@ -800,35 +803,36 @@ static struct via686a_data *via686a_upda
 }
 
 static struct pci_device_id via686a_pci_ids[] = {
-       { PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4) },
-       { 0, }
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4) },
+	{ 0, }
 };
 
 MODULE_DEVICE_TABLE(pci, via686a_pci_ids);
 
 static int __devinit via686a_pci_probe(struct pci_dev *dev,
-                                      const struct pci_device_id *id)
+				       const struct pci_device_id *id)
 {
-       u16 val;
-       int addr = 0;
+	u16 val;
+	int addr = 0;
 
-       if (PCIBIOS_SUCCESSFUL !=
-           pci_read_config_word(dev, VIA686A_BASE_REG, &val))
-               return -ENODEV;
-
-       addr = val & ~(VIA686A_EXTENT - 1);
-       if (addr == 0 && force_addr == 0) {
-               dev_err(&dev->dev,"base address not set - upgrade BIOS or use force_addr=0xaddr\n");
-               return -ENODEV;
-       }
-       if (force_addr)
-               addr = force_addr;      /* so detect will get called */
-
-       if (!addr) {
-               dev_err(&dev->dev,"No Via 686A sensors found.\n");
-               return -ENODEV;
-       }
-       normal_isa[0] = addr;
+	if (PCIBIOS_SUCCESSFUL !=
+	    pci_read_config_word(dev, VIA686A_BASE_REG, &val))
+		return -ENODEV;
+
+	addr = val & ~(VIA686A_EXTENT - 1);
+	if (addr == 0 && force_addr == 0) {
+		dev_err(&dev->dev, "base address not set - upgrade BIOS "
+			"or use force_addr=0xaddr\n");
+		return -ENODEV;
+	}
+	if (force_addr)
+		addr = force_addr;	/* so detect will get called */
+
+	if (!addr) {
+		dev_err(&dev->dev, "No Via 686A sensors found.\n");
+		return -ENODEV;
+	}
+	normal_isa[0] = addr;
 
 	s_bridge = pci_dev_get(dev);
 	if (i2c_add_driver(&via686a_driver)) {
@@ -844,14 +848,14 @@ static int __devinit via686a_pci_probe(s
 }
 
 static struct pci_driver via686a_pci_driver = {
-       .name		= "via686a",
-       .id_table	= via686a_pci_ids,
-       .probe		= via686a_pci_probe,
+	.name		= "via686a",
+	.id_table	= via686a_pci_ids,
+	.probe		= via686a_pci_probe,
 };
 
 static int __init sm_via686a_init(void)
 {
-       return pci_register_driver(&via686a_pci_driver);
+	return pci_register_driver(&via686a_pci_driver);
 }
 
 static void __exit sm_via686a_exit(void)
@@ -865,8 +869,8 @@ static void __exit sm_via686a_exit(void)
 }
 
 MODULE_AUTHOR("Kyösti Mälkki <kmalkki@cc.hut.fi>, "
-              "Mark Studebaker <mdsxyz123@yahoo.com> "
-             "and Bob Dougherty <bobd@stanford.edu>");
+	      "Mark Studebaker <mdsxyz123@yahoo.com> "
+	      "and Bob Dougherty <bobd@stanford.edu>");
 MODULE_DESCRIPTION("VIA 686A Sensor device");
 MODULE_LICENSE("GPL");
 

