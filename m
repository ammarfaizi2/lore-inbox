Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265199AbSKEU3t>; Tue, 5 Nov 2002 15:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265200AbSKEU3t>; Tue, 5 Nov 2002 15:29:49 -0500
Received: from mx6.airmail.net ([209.196.77.103]:32005 "EHLO mx6.airmail.net")
	by vger.kernel.org with ESMTP id <S265199AbSKEU25>;
	Tue, 5 Nov 2002 15:28:57 -0500
Date: Tue, 5 Nov 2002 14:35:23 -0600
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 designated initializers for drivers/char
Message-ID: <20021105203523.GB32444@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's a big patch that switches drivers/char to use C99 designated
initializers. The patch is against 2.5.46.

Art Haas

--- linux-2.5.46/drivers/char/acquirewdt.c.old	2002-07-05 18:42:03.000000000 -0500
+++ linux-2.5.46/drivers/char/acquirewdt.c	2002-11-05 09:39:50.000000000 -0600
@@ -186,12 +186,12 @@
  
  
 static struct file_operations acq_fops = {
-	owner:		THIS_MODULE,
-	read:		acq_read,
-	write:		acq_write,
-	ioctl:		acq_ioctl,
-	open:		acq_open,
-	release:	acq_close,
+	.owner		= THIS_MODULE,
+	.read		= acq_read,
+	.write		= acq_write,
+	.ioctl		= acq_ioctl,
+	.open		= acq_open,
+	.release	= acq_close,
 };
 
 static struct miscdevice acq_miscdev=
--- linux-2.5.46/drivers/char/advantechwdt.c.old	2002-07-05 18:42:21.000000000 -0500
+++ linux-2.5.46/drivers/char/advantechwdt.c	2002-11-05 09:39:53.000000000 -0600
@@ -200,12 +200,12 @@
  */
  
 static struct file_operations advwdt_fops = {
-	owner:		THIS_MODULE,
-	read:		advwdt_read,
-	write:		advwdt_write,
-	ioctl:		advwdt_ioctl,
-	open:		advwdt_open,
-	release:	advwdt_close,
+	.owner		= THIS_MODULE,
+	.read		= advwdt_read,
+	.write		= advwdt_write,
+	.ioctl		= advwdt_ioctl,
+	.open		= advwdt_open,
+	.release	= advwdt_close,
 };
 
 static struct miscdevice advwdt_miscdev = {
--- linux-2.5.46/drivers/char/amd768_rng.c.old	2002-10-31 16:19:38.000000000 -0600
+++ linux-2.5.46/drivers/char/amd768_rng.c	2002-11-05 09:39:53.000000000 -0600
@@ -167,10 +167,10 @@
 
 
 static struct file_operations rng_chrdev_ops = {
-	owner:		THIS_MODULE,
-	open:		rng_dev_open,
-	release:	rng_dev_release,
-	read:		rng_dev_read,
+	.owner		= THIS_MODULE,
+	.open		= rng_dev_open,
+	.release	= rng_dev_release,
+	.read		= rng_dev_read,
 };
 
 
--- linux-2.5.46/drivers/char/applicom.c.old	2002-07-05 18:42:37.000000000 -0500
+++ linux-2.5.46/drivers/char/applicom.c	2002-11-05 09:39:55.000000000 -0600
@@ -119,11 +119,11 @@
 static void ac_interrupt(int, void *, struct pt_regs *);
 
 static struct file_operations ac_fops = {
-	owner:THIS_MODULE,
-	llseek:no_llseek,
-	read:ac_read,
-	write:ac_write,
-	ioctl:ac_ioctl,
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+	.read = ac_read,
+	.write = ac_write,
+	.ioctl = ac_ioctl,
 };
 
 static struct miscdevice ac_miscdev = {
--- linux-2.5.46/drivers/char/busmouse.c.old	2002-07-05 18:42:19.000000000 -0500
+++ linux-2.5.46/drivers/char/busmouse.c	2002-11-05 09:39:52.000000000 -0600
@@ -336,13 +336,13 @@
 
 struct file_operations busmouse_fops=
 {
-	owner:		THIS_MODULE,
-	read:		busmouse_read,
-	write:		busmouse_write,
-	poll:		busmouse_poll,
-	open:		busmouse_open,
-	release:	busmouse_release,
-	fasync:		busmouse_fasync,
+	.owner		= THIS_MODULE,
+	.read		= busmouse_read,
+	.write		= busmouse_write,
+	.poll		= busmouse_poll,
+	.open		= busmouse_open,
+	.release	= busmouse_release,
+	.fasync		= busmouse_fasync,
 };
 
 /**
--- linux-2.5.46/drivers/char/cyclades.c.old	2002-10-12 09:46:43.000000000 -0500
+++ linux-2.5.46/drivers/char/cyclades.c	2002-11-05 09:39:51.000000000 -0600
@@ -884,7 +884,7 @@
 
 static int cyz_timeron = 0;
 static struct timer_list cyz_timerlist = {
-    function: cyz_poll
+    .function = cyz_poll
 };
 #else /* CONFIG_CYZ_INTR */
 static void cyz_rx_restart(unsigned long);
--- linux-2.5.46/drivers/char/ds1620.c.old	2002-07-05 18:42:04.000000000 -0500
+++ linux-2.5.46/drivers/char/ds1620.c	2002-11-05 09:39:50.000000000 -0600
@@ -337,9 +337,9 @@
 #endif
 
 static struct file_operations ds1620_fops = {
-	owner:		THIS_MODULE,
-	read:		ds1620_read,
-	ioctl:		ds1620_ioctl,
+	.owner		= THIS_MODULE,
+	.read		= ds1620_read,
+	.ioctl		= ds1620_ioctl,
 };
 
 static struct miscdevice ds1620_miscdev = {
--- linux-2.5.46/drivers/char/dsp56k.c.old	2002-08-02 08:16:18.000000000 -0500
+++ linux-2.5.46/drivers/char/dsp56k.c	2002-11-05 09:39:53.000000000 -0600
@@ -488,12 +488,12 @@
 }
 
 static struct file_operations dsp56k_fops = {
-	owner:		THIS_MODULE,
-	read:		dsp56k_read,
-	write:		dsp56k_write,
-	ioctl:		dsp56k_ioctl,
-	open:		dsp56k_open,
-	release:	dsp56k_release,
+	.owner		= THIS_MODULE,
+	.read		= dsp56k_read,
+	.write		= dsp56k_write,
+	.ioctl		= dsp56k_ioctl,
+	.open		= dsp56k_open,
+	.release	= dsp56k_release,
 };
 
 
--- linux-2.5.46/drivers/char/dtlk.c.old	2002-08-02 08:16:18.000000000 -0500
+++ linux-2.5.46/drivers/char/dtlk.c	2002-11-05 09:39:53.000000000 -0600
@@ -98,13 +98,13 @@
 
 static struct file_operations dtlk_fops =
 {
-	owner:		THIS_MODULE,
-	read:		dtlk_read,
-	write:		dtlk_write,
-	poll:		dtlk_poll,
-	ioctl:		dtlk_ioctl,
-	open:		dtlk_open,
-	release:	dtlk_release,
+	.owner		= THIS_MODULE,
+	.read		= dtlk_read,
+	.write		= dtlk_write,
+	.poll		= dtlk_poll,
+	.ioctl		= dtlk_ioctl,
+	.open		= dtlk_open,
+	.release	= dtlk_release,
 };
 
 /* local prototypes */
--- linux-2.5.46/drivers/char/dz.c.old	2002-10-31 16:19:38.000000000 -0600
+++ linux-2.5.46/drivers/char/dz.c	2002-11-05 09:39:50.000000000 -0600
@@ -1601,12 +1601,12 @@
 }
 
 static struct console dz_sercons = {
-    name:	"ttyS",
-    write:	dz_console_print,
-    device:	dz_console_device,
-    setup:	dz_console_setup,
-    flags:	CON_CONSDEV | CON_PRINTBUFFER,
-    index:	CONSOLE_LINE,
+    .name	= "ttyS",
+    .write	= dz_console_print,
+    .device	= dz_console_device,
+    .setup	= dz_console_setup,
+    .flags	= CON_CONSDEV | CON_PRINTBUFFER,
+    .index	= CONSOLE_LINE,
 };
 
 void __init dz_serial_console_init(void)
--- linux-2.5.46/drivers/char/efirtc.c.old	2002-08-31 21:57:21.000000000 -0500
+++ linux-2.5.46/drivers/char/efirtc.c	2002-11-05 09:39:52.000000000 -0600
@@ -282,10 +282,10 @@
  */
 
 static struct file_operations efi_rtc_fops = {
-	owner:		THIS_MODULE,
-	ioctl:		efi_rtc_ioctl,
-	open:		efi_rtc_open,
-	release:	efi_rtc_close,
+	.owner		= THIS_MODULE,
+	.ioctl		= efi_rtc_ioctl,
+	.open		= efi_rtc_open,
+	.release	= efi_rtc_close,
 };
 
 static struct miscdevice efi_rtc_dev=
--- linux-2.5.46/drivers/char/eurotechwdt.c.old	2002-09-20 12:36:41.000000000 -0500
+++ linux-2.5.46/drivers/char/eurotechwdt.c	2002-11-05 09:39:50.000000000 -0600
@@ -388,12 +388,12 @@
  
  
 static struct file_operations eurwdt_fops = {
-        owner:          THIS_MODULE,
-        llseek:         no_llseek,
-        write:          eurwdt_write,
-        ioctl:          eurwdt_ioctl,
-        open:           eurwdt_open,
-        release:        eurwdt_release,
+        .owner          = THIS_MODULE,
+        .llseek         = no_llseek,
+        .write          = eurwdt_write,
+        .ioctl          = eurwdt_ioctl,
+        .open           = eurwdt_open,
+        .release        = eurwdt_release,
 };
 
 static struct miscdevice eurwdt_miscdev =
--- linux-2.5.46/drivers/char/hp_psaux.c.old	2002-07-05 18:42:37.000000000 -0500
+++ linux-2.5.46/drivers/char/hp_psaux.c	2002-11-05 09:39:55.000000000 -0600
@@ -370,18 +370,18 @@
 }
 
 static struct file_operations psaux_fops = {
-	read:		read_aux,
-	write:		write_aux,
-	poll:		aux_poll,
-	open:		open_aux,
-	release:	release_aux,
-	fasync:		fasync_aux,
+	.read		= read_aux,
+	.write		= write_aux,
+	.poll		= aux_poll,
+	.open		= open_aux,
+	.release	= release_aux,
+	.fasync		= fasync_aux,
 };
 
 static struct miscdevice psaux_mouse = {
-	minor:		PSMOUSE_MINOR,
-	name:		"psaux",
-	fops:		&psaux_fops,
+	.minor		= PSMOUSE_MINOR,
+	.name		= "psaux",
+	.fops		= &psaux_fops,
 };
 
 #endif /* CONFIG_PSMOUSE */
