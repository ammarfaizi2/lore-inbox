Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbVKNNuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbVKNNuO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 08:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVKNNuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 08:50:14 -0500
Received: from [195.144.244.147] ([195.144.244.147]:40395 "EHLO
	amanaus.varma-el.com") by vger.kernel.org with ESMTP
	id S1751127AbVKNNuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 08:50:12 -0500
Message-ID: <4378960F.8030800@varma-el.com>
Date: Mon, 14 Nov 2005 16:50:07 +0300
From: Andrey Volkov <avolkov@varma-el.com>
Organization: Varma Electronics Oy
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ru-ru, ru
MIME-Version: 1.0
To: khali@linux-fr.org
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] Added support of ST m41t85 rtc chip
X-Enigmail-Version: 0.93.0.0
OpenPGP: url=pgp.dtype.org
Content-Type: multipart/mixed;
 boundary="------------070409030400080608080307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070409030400080608080307
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit

Hello Jean,

Possible too late to include in 2.6.15,
but better later then never :).

Comments?

-- 
Regards
Andrey Volkov

P.S. Please CC to me directly, I'm not in lm-sensors@lm-sensors.org list.

--------------070409030400080608080307
Content-Type: text/plain;
 name="m41t85_rtc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="m41t85_rtc.diff"

Added support of ST M41T85 RTC

Signed-off-By: Andrey Volkov <avolkov@varma-el.com>
---

 drivers/i2c/chips/Kconfig  |   88 ++++++++++++++
 drivers/i2c/chips/Makefile |    1 
 drivers/i2c/chips/m41t85.c |  285 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c-id.h     |    1 
 4 files changed, 375 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index f9fae28..6593fc5 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -111,6 +111,94 @@ config SENSORS_M41T00
 	  This driver can also be built as a module.  If so, the module
 	  will be called m41t00.
 
+config SENSORS_M41T85
+	tristate "ST M41T85 RTC chip"
+	depends on I2C
+	help
+	  If you say yes here you get support for the ST M41T85 RTC chip.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called m41t85.
+
+config SENSORS_M41T85_SQW_FRQ_ENABLE
+	depends on SENSORS_M41T85
+	bool "Square Wave Output"
+	help
+	  If you say yes here, then m41t85 will generate clocks on it 
+	  SQW pin at frequency which you are select below.
+
+choice 
+	prompt "SQW frequincy"
+	depends on SENSORS_M41T85_SQW_FRQ_ENABLE
+	default SENSORS_M41T85_SQW_FRQ_32KHZ
+
+config SENSORS_M41T85_SQW_FRQ_32KHZ
+	bool "32.768 kHz"
+
+config SENSORS_M41T85_SQW_FRQ_8KHZ
+	bool "8 kHz"
+
+config SENSORS_M41T85_SQW_FRQ_4KHZ
+	bool "4 kHz"
+
+config SENSORS_M41T85_SQW_FRQ_2KHZ
+	bool "2 kHz"
+
+config SENSORS_M41T85_SQW_FRQ_1KHZ
+	bool "1 kHz"
+
+config SENSORS_M41T85_SQW_FRQ_512HZ
+	bool "512 Hz"
+
+config SENSORS_M41T85_SQW_FRQ_256HZ
+	bool "256 Hz"
+
+config SENSORS_M41T85_SQW_FRQ_128HZ
+	bool "128 Hz"
+
+config SENSORS_M41T85_SQW_FRQ_64HZ
+	bool "64 Hz"
+
+config SENSORS_M41T85_SQW_FRQ_32HZ
+	bool "32 Hz"
+
+config SENSORS_M41T85_SQW_FRQ_16HZ
+	bool "16 Hz"
+
+config SENSORS_M41T85_SQW_FRQ_8HZ
+	bool "8 Hz"
+
+config SENSORS_M41T85_SQW_FRQ_4HZ
+	bool "4 Hz"
+
+config SENSORS_M41T85_SQW_FRQ_2HZ
+	bool "2 Hz"
+
+config SENSORS_M41T85_SQW_FRQ_1HZ
+	bool "1 Hz"
+
+endchoice
+
+config SENSORS_M41T85_SQW_FRQ
+	int
+	depends on SENSORS_M41T85_SQW_FRQ_ENABLE
+	default "1" if SENSORS_M41T85_SQW_FRQ_32KHZ
+	default "2" if SENSORS_M41T85_SQW_FRQ_8KHZ
+	default "3" if SENSORS_M41T85_SQW_FRQ_4KHZ
+	default "4" if SENSORS_M41T85_SQW_FRQ_2KHZ
+	default "5" if SENSORS_M41T85_SQW_FRQ_1KHZ
+	default "6" if SENSORS_M41T85_SQW_FRQ_512HZ
+	default "7" if SENSORS_M41T85_SQW_FRQ_256HZ
+	default "8" if SENSORS_M41T85_SQW_FRQ_128HZ
+	default "9" if SENSORS_M41T85_SQW_FRQ_64HZ
+	default "10" if SENSORS_M41T85_SQW_FRQ_32HZ
+	default "11" if SENSORS_M41T85_SQW_FRQ_16HZ
+	default "12" if SENSORS_M41T85_SQW_FRQ_8HZ
+	default "13" if SENSORS_M41T85_SQW_FRQ_4HZ
+	default "14" if SENSORS_M41T85_SQW_FRQ_2HZ
+	default "15" if SENSORS_M41T85_SQW_FRQ_1HZ
+
+
 config SENSORS_MAX6875
 	tristate "Maxim MAX6875 Power supply supervisor"
 	depends on I2C && EXPERIMENTAL
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
index 46178b5..5637881 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_SENSORS_RTC8564)	+= rtc8564
 obj-$(CONFIG_ISP1301_OMAP)	+= isp1301_omap.o
 obj-$(CONFIG_TPS65010)		+= tps65010.o
 obj-$(CONFIG_RTC_X1205_I2C)	+= x1205.o
