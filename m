Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264341AbTLPEOU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 23:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264343AbTLPEOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 23:14:20 -0500
Received: from smtp-relay.dca.net ([216.158.48.66]:65469 "EHLO
	smtp-relay.dca.net") by vger.kernel.org with ESMTP id S264341AbTLPEOF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 23:14:05 -0500
Date: Mon, 15 Dec 2003 23:02:51 -0500
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Sensors <sensors@Stimpy.netroedge.com>
Subject: Re: [PATCH 2.6] sensors chip updates (2 of 4)
Message-ID: <20031216040251.GC1658@earth.solarsys.private>
References: <20031216035219.GA1658@earth.solarsys.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031216035219.GA1658@earth.solarsys.private>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is from the lm_sensors project CVS, from this revision:

	1.111 (mds) remove initialization of limits by driver

It is better to set these limits by a combination of /etc/sensors.conf
and 'sensors -s'; "mechanism not policy." And what's not to like about
a patch that removes 163 lines?

--- linux-2.6.0-test11-mmh/drivers/i2c/chips/w83781d.c.old	2003-12-14 17:22:51.307815925 -0500
+++ linux-2.6.0-test11-mmh/drivers/i2c/chips/w83781d.c	2003-12-14 17:20:35.000000000 -0500
@@ -208,72 +208,6 @@
 	return ((u8) i);
 }
 