@@ -452,12 +452,12 @@
 extern int pckbd_translate(unsigned char, unsigned char *, char);
 
 static struct kbd_ops gsc_ps2_kbd_ops = {
-	translate:	pckbd_translate,
-	init_hw:	lasi_ps2_init_hw,
-	leds:		lasikbd_leds,
+	.translate	= pckbd_translate,
+	.init_hw	= lasi_ps2_init_hw,
+	.leds		= lasikbd_leds,
 #ifdef CONFIG_MAGIC_SYSRQ
-	sysrq_key:	0x54,
-	sysrq_xlate:	hp_ps2kbd_sysrq_xlate,
+	.sysrq_key	= 0x54,
+	.sysrq_xlate	= hp_ps2kbd_sysrq_xlate,
 #endif
 };
 
--- linux-2.5.46/drivers/char/hvc_console.c.old	2002-09-16 09:33:54.000000000 -0500
+++ linux-2.5.46/drivers/char/hvc_console.c	2002-11-05 09:39:55.000000000 -0600
@@ -340,12 +340,12 @@
 }
 
 struct console hvc_con_driver = {
-	name:		"hvc",
-	write:		hvc_console_print,
-	device:		hvc_console_device,
-	setup:		hvc_console_setup,
-	flags:		CON_PRINTBUFFER,
-	index:		-1,
+	.name		= "hvc",
+	.write		= hvc_console_print,
+	.device		= hvc_console_device,
+	.setup		= hvc_console_setup,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
 };
 
 int __init hvc_console_init(void)
--- linux-2.5.44/drivers/char/i810-tco.c.old	2002-10-01 11:45:36.000000000 -0500
+++ linux-2.5.44/drivers/char/i810-tco.c	2002-10-19 11:25:49.000000000 -0500
@@ -244,9 +244,9 @@
 	int options, retval = -EINVAL;
 
 	static struct watchdog_info ident = {
-		options:		WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
-		firmware_version:	0,
-		identity:		"i810 TCO timer",
+		.options		= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+		.firmware_version	= 0,
+		.identity		= "i810 TCO timer",
 	};
 	switch (cmd) {
 		default:
@@ -371,17 +371,17 @@
 }
 
 static struct file_operations i810tco_fops = {
-	owner:		THIS_MODULE,
-	write:		i810tco_write,
-	ioctl:		i810tco_ioctl,
-	open:		i810tco_open,
-	release:	i810tco_release,
+	.owner		= THIS_MODULE,
+	.write		= i810tco_write,
+	.ioctl		= i810tco_ioctl,
+	.open		= i810tco_open,
+	.release	= i810tco_release,
 };
 
 static struct miscdevice i810tco_miscdev = {
-	minor:		WATCHDOG_MINOR,
-	name:		"watchdog",
-	fops:		&i810tco_fops,
+	.minor		= WATCHDOG_MINOR,
+	.name		= "watchdog",
+	.fops		= &i810tco_fops,
 };
 
 static int __init watchdog_init (void)
--- linux-2.5.46/drivers/char/i810_rng.c.old	2002-10-31 16:19:38.000000000 -0600
+++ linux-2.5.46/drivers/char/i810_rng.c	2002-11-05 09:39:54.000000000 -0600
@@ -255,10 +255,10 @@
 
 
 static struct file_operations rng_chrdev_ops = {
-	owner:		THIS_MODULE,
-	open:		rng_dev_open,
-	release:	rng_dev_release,
-	read:		rng_dev_read,
+	.owner		= THIS_MODULE,
+	.open		= rng_dev_open,
+	.release	= rng_dev_release,
+	.read		= rng_dev_read,
 };
 
 
