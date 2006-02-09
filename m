Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422824AbWBIGjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422824AbWBIGjX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 01:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422825AbWBIGjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 01:39:23 -0500
Received: from xenotime.net ([66.160.160.81]:13255 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1422824AbWBIGjW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 01:39:22 -0500
Date: Wed, 8 Feb 2006 22:39:59 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, ak@suse.de
Subject: [PATCH] early_printk: cleanup trailiing whitespace
Message-Id: <20060208223959.5052de3b.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Remove all trailing tabs and spaces.  No other changes.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 arch/x86_64/kernel/early_printk.c |   92 +++++++++++++++++++-------------------
 1 files changed, 46 insertions(+), 46 deletions(-)

--- linux-2616-rc2.orig/arch/x86_64/kernel/early_printk.c
+++ linux-2616-rc2/arch/x86_64/kernel/early_printk.c
@@ -21,7 +21,7 @@
 #define MAX_XPOS	max_xpos
 
 static int max_ypos = 25, max_xpos = 80;
-static int current_ypos = 1, current_xpos = 0; 
+static int current_ypos = 1, current_xpos = 0;
 
 static void early_vga_write(struct console *con, const char *str, unsigned n)
 {
@@ -63,7 +63,7 @@ static struct console early_vga_console 
 	.index =	-1,
 };
 
-/* Serial functions loosely based on a similar package from Klaus P. Gerlicher */ 
+/* Serial functions loosely based on a similar package from Klaus P. Gerlicher */
 
 static int early_serial_base = 0x3f8;  /* ttyS0 */
 
@@ -83,30 +83,30 @@ static int early_serial_base = 0x3f8;  /
 #define DLL             0       /*  Divisor Latch Low         */
 #define DLH             1       /*  Divisor latch High        */
 
-static int early_serial_putc(unsigned char ch) 
-{ 
-	unsigned timeout = 0xffff; 
-	while ((inb(early_serial_base + LSR) & XMTRDY) == 0 && --timeout) 
+static int early_serial_putc(unsigned char ch)
+{
+	unsigned timeout = 0xffff;
+	while ((inb(early_serial_base + LSR) & XMTRDY) == 0 && --timeout)
 		cpu_relax();
 	outb(ch, early_serial_base + TXR);
 	return timeout ? 0 : -1;
-} 
+}
 
 static void early_serial_write(struct console *con, const char *s, unsigned n)
 {
-	while (*s && n-- > 0) { 
-		early_serial_putc(*s); 
-		if (*s == '\n') 
-			early_serial_putc('\r'); 
-		s++; 
-	} 
-} 
+	while (*s && n-- > 0) {
+		early_serial_putc(*s);
+		if (*s == '\n')
+			early_serial_putc('\r');
+		s++;
+	}
+}
 
 #define DEFAULT_BAUD 9600
 
 static __init void early_serial_init(char *s)
 {
-	unsigned char c; 
+	unsigned char c;
 	unsigned divisor;
 	unsigned baud = DEFAULT_BAUD;
 	char *e;
@@ -115,7 +115,7 @@ static __init void early_serial_init(cha
 		++s;
 
 	if (*s) {
-		unsigned port; 
+		unsigned port;
 		if (!strncmp(s,"0x",2)) {
 			early_serial_base = simple_strtoul(s, &e, 16);
 		} else {
@@ -139,16 +139,16 @@ static __init void early_serial_init(cha
 	outb(0x3, early_serial_base + MCR);	/* DTR + RTS */
 
 	if (*s) {
-		baud = simple_strtoul(s, &e, 0); 
-		if (baud == 0 || s == e) 
+		baud = simple_strtoul(s, &e, 0);
+		if (baud == 0 || s == e)
 			baud = DEFAULT_BAUD;
-	} 
-	
-	divisor = 115200 / baud; 
-	c = inb(early_serial_base + LCR); 
-	outb(c | DLAB, early_serial_base + LCR); 
-	outb(divisor & 0xff, early_serial_base + DLL); 
-	outb((divisor >> 8) & 0xff, early_serial_base + DLH); 
+	}
+
+	divisor = 115200 / baud;
+	c = inb(early_serial_base + LCR);
+	outb(c | DLAB, early_serial_base + LCR);
+	outb(divisor & 0xff, early_serial_base + DLL);
+	outb((divisor >> 8) & 0xff, early_serial_base + DLH);
 	outb(c & ~DLAB, early_serial_base + LCR);
 }
 
@@ -205,67 +205,67 @@ struct console *early_console = &early_v
 static int early_console_initialized = 0;
 
 void early_printk(const char *fmt, ...)
-{ 
-	char buf[512]; 
-	int n; 
+{
+	char buf[512];
+	int n;
 	va_list ap;
 
-	va_start(ap,fmt); 
+	va_start(ap,fmt);
 	n = vscnprintf(buf,512,fmt,ap);
 	early_console->write(early_console,buf,n);
-	va_end(ap); 
-} 
+	va_end(ap);
+}
 
 static int __initdata keep_early;
 
-int __init setup_early_printk(char *opt) 
-{  
+int __init setup_early_printk(char *opt)
+{
 	char *space;
-	char buf[256]; 
+	char buf[256];
 
 	if (early_console_initialized)
 		return -1;
 
-	strlcpy(buf,opt,sizeof(buf)); 
-	space = strchr(buf, ' '); 
+	strlcpy(buf,opt,sizeof(buf));
+	space = strchr(buf, ' ');
 	if (space)
-		*space = 0; 
+		*space = 0;
 
 	if (strstr(buf,"keep"))
-		keep_early = 1; 
+		keep_early = 1;
 
-	if (!strncmp(buf, "serial", 6)) { 
+	if (!strncmp(buf, "serial", 6)) {
 		early_serial_init(buf + 6);
 		early_console = &early_serial_console;
-	} else if (!strncmp(buf, "ttyS", 4)) { 
+	} else if (!strncmp(buf, "ttyS", 4)) {
 		early_serial_init(buf);
-		early_console = &early_serial_console;		
+		early_console = &early_serial_console;
 	} else if (!strncmp(buf, "vga", 3)
 	           && SCREEN_INFO.orig_video_isVGA == 1) {
 		max_xpos = SCREEN_INFO.orig_video_cols;
 		max_ypos = SCREEN_INFO.orig_video_lines;
-		early_console = &early_vga_console; 
+		early_console = &early_vga_console;
  	} else if (!strncmp(buf, "simnow", 6)) {
  		simnow_init(buf + 6);
  		early_console = &simnow_console;
  		keep_early = 1;
 	}
 	early_console_initialized = 1;
-	register_console(early_console);       
+	register_console(early_console);
 	return 0;
 }
 
 void __init disable_early_printk(void)
-{ 
+{
 	if (!early_console_initialized || !early_console)
 		return;
 	if (!keep_early) {
 		printk("disabling early console\n");
 		unregister_console(early_console);
 		early_console_initialized = 0;
-	} else { 
+	} else {
 		printk("keeping early console\n");
 	}
-} 
+}
 
 __setup("earlyprintk=", setup_early_printk);


---