-/* Initial limits */
-#define W83781D_INIT_IN_0		(vid == 3500 ? 280 : vid / 10)
-#define W83781D_INIT_IN_1		(vid == 3500 ? 280 : vid / 10)
-#define W83781D_INIT_IN_2		330
-#define W83781D_INIT_IN_3		(((500)   * 100) / 168)
-#define W83781D_INIT_IN_4		(((1200)  * 10) / 38)
-#define W83781D_INIT_IN_5		(((-1200) * -604) / 2100)
-#define W83781D_INIT_IN_6		(((-500)  * -604) / 909)
-#define W83781D_INIT_IN_7		(((500)   * 100) / 168)
-#define W83781D_INIT_IN_8		300
-/* Initial limits for 782d/783s negative voltages */
-/* Note level shift. Change min/max below if you change these. */
-#define W83782D_INIT_IN_5		((((-1200) + 1491) * 100)/514)
-#define W83782D_INIT_IN_6		((( (-500)  + 771) * 100)/314)
-
-#define W83781D_INIT_IN_PERCENTAGE	10
-#define W83781D_INIT_IN_MIN(val)	(val - val * W83781D_INIT_IN_PERCENTAGE / 100)
-#define W83781D_INIT_IN_MAX(val)	(val + val * W83781D_INIT_IN_PERCENTAGE / 100)
-
-#define W83781D_INIT_IN_MIN_0		W83781D_INIT_IN_MIN(W83781D_INIT_IN_0)
-#define W83781D_INIT_IN_MAX_0		W83781D_INIT_IN_MAX(W83781D_INIT_IN_0)
-#define W83781D_INIT_IN_MIN_1		W83781D_INIT_IN_MIN(W83781D_INIT_IN_1)
-#define W83781D_INIT_IN_MAX_1		W83781D_INIT_IN_MAX(W83781D_INIT_IN_1)
-#define W83781D_INIT_IN_MIN_2		W83781D_INIT_IN_MIN(W83781D_INIT_IN_2)
-#define W83781D_INIT_IN_MAX_2		W83781D_INIT_IN_MAX(W83781D_INIT_IN_2)
-#define W83781D_INIT_IN_MIN_3		W83781D_INIT_IN_MIN(W83781D_INIT_IN_3)
-#define W83781D_INIT_IN_MAX_3		W83781D_INIT_IN_MAX(W83781D_INIT_IN_3)
-#define W83781D_INIT_IN_MIN_4		W83781D_INIT_IN_MIN(W83781D_INIT_IN_4)
-#define W83781D_INIT_IN_MAX_4		W83781D_INIT_IN_MAX(W83781D_INIT_IN_4)
-#define W83781D_INIT_IN_MIN_5		W83781D_INIT_IN_MIN(W83781D_INIT_IN_5)
-#define W83781D_INIT_IN_MAX_5		W83781D_INIT_IN_MAX(W83781D_INIT_IN_5)
-#define W83781D_INIT_IN_MIN_6		W83781D_INIT_IN_MIN(W83781D_INIT_IN_6)
-#define W83781D_INIT_IN_MAX_6		W83781D_INIT_IN_MAX(W83781D_INIT_IN_6)
-#define W83781D_INIT_IN_MIN_7		W83781D_INIT_IN_MIN(W83781D_INIT_IN_7)
-#define W83781D_INIT_IN_MAX_7		W83781D_INIT_IN_MAX(W83781D_INIT_IN_7)
-#define W83781D_INIT_IN_MIN_8		W83781D_INIT_IN_MIN(W83781D_INIT_IN_8)
-#define W83781D_INIT_IN_MAX_8		W83781D_INIT_IN_MAX(W83781D_INIT_IN_8)
-
-/* Initial limits for 782d/783s negative voltages */
-/* These aren't direct multiples because of level shift */
-/* Beware going negative - check */
-#define W83782D_INIT_IN_MIN_5_TMP \
-	(((-1200 * (100 + W83781D_INIT_IN_PERCENTAGE)) + (1491 * 100))/514)
-#define W83782D_INIT_IN_MIN_5 \
-	((W83782D_INIT_IN_MIN_5_TMP > 0) ? W83782D_INIT_IN_MIN_5_TMP : 0)
-#define W83782D_INIT_IN_MAX_5 \
-	(((-1200 * (100 - W83781D_INIT_IN_PERCENTAGE)) + (1491 * 100))/514)
-#define W83782D_INIT_IN_MIN_6_TMP \
-	((( -500 * (100 + W83781D_INIT_IN_PERCENTAGE)) +  (771 * 100))/314)
-#define W83782D_INIT_IN_MIN_6 \
-	((W83782D_INIT_IN_MIN_6_TMP > 0) ? W83782D_INIT_IN_MIN_6_TMP : 0)
-#define W83782D_INIT_IN_MAX_6 \
-	((( -500 * (100 - W83781D_INIT_IN_PERCENTAGE)) +  (771 * 100))/314)
-
-#define W83781D_INIT_FAN_MIN_1		3000
-#define W83781D_INIT_FAN_MIN_2		3000
-#define W83781D_INIT_FAN_MIN_3		3000
-
-/* temp = value / 100 */
-#define W83781D_INIT_TEMP_OVER		6000
-#define W83781D_INIT_TEMP_HYST		12700	/* must be 127 for ALARM to work */
-#define W83781D_INIT_TEMP2_OVER		6000
-#define W83781D_INIT_TEMP2_HYST		5000
-#define W83781D_INIT_TEMP3_OVER		6000
-#define W83781D_INIT_TEMP3_HYST		5000
-
 /* There are some complications in a module like this. First off, W83781D chips
    may be both present on the SMBus and the ISA bus, and we have to handle
    those cases separately at some places. Second, there might be several
@@ -1688,113 +1622,6 @@
 #endif				/* W83781D_RT */
 
 	if (init) {
-		w83781d_write_value(client, W83781D_REG_IN_MIN(0),
-				    IN_TO_REG(W83781D_INIT_IN_MIN_0));
-		w83781d_write_value(client, W83781D_REG_IN_MAX(0),
-				    IN_TO_REG(W83781D_INIT_IN_MAX_0));
-		if (type != w83783s && type != w83697hf) {
-			w83781d_write_value(client, W83781D_REG_IN_MIN(1),
-					    IN_TO_REG(W83781D_INIT_IN_MIN_1));
-			w83781d_write_value(client, W83781D_REG_IN_MAX(1),
-					    IN_TO_REG(W83781D_INIT_IN_MAX_1));
-		}
-
-		w83781d_write_value(client, W83781D_REG_IN_MIN(2),
-				    IN_TO_REG(W83781D_INIT_IN_MIN_2));
-		w83781d_write_value(client, W83781D_REG_IN_MAX(2),
-				    IN_TO_REG(W83781D_INIT_IN_MAX_2));
-		w83781d_write_value(client, W83781D_REG_IN_MIN(3),
-				    IN_TO_REG(W83781D_INIT_IN_MIN_3));
-		w83781d_write_value(client, W83781D_REG_IN_MAX(3),
-				    IN_TO_REG(W83781D_INIT_IN_MAX_3));
-		w83781d_write_value(client, W83781D_REG_IN_MIN(4),
-				    IN_TO_REG(W83781D_INIT_IN_MIN_4));
-		w83781d_write_value(client, W83781D_REG_IN_MAX(4),
-				    IN_TO_REG(W83781D_INIT_IN_MAX_4));
-		if (type == w83781d || type == as99127f) {
-			w83781d_write_value(client, W83781D_REG_IN_MIN(5),
-					    IN_TO_REG(W83781D_INIT_IN_MIN_5));
-			w83781d_write_value(client, W83781D_REG_IN_MAX(5),
-					    IN_TO_REG(W83781D_INIT_IN_MAX_5));
-		} else {
-			w83781d_write_value(client, W83781D_REG_IN_MIN(5),
-					    IN_TO_REG(W83782D_INIT_IN_MIN_5));
-			w83781d_write_value(client, W83781D_REG_IN_MAX(5),
-					    IN_TO_REG(W83782D_INIT_IN_MAX_5));
-		}
-		if (type == w83781d || type == as99127f) {
-			w83781d_write_value(client, W83781D_REG_IN_MIN(6),
-					    IN_TO_REG(W83781D_INIT_IN_MIN_6));
-			w83781d_write_value(client, W83781D_REG_IN_MAX(6),
-					    IN_TO_REG(W83781D_INIT_IN_MAX_6));
-		} else {
-			w83781d_write_value(client, W83781D_REG_IN_MIN(6),
-					    IN_TO_REG(W83782D_INIT_IN_MIN_6));
-			w83781d_write_value(client, W83781D_REG_IN_MAX(6),
-					    IN_TO_REG(W83782D_INIT_IN_MAX_6));
-		}
-		if ((type == w83782d) || (type == w83627hf) ||
-		    (type == w83697hf)) {
-			w83781d_write_value(client, W83781D_REG_IN_MIN(7),
-					    IN_TO_REG(W83781D_INIT_IN_MIN_7));
-			w83781d_write_value(client, W83781D_REG_IN_MAX(7),
-					    IN_TO_REG(W83781D_INIT_IN_MAX_7));
-			w83781d_write_value(client, W83781D_REG_IN_MIN(8),
-					    IN_TO_REG(W83781D_INIT_IN_MIN_8));
-			w83781d_write_value(client, W83781D_REG_IN_MAX(8),
-					    IN_TO_REG(W83781D_INIT_IN_MAX_8));
-			w83781d_write_value(client, W83781D_REG_VBAT,
-					    (w83781d_read_value
-					     (client,
-					      W83781D_REG_VBAT) | 0x01));
-		}
-		w83781d_write_value(client, W83781D_REG_FAN_MIN(1),
-				    FAN_TO_REG(W83781D_INIT_FAN_MIN_1, 2));
-		w83781d_write_value(client, W83781D_REG_FAN_MIN(2),
-				    FAN_TO_REG(W83781D_INIT_FAN_MIN_2, 2));
-		if (type != w83697hf) {
-			w83781d_write_value(client, W83781D_REG_FAN_MIN(3),
-					    FAN_TO_REG(W83781D_INIT_FAN_MIN_3,
-						       2));
-		}
-
-		w83781d_write_value(client, W83781D_REG_TEMP_OVER(1),
-				    TEMP_TO_REG(W83781D_INIT_TEMP_OVER));
-		w83781d_write_value(client, W83781D_REG_TEMP_HYST(1),
-				    TEMP_TO_REG(W83781D_INIT_TEMP_HYST));
-
-		if (type == as99127f) {
-			w83781d_write_value(client, W83781D_REG_TEMP_OVER(2),
-					    AS99127_TEMP_ADD_TO_REG
-					    (W83781D_INIT_TEMP2_OVER));
-			w83781d_write_value(client, W83781D_REG_TEMP_HYST(2),
-					    AS99127_TEMP_ADD_TO_REG
-					    (W83781D_INIT_TEMP2_HYST));
-		} else {
-			w83781d_write_value(client, W83781D_REG_TEMP_OVER(2),
-					    TEMP_ADD_TO_REG
-					    (W83781D_INIT_TEMP2_OVER));
-			w83781d_write_value(client, W83781D_REG_TEMP_HYST(2),
-					    TEMP_ADD_TO_REG
-					    (W83781D_INIT_TEMP2_HYST));
-		}
-		w83781d_write_value(client, W83781D_REG_TEMP2_CONFIG, 0x00);
-
-		if (type == as99127f) {
-			w83781d_write_value(client, W83781D_REG_TEMP_OVER(3),
-					    AS99127_TEMP_ADD_TO_REG
-					    (W83781D_INIT_TEMP3_OVER));
-			w83781d_write_value(client, W83781D_REG_TEMP_HYST(3),
-					    AS99127_TEMP_ADD_TO_REG
-					    (W83781D_INIT_TEMP3_HYST));
-		} else if (type != w83783s && type != w83697hf) {
-			w83781d_write_value(client, W83781D_REG_TEMP_OVER(3),
-					    TEMP_ADD_TO_REG
-					    (W83781D_INIT_TEMP3_OVER));
-			w83781d_write_value(client, W83781D_REG_TEMP_HYST(3),
-					    TEMP_ADD_TO_REG
-					    (W83781D_INIT_TEMP3_HYST));
-		}
 		if (type != w83783s && type != w83697hf) {
 			w83781d_write_value(client, W83781D_REG_TEMP3_CONFIG,
 					    0x00);
-- 
Mark M. Hoffman
mhoffman@lightlink.com