--- linux-2.5.46/drivers/char/i8k.c.old	2002-07-05 18:42:18.000000000 -0500
+++ linux-2.5.46/drivers/char/i8k.c	2002-11-05 09:39:52.000000000 -0600
@@ -82,8 +82,8 @@
 		     unsigned long);
 
 static struct file_operations i8k_fops = {
-    read:	i8k_read,
-    ioctl:	i8k_ioctl,
+    .read	= i8k_read,
+    .ioctl	= i8k_ioctl,
 };
 
 typedef struct {
--- linux-2.5.46/drivers/char/ib700wdt.c.old	2002-07-05 18:42:21.000000000 -0500
+++ linux-2.5.46/drivers/char/ib700wdt.c	2002-11-05 09:39:53.000000000 -0600
@@ -239,12 +239,12 @@
  */
 
 static struct file_operations ibwdt_fops = {
-	owner:		THIS_MODULE,
-	read:		ibwdt_read,
-	write:		ibwdt_write,
-	ioctl:		ibwdt_ioctl,
-	open:		ibwdt_open,
-	release:	ibwdt_close,
+	.owner		= THIS_MODULE,
+	.read		= ibwdt_read,
+	.write		= ibwdt_write,
+	.ioctl		= ibwdt_ioctl,
+	.open		= ibwdt_open,
+	.release	= ibwdt_close,
 };
 
 static struct miscdevice ibwdt_miscdev = {
--- linux-2.5.46/drivers/char/ip2main.c.old	2002-10-31 16:19:38.000000000 -0600
+++ linux-2.5.46/drivers/char/ip2main.c	2002-11-05 09:39:55.000000000 -0600
@@ -334,11 +334,11 @@
  * download the loadware to the boards.
  */
 static struct file_operations ip2_ipl = {
-	owner:		THIS_MODULE,
-	read:		ip2_ipl_read,
-	write:		ip2_ipl_write,
-	ioctl:		ip2_ipl_ioctl,
-	open:		ip2_ipl_open,
+	.owner		= THIS_MODULE,
+	.read		= ip2_ipl_read,
+	.write		= ip2_ipl_write,
+	.ioctl		= ip2_ipl_ioctl,
+	.open		= ip2_ipl_open,
 }; 
 
 static unsigned long irq_counter = 0;
@@ -352,7 +352,7 @@
  * selected, the board is serviced periodically to see if anything needs doing.
  */
 #define  POLL_TIMEOUT   (jiffies + 1)
-static struct timer_list PollTimer = { function: ip2_poll };
+static struct timer_list PollTimer = { .function = ip2_poll };
 static char  TimerOn;
 
 #ifdef IP2DEBUG_TRACE
--- linux-2.5.46/drivers/char/isicom.c.old	2002-10-19 11:21:27.000000000 -0500
+++ linux-2.5.46/drivers/char/isicom.c	2002-11-05 09:39:50.000000000 -0600
@@ -113,8 +113,8 @@
  */
 
 static struct file_operations ISILoad_fops = {
-	owner:		THIS_MODULE,
-	ioctl:		ISILoad_ioctl,
+	.owner		= THIS_MODULE,
+	.ioctl		= ISILoad_ioctl,
 };
 
 struct miscdevice isiloader_device = {
--- linux-2.5.46/drivers/char/istallion.c.old	2002-10-31 16:19:38.000000000 -0600
+++ linux-2.5.46/drivers/char/istallion.c	2002-11-05 09:45:02.000000000 -0600
@@ -213,8 +213,8 @@
  *	at 9600 baud, 8 data bits, no parity, 1 stop bit.
  */
 static struct termios		stli_deftermios = {
-	c_cflag:	(B9600 | CS8 | CREAD | HUPCL | CLOCAL),
-	c_cc:		INIT_C_CC,
+	.c_cflag	= (B9600 | CS8 | CREAD | HUPCL | CLOCAL),
+	.c_cc		= INIT_C_CC,
 };
 
 /*
@@ -783,10 +783,10 @@
  *	board. This is also a very useful debugging tool.
  */
 static struct file_operations	stli_fsiomem = {
-	owner:		THIS_MODULE,
-	read:		stli_memread,
-	write:		stli_memwrite,
-	ioctl:		stli_memioctl,
+	.owner		= THIS_MODULE,
+	.read		= stli_memread,
+	.write		= stli_memwrite,
+	.ioctl		= stli_memioctl,
 };
 
 /*****************************************************************************/
@@ -798,7 +798,7 @@
  *	not increase character latency by much either...
  */
 static struct timer_list	stli_timerlist = {
-	function: stli_poll
+	.function = stli_poll
 };
 
 static int	stli_timeron;
--- linux-2.5.46/drivers/char/ite_gpio.c.old	2002-07-05 18:42:32.000000000 -0500
+++ linux-2.5.46/drivers/char/ite_gpio.c	2002-11-05 09:39:55.000000000 -0600
@@ -373,10 +373,10 @@
 
 static struct file_operations ite_gpio_fops =
 {
-	owner:		THIS_MODULE,
-	ioctl:		ite_gpio_ioctl,
-	open:		ite_gpio_open,
-	release:	ite_gpio_release,
+	.owner		= THIS_MODULE,
+	.ioctl		= ite_gpio_ioctl,
+	.open		= ite_gpio_open,
+	.release	= ite_gpio_release,
 };
 
 /* GPIO_MINOR in include/linux/miscdevice.h */
--- linux-2.5.46/drivers/char/keyboard.c.old	2002-10-12 09:46:43.000000000 -0500
+++ linux-2.5.46/drivers/char/keyboard.c	2002-11-05 09:39:52.000000000 -0600
@@ -233,7 +233,7 @@
 	}
 }
 
-static struct timer_list kd_mksound_timer = { function: kd_nosound };
+static struct timer_list kd_mksound_timer = { .function = kd_nosound };
 
 void kd_mksound(unsigned int hz, unsigned int ticks)
 {
@@ -1171,13 +1171,13 @@
 
 static struct input_device_id kbd_ids[] = {
 	{
-                flags: INPUT_DEVICE_ID_MATCH_EVBIT,
-                evbit: { BIT(EV_KEY) },
+                .flags = INPUT_DEVICE_ID_MATCH_EVBIT,
+                .evbit = { BIT(EV_KEY) },
         },
 	
 	{
-                flags: INPUT_DEVICE_ID_MATCH_EVBIT,
-                evbit: { BIT(EV_SND) },
+                .flags = INPUT_DEVICE_ID_MATCH_EVBIT,
+                .evbit = { BIT(EV_SND) },
         },	
 
 	{ },    /* Terminating entry */
@@ -1186,11 +1186,11 @@
 MODULE_DEVICE_TABLE(input, kbd_ids);
 
 static struct input_handler kbd_handler = {
-	event:		kbd_event,
-	connect:	kbd_connect,
-	disconnect:	kbd_disconnect,
-	name:		"kbd",
-	id_table:	kbd_ids,
+	.event		= kbd_event,
+	.connect	= kbd_connect,
+	.disconnect	= kbd_disconnect,
+	.name		= "kbd",
+	.id_table	= kbd_ids,
 };
 
 int __init kbd_init(void)
--- linux-2.5.46/drivers/char/lp.c.old	2002-09-16 09:33:55.000000000 -0500
+++ linux-2.5.46/drivers/char/lp.c	2002-11-05 09:39:49.000000000 -0600
@@ -660,13 +660,13 @@
 }
 
 static struct file_operations lp_fops = {
-	owner:		THIS_MODULE,
-	write:		lp_write,
-	ioctl:		lp_ioctl,
-	open:		lp_open,
-	release:	lp_release,
+	.owner		= THIS_MODULE,
+	.write		= lp_write,
+	.ioctl		= lp_ioctl,
+	.open		= lp_open,
+	.release	= lp_release,
 #ifdef CONFIG_PARPORT_1284
-	read:		lp_read,
+	.read		= lp_read,
 #endif
 };
 
@@ -741,10 +741,10 @@
 }
 
 static struct console lpcons = {
-	name:		"lp",
-	write:		lp_console_write,
-	device:		lp_console_device,
-	flags:		CON_PRINTBUFFER,
+	.name		= "lp",
+	.write		= lp_console_write,
+	.device		= lp_console_device,
+	.flags		= CON_PRINTBUFFER,
 };
 
 #endif /* console on line printer */
--- linux-2.5.46/drivers/char/machzwd.c.old	2002-10-12 09:46:43.000000000 -0500
+++ linux-2.5.46/drivers/char/machzwd.c	2002-11-05 09:39:51.000000000 -0600
@@ -117,9 +117,9 @@
 #define PFX "machzwd"
 
 static struct watchdog_info zf_info = {
-	options:		WDIOF_KEEPALIVEPING, 
-	firmware_version:	1, 
-	identity:		"ZF-Logic watchdog"
+	.options		= WDIOF_KEEPALIVEPING, 
+	.firmware_version	= 1, 
+	.identity		= "ZF-Logic watchdog"
 };
 
 
@@ -449,12 +449,12 @@
 
 
 static struct file_operations zf_fops = {
-	owner:          THIS_MODULE,
-	read:           zf_read,
-	write:          zf_write,
-	ioctl:          zf_ioctl,
-	open:           zf_open,
-	release:        zf_close,
+	.owner          = THIS_MODULE,
+	.read           = zf_read,
+	.write          = zf_write,
+	.ioctl          = zf_ioctl,
+	.open           = zf_open,
+	.release        = zf_close,
 };
 
 static struct miscdevice zf_miscdev = {
--- linux-2.5.46/drivers/char/mem.c.old	2002-08-27 19:10:48.000000000 -0500
+++ linux-2.5.46/drivers/char/mem.c	2002-11-05 09:39:52.000000000 -0600
@@ -537,47 +537,47 @@
 #define open_kmem	open_mem
 
 static struct file_operations mem_fops = {
-	llseek:		memory_lseek,
-	read:		read_mem,
-	write:		write_mem,
-	mmap:		mmap_mem,
-	open:		open_mem,
+	.llseek		= memory_lseek,
+	.read		= read_mem,
+	.write		= write_mem,
+	.mmap		= mmap_mem,
+	.open		= open_mem,
 };
 
 static struct file_operations kmem_fops = {
-	llseek:		memory_lseek,
-	read:		read_kmem,
-	write:		write_kmem,
-	mmap:		mmap_kmem,
-	open:		open_kmem,
+	.llseek		= memory_lseek,
+	.read		= read_kmem,
+	.write		= write_kmem,
+	.mmap		= mmap_kmem,
+	.open		= open_kmem,
 };
 
 static struct file_operations null_fops = {
-	llseek:		null_lseek,
-	read:		read_null,
-	write:		write_null,
+	.llseek		= null_lseek,
+	.read		= read_null,
+	.write		= write_null,
 };
 
 #if defined(CONFIG_ISA) || !defined(__mc68000__)
 static struct file_operations port_fops = {
-	llseek:		memory_lseek,
-	read:		read_port,
-	write:		write_port,
-	open:		open_port,
+	.llseek		= memory_lseek,
+	.read		= read_port,
+	.write		= write_port,
+	.open		= open_port,
 };
 #endif
 
 static struct file_operations zero_fops = {
-	llseek:		zero_lseek,
-	read:		read_zero,
-	write:		write_zero,
-	mmap:		mmap_zero,
+	.llseek		= zero_lseek,
+	.read		= read_zero,
+	.write		= write_zero,
+	.mmap		= mmap_zero,
 };
 
 static struct file_operations full_fops = {
-	llseek:		full_lseek,
-	read:		read_full,
-	write:		write_full,
+	.llseek		= full_lseek,
+	.read		= read_full,
+	.write		= write_full,
 };
 
 static int memory_open(struct inode * inode, struct file * filp)
@@ -647,7 +647,7 @@
 }
 
 static struct file_operations memory_fops = {
-	open:		memory_open,	/* just a selector for the real open */
+	.open		= memory_open,	/* just a selector for the real open */
 };
 
 int __init chr_dev_init(void)
--- linux-2.5.46/drivers/char/misc.c.old	2002-09-18 09:55:55.000000000 -0500
+++ linux-2.5.46/drivers/char/misc.c	2002-11-05 09:39:49.000000000 -0600
@@ -146,8 +146,8 @@
 }
 
 static struct file_operations misc_fops = {
-	owner:		THIS_MODULE,
-	open:		misc_open,
+	.owner		= THIS_MODULE,
+	.open		= misc_open,
 };
 
 