+obj-$(CONFIG_SENSORS_M41T85)	+= m41t85.o
 
 ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/drivers/i2c/chips/m41t85.c b/drivers/i2c/chips/m41t85.c
new file mode 100644
index 0000000..f26a115
--- /dev/null
+++ b/drivers/i2c/chips/m41t85.c
@@ -0,0 +1,285 @@
+/*
+ * drivers/i2c/chips/m41t85.c
+ *
+ * DESCRIPTION:
+ *	I2C client/driver for the ST M41T85 Real-Time Clock chip.
+ *
+ * AUTHOR:
+ *  Andrey Volkov <avolkov@varma-el.com>
+ *
+ * COPYRIGHT: 
+ *  2005, Varma Electronics Oy
+ *
+ *  Based on driver for ST M41T00 by Mark A. Greer <mgreer@mvista.com>
+ *	(see m41t00.c for copyright)
+ *
+ * LICENCE:
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License version 2.  See the file COPYING in the main directory of this archive
+ *  for more details.
+ *
+ * HISTORY:
+ *	 2005-10-12	Created
+ */
+
+/*
+ * This i2c client/driver wedges between the drivers/char/genrtc.c RTC
+ * interface and the SMBus interface of the i2c subsystem.
+ * It would be more efficient to use i2c msgs/i2c_transfer directly but, as
+ * recommened in .../Documentation/i2c/writing-clients section
+ * "Sending and receiving", using SMBus level communication is preferred.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/rtc.h>
+#include <linux/bcd.h>
+
+#include <asm/time.h>
+#include <asm/rtc.h>
+
+#define	M41T85_DRV_NAME		"m41t85"
+
+#define RTC_CSEC_ADDR			0x00
+#define RTC_SEC_ADDR 			0x01
+#define RTC_MIN_ADDR 			0x02
+#define RTC_HOUR_ADDR			0x03
+#define RTC_WDAY_ADDR			0x04
+#define RTC_DAY_ADDR  			0x05
+#define RTC_MONTH_ADDR			0x06
+#define RTC_YEARS_ADDR			0x07
+#define RTC_CONTROL_ADDR		0x08
+#define RTC_WATCHDOG_ADDR		0x09
+#define RTC_ALARM_MONTH_ADDR	0x0a
+#define RTC_ALARM_DATE_ADDR		0x0b
+#define RTC_ALARM_HOUR_ADDR		0x0c
+#define RTC_ALARM_MIN_ADDR		0x0d
+#define RTC_ALARM_SEC_ADDR		0x0e
+#define RTC_WDF_ADDR			0x0f
+#define RTC_SQW_ADDR			0x13
+
+
+static DECLARE_MUTEX(m41t85_mutex);
+
+static struct i2c_driver m41t85_driver;
+static struct i2c_client *save_client;
+
+static unsigned short ignore[] = { I2C_CLIENT_END };
+static unsigned short normal_addr[] = { 0x68, I2C_CLIENT_END };
+
+static struct i2c_client_address_data addr_data = {
+	.normal_i2c		= normal_addr,
+	.probe			= ignore,
+	.ignore			= ignore,
+};
+
+ulong
+m41t85_get_rtc_time(void)
+{
+	s32	sec, min, hour, day, mon, year;
+	s32	sec1, min1, hour1, day1, mon1, year1;
+	ulong	limit = 10;
+
+	sec = min = hour = day = mon = year = 0;
+	sec1 = min1 = hour1 = day1 = mon1 = year1 = 0;
+
+	down(&m41t85_mutex);
+	do {
+
+		if (((sec = i2c_smbus_read_byte_data(save_client, RTC_SEC_ADDR)) >= 0)
+			&& ((min = i2c_smbus_read_byte_data(save_client, RTC_MIN_ADDR))
+				>= 0)
+			&& ((hour = i2c_smbus_read_byte_data(save_client, RTC_HOUR_ADDR))
+				>= 0)
+			&& ((day = i2c_smbus_read_byte_data(save_client, RTC_DAY_ADDR))
+				>= 0)
+			&& ((mon = i2c_smbus_read_byte_data(save_client, RTC_MONTH_ADDR))
+				>= 0)
+			&& ((year = i2c_smbus_read_byte_data(save_client, RTC_YEARS_ADDR))
+				>= 0)
+			&& ((sec == sec1) && (min == min1) && (hour == hour1)
+				&& (day == day1) && (mon == mon1)
+				&& (year == year1)))
+
+				break;
+
+		sec1 = sec;
+		min1 = min;
+		hour1 = hour;
+		day1 = day;
+		mon1 = mon;
+		year1 = year;
+	} while (--limit > 0);
+	up(&m41t85_mutex);
+
+	if (limit == 0) {
+		dev_warn(&save_client->dev,
+			"m41t85: can't read rtc chip\n");
+		sec = min = hour = day = mon = year = 0;
+	}
+
+	sec = BCD2BIN(sec & 0x7f);
+	min = BCD2BIN(min & 0x7f);
+	hour = BCD2BIN(hour & 0x3f);
+	day = BCD2BIN(day & 0x3f);
+	mon = BCD2BIN(mon & 0x1f);
+	year = BCD2BIN(year & 0xff);
+
+	year += 1900;
+	if (year < 1970)
+		year += 100;
+
+	return mktime(year, mon, day, hour, min, sec);
+}
+
+static void
+m41t85_set_tlet(ulong arg)
+{
+	struct rtc_time	tm;
+	ulong	nowtime = *(ulong *)arg;
+
+	to_tm(nowtime, &tm);
+	tm.tm_year = (tm.tm_year - 1900) % 100;
+
+	tm.tm_sec = BIN2BCD(tm.tm_sec);
+	tm.tm_min = BIN2BCD(tm.tm_min);
+	tm.tm_hour = BIN2BCD(tm.tm_hour);
+	tm.tm_mon = BIN2BCD(tm.tm_mon);
+	tm.tm_mday = BIN2BCD(tm.tm_mday);
+	tm.tm_year = BIN2BCD(tm.tm_year);
+
+	down(&m41t85_mutex);
+	if ((i2c_smbus_write_byte_data(save_client, RTC_SEC_ADDR, tm.tm_sec & 0x7f) < 0)
+		|| (i2c_smbus_write_byte_data(save_client, RTC_MIN_ADDR, tm.tm_min & 0x7f)
+			< 0)
+		|| (i2c_smbus_write_byte_data(save_client, RTC_HOUR_ADDR, tm.tm_hour & 0x7f)
+			< 0)
+		|| (i2c_smbus_write_byte_data(save_client, RTC_DAY_ADDR, tm.tm_mday & 0x7f)
+			< 0)
+		|| (i2c_smbus_write_byte_data(save_client, RTC_MONTH_ADDR, tm.tm_mon & 0x7f)
+			< 0)
+		|| (i2c_smbus_write_byte_data(save_client, RTC_YEARS_ADDR, tm.tm_year & 0x7f)
+			< 0))
+
+		dev_warn(&save_client->dev,"m41t85: can't write to rtc chip\n");
+
+	up(&m41t85_mutex);
+	return;
+}
+
+static ulong	new_time;
+
+DECLARE_TASKLET_DISABLED(m41t85_tasklet, m41t85_set_tlet, (ulong)&new_time);
+
+int
+m41t85_set_rtc_time(ulong nowtime)
+{
+	new_time = nowtime;
+
+	if (in_interrupt())
+		tasklet_schedule(&m41t85_tasklet);
+	else
+		m41t85_set_tlet((ulong)&new_time);
+
+	return 0;
+}
+
+/*
+ *****************************************************************************
+ *
+ *	Driver Interface
+ *
+ *****************************************************************************
+ */
+static int
+m41t85_probe(struct i2c_adapter *adap, int addr, int kind)
+{
+	struct i2c_client *client;
+	int ret;
+	s32 reg;
+
+	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	if (!client)
+		return -ENOMEM;
+
+	strncpy(client->name, M41T85_DRV_NAME, I2C_NAME_SIZE);
+	client->addr = addr;
+	client->adapter = adap;
+	client->driver = &m41t85_driver;
+
+	if ((ret = i2c_attach_client(client)) != 0) {
+		kfree(client);
+		return ret;
+	}
+
+	#if defined (CONFIG_SENSORS_M41T85_SQW_FRQ)
+	reg = i2c_smbus_read_byte_data(client, RTC_ALARM_MONTH_ADDR);
+	if (reg >=0 && (reg & 0x40) == 0) { 
+		ret = i2c_smbus_write_byte_data(client, RTC_SQW_ADDR, CONFIG_SENSORS_M41T85_SQW_FRQ);
+		if(ret == 0)
+			i2c_smbus_write_byte_data(client, RTC_ALARM_MONTH_ADDR, reg | 0x40);
+	}
+	#endif
+	/* Check if ST flag set, and if yes, then clear it */
+	reg = i2c_smbus_read_byte_data(client, RTC_SEC_ADDR);
+	if (reg >=0 && (reg & 0x80) != 0)
+		i2c_smbus_write_byte_data(client, RTC_SEC_ADDR, reg & ~0x80);
+
+	/* Check if HT flag set, and if yes, then clear it */
+	reg = i2c_smbus_read_byte_data(client, RTC_ALARM_HOUR_ADDR);
+	if (reg >=0 && (reg & 0x40) != 0)
+		i2c_smbus_write_byte_data(client, RTC_ALARM_HOUR_ADDR, reg & ~0x40);
+
+	save_client = client;
+	return 0;
+}
+
+static int
+m41t85_attach(struct i2c_adapter *adap)
+{
+	return i2c_probe(adap, &addr_data, m41t85_probe);
+}
+
+static int
+m41t85_detach(struct i2c_client *client)
+{
+	int	rc;
+
+	if ((rc = i2c_detach_client(client)) == 0) {
+		kfree(client);
+		tasklet_kill(&m41t85_tasklet);
+	}
+	return rc;
+}
+
+static struct i2c_driver m41t85_driver = {
+	.owner		= THIS_MODULE,
+	.name		= M41T85_DRV_NAME,
+	.id			= I2C_DRIVERID_STM41T85,
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= m41t85_attach,
+	.detach_client	= m41t85_detach,
+};
+
+static int __init
+m41t85_init(void)
+{
+	return i2c_add_driver(&m41t85_driver);
+}
+
+static void __exit
+m41t85_exit(void)
+{
+	i2c_del_driver(&m41t85_driver);
+	return;
+}
+
+module_init(m41t85_init);
+module_exit(m41t85_exit);
+
+MODULE_AUTHOR("Andrey Volkov <avolkov@varma-el.com>");
+MODULE_DESCRIPTION("ST Microelectronics M41T85 RTC I2C Client Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/i2c-id.h b/include/linux/i2c-id.h
index 5c05f52..ac8ffcd 100644
--- a/include/linux/i2c-id.h
+++ b/include/linux/i2c-id.h
@@ -108,6 +108,7 @@
 #define I2C_DRIVERID_SAA7127	72	/* saa7124 video encoder	*/
 #define I2C_DRIVERID_SAA711X	73	/* saa711x video encoders	*/
 #define I2C_DRIVERID_AKITAIOEXP	74	/* IO Expander on Sharp SL-C1000 */
+#define I2C_DRIVERID_STM41T85	75	/* real time clock		*/
 
 #define I2C_DRIVERID_EXP0	0xF0	/* experimental use id's	*/
 #define I2C_DRIVERID_EXP1	0xF1

--------------070409030400080608080307--