--- linux-2.5.46/drivers/char/mixcomwd.c.old	2002-07-05 18:42:19.000000000 -0500
+++ linux-2.5.46/drivers/char/mixcomwd.c	2002-11-05 09:39:52.000000000 -0600
@@ -177,11 +177,11 @@
 
 static struct file_operations mixcomwd_fops=
 {
-	owner:		THIS_MODULE,
-	write:		mixcomwd_write,
-	ioctl:		mixcomwd_ioctl,
-	open:		mixcomwd_open,
-	release:	mixcomwd_release,
+	.owner		= THIS_MODULE,
+	.write		= mixcomwd_write,
+	.ioctl		= mixcomwd_ioctl,
+	.open		= mixcomwd_open,
+	.release	= mixcomwd_release,
 };
 
 static struct miscdevice mixcomwd_miscdev=
--- linux-2.5.46/drivers/char/nvram.c.old	2002-11-05 09:33:36.000000000 -0600
+++ linux-2.5.46/drivers/char/nvram.c	2002-11-05 09:39:53.000000000 -0600
@@ -438,13 +438,13 @@
 #endif /* CONFIG_PROC_FS */
 
 static struct file_operations nvram_fops = {
-	owner:		THIS_MODULE,
-	llseek:		nvram_llseek,
-	read:		nvram_read,
-	write:		nvram_write,
-	ioctl:		nvram_ioctl,
-	open:		nvram_open,
-	release:	nvram_release,
+	.owner		= THIS_MODULE,
+	.llseek		= nvram_llseek,
+	.read		= nvram_read,
+	.write		= nvram_write,
+	.ioctl		= nvram_ioctl,
+	.open		= nvram_open,
+	.release	= nvram_release,
 };
 
 static struct miscdevice nvram_dev = {
--- linux-2.5.46/drivers/char/nwbutton.c.old	2002-07-05 18:42:22.000000000 -0500
+++ linux-2.5.46/drivers/char/nwbutton.c	2002-11-05 09:39:53.000000000 -0600
@@ -183,8 +183,8 @@
  */
 
 static struct file_operations button_fops = {
-	owner:		THIS_MODULE,
-	read:		button_read,
+	.owner		= THIS_MODULE,
+	.read		= button_read,
 };
 
 /* 
--- linux-2.5.46/drivers/char/nwflash.c.old	2002-07-05 18:42:24.000000000 -0500
+++ linux-2.5.46/drivers/char/nwflash.c	2002-11-05 09:39:54.000000000 -0600
@@ -652,11 +652,11 @@
 
 static struct file_operations flash_fops =
 {
-	owner:		THIS_MODULE,
-	llseek:		flash_llseek,
-	read:		flash_read,
-	write:		flash_write,
-	ioctl:		flash_ioctl,
+	.owner		= THIS_MODULE,
+	.llseek		= flash_llseek,
+	.read		= flash_read,
+	.write		= flash_write,
+	.ioctl		= flash_ioctl,
 };
 
 static struct miscdevice flash_miscdev =
--- linux-2.5.46/drivers/char/pcwd.c.old	2002-07-05 18:42:03.000000000 -0500
+++ linux-2.5.46/drivers/char/pcwd.c	2002-11-05 09:39:50.000000000 -0600
@@ -540,12 +540,12 @@
 }
 
 static struct file_operations pcwd_fops = {
-	owner:		THIS_MODULE,
-	read:		pcwd_read,
-	write:		pcwd_write,
-	ioctl:		pcwd_ioctl,
-	open:		pcwd_open,
-	release:	pcwd_close,
+	.owner		= THIS_MODULE,
+	.read		= pcwd_read,
+	.write		= pcwd_write,
+	.ioctl		= pcwd_ioctl,
+	.open		= pcwd_open,
+	.release	= pcwd_close,
 };
 
 static struct miscdevice pcwd_miscdev = {
--- linux-2.5.46/drivers/char/ppdev.c.old	2002-10-12 09:46:43.000000000 -0500
+++ linux-2.5.46/drivers/char/ppdev.c	2002-11-05 09:39:53.000000000 -0600
@@ -739,14 +739,14 @@
 }
 
 static struct file_operations pp_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		pp_read,
-	write:		pp_write,
-	poll:		pp_poll,
-	ioctl:		pp_ioctl,
-	open:		pp_open,
-	release:	pp_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= pp_read,
+	.write		= pp_write,
+	.poll		= pp_poll,
+	.ioctl		= pp_ioctl,
+	.open		= pp_open,
+	.release	= pp_release,
 };
 
 static devfs_handle_t devfs_handle;
--- linux-2.5.46/drivers/char/qtronix.c.old	2002-10-12 09:46:43.000000000 -0500
+++ linux-2.5.46/drivers/char/qtronix.c	2002-11-05 09:39:53.000000000 -0600
@@ -568,12 +568,12 @@
 }
 
 struct file_operations psaux_fops = {
-	read:		read_aux,
-	write:		write_aux,
-	poll:		aux_poll,
-	open:		open_aux,
-	release:	release_aux,
-	fasync:		fasync_aux,
+	.read		= read_aux,
+	.write		= write_aux,
+	.poll		= aux_poll,
+	.open		= open_aux,
+	.release	= release_aux,
+	.fasync		= fasync_aux,
 };
 
 /*
--- linux-2.5.46/drivers/char/random.c.old	2002-10-31 16:19:38.000000000 -0600
+++ linux-2.5.46/drivers/char/random.c	2002-11-05 09:39:50.000000000 -0600
@@ -1674,16 +1674,16 @@
 }
 
 struct file_operations random_fops = {
-	read:		random_read,
-	write:		random_write,
-	poll:		random_poll,
-	ioctl:		random_ioctl,
+	.read		= random_read,
+	.write		= random_write,
+	.poll		= random_poll,
+	.ioctl		= random_ioctl,
 };
 
 struct file_operations urandom_fops = {
-	read:		urandom_read,
-	write:		random_write,
-	ioctl:		random_ioctl,
+	.read		= urandom_read,
+	.write		= random_write,
+	.ioctl		= random_ioctl,
 };
 
 /***************************************************************
--- linux-2.5.46/drivers/char/riscom8.c.old	2002-10-12 09:46:43.000000000 -0500
+++ linux-2.5.46/drivers/char/riscom8.c	2002-11-05 09:39:54.000000000 -0600
@@ -102,16 +102,16 @@
 
 static struct riscom_board rc_board[RC_NBOARD] =  {
 	{
-		base:	RC_IOBASE1,
+		.base	= RC_IOBASE1,
 	},
 	{
-		base:	RC_IOBASE2,
+		.base	= RC_IOBASE2,
 	},
 	{
-		base:	RC_IOBASE3,
+		.base	= RC_IOBASE3,
 	},
 	{
-		base:	RC_IOBASE4,
+		.base	= RC_IOBASE4,
 	},
 };
 
--- linux-2.5.46/drivers/char/rtc.c.old	2002-10-16 12:44:19.000000000 -0500
+++ linux-2.5.46/drivers/char/rtc.c	2002-11-05 09:39:53.000000000 -0600
@@ -775,16 +775,16 @@
  */
 
 static struct file_operations rtc_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		rtc_read,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= rtc_read,
 #if RTC_IRQ
-	poll:		rtc_poll,
+	.poll		= rtc_poll,
 #endif
-	ioctl:		rtc_ioctl,
-	open:		rtc_open,
-	release:	rtc_release,
-	fasync:		rtc_fasync,
+	.ioctl		= rtc_ioctl,
+	.open		= rtc_open,
+	.release	= rtc_release,
+	.fasync		= rtc_fasync,
 };
 
 static struct miscdevice rtc_dev=
--- linux-2.5.46/drivers/char/sbc60xxwdt.c.old	2002-07-05 18:42:05.000000000 -0500
+++ linux-2.5.46/drivers/char/sbc60xxwdt.c	2002-11-05 09:39:51.000000000 -0600
@@ -262,13 +262,13 @@
 }
 
 static struct file_operations wdt_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		fop_read,
-	write:		fop_write,
-	open:		fop_open,
-	release:	fop_close,
-	ioctl:		fop_ioctl
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= fop_read,
+	.write		= fop_write,
+	.open		= fop_open,
+	.release	= fop_close,
+	.ioctl		= fop_ioctl
 };
 
 static struct miscdevice wdt_miscdev = {
--- linux-2.5.46/drivers/char/scx200_wdt.c.old	2002-10-07 15:45:26.000000000 -0500
+++ linux-2.5.46/drivers/char/scx200_wdt.c	2002-11-05 09:39:55.000000000 -0600
@@ -128,7 +128,7 @@
 
 static struct notifier_block scx200_wdt_notifier =
 {
-        notifier_call: scx200_wdt_notify_sys
+        .notifier_call = scx200_wdt_notify_sys
 };
 
 static ssize_t scx200_wdt_write(struct file *file, const char *data, 
--- linux-2.5.46/drivers/char/serial167.c.old	2002-10-12 09:46:43.000000000 -0500
+++ linux-2.5.46/drivers/char/serial167.c	2002-11-05 09:39:53.000000000 -0600
@@ -2827,12 +2827,12 @@
 
 
 static struct console sercons = {
-	name:		"ttyS",
-	write:		serial167_console_write,
-	device:		serial167_console_device,
-	setup:		serial167_console_setup,
-	flags:		CON_PRINTBUFFER,
-	index:		-1,
+	.name		= "ttyS",
+	.write		= serial167_console_write,
+	.device		= serial167_console_device,
+	.setup		= serial167_console_setup,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
 };
 
 
--- linux-2.5.46/drivers/char/serial_tx3912.c.old	2002-09-16 09:33:55.000000000 -0500
+++ linux-2.5.46/drivers/char/serial_tx3912.c	2002-11-05 09:39:55.000000000 -0600
@@ -48,16 +48,16 @@
  * Used by generic serial driver to access hardware
  */
 static struct real_driver rs_real_driver = { 
-	disable_tx_interrupts: rs_disable_tx_interrupts, 
-	enable_tx_interrupts:  rs_enable_tx_interrupts, 
-	disable_rx_interrupts: rs_disable_rx_interrupts, 
-	enable_rx_interrupts:  rs_enable_rx_interrupts, 
-	get_CD:                rs_get_CD, 
-	shutdown_port:         rs_shutdown_port,  
-	set_real_termios:      rs_set_real_termios,  
-	chars_in_buffer:       rs_chars_in_buffer, 
-	close:                 rs_close, 
-	hungup:                rs_hungup,
+	.disable_tx_interrupts = rs_disable_tx_interrupts, 
+	.enable_tx_interrupts  = rs_enable_tx_interrupts, 
+	.disable_rx_interrupts = rs_disable_rx_interrupts, 
+	.enable_rx_interrupts  = rs_enable_rx_interrupts, 
+	.get_CD                = rs_get_CD, 
+	.shutdown_port         = rs_shutdown_port,  
+	.set_real_termios      = rs_set_real_termios,  
+	.chars_in_buffer       = rs_chars_in_buffer, 
+	.close                 = rs_close, 
+	.hungup                = rs_hungup,
 }; 
 
 /*
@@ -1046,12 +1046,12 @@
 }
 
 static struct console sercons = {
-	name:     "ttyS",
-	write:    serial_console_write,
-	device:   serial_console_device,
-	setup:    serial_console_setup,
-	flags:    CON_PRINTBUFFER,
-	index:    -1
+	.name     = "ttyS",
+	.write    = serial_console_write,
+	.device   = serial_console_device,
+	.setup    = serial_console_setup,
+	.flags    = CON_PRINTBUFFER,
+	.index    = -1
 };
 
 void __init tx3912_console_init(void)
--- linux-2.5.46/drivers/char/sh-sci.c.old	2002-10-07 15:45:26.000000000 -0500
+++ linux-2.5.46/drivers/char/sh-sci.c	2002-11-05 09:39:53.000000000 -0600
@@ -1259,12 +1259,12 @@
 }
 
 static struct console sercons = {
-	name:		"ttySC",
-	write:		serial_console_write,
-	device:		serial_console_device,
-	setup:		serial_console_setup,
-	flags:		CON_PRINTBUFFER,
-	index:		-1,
+	.name		= "ttySC",
+	.write		= serial_console_write,
+	.device		= serial_console_device,
+	.setup		= serial_console_setup,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
 };
 
 /*
--- linux-2.5.46/drivers/char/shwdt.c.old	2002-07-05 18:42:20.000000000 -0500
+++ linux-2.5.46/drivers/char/shwdt.c	2002-11-05 09:39:52.000000000 -0600
@@ -325,12 +325,12 @@
 }
 
 static struct file_operations sh_wdt_fops = {
-	owner:		THIS_MODULE,
-	read:		sh_wdt_read,
-	write:		sh_wdt_write,
-	ioctl:		sh_wdt_ioctl,
-	open:		sh_wdt_open,
-	release:	sh_wdt_close,
+	.owner		= THIS_MODULE,
+	.read		= sh_wdt_read,
+	.write		= sh_wdt_write,
+	.ioctl		= sh_wdt_ioctl,
+	.open		= sh_wdt_open,
+	.release	= sh_wdt_close,
 };
 
 static struct watchdog_info sh_wdt_info = {
--- linux-2.5.46/drivers/char/softdog.c.old	2002-07-05 18:42:22.000000000 -0500
+++ linux-2.5.46/drivers/char/softdog.c	2002-11-05 09:39:53.000000000 -0600
@@ -68,7 +68,7 @@
 static void watchdog_fire(unsigned long);
 
 static struct timer_list watchdog_ticktock = {
-	function:	watchdog_fire,
+	.function	= watchdog_fire,
 };
 static int timer_alive;
 
@@ -140,7 +140,7 @@
 	unsigned int cmd, unsigned long arg)
 {
 	static struct watchdog_info ident = {
-		identity: "Software Watchdog",
+		.identity = "Software Watchdog",
 	};
 	switch (cmd) {
 		default:
@@ -159,17 +159,17 @@
 }
 
 static struct file_operations softdog_fops = {
-	owner:		THIS_MODULE,
-	write:		softdog_write,
-	ioctl:		softdog_ioctl,
-	open:		softdog_open,
-	release:	softdog_release,
+	.owner		= THIS_MODULE,
+	.write		= softdog_write,
+	.ioctl		= softdog_ioctl,
+	.open		= softdog_open,
+	.release	= softdog_release,
 };
 
 static struct miscdevice softdog_miscdev = {
-	minor:		WATCHDOG_MINOR,
-	name:		"watchdog",
-	fops:		&softdog_fops,
+	.minor		= WATCHDOG_MINOR,
+	.name		= "watchdog",
+	.fops		= &softdog_fops,
 };
 
 static char banner[] __initdata = KERN_INFO "Software Watchdog Timer: 0.06, soft_margin: %d sec, nowayout: %d\n";
--- linux-2.5.46/drivers/char/sonypi.c.old	2002-10-31 16:19:39.000000000 -0600
+++ linux-2.5.46/drivers/char/sonypi.c	2002-11-05 09:39:51.000000000 -0600
@@ -613,13 +613,13 @@
 }
 
 static struct file_operations sonypi_misc_fops = {
-	owner:		THIS_MODULE,
-	read:		sonypi_misc_read,
-	poll:		sonypi_misc_poll,
-	open:		sonypi_misc_open,
-	release:	sonypi_misc_release,
-	fasync: 	sonypi_misc_fasync,
-	ioctl:		sonypi_misc_ioctl,
+	.owner		= THIS_MODULE,
+	.read		= sonypi_misc_read,
+	.poll		= sonypi_misc_poll,
+	.open		= sonypi_misc_open,
+	.release	= sonypi_misc_release,
+	.fasync 	= sonypi_misc_fasync,
+	.ioctl		= sonypi_misc_ioctl,
 };
 
 struct miscdevice sonypi_misc_device = {
--- linux-2.5.46/drivers/char/stallion.c.old	2002-10-31 16:19:39.000000000 -0600
+++ linux-2.5.46/drivers/char/stallion.c	2002-11-05 09:46:09.000000000 -0600
@@ -170,8 +170,8 @@
  *	at 9600, 8 data bits, 1 stop bit.
  */
 static struct termios		stl_deftermios = {
-	c_cflag:	(B9600 | CS8 | CREAD | HUPCL | CLOCAL),
-	c_cc:		INIT_C_CC,
+	.c_cflag	= (B9600 | CS8 | CREAD | HUPCL | CLOCAL),
+	.c_cc		= INIT_C_CC,
 };
 
 /*
@@ -745,8 +745,8 @@
  *	to get at port stats - only not using the port device itself.
  */
 static struct file_operations	stl_fsiomem = {
-	owner:		THIS_MODULE,
-	ioctl:		stl_memioctl,
+	.owner		= THIS_MODULE,
+	.ioctl		= stl_memioctl,
 };
 
 /*****************************************************************************/
--- linux-2.5.46/drivers/char/sx.c.old	2002-10-12 09:46:44.000000000 -0500
+++ linux-2.5.46/drivers/char/sx.c	2002-11-05 09:39:51.000000000 -0600
@@ -419,8 +419,8 @@
  */
 
 static struct file_operations sx_fw_fops = {
-	owner:		THIS_MODULE,
-	ioctl:		sx_fw_ioctl,
+	.owner		= THIS_MODULE,
+	.ioctl		= sx_fw_ioctl,
 };
 
 static struct miscdevice sx_fw_device = {
--- linux-2.5.46/drivers/char/synclink.c.old	2002-10-16 12:44:19.000000000 -0500
+++ linux-2.5.46/drivers/char/synclink.c	2002-11-05 09:39:53.000000000 -0600
@@ -932,10 +932,10 @@
 MODULE_LICENSE("GPL");
 
 static struct pci_driver synclink_pci_driver = {
-	name:		"synclink",
-	id_table:	synclink_pci_tbl,
-	probe:		synclink_init_one,
-	remove:		__devexit_p(synclink_remove_one),
+	.name		= "synclink",
+	.id_table	= synclink_pci_tbl,
+	.probe		= synclink_init_one,
+	.remove		= __devexit_p(synclink_remove_one),
 };
 
 static struct tty_driver serial_driver, callout_driver;
--- linux-2.5.46/drivers/char/synclinkmp.c.old	2002-10-16 12:44:19.000000000 -0500
+++ linux-2.5.46/drivers/char/synclinkmp.c	2002-11-05 09:39:52.000000000 -0600
@@ -517,10 +517,10 @@
 MODULE_LICENSE("GPL");
 
 static struct pci_driver synclinkmp_pci_driver = {
-	name:		"synclinkmp",
-	id_table:	synclinkmp_pci_tbl,
-	probe:		synclinkmp_init_one,
-	remove:		__devexit_p(synclinkmp_remove_one),
+	.name		= "synclinkmp",
+	.id_table	= synclinkmp_pci_tbl,
+	.probe		= synclinkmp_init_one,
+	.remove		= __devexit_p(synclinkmp_remove_one),
 };
 
 
--- linux-2.5.46/drivers/char/sysrq.c.old	2002-11-05 09:33:36.000000000 -0600
+++ linux-2.5.46/drivers/char/sysrq.c	2002-11-05 09:39:52.000000000 -0600
@@ -59,9 +59,9 @@
 	console_loglevel = i;
 }	
 static struct sysrq_key_op sysrq_loglevel_op = {
-	handler:	sysrq_handle_loglevel,
-	help_msg:	"loglevel0-8",
-	action_msg:	"Changing Loglevel",
+	.handler	= sysrq_handle_loglevel,
+	.help_msg	= "loglevel0-8",
+	.action_msg	= "Changing Loglevel",
 };
 
 
@@ -75,9 +75,9 @@
 	reset_vc(fg_console);
 }
 static struct sysrq_key_op sysrq_SAK_op = {
-	handler:	sysrq_handle_SAK,
-	help_msg:	"saK",
-	action_msg:	"SAK",
+	.handler	= sysrq_handle_SAK,
+	.help_msg	= "saK",
+	.action_msg	= "SAK",
 };
 #endif
 
@@ -92,9 +92,9 @@
 		kbd->kbdmode = VC_XLATE;
 }
 static struct sysrq_key_op sysrq_unraw_op = {
-	handler:	sysrq_handle_unraw,
-	help_msg:	"unRaw",
-	action_msg:	"Keyboard mode set to XLATE",
+	.handler	= sysrq_handle_unraw,
+	.help_msg	= "unRaw",
+	.action_msg	= "Keyboard mode set to XLATE",
 };
 #endif /* CONFIG_VT */
 
@@ -105,9 +105,9 @@
 	machine_restart(NULL);
 }
 static struct sysrq_key_op sysrq_reboot_op = {
-	handler:	sysrq_handle_reboot,
-	help_msg:	"reBoot",
-	action_msg:	"Resetting",
+	.handler	= sysrq_handle_reboot,
+	.help_msg	= "reBoot",
+	.action_msg	= "Resetting",
 };
 
 
@@ -235,9 +235,9 @@
 	wakeup_bdflush(0);
 }
 static struct sysrq_key_op sysrq_sync_op = {
-	handler:	sysrq_handle_sync,
-	help_msg:	"Sync",
-	action_msg:	"Emergency Sync",
+	.handler	= sysrq_handle_sync,
+	.help_msg	= "Sync",
+	.action_msg	= "Emergency Sync",
 };
 
 static void sysrq_handle_mountro(int key, struct pt_regs *pt_regs,
@@ -247,9 +247,9 @@
 	wakeup_bdflush(0);
 }
 static struct sysrq_key_op sysrq_mountro_op = {
-	handler:	sysrq_handle_mountro,
-	help_msg:	"Unmount",
-	action_msg:	"Emergency Remount R/O",
+	.handler	= sysrq_handle_mountro,
+	.help_msg	= "Unmount",
+	.action_msg	= "Emergency Remount R/O",
 };
 
 /* END SYNC SYSRQ HANDLERS BLOCK */
@@ -264,9 +264,9 @@
 		show_regs(pt_regs);
 }
 static struct sysrq_key_op sysrq_showregs_op = {
-	handler:	sysrq_handle_showregs,
-	help_msg:	"showPc",
-	action_msg:	"Show Regs",
+	.handler	= sysrq_handle_showregs,
+	.help_msg	= "showPc",
+	.action_msg	= "Show Regs",
 };
 
 
@@ -276,9 +276,9 @@
 	show_state();
 }
 static struct sysrq_key_op sysrq_showstate_op = {
-	handler:	sysrq_handle_showstate,
-	help_msg:	"showTasks",
-	action_msg:	"Show State",
+	.handler	= sysrq_handle_showstate,
+	.help_msg	= "showTasks",
+	.action_msg	= "Show State",
 };
 
 
@@ -288,9 +288,9 @@
 	show_mem();
 }
 static struct sysrq_key_op sysrq_showmem_op = {
-	handler:	sysrq_handle_showmem,
-	help_msg:	"showMem",
-	action_msg:	"Show Memory",
+	.handler	= sysrq_handle_showmem,
+	.help_msg	= "showMem",
+	.action_msg	= "Show Memory",
 };
 
 /* SHOW SYSRQ HANDLERS BLOCK */
@@ -318,16 +318,16 @@
 	console_loglevel = 8;
 }
 static struct sysrq_key_op sysrq_term_op = {
-	handler:	sysrq_handle_term,
-	help_msg:	"tErm",
-	action_msg:	"Terminate All Tasks",
+	.handler	= sysrq_handle_term,
+	.help_msg	= "tErm",
+	.action_msg	= "Terminate All Tasks",
 };
 
 #ifdef CONFIG_VOYAGER
 static struct sysrq_key_op sysrq_voyager_dump_op = {
-	handler:	voyager_dump,
-	help_msg:	"voyager",
-	action_msg:	"Dump Voyager Status\n",
+	.handler	= voyager_dump,
+	.help_msg	= "voyager",
+	.action_msg	= "Dump Voyager Status\n",
 };
 #endif
 
@@ -338,9 +338,9 @@
 	console_loglevel = 8;
 }
 static struct sysrq_key_op sysrq_kill_op = {
-	handler:	sysrq_handle_kill,
-	help_msg:	"kIll",
-	action_msg:	"Kill All Tasks",
+	.handler	= sysrq_handle_kill,
+	.help_msg	= "kIll",
+	.action_msg	= "Kill All Tasks",
 };
 
 /* END SIGNAL SYSRQ HANDLERS BLOCK */
--- linux-2.5.46/drivers/char/tipar.c.old	2002-10-19 11:21:27.000000000 -0500
+++ linux-2.5.46/drivers/char/tipar.c	2002-11-05 09:39:55.000000000 -0600
@@ -381,13 +381,13 @@
 /* ----- kernel module registering ------------------------------------ */
 
 static struct file_operations tipar_fops = {
-	owner:THIS_MODULE,
-	llseek:no_llseek,
-	read:tipar_read,
-	write:tipar_write,
-	ioctl:tipar_ioctl,
-	open:tipar_open,
-	release:tipar_close,
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+	.read = tipar_read,
+	.write = tipar_write,
+	.ioctl = tipar_ioctl,
+	.open = tipar_open,
+	.release = tipar_close,
 };
 
 /* --- initialisation code ------------------------------------- */
--- linux-2.5.46/drivers/char/toshiba.c.old	2002-10-01 11:45:36.000000000 -0500
+++ linux-2.5.46/drivers/char/toshiba.c	2002-11-05 09:39:55.000000000 -0600
@@ -91,8 +91,8 @@
 
 
 static struct file_operations tosh_fops = {
-	owner:		THIS_MODULE,
-	ioctl:		tosh_ioctl,
+	.owner		= THIS_MODULE,
+	.ioctl		= tosh_ioctl,
 };
 
 static struct miscdevice tosh_device = {
--- linux-2.5.46/drivers/char/tpqic02.c.old	2002-10-31 16:19:39.000000000 -0600
+++ linux-2.5.46/drivers/char/tpqic02.c	2002-11-05 09:39:54.000000000 -0600
@@ -2565,13 +2565,13 @@
 
 /* These are (most) of the interface functions: */
 static struct file_operations qic02_tape_fops = {
-	owner:THIS_MODULE,
-	llseek:no_llseek,
-	read:qic02_do_tape_read,
-	write:qic02_do_tape_write,
-	ioctl:qic02_do_tape_ioctl,
-	open:qic02_tape_open,
-	release:qic02_tape_release,
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+	.read = qic02_do_tape_read,
+	.write = qic02_do_tape_write,
+	.ioctl = qic02_do_tape_ioctl,
+	.open = qic02_tape_open,
+	.release = qic02_tape_release,
 };
 
 
--- linux-2.5.46/drivers/char/tty_io.c.old	2002-10-16 12:44:19.000000000 -0500
+++ linux-2.5.46/drivers/char/tty_io.c	2002-11-05 09:39:50.000000000 -0600
@@ -404,23 +404,23 @@
 }
 
 static struct file_operations tty_fops = {
-	llseek:		no_llseek,
-	read:		tty_read,
-	write:		tty_write,
-	poll:		tty_poll,
-	ioctl:		tty_ioctl,
-	open:		tty_open,
-	release:	tty_release,
-	fasync:		tty_fasync,
+	.llseek		= no_llseek,
+	.read		= tty_read,
+	.write		= tty_write,
+	.poll		= tty_poll,
+	.ioctl		= tty_ioctl,
+	.open		= tty_open,
+	.release	= tty_release,
+	.fasync		= tty_fasync,
 };
 
 static struct file_operations hung_up_tty_fops = {
-	llseek:		no_llseek,
-	read:		hung_up_tty_read,
-	write:		hung_up_tty_write,
-	poll:		hung_up_tty_poll,
-	ioctl:		hung_up_tty_ioctl,
-	release:	tty_release,
+	.llseek		= no_llseek,
+	.read		= hung_up_tty_read,
+	.write		= hung_up_tty_write,
+	.poll		= hung_up_tty_poll,
+	.ioctl		= hung_up_tty_ioctl,
+	.release	= tty_release,
 };
 
 /*
--- linux-2.5.46/drivers/char/vc_screen.c.old	2002-08-02 08:16:20.000000000 -0500
+++ linux-2.5.46/drivers/char/vc_screen.c	2002-11-05 09:39:52.000000000 -0600
@@ -464,10 +464,10 @@
 }
 
 static struct file_operations vcs_fops = {
-	llseek:		vcs_lseek,
-	read:		vcs_read,
-	write:		vcs_write,
-	open:		vcs_open,
+	.llseek		= vcs_lseek,
+	.read		= vcs_read,
+	.write		= vcs_write,
+	.open		= vcs_open,
 };
 
 static devfs_handle_t devfs_handle;
--- linux-2.5.46/drivers/char/vme_scc.c.old	2002-10-31 16:19:39.000000000 -0600
+++ linux-2.5.46/drivers/char/vme_scc.c	2002-11-05 09:39:49.000000000 -0600
@@ -1094,12 +1094,12 @@
 
 
 static struct console sercons = {
-	name:		"ttyS",
-	write:		scc_console_write,
-	device:		scc_console_device,
-	setup:		scc_console_setup,
-	flags:		CON_PRINTBUFFER,
-	index:		-1,
+	.name		= "ttyS",
+	.write		= scc_console_write,
+	.device		= scc_console_device,
+	.setup		= scc_console_setup,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
 };
 
 
--- linux-2.5.46/drivers/char/vt.c.old	2002-10-07 15:45:27.000000000 -0500
+++ linux-2.5.46/drivers/char/vt.c	2002-11-05 09:39:51.000000000 -0600
@@ -2172,12 +2172,12 @@
 }
 
 struct console vt_console_driver = {
-	name:		"tty",
-	write:		vt_console_print,
-	device:		vt_console_device,
-	unblank:	unblank_screen,
-	flags:		CON_PRINTBUFFER,
-	index:		-1,
+	.name		= "tty",
+	.write		= vt_console_print,
+	.device		= vt_console_device,
+	.unblank	= unblank_screen,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
 };
 #endif
 
--- linux-2.5.46/drivers/char/w83877f_wdt.c.old	2002-10-12 09:46:44.000000000 -0500
+++ linux-2.5.46/drivers/char/w83877f_wdt.c	2002-11-05 09:39:50.000000000 -0600
@@ -269,13 +269,13 @@
 }
 
 static struct file_operations wdt_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		fop_read,
-	write:		fop_write,
-	open:		fop_open,
-	release:	fop_close,
-	ioctl:		fop_ioctl
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= fop_read,
+	.write		= fop_write,
+	.open		= fop_open,
+	.release	= fop_close,
+	.ioctl		= fop_ioctl
 };
 
 static struct miscdevice wdt_miscdev = {
--- linux-2.5.46/drivers/char/wdt.c.old	2002-07-05 18:42:27.000000000 -0500
+++ linux-2.5.46/drivers/char/wdt.c	2002-11-05 09:39:55.000000000 -0600
@@ -438,13 +438,13 @@
  
  
 static struct file_operations wdt_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		wdt_read,
-	write:		wdt_write,
-	ioctl:		wdt_ioctl,
-	open:		wdt_open,
-	release:	wdt_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= wdt_read,
+	.write		= wdt_write,
+	.ioctl		= wdt_ioctl,
+	.open		= wdt_open,
+	.release	= wdt_release,
 };
 
 static struct miscdevice wdt_miscdev=
--- linux-2.5.46/drivers/char/wdt285.c.old	2002-07-05 18:42:18.000000000 -0500
+++ linux-2.5.46/drivers/char/wdt285.c	2002-11-05 09:39:52.000000000 -0600
@@ -150,11 +150,11 @@
 
 static struct file_operations watchdog_fops=
 {
-	owner:		THIS_MODULE,
-	write:		watchdog_write,
-	ioctl:		watchdog_ioctl,
-	open:		watchdog_open,
-	release:	watchdog_release,
+	.owner		= THIS_MODULE,
+	.write		= watchdog_write,
+	.ioctl		= watchdog_ioctl,
+	.open		= watchdog_open,
+	.release	= watchdog_release,
 };
 
 static struct miscdevice watchdog_miscdev=
--- linux-2.5.46/drivers/char/wdt977.c.old	2002-08-10 22:03:49.000000000 -0500
+++ linux-2.5.46/drivers/char/wdt977.c	2002-11-05 09:39:52.000000000 -0600
@@ -311,11 +311,11 @@
 
 static struct file_operations wdt977_fops=
 {
-	owner:		THIS_MODULE,
-	write:		wdt977_write,
-	ioctl:		wdt977_ioctl,
-	open:		wdt977_open,
-	release:	wdt977_release,
+	.owner		= THIS_MODULE,
+	.write		= wdt977_write,
+	.ioctl		= wdt977_ioctl,
+	.open		= wdt977_open,
+	.release	= wdt977_release,
 };
 
 static struct miscdevice wdt977_miscdev=
--- linux-2.5.46/drivers/char/wdt_pci.c.old	2002-10-12 09:46:44.000000000 -0500
+++ linux-2.5.46/drivers/char/wdt_pci.c	2002-11-05 09:39:55.000000000 -0600
@@ -472,13 +472,13 @@
  
  
 static struct file_operations wdtpci_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		wdtpci_read,
-	write:		wdtpci_write,
-	ioctl:		wdtpci_ioctl,
-	open:		wdtpci_open,
-	release:	wdtpci_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= wdtpci_read,
+	.write		= wdtpci_write,
+	.ioctl		= wdtpci_ioctl,
+	.open		= wdtpci_open,
+	.release	= wdtpci_release,
 };
 
 static struct miscdevice wdtpci_miscdev=
@@ -601,10 +601,10 @@
 
 
 static struct pci_driver wdtpci_driver = {
-	name:		"wdt-pci",
-	id_table:	wdtpci_pci_tbl,
-	probe:		wdtpci_init_one,
-	remove:		__devexit_p(wdtpci_remove_one),
+	.name		= "wdt-pci",
+	.id_table	= wdtpci_pci_tbl,
+	.probe		= wdtpci_init_one,
+	.remove		= __devexit_p(wdtpci_remove_one),
 };
 
 
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
