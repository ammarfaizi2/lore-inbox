Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161502AbWJaAmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161502AbWJaAmO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 19:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161559AbWJaAmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 19:42:14 -0500
Received: from av1.karneval.cz ([81.27.192.123]:20325 "EHLO av1.karneval.cz")
	by vger.kernel.org with ESMTP id S1161502AbWJaAmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 19:42:04 -0500
Message-id: <256814842644932742@karneval.cz>
Subject: [PATCH 3/9] Char: sx, whitespace cleanup
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: <R.E.Wolff@BitWizard.nl>
Cc: <support@specialix.co.uk>
Date: Tue, 31 Oct 2006 01:41:54 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sx, whitespace cleanup

Use Lindent to cleanup whitespace. Wrap long lines by hand.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit b7dbf65a81c1707405982cb66aa5df5a9ada464e
tree 9cfad16876a599dc1a122d273fd5f4c192a8fa62
parent d5dabf3057e62f7d07844832090500348543222a
author Jiri Slaby <jirislaby@gmail.com> Tue, 31 Oct 2006 00:42:39 +0100
committer Jiri Slaby <jirislaby@gmail.com> Tue, 31 Oct 2006 00:42:39 +0100

 drivers/char/sx.c | 1822 ++++++++++++++++++++++++++++-------------------------
 1 files changed, 976 insertions(+), 846 deletions(-)

diff --git a/drivers/char/sx.c b/drivers/char/sx.c
index ca6d518..7395c13 100644
--- a/drivers/char/sx.c
+++ b/drivers/char/sx.c
@@ -238,7 +238,6 @@ #include "sxwindow.h"
 #include <linux/generic_serial.h>
 #include "sx.h"
 
-
 /* I don't think that this driver can handle more than 256 ports on
    one machine. You'll have to increase the number of boards in sx.h
    if you want more than 4 boards.  */
@@ -253,7 +252,6 @@ #endif
 /* Am I paranoid or not ? ;-) */
 #undef SX_PARANOIA_CHECK
 
-
 /* 20 -> 2000 per second. The card should rate-limit interrupts at 100
    Hz, but it is user configurable. I don't recommend going above 1000
    Hz. The interrupt ratelimit might trigger if the interrupt is
@@ -267,7 +265,6 @@ #define IRQ_RATE_LIMIT 20
    interrupt. Use polling. */
 #undef IRQ_RATE_LIMIT
 
-
 #if 0
 /* Not implemented */
 /* 
@@ -276,26 +273,24 @@ #if 0
  */
 #define SX_REPORT_FIFO
 #define SX_REPORT_OVERRUN
-#endif 
-
+#endif
 
 /* Function prototypes */
-static void sx_disable_tx_interrupts (void * ptr); 
-static void sx_enable_tx_interrupts (void * ptr); 
-static void sx_disable_rx_interrupts (void * ptr); 
-static void sx_enable_rx_interrupts (void * ptr); 
-static int  sx_get_CD (void * ptr); 
-static void sx_shutdown_port (void * ptr);
-static int  sx_set_real_termios (void  *ptr);
-static void sx_close (void  *ptr);
-static int sx_chars_in_buffer (void * ptr);
-static int sx_init_board (struct sx_board *board);
-static int sx_init_portstructs (int nboards, int nports);
-static int sx_fw_ioctl (struct inode *inode, struct file *filp,
-                        unsigned int cmd, unsigned long arg);
+static void sx_disable_tx_interrupts(void *ptr);
+static void sx_enable_tx_interrupts(void *ptr);
+static void sx_disable_rx_interrupts(void *ptr);
+static void sx_enable_rx_interrupts(void *ptr);
+static int sx_get_CD(void *ptr);
+static void sx_shutdown_port(void *ptr);
+static int sx_set_real_termios(void *ptr);
+static void sx_close(void *ptr);
+static int sx_chars_in_buffer(void *ptr);
+static int sx_init_board(struct sx_board *board);
+static int sx_init_portstructs(int nboards, int nports);
+static int sx_fw_ioctl(struct inode *inode, struct file *filp,
+		unsigned int cmd, unsigned long arg);
 static int sx_init_drivers(void);
 
-
 static struct tty_driver *sx_driver;
 
 static DEFINE_MUTEX(sx_boards_lock);
@@ -305,7 +300,6 @@ static int sx_initialized;
 static int sx_nports;
 static int sx_debug;
 
-
 /* You can have the driver poll your card. 
     - Set sx_poll to 1 to poll every timer tick (10ms on Intel). 
       This is used when the card cannot use an interrupt for some reason.
@@ -330,11 +324,17 @@ #ifdef CONFIG_ISA
    or less.... -- REW 
    duh: Card at 0xa0000 is possible on HP Netserver?? -- pvdl
 */
-static int sx_probe_addrs[]= {0xc0000, 0xd0000, 0xe0000, 
-                              0xc8000, 0xd8000, 0xe8000};
-static int si_probe_addrs[]= {0xc0000, 0xd0000, 0xe0000, 
-                              0xc8000, 0xd8000, 0xe8000, 0xa0000};
-static int si1_probe_addrs[]= { 0xd0000};
+static int sx_probe_addrs[] = {
+	0xc0000, 0xd0000, 0xe0000,
+	0xc8000, 0xd8000, 0xe8000
+};
+static int si_probe_addrs[] = {
+	0xc0000, 0xd0000, 0xe0000,
+	0xc8000, 0xd8000, 0xe8000, 0xa0000
+};
+static int si1_probe_addrs[] = {
+	0xd0000
+};
 
 #define NR_SX_ADDRS ARRAY_SIZE(sx_probe_addrs)
 #define NR_SI_ADDRS ARRAY_SIZE(si_probe_addrs)
@@ -362,13 +362,12 @@ static struct real_driver sx_real_driver
 	sx_disable_rx_interrupts,
 	sx_enable_rx_interrupts,
 	sx_get_CD,
-	sx_shutdown_port, 
-	sx_set_real_termios, 
+	sx_shutdown_port,
+	sx_set_real_termios,
 	sx_chars_in_buffer,
 	sx_close,
 };
 
-
 /* 
    This driver can spew a whole lot of debugging output at you. If you
    need maximum performance, you should disable the DEBUG define. To
@@ -379,23 +378,17 @@ static struct real_driver sx_real_driver
 */
 #define DEBUG
 
-
 #ifdef DEBUG
-#define sx_dprintk(f, str...) if (sx_debug & f) printk (str)
+#define sx_dprintk(f, str...)	if (sx_debug & f) printk (str)
 #else
-#define sx_dprintk(f, str...) /* nothing */
+#define sx_dprintk(f, str...)	/* nothing */
 #endif
 
+#define func_enter()	sx_dprintk(SX_DEBUG_FLOW, "sx: enter %s\n",__FUNCTION__)
+#define func_exit()	sx_dprintk(SX_DEBUG_FLOW, "sx: exit  %s\n",__FUNCTION__)
 
-
-#define func_enter() sx_dprintk (SX_DEBUG_FLOW, "sx: enter %s\n",__FUNCTION__)
-#define func_exit()  sx_dprintk (SX_DEBUG_FLOW, "sx: exit  %s\n", __FUNCTION__)
-
-#define func_enter2() sx_dprintk (SX_DEBUG_FLOW, "sx: enter %s (port %d)\n", \
-					__FUNCTION__, port->line)
-
-
-
+#define func_enter2()	sx_dprintk(SX_DEBUG_FLOW, "sx: enter %s (port %d)\n", \
+				__FUNCTION__, port->line)
 
 /* 
  *  Firmware loader driver specific routines
@@ -403,31 +396,26 @@ #define func_enter2() sx_dprintk (SX_DEB
  */
 
 static const struct file_operations sx_fw_fops = {
-	.owner		= THIS_MODULE,
-	.ioctl		= sx_fw_ioctl,
+	.owner = THIS_MODULE,
+	.ioctl = sx_fw_ioctl,
 };
 
 static struct miscdevice sx_fw_device = {
 	SXCTL_MISC_MINOR, "sxctl", &sx_fw_fops
 };
 
-
-
-
-
 #ifdef SX_PARANOIA_CHECK
 
 /* This doesn't work. Who's paranoid around here? Not me! */
 
-static inline int sx_paranoia_check(struct sx_port const * port,
+static inline int sx_paranoia_check(struct sx_port const *port,
 				    char *name, const char *routine)
 {
+	static const char *badmagic = KERN_ERR "sx: Warning: bad sx port magic "
+			"number for device %s in %s\n";
+	static const char *badinfo = KERN_ERR "sx: Warning: null sx port for "
+			"device %s in %s\n";
 
-	static const char *badmagic =
-	  KERN_ERR "sx: Warning: bad sx port magic number for device %s in %s\n";
-	static const char *badinfo =
-	  KERN_ERR "sx: Warning: null sx port for device %s in %s\n";
- 
 	if (!port) {
 		printk(badinfo, name, routine);
 		return 1;
@@ -450,23 +438,24 @@ #endif
 #define TIMEOUT_1 30
 #define TIMEOUT_2 1000000
 
-
 #ifdef DEBUG
 static void my_hd_io(void __iomem *p, int len)
 {
 	int i, j, ch;
 	unsigned char __iomem *addr = p;
 
-	for (i=0;i<len;i+=16) {
-		printk ("%p ", addr+i);
-		for (j=0;j<16;j++) {
-			printk ("%02x %s", readb(addr+j+i), (j==7)?" ":"");
+	for (i = 0; i < len; i += 16) {
+		printk("%p ", addr + i);
+		for (j = 0; j < 16; j++) {
+			printk("%02x %s", readb(addr + j + i),
+					(j == 7) ? " " : "");
 		}
-		for (j=0;j<16;j++) {
-			ch = readb(addr+j+i);
-			printk ("%c", (ch < 0x20)?'.':((ch > 0x7f)?'.':ch));
+		for (j = 0; j < 16; j++) {
+			ch = readb(addr + j + i);
+			printk("%c", (ch < 0x20) ? '.' :
+					((ch > 0x7f) ? '.' : ch));
 		}
-		printk ("\n");
+		printk("\n");
 	}
 }
 static void my_hd(void *p, int len)
@@ -474,419 +463,468 @@ static void my_hd(void *p, int len)
 	int i, j, ch;
 	unsigned char *addr = p;
 
-	for (i=0;i<len;i+=16) {
-		printk ("%p ", addr+i);
-		for (j=0;j<16;j++) {
-			printk ("%02x %s", addr[j+i], (j==7)?" ":"");
+	for (i = 0; i < len; i += 16) {
+		printk("%p ", addr + i);
+		for (j = 0; j < 16; j++) {
+			printk("%02x %s", addr[j + i], (j == 7) ? " " : "");
 		}
-		for (j=0;j<16;j++) {
-			ch = addr[j+i];
-			printk ("%c", (ch < 0x20)?'.':((ch > 0x7f)?'.':ch));
+		for (j = 0; j < 16; j++) {
+			ch = addr[j + i];
+			printk("%c", (ch < 0x20) ? '.' :
+					((ch > 0x7f) ? '.' : ch));
 		}
-		printk ("\n");
+		printk("\n");
 	}
 }
 #endif
 
-
-
 /* This needs redoing for Alpha -- REW -- Done. */
 
-static inline void write_sx_byte (struct sx_board *board, int offset, u8 byte)
+static inline void write_sx_byte(struct sx_board *board, int offset, u8 byte)
 {
-	writeb (byte, board->base+offset);
+	writeb(byte, board->base + offset);
 }
 
-static inline u8 read_sx_byte (struct sx_board *board, int offset)
+static inline u8 read_sx_byte(struct sx_board *board, int offset)
 {
-	return readb (board->base+offset);
+	return readb(board->base + offset);
 }
 
-
-static inline void write_sx_word (struct sx_board *board, int offset, u16 word)
+static inline void write_sx_word(struct sx_board *board, int offset, u16 word)
 {
-	writew (word, board->base+offset);
+	writew(word, board->base + offset);
 }
 
-static inline u16 read_sx_word (struct sx_board *board, int offset)
+static inline u16 read_sx_word(struct sx_board *board, int offset)
 {
-	return readw (board->base + offset);
+	return readw(board->base + offset);
 }
 
-
-static int sx_busy_wait_eq (struct sx_board *board, 
-                     	    int offset, int mask, int correctval)
+static int sx_busy_wait_eq(struct sx_board *board,
+		int offset, int mask, int correctval)
 {
 	int i;
 
-	func_enter ();
+	func_enter();
 
-	for (i=0; i < TIMEOUT_1 ;i++)
-		if ((read_sx_byte (board, offset) & mask) == correctval) {
-			func_exit ();
+	for (i = 0; i < TIMEOUT_1; i++)
+		if ((read_sx_byte(board, offset) & mask) == correctval) {
+			func_exit();
 			return 1;
 		}
 
-	for (i=0; i < TIMEOUT_2 ;i++) {
-		if ((read_sx_byte (board, offset) & mask) == correctval) {
-			func_exit ();
+	for (i = 0; i < TIMEOUT_2; i++) {
+		if ((read_sx_byte(board, offset) & mask) == correctval) {
+			func_exit();
 			return 1;
 		}
-		udelay (1);
+		udelay(1);
 	}
 
-	func_exit ();
+	func_exit();
 	return 0;
 }
 
-
-static int sx_busy_wait_neq (struct sx_board *board, 
-                      	     int offset, int mask, int badval)
+static int sx_busy_wait_neq(struct sx_board *board,
+		int offset, int mask, int badval)
 {
 	int i;
 
-	func_enter ();
+	func_enter();
 
-	for (i=0; i < TIMEOUT_1 ;i++)
-		if ((read_sx_byte (board, offset) & mask) != badval) {
-			func_exit ();
+	for (i = 0; i < TIMEOUT_1; i++)
+		if ((read_sx_byte(board, offset) & mask) != badval) {
+			func_exit();
 			return 1;
 		}
 
-	for (i=0; i < TIMEOUT_2 ;i++) {
-		if ((read_sx_byte (board, offset) & mask) != badval) {
-			func_exit ();
+	for (i = 0; i < TIMEOUT_2; i++) {
+		if ((read_sx_byte(board, offset) & mask) != badval) {
+			func_exit();
 			return 1;
 		}
-		udelay (1);
+		udelay(1);
 	}
 
-	func_exit ();
+	func_exit();
 	return 0;
 }
 
-
-
 /* 5.6.4 of 6210028 r2.3 */
-static int sx_reset (struct sx_board *board)
+static int sx_reset(struct sx_board *board)
 {
-	func_enter ();
+	func_enter();
 
-	if (IS_SX_BOARD (board)) {
+	if (IS_SX_BOARD(board)) {
 
-		write_sx_byte (board, SX_CONFIG, 0);
-		write_sx_byte (board, SX_RESET, 1); /* Value doesn't matter */
+		write_sx_byte(board, SX_CONFIG, 0);
+		write_sx_byte(board, SX_RESET, 1); /* Value doesn't matter */
 
-		if (!sx_busy_wait_eq (board, SX_RESET_STATUS, 1, 0)) {
-			printk (KERN_INFO "sx: Card doesn't respond to reset....\n");
+		if (!sx_busy_wait_eq(board, SX_RESET_STATUS, 1, 0)) {
+			printk(KERN_INFO "sx: Card doesn't respond to "
+					"reset...\n");
 			return 0;
 		}
 	} else if (IS_EISA_BOARD(board)) {
-		outb(board->irq<<4, board->eisa_base+0xc02);
+		outb(board->irq << 4, board->eisa_base + 0xc02);
 	} else if (IS_SI1_BOARD(board)) {
-	        write_sx_byte (board, SI1_ISA_RESET,   0); // value does not matter
+		write_sx_byte(board, SI1_ISA_RESET, 0);	/*value doesn't matter*/
 	} else {
 		/* Gory details of the SI/ISA board */
-		write_sx_byte (board, SI2_ISA_RESET,    SI2_ISA_RESET_SET);
-		write_sx_byte (board, SI2_ISA_IRQ11,    SI2_ISA_IRQ11_CLEAR);
-		write_sx_byte (board, SI2_ISA_IRQ12,    SI2_ISA_IRQ12_CLEAR);
-		write_sx_byte (board, SI2_ISA_IRQ15,    SI2_ISA_IRQ15_CLEAR);
-		write_sx_byte (board, SI2_ISA_INTCLEAR, SI2_ISA_INTCLEAR_CLEAR);
-		write_sx_byte (board, SI2_ISA_IRQSET,   SI2_ISA_IRQSET_CLEAR);
+		write_sx_byte(board, SI2_ISA_RESET, SI2_ISA_RESET_SET);
+		write_sx_byte(board, SI2_ISA_IRQ11, SI2_ISA_IRQ11_CLEAR);
+		write_sx_byte(board, SI2_ISA_IRQ12, SI2_ISA_IRQ12_CLEAR);
+		write_sx_byte(board, SI2_ISA_IRQ15, SI2_ISA_IRQ15_CLEAR);
+		write_sx_byte(board, SI2_ISA_INTCLEAR, SI2_ISA_INTCLEAR_CLEAR);
+		write_sx_byte(board, SI2_ISA_IRQSET, SI2_ISA_IRQSET_CLEAR);
 	}
 
-	func_exit ();
+	func_exit();
 	return 1;
 }
 
-
 /* This doesn't work on machines where "NULL" isn't 0 */
 /* If you have one of those, someone will need to write 
    the equivalent of this, which will amount to about 3 lines. I don't
    want to complicate this right now. -- REW
    (See, I do write comments every now and then :-) */
-#define OFFSETOF(strct, elem) ((long)&(((struct strct *)NULL)->elem))
-
-
-#define CHAN_OFFSET(port,elem) (port->ch_base + OFFSETOF (_SXCHANNEL, elem))
-#define MODU_OFFSET(board,addr,elem)    (addr + OFFSETOF (_SXMODULE, elem))
-#define  BRD_OFFSET(board,elem)                (OFFSETOF (_SXCARD, elem))
+#define OFFSETOF(strct, elem)	((long)&(((struct strct *)NULL)->elem))
 
+#define CHAN_OFFSET(port,elem)	(port->ch_base + OFFSETOF (_SXCHANNEL, elem))
+#define MODU_OFFSET(board,addr,elem)	(addr + OFFSETOF (_SXMODULE, elem))
+#define  BRD_OFFSET(board,elem)	(OFFSETOF (_SXCARD, elem))
 
 #define sx_write_channel_byte(port, elem, val) \
-   write_sx_byte (port->board, CHAN_OFFSET (port, elem), val)
+	write_sx_byte (port->board, CHAN_OFFSET (port, elem), val)
 
 #define sx_read_channel_byte(port, elem) \
-   read_sx_byte (port->board, CHAN_OFFSET (port, elem))
+	read_sx_byte (port->board, CHAN_OFFSET (port, elem))
 
 #define sx_write_channel_word(port, elem, val) \
-   write_sx_word (port->board, CHAN_OFFSET (port, elem), val)
+	write_sx_word (port->board, CHAN_OFFSET (port, elem), val)
 
 #define sx_read_channel_word(port, elem) \
-   read_sx_word (port->board, CHAN_OFFSET (port, elem))
-
+	read_sx_word (port->board, CHAN_OFFSET (port, elem))
 
 #define sx_write_module_byte(board, addr, elem, val) \
-   write_sx_byte (board, MODU_OFFSET (board, addr, elem), val)
+	write_sx_byte (board, MODU_OFFSET (board, addr, elem), val)
 
 #define sx_read_module_byte(board, addr, elem) \
-   read_sx_byte (board, MODU_OFFSET (board, addr, elem))
+	read_sx_byte (board, MODU_OFFSET (board, addr, elem))
 
 #define sx_write_module_word(board, addr, elem, val) \
-   write_sx_word (board, MODU_OFFSET (board, addr, elem), val)
+	write_sx_word (board, MODU_OFFSET (board, addr, elem), val)
 
 #define sx_read_module_word(board, addr, elem) \
-   read_sx_word (board, MODU_OFFSET (board, addr, elem))
-
+	read_sx_word (board, MODU_OFFSET (board, addr, elem))
 
 #define sx_write_board_byte(board, elem, val) \
-   write_sx_byte (board, BRD_OFFSET (board, elem), val)
+	write_sx_byte (board, BRD_OFFSET (board, elem), val)
 
 #define sx_read_board_byte(board, elem) \
-   read_sx_byte (board, BRD_OFFSET (board, elem))
+	read_sx_byte (board, BRD_OFFSET (board, elem))
 
 #define sx_write_board_word(board, elem, val) \
-   write_sx_word (board, BRD_OFFSET (board, elem), val)
+	write_sx_word (board, BRD_OFFSET (board, elem), val)
 
 #define sx_read_board_word(board, elem) \
-   read_sx_word (board, BRD_OFFSET (board, elem))
-
+	read_sx_word (board, BRD_OFFSET (board, elem))
 
-static int sx_start_board (struct sx_board *board)
+static int sx_start_board(struct sx_board *board)
 {
-	if (IS_SX_BOARD (board)) {
-		write_sx_byte (board, SX_CONFIG, SX_CONF_BUSEN);
+	if (IS_SX_BOARD(board)) {
+		write_sx_byte(board, SX_CONFIG, SX_CONF_BUSEN);
 	} else if (IS_EISA_BOARD(board)) {
 		write_sx_byte(board, SI2_EISA_OFF, SI2_EISA_VAL);
-		outb((board->irq<<4)|4, board->eisa_base+0xc02);
+		outb((board->irq << 4) | 4, board->eisa_base + 0xc02);
 	} else if (IS_SI1_BOARD(board)) {
-		write_sx_byte (board, SI1_ISA_RESET_CLEAR, 0);
-		write_sx_byte (board, SI1_ISA_INTCL, 0);
+		write_sx_byte(board, SI1_ISA_RESET_CLEAR, 0);
+		write_sx_byte(board, SI1_ISA_INTCL, 0);
 	} else {
 		/* Don't bug me about the clear_set. 
 		   I haven't the foggiest idea what it's about -- REW */
-		write_sx_byte (board, SI2_ISA_RESET,    SI2_ISA_RESET_CLEAR);
-		write_sx_byte (board, SI2_ISA_INTCLEAR, SI2_ISA_INTCLEAR_SET);
+		write_sx_byte(board, SI2_ISA_RESET, SI2_ISA_RESET_CLEAR);
+		write_sx_byte(board, SI2_ISA_INTCLEAR, SI2_ISA_INTCLEAR_SET);
 	}
 	return 1;
 }
 
 #define SX_IRQ_REG_VAL(board) \
-        ((board->flags & SX_ISA_BOARD)?(board->irq << 4):0)
+	((board->flags & SX_ISA_BOARD) ? (board->irq << 4) : 0)
 
 /* Note. The SX register is write-only. Therefore, we have to enable the
    bus too. This is a no-op, if you don't mess with this driver... */
-static int sx_start_interrupts (struct sx_board *board)
+static int sx_start_interrupts(struct sx_board *board)
 {
 
 	/* Don't call this with board->irq == 0 */
 
 	if (IS_SX_BOARD(board)) {
-		write_sx_byte (board, SX_CONFIG, SX_IRQ_REG_VAL (board) | 
-		                                 SX_CONF_BUSEN | 
-		                                 SX_CONF_HOSTIRQ);
+		write_sx_byte(board, SX_CONFIG, SX_IRQ_REG_VAL(board) |
+				SX_CONF_BUSEN | SX_CONF_HOSTIRQ);
 	} else if (IS_EISA_BOARD(board)) {
-		inb(board->eisa_base+0xc03);  
+		inb(board->eisa_base + 0xc03);
 	} else if (IS_SI1_BOARD(board)) {
-	       write_sx_byte (board, SI1_ISA_INTCL,0);
-	       write_sx_byte (board, SI1_ISA_INTCL_CLEAR,0);
+		write_sx_byte(board, SI1_ISA_INTCL, 0);
+		write_sx_byte(board, SI1_ISA_INTCL_CLEAR, 0);
 	} else {
 		switch (board->irq) {
-		case 11:write_sx_byte (board, SI2_ISA_IRQ11, SI2_ISA_IRQ11_SET);break;
-		case 12:write_sx_byte (board, SI2_ISA_IRQ12, SI2_ISA_IRQ12_SET);break;
-		case 15:write_sx_byte (board, SI2_ISA_IRQ15, SI2_ISA_IRQ15_SET);break;
-		default:printk (KERN_INFO "sx: SI/XIO card doesn't support interrupt %d.\n", 
-		                board->irq);
-		return 0;
+		case 11:
+			write_sx_byte(board, SI2_ISA_IRQ11, SI2_ISA_IRQ11_SET);
+			break;
+		case 12:
+			write_sx_byte(board, SI2_ISA_IRQ12, SI2_ISA_IRQ12_SET);
+			break;
+		case 15:
+			write_sx_byte(board, SI2_ISA_IRQ15, SI2_ISA_IRQ15_SET);
+			break;
+		default:
+			printk(KERN_INFO "sx: SI/XIO card doesn't support "
+					"interrupt %d.\n", board->irq);
+			return 0;
 		}
-		write_sx_byte (board, SI2_ISA_INTCLEAR, SI2_ISA_INTCLEAR_SET);
+		write_sx_byte(board, SI2_ISA_INTCLEAR, SI2_ISA_INTCLEAR_SET);
 	}
 
 	return 1;
 }
 
-
-static int sx_send_command (struct sx_port *port, 
-                     	    int command, int mask, int newstat)
+static int sx_send_command(struct sx_port *port,
+		int command, int mask, int newstat)
 {
-	func_enter2 ();
-	write_sx_byte (port->board, CHAN_OFFSET (port, hi_hstat), command);
-	func_exit ();
-	return sx_busy_wait_eq (port->board, CHAN_OFFSET (port, hi_hstat), mask, newstat);
+	func_enter2();
+	write_sx_byte(port->board, CHAN_OFFSET(port, hi_hstat), command);
+	func_exit();
+	return sx_busy_wait_eq(port->board, CHAN_OFFSET(port, hi_hstat), mask,
+			newstat);
 }
 
-
-static char *mod_type_s (int module_type)
+static char *mod_type_s(int module_type)
 {
 	switch (module_type) {
-	case TA4:       return "TA4";
-	case TA8:       return "TA8";
-	case TA4_ASIC:  return "TA4_ASIC";
-	case TA8_ASIC:  return "TA8_ASIC";
-	case MTA_CD1400:return "MTA_CD1400";
-	case SXDC:      return "SXDC";
-	default:return "Unknown/invalid";
+	case TA4:
+		return "TA4";
+	case TA8:
+		return "TA8";
+	case TA4_ASIC:
+		return "TA4_ASIC";
+	case TA8_ASIC:
+		return "TA8_ASIC";
+	case MTA_CD1400:
+		return "MTA_CD1400";
+	case SXDC:
+		return "SXDC";
+	default:
+		return "Unknown/invalid";
 	}
 }
 
-
-static char *pan_type_s (int pan_type)
+static char *pan_type_s(int pan_type)
 {
 	switch (pan_type) {
-	case MOD_RS232DB25:     return "MOD_RS232DB25";
-	case MOD_RS232RJ45:     return "MOD_RS232RJ45";
-	case MOD_RS422DB25:     return "MOD_RS422DB25";
-	case MOD_PARALLEL:      return "MOD_PARALLEL";
-	case MOD_2_RS232DB25:   return "MOD_2_RS232DB25";
-	case MOD_2_RS232RJ45:   return "MOD_2_RS232RJ45";
-	case MOD_2_RS422DB25:   return "MOD_2_RS422DB25";
-	case MOD_RS232DB25MALE: return "MOD_RS232DB25MALE";
-	case MOD_2_PARALLEL:    return "MOD_2_PARALLEL";
-	case MOD_BLANK:         return "empty";
-	default:return "invalid";
+	case MOD_RS232DB25:
+		return "MOD_RS232DB25";
+	case MOD_RS232RJ45:
+		return "MOD_RS232RJ45";
+	case MOD_RS422DB25:
+		return "MOD_RS422DB25";
+	case MOD_PARALLEL:
+		return "MOD_PARALLEL";
+	case MOD_2_RS232DB25:
+		return "MOD_2_RS232DB25";
+	case MOD_2_RS232RJ45:
+		return "MOD_2_RS232RJ45";
+	case MOD_2_RS422DB25:
+		return "MOD_2_RS422DB25";
+	case MOD_RS232DB25MALE:
+		return "MOD_RS232DB25MALE";
+	case MOD_2_PARALLEL:
+		return "MOD_2_PARALLEL";
+	case MOD_BLANK:
+		return "empty";
+	default:
+		return "invalid";
 	}
 }
 
-
-static int mod_compat_type (int module_type)
+static int mod_compat_type(int module_type)
 {
 	return module_type >> 4;
 }
 
 static void sx_reconfigure_port(struct sx_port *port)
 {
-	if (sx_read_channel_byte (port, hi_hstat) == HS_IDLE_OPEN) {
-		if (sx_send_command (port, HS_CONFIG, -1, HS_IDLE_OPEN) != 1) {
-			printk (KERN_WARNING "sx: Sent reconfigure command, but card didn't react.\n");
+	if (sx_read_channel_byte(port, hi_hstat) == HS_IDLE_OPEN) {
+		if (sx_send_command(port, HS_CONFIG, -1, HS_IDLE_OPEN) != 1) {
+			printk(KERN_WARNING "sx: Sent reconfigure command, but "
+					"card didn't react.\n");
 		}
 	} else {
-		sx_dprintk (SX_DEBUG_TERMIOS, 
-		            "sx: Not sending reconfigure: port isn't open (%02x).\n", 
-		            sx_read_channel_byte (port, hi_hstat));
-	}	
+		sx_dprintk(SX_DEBUG_TERMIOS, "sx: Not sending reconfigure: "
+				"port isn't open (%02x).\n",
+				sx_read_channel_byte(port, hi_hstat));
+	}
 }
 
-static void sx_setsignals (struct sx_port *port, int dtr, int rts)
+static void sx_setsignals(struct sx_port *port, int dtr, int rts)
 {
 	int t;
-	func_enter2 ();
+	func_enter2();
 
-	t = sx_read_channel_byte (port, hi_op);
-	if (dtr >= 0) t = dtr? (t | OP_DTR): (t & ~OP_DTR);
-	if (rts >= 0) t = rts? (t | OP_RTS): (t & ~OP_RTS);
-	sx_write_channel_byte (port, hi_op, t);
-	sx_dprintk (SX_DEBUG_MODEMSIGNALS, "setsignals: %d/%d\n", dtr, rts);
+	t = sx_read_channel_byte(port, hi_op);
+	if (dtr >= 0)
+		t = dtr ? (t | OP_DTR) : (t & ~OP_DTR);
+	if (rts >= 0)
+		t = rts ? (t | OP_RTS) : (t & ~OP_RTS);
+	sx_write_channel_byte(port, hi_op, t);
+	sx_dprintk(SX_DEBUG_MODEMSIGNALS, "setsignals: %d/%d\n", dtr, rts);
 
-	func_exit ();
+	func_exit();
 }
 
-
-
-static int sx_getsignals (struct sx_port *port)
+static int sx_getsignals(struct sx_port *port)
 {
-	int i_stat,o_stat;
-
-	o_stat = sx_read_channel_byte (port, hi_op);
-	i_stat = sx_read_channel_byte (port, hi_ip);
-
-	sx_dprintk (SX_DEBUG_MODEMSIGNALS, "getsignals: %d/%d  (%d/%d) %02x/%02x\n",
-	            (o_stat & OP_DTR) != 0, (o_stat & OP_RTS) != 0,
-	            port->c_dcd, sx_get_CD (port),
-	            sx_read_channel_byte (port, hi_ip),
-	            sx_read_channel_byte (port, hi_state));
-
-	return (((o_stat & OP_DTR)?TIOCM_DTR:0) |
-	        ((o_stat & OP_RTS)?TIOCM_RTS:0) |
-	        ((i_stat & IP_CTS)?TIOCM_CTS:0) |
-	        ((i_stat & IP_DCD)?TIOCM_CAR:0) |
-	        ((i_stat & IP_DSR)?TIOCM_DSR:0) |
-	        ((i_stat & IP_RI)?TIOCM_RNG:0)
-	        );
+	int i_stat, o_stat;
+
+	o_stat = sx_read_channel_byte(port, hi_op);
+	i_stat = sx_read_channel_byte(port, hi_ip);
+
+	sx_dprintk(SX_DEBUG_MODEMSIGNALS, "getsignals: %d/%d  (%d/%d) "
+			"%02x/%02x\n",
+			(o_stat & OP_DTR) != 0, (o_stat & OP_RTS) != 0,
+			port->c_dcd, sx_get_CD(port),
+			sx_read_channel_byte(port, hi_ip),
+			sx_read_channel_byte(port, hi_state));
+
+	return (((o_stat & OP_DTR) ? TIOCM_DTR : 0) |
+		((o_stat & OP_RTS) ? TIOCM_RTS : 0) |
+		((i_stat & IP_CTS) ? TIOCM_CTS : 0) |
+		((i_stat & IP_DCD) ? TIOCM_CAR : 0) |
+		((i_stat & IP_DSR) ? TIOCM_DSR : 0) |
+		((i_stat & IP_RI) ? TIOCM_RNG : 0));
 }
 
-
-static void sx_set_baud (struct sx_port *port)
+static void sx_set_baud(struct sx_port *port)
 {
 	int t;
 
 	if (port->board->ta_type == MOD_SXDC) {
 		switch (port->gs.baud) {
-		  /* Save some typing work... */
-#define e(x) case x:t= BAUD_ ## x ; break
-			e(50);e(75);e(110);e(150);e(200);e(300);e(600);
-                        e(1200);e(1800);e(2000);e(2400);e(4800);e(7200);
-                        e(9600);e(14400);e(19200);e(28800);e(38400);
-                        e(56000);e(57600);e(64000);e(76800);e(115200);
-			e(128000);e(150000);e(230400);e(256000);e(460800);
-                        e(921600);
-		case 134    :t = BAUD_134_5;   break;
-		case 0      :t = -1;
-								 break;
+			/* Save some typing work... */
+#define e(x) case x: t = BAUD_ ## x; break
+			e(50);
+			e(75);
+			e(110);
+			e(150);
+			e(200);
+			e(300);
+			e(600);
+			e(1200);
+			e(1800);
+			e(2000);
+			e(2400);
+			e(4800);
+			e(7200);
+			e(9600);
+			e(14400);
+			e(19200);
+			e(28800);
+			e(38400);
+			e(56000);
+			e(57600);
+			e(64000);
+			e(76800);
+			e(115200);
+			e(128000);
+			e(150000);
+			e(230400);
+			e(256000);
+			e(460800);
+			e(921600);
+		case 134:
+			t = BAUD_134_5;
+			break;
+		case 0:
+			t = -1;
+			break;
 		default:
 			/* Can I return "invalid"? */
 			t = BAUD_9600;
-			printk (KERN_INFO "sx: unsupported baud rate: %d.\n", port->gs.baud);
+			printk(KERN_INFO "sx: unsupported baud rate: %d.\n",
+					port->gs.baud);
 			break;
 		}
 #undef e
 		if (t > 0) {
-			/* The baud rate is not set to 0, so we're enabeling DTR... -- REW */
-			sx_setsignals (port, 1, -1); 
+/* The baud rate is not set to 0, so we're enabeling DTR... -- REW */
+			sx_setsignals(port, 1, -1);
 			/* XXX This is not TA & MTA compatible */
-			sx_write_channel_byte (port, hi_csr, 0xff);
+			sx_write_channel_byte(port, hi_csr, 0xff);
 
-			sx_write_channel_byte (port, hi_txbaud, t);
-			sx_write_channel_byte (port, hi_rxbaud, t);
+			sx_write_channel_byte(port, hi_txbaud, t);
+			sx_write_channel_byte(port, hi_rxbaud, t);
 		} else {
-			sx_setsignals (port, 0, -1);
+			sx_setsignals(port, 0, -1);
 		}
 	} else {
 		switch (port->gs.baud) {
-#define e(x) case x:t= CSR_ ## x ; break
-			e(75);e(150);e(300);e(600);e(1200);e(2400);e(4800);
-                        e(1800);e(9600);
-			e(19200);e(57600);e(38400);
-			/* TA supports 110, but not 115200, MTA supports 115200, but not 110 */
-		case 110: 
+#define e(x) case x: t = CSR_ ## x; break
+			e(75);
+			e(150);
+			e(300);
+			e(600);
+			e(1200);
+			e(2400);
+			e(4800);
+			e(1800);
+			e(9600);
+			e(19200);
+			e(57600);
+			e(38400);
+/* TA supports 110, but not 115200, MTA supports 115200, but not 110 */
+		case 110:
 			if (port->board->ta_type == MOD_TA) {
 				t = CSR_110;
 				break;
 			} else {
 				t = CSR_9600;
-				printk (KERN_INFO "sx: Unsupported baud rate: %d.\n", port->gs.baud);
+				printk(KERN_INFO "sx: Unsupported baud rate: "
+						"%d.\n", port->gs.baud);
 				break;
 			}
-		case 115200: 
+		case 115200:
 			if (port->board->ta_type == MOD_TA) {
 				t = CSR_9600;
-				printk (KERN_INFO "sx: Unsupported baud rate: %d.\n", port->gs.baud);
+				printk(KERN_INFO "sx: Unsupported baud rate: "
+						"%d.\n", port->gs.baud);
 				break;
 			} else {
 				t = CSR_110;
 				break;
 			}
-		case 0      :t = -1;
-								 break;
+		case 0:
+			t = -1;
+			break;
 		default:
 			t = CSR_9600;
-			printk (KERN_INFO "sx: Unsupported baud rate: %d.\n", port->gs.baud);
+			printk(KERN_INFO "sx: Unsupported baud rate: %d.\n",
+					port->gs.baud);
 			break;
 		}
 #undef e
 		if (t >= 0) {
-			sx_setsignals (port, 1, -1);
-			sx_write_channel_byte (port, hi_csr, t * 0x11);
+			sx_setsignals(port, 1, -1);
+			sx_write_channel_byte(port, hi_csr, t * 0x11);
 		} else {
-			sx_setsignals (port, 0, -1);
+			sx_setsignals(port, 0, -1);
 		}
 	}
 }
 
-
 /* Simon Allen's version of this routine was 225 lines long. 85 is a lot
    better. -- REW */
 
-static int sx_set_real_termios (void *ptr)
+static int sx_set_real_termios(void *ptr)
 {
 	struct sx_port *port = ptr;
 
@@ -901,80 +939,83 @@ static int sx_set_real_termios (void *pt
 	   belongs (next to the drop dtr if baud == 0) -- REW */
 	/* sx_setsignals (port, 1, -1); */
 
-	sx_set_baud (port);
+	sx_set_baud(port);
 
 #define CFLAG port->gs.tty->termios->c_cflag
-	sx_write_channel_byte (port, hi_mr1,
-	                       (C_PARENB (port->gs.tty)? MR1_WITH:MR1_NONE) |
-	                       (C_PARODD (port->gs.tty)? MR1_ODD:MR1_EVEN) |
-	                       (C_CRTSCTS(port->gs.tty)? MR1_RTS_RXFLOW:0) |
-	                       (((CFLAG & CSIZE)==CS8) ? MR1_8_BITS:0) |
-	                       (((CFLAG & CSIZE)==CS7) ? MR1_7_BITS:0) |
-	                       (((CFLAG & CSIZE)==CS6) ? MR1_6_BITS:0) |
-	                       (((CFLAG & CSIZE)==CS5) ? MR1_5_BITS:0) );
-
-	sx_write_channel_byte (port, hi_mr2,
-	                       (C_CRTSCTS(port->gs.tty)?MR2_CTS_TXFLOW:0) |
-	                       (C_CSTOPB (port->gs.tty)?MR2_2_STOP:MR2_1_STOP));
+	sx_write_channel_byte(port, hi_mr1,
+			(C_PARENB(port->gs.tty) ? MR1_WITH : MR1_NONE) |
+			(C_PARODD(port->gs.tty) ? MR1_ODD : MR1_EVEN) |
+			(C_CRTSCTS(port->gs.tty) ? MR1_RTS_RXFLOW : 0) |
+			(((CFLAG & CSIZE) == CS8) ? MR1_8_BITS : 0) |
+			(((CFLAG & CSIZE) == CS7) ? MR1_7_BITS : 0) |
+			(((CFLAG & CSIZE) == CS6) ? MR1_6_BITS : 0) |
+			(((CFLAG & CSIZE) == CS5) ? MR1_5_BITS : 0));
+
+	sx_write_channel_byte(port, hi_mr2,
+			(C_CRTSCTS(port->gs.tty) ? MR2_CTS_TXFLOW : 0) |
+			(C_CSTOPB(port->gs.tty) ? MR2_2_STOP :
+			MR2_1_STOP));
 
 	switch (CFLAG & CSIZE) {
-	case CS8:sx_write_channel_byte (port, hi_mask, 0xff);break;
-	case CS7:sx_write_channel_byte (port, hi_mask, 0x7f);break;
-	case CS6:sx_write_channel_byte (port, hi_mask, 0x3f);break;
-	case CS5:sx_write_channel_byte (port, hi_mask, 0x1f);break;
+	case CS8:
+		sx_write_channel_byte(port, hi_mask, 0xff);
+		break;
+	case CS7:
+		sx_write_channel_byte(port, hi_mask, 0x7f);
+		break;
+	case CS6:
+		sx_write_channel_byte(port, hi_mask, 0x3f);
+		break;
+	case CS5:
+		sx_write_channel_byte(port, hi_mask, 0x1f);
+		break;
 	default:
-		printk (KERN_INFO "sx: Invalid wordsize: %u\n", CFLAG & CSIZE);
+		printk(KERN_INFO "sx: Invalid wordsize: %u\n", CFLAG & CSIZE);
 		break;
 	}
 
-	sx_write_channel_byte (port, hi_prtcl, 
-	                       (I_IXON   (port->gs.tty)?SP_TXEN:0) |
-	                       (I_IXOFF  (port->gs.tty)?SP_RXEN:0) |
-	                       (I_IXANY  (port->gs.tty)?SP_TANY:0) |
-	                       SP_DCEN);
+	sx_write_channel_byte(port, hi_prtcl,
+			(I_IXON(port->gs.tty) ? SP_TXEN : 0) |
+			(I_IXOFF(port->gs.tty) ? SP_RXEN : 0) |
+			(I_IXANY(port->gs.tty) ? SP_TANY : 0) | SP_DCEN);
 
-	sx_write_channel_byte (port, hi_break, 
-	                       (I_IGNBRK(port->gs.tty)?BR_IGN:0 |
-	                        I_BRKINT(port->gs.tty)?BR_INT:0));
+	sx_write_channel_byte(port, hi_break,
+			(I_IGNBRK(port->gs.tty) ? BR_IGN : 0 |
+			I_BRKINT(port->gs.tty) ? BR_INT : 0));
 
-	sx_write_channel_byte (port, hi_txon,  START_CHAR (port->gs.tty));
-	sx_write_channel_byte (port, hi_rxon,  START_CHAR (port->gs.tty));
-	sx_write_channel_byte (port, hi_txoff, STOP_CHAR  (port->gs.tty));
-	sx_write_channel_byte (port, hi_rxoff, STOP_CHAR  (port->gs.tty));
+	sx_write_channel_byte(port, hi_txon, START_CHAR(port->gs.tty));
+	sx_write_channel_byte(port, hi_rxon, START_CHAR(port->gs.tty));
+	sx_write_channel_byte(port, hi_txoff, STOP_CHAR(port->gs.tty));
+	sx_write_channel_byte(port, hi_rxoff, STOP_CHAR(port->gs.tty));
 
 	sx_reconfigure_port(port);
 
 	/* Tell line discipline whether we will do input cooking */
-	if(I_OTHER(port->gs.tty)) {
+	if (I_OTHER(port->gs.tty)) {
 		clear_bit(TTY_HW_COOK_IN, &port->gs.tty->flags);
 	} else {
 		set_bit(TTY_HW_COOK_IN, &port->gs.tty->flags);
 	}
-	sx_dprintk (SX_DEBUG_TERMIOS, "iflags: %x(%d) ",
-	            port->gs.tty->termios->c_iflag, 
-	            I_OTHER(port->gs.tty));
-
+	sx_dprintk(SX_DEBUG_TERMIOS, "iflags: %x(%d) ",
+			port->gs.tty->termios->c_iflag, I_OTHER(port->gs.tty));
 
 /* Tell line discipline whether we will do output cooking.
  * If OPOST is set and no other output flags are set then we can do output
  * processing.  Even if only *one* other flag in the O_OTHER group is set
  * we do cooking in software.
  */
-	if(O_OPOST(port->gs.tty) && !O_OTHER(port->gs.tty)) {
+	if (O_OPOST(port->gs.tty) && !O_OTHER(port->gs.tty)) {
 		set_bit(TTY_HW_COOK_OUT, &port->gs.tty->flags);
 	} else {
 		clear_bit(TTY_HW_COOK_OUT, &port->gs.tty->flags);
 	}
-	sx_dprintk (SX_DEBUG_TERMIOS, "oflags: %x(%d)\n",
-	            port->gs.tty->termios->c_oflag, 
-	            O_OTHER(port->gs.tty));
+	sx_dprintk(SX_DEBUG_TERMIOS, "oflags: %x(%d)\n",
+			port->gs.tty->termios->c_oflag, O_OTHER(port->gs.tty));
 	/* port->c_dcd = sx_get_CD (port); */
-	func_exit ();
+	func_exit();
 	return 0;
 }
 
-
-
 /* ********************************************************************** *
  *                   the interrupt related routines                       *
  * ********************************************************************** */
@@ -990,245 +1031,260 @@ #define CFLAG port->gs.tty->termios->c_c
    know I'm dead against that, but I think it is required in this
    case.  */
 
-
-static void sx_transmit_chars (struct sx_port *port)
+static void sx_transmit_chars(struct sx_port *port)
 {
 	int c;
 	int tx_ip;
 	int txroom;
 
-	func_enter2 ();
-	sx_dprintk (SX_DEBUG_TRANSMIT, "Port %p: transmit %d chars\n", 
-	            port, port->gs.xmit_cnt);
+	func_enter2();
+	sx_dprintk(SX_DEBUG_TRANSMIT, "Port %p: transmit %d chars\n",
+			port, port->gs.xmit_cnt);
 
-	if (test_and_set_bit (SX_PORT_TRANSMIT_LOCK, &port->locks)) {
+	if (test_and_set_bit(SX_PORT_TRANSMIT_LOCK, &port->locks)) {
 		return;
 	}
 
 	while (1) {
 		c = port->gs.xmit_cnt;
 
-		sx_dprintk (SX_DEBUG_TRANSMIT, "Copying %d ", c);
-		tx_ip  = sx_read_channel_byte (port, hi_txipos);
+		sx_dprintk(SX_DEBUG_TRANSMIT, "Copying %d ", c);
+		tx_ip = sx_read_channel_byte(port, hi_txipos);
 
 		/* Took me 5 minutes to deduce this formula. 
 		   Luckily it is literally in the manual in section 6.5.4.3.5 */
-		txroom = (sx_read_channel_byte (port, hi_txopos) - tx_ip - 1) & 0xff;
+		txroom = (sx_read_channel_byte(port, hi_txopos) - tx_ip - 1) &
+				0xff;
 
 		/* Don't copy more bytes than there is room for in the buffer */
 		if (c > txroom)
 			c = txroom;
-		sx_dprintk (SX_DEBUG_TRANSMIT, " %d(%d) ", c, txroom );
+		sx_dprintk(SX_DEBUG_TRANSMIT, " %d(%d) ", c, txroom);
 
 		/* Don't copy past the end of the hardware transmit buffer */
-		if (c > 0x100 - tx_ip) 
+		if (c > 0x100 - tx_ip)
 			c = 0x100 - tx_ip;
 
-		sx_dprintk (SX_DEBUG_TRANSMIT, " %d(%d) ", c, 0x100-tx_ip );
+		sx_dprintk(SX_DEBUG_TRANSMIT, " %d(%d) ", c, 0x100 - tx_ip);
 
 		/* Don't copy pas the end of the source buffer */
-		if (c > SERIAL_XMIT_SIZE - port->gs.xmit_tail) 
+		if (c > SERIAL_XMIT_SIZE - port->gs.xmit_tail)
 			c = SERIAL_XMIT_SIZE - port->gs.xmit_tail;
 
-		sx_dprintk (SX_DEBUG_TRANSMIT, " %d(%ld) \n", 
-		            c, SERIAL_XMIT_SIZE- port->gs.xmit_tail);
-
-		/* If for one reason or another, we can't copy more data, we're done! */
-		if (c == 0) break;
+		sx_dprintk(SX_DEBUG_TRANSMIT, " %d(%ld) \n",
+				c, SERIAL_XMIT_SIZE - port->gs.xmit_tail);
 
+		/* If for one reason or another, we can't copy more data, we're
+		   done! */
+		if (c == 0)
+			break;
 
-		memcpy_toio (port->board->base + CHAN_OFFSET(port,hi_txbuf) + tx_ip, 
-		             port->gs.xmit_buf + port->gs.xmit_tail, c);
+		memcpy_toio(port->board->base + CHAN_OFFSET(port, hi_txbuf) +
+			tx_ip, port->gs.xmit_buf + port->gs.xmit_tail, c);
 
 		/* Update the pointer in the card */
-		sx_write_channel_byte (port, hi_txipos, (tx_ip+c) & 0xff);
+		sx_write_channel_byte(port, hi_txipos, (tx_ip + c) & 0xff);
 
 		/* Update the kernel buffer end */
-		port->gs.xmit_tail = (port->gs.xmit_tail + c) & (SERIAL_XMIT_SIZE-1);
+		port->gs.xmit_tail = (port->gs.xmit_tail + c) &
+				(SERIAL_XMIT_SIZE - 1);
 
 		/* This one last. (this is essential)
-		   It would allow others to start putting more data into the buffer! */
+		   It would allow others to start putting more data into the
+		   buffer! */
 		port->gs.xmit_cnt -= c;
 	}
 
 	if (port->gs.xmit_cnt == 0) {
-		sx_disable_tx_interrupts (port);
+		sx_disable_tx_interrupts(port);
 	}
 
 	if ((port->gs.xmit_cnt <= port->gs.wakeup_chars) && port->gs.tty) {
 		tty_wakeup(port->gs.tty);
-		sx_dprintk (SX_DEBUG_TRANSMIT, "Waking up.... ldisc (%d)....\n",
-		            port->gs.wakeup_chars); 
+		sx_dprintk(SX_DEBUG_TRANSMIT, "Waking up.... ldisc (%d)....\n",
+				port->gs.wakeup_chars);
 	}
 
-	clear_bit (SX_PORT_TRANSMIT_LOCK, &port->locks);
-	func_exit ();
+	clear_bit(SX_PORT_TRANSMIT_LOCK, &port->locks);
+	func_exit();
 }
 
-
 /* Note the symmetry between receiving chars and transmitting them!
    Note: The kernel should have implemented both a receive buffer and
    a transmit buffer. */
 
 /* Inlined: Called only once. Remove the inline when you add another call */
-static inline void sx_receive_chars (struct sx_port *port)
+static inline void sx_receive_chars(struct sx_port *port)
 {
 	int c;
 	int rx_op;
 	struct tty_struct *tty;
-	int copied=0;
+	int copied = 0;
 	unsigned char *rp;
 
-	func_enter2 ();
+	func_enter2();
 	tty = port->gs.tty;
 	while (1) {
-		rx_op = sx_read_channel_byte (port, hi_rxopos);
-		c = (sx_read_channel_byte (port, hi_rxipos) - rx_op) & 0xff;
+		rx_op = sx_read_channel_byte(port, hi_rxopos);
+		c = (sx_read_channel_byte(port, hi_rxipos) - rx_op) & 0xff;
 
-		sx_dprintk (SX_DEBUG_RECEIVE, "rxop=%d, c = %d.\n", rx_op, c); 
+		sx_dprintk(SX_DEBUG_RECEIVE, "rxop=%d, c = %d.\n", rx_op, c);
 
 		/* Don't copy past the end of the hardware receive buffer */
-		if (rx_op + c > 0x100) c = 0x100 - rx_op;
+		if (rx_op + c > 0x100)
+			c = 0x100 - rx_op;
 
-		sx_dprintk (SX_DEBUG_RECEIVE, "c = %d.\n", c);
+		sx_dprintk(SX_DEBUG_RECEIVE, "c = %d.\n", c);
 
 		/* Don't copy more bytes than there is room for in the buffer */
 
 		c = tty_prepare_flip_string(tty, &rp, c);
 
-		sx_dprintk (SX_DEBUG_RECEIVE, "c = %d.\n", c); 
+		sx_dprintk(SX_DEBUG_RECEIVE, "c = %d.\n", c);
 
 		/* If for one reason or another, we can't copy more data, we're done! */
-		if (c == 0) break;
+		if (c == 0)
+			break;
 
-		sx_dprintk (SX_DEBUG_RECEIVE , "Copying over %d chars. First is %d at %lx\n", c, 
-		            read_sx_byte (port->board, CHAN_OFFSET(port,hi_rxbuf) + rx_op),
-		            CHAN_OFFSET(port, hi_rxbuf)); 
-		memcpy_fromio (rp,
-		               port->board->base + CHAN_OFFSET(port,hi_rxbuf) + rx_op, c);
+		sx_dprintk(SX_DEBUG_RECEIVE, "Copying over %d chars. First is "
+				"%d at %lx\n", c, read_sx_byte(port->board,
+					CHAN_OFFSET(port, hi_rxbuf) + rx_op),
+				CHAN_OFFSET(port, hi_rxbuf));
+		memcpy_fromio(rp, port->board->base +
+				CHAN_OFFSET(port, hi_rxbuf) + rx_op, c);
 
 		/* This one last. ( Not essential.)
-		   It allows the card to start putting more data into the buffer! 
+		   It allows the card to start putting more data into the
+		   buffer! 
 		   Update the pointer in the card */
-		sx_write_channel_byte (port, hi_rxopos, (rx_op + c) & 0xff);
+		sx_write_channel_byte(port, hi_rxopos, (rx_op + c) & 0xff);
 
 		copied += c;
 	}
 	if (copied) {
 		struct timeval tv;
 
-		do_gettimeofday (&tv);
-		sx_dprintk (SX_DEBUG_RECEIVE, 
-		            "pushing flipq port %d (%3d chars): %d.%06d  (%d/%d)\n", 
-		            port->line, copied, 
-		            (int) (tv.tv_sec % 60), (int)tv.tv_usec, tty->raw, tty->real_raw);
+		do_gettimeofday(&tv);
+		sx_dprintk(SX_DEBUG_RECEIVE, "pushing flipq port %d (%3d "
+				"chars): %d.%06d  (%d/%d)\n", port->line,
+				copied, (int)(tv.tv_sec % 60), (int)tv.tv_usec,
+				tty->raw, tty->real_raw);
 
-		/* Tell the rest of the system the news. Great news. New characters! */
-		tty_flip_buffer_push (tty);
+		/* Tell the rest of the system the news. Great news. New 
+		   characters! */
+		tty_flip_buffer_push(tty);
 		/*    tty_schedule_flip (tty); */
 	}
 
-	func_exit ();
+	func_exit();
 }
 
 /* Inlined: it is called only once. Remove the inline if you add another 
    call */
-static inline void sx_check_modem_signals (struct sx_port *port)
+static inline void sx_check_modem_signals(struct sx_port *port)
 {
 	int hi_state;
 	int c_dcd;
 
-	hi_state = sx_read_channel_byte (port, hi_state);
-	sx_dprintk (SX_DEBUG_MODEMSIGNALS, "Checking modem signals (%d/%d)\n",
-	            port->c_dcd, sx_get_CD (port));
+	hi_state = sx_read_channel_byte(port, hi_state);
+	sx_dprintk(SX_DEBUG_MODEMSIGNALS, "Checking modem signals (%d/%d)\n",
+			port->c_dcd, sx_get_CD(port));
 
 	if (hi_state & ST_BREAK) {
 		hi_state &= ~ST_BREAK;
-		sx_dprintk (SX_DEBUG_MODEMSIGNALS, "got a break.\n");
-		sx_write_channel_byte (port, hi_state, hi_state);
-		gs_got_break (&port->gs);
+		sx_dprintk(SX_DEBUG_MODEMSIGNALS, "got a break.\n");
+		sx_write_channel_byte(port, hi_state, hi_state);
+		gs_got_break(&port->gs);
 	}
 	if (hi_state & ST_DCD) {
 		hi_state &= ~ST_DCD;
-		sx_dprintk (SX_DEBUG_MODEMSIGNALS, "got a DCD change.\n");
-		sx_write_channel_byte (port, hi_state, hi_state);
-		c_dcd = sx_get_CD (port);
-		sx_dprintk (SX_DEBUG_MODEMSIGNALS, "DCD is now %d\n", c_dcd);
+		sx_dprintk(SX_DEBUG_MODEMSIGNALS, "got a DCD change.\n");
+		sx_write_channel_byte(port, hi_state, hi_state);
+		c_dcd = sx_get_CD(port);
+		sx_dprintk(SX_DEBUG_MODEMSIGNALS, "DCD is now %d\n", c_dcd);
 		if (c_dcd != port->c_dcd) {
 			port->c_dcd = c_dcd;
-			if (sx_get_CD (port)) {
+			if (sx_get_CD(port)) {
 				/* DCD went UP */
-				if ((sx_read_channel_byte(port, hi_hstat) != HS_IDLE_CLOSED) &&
-						!(port->gs.tty->termios->c_cflag & CLOCAL) ) {
-					/* Are we blocking in open?*/
-					sx_dprintk (SX_DEBUG_MODEMSIGNALS, "DCD active, unblocking open\n");
-					wake_up_interruptible(&port->gs.open_wait);
+				if ((sx_read_channel_byte(port, hi_hstat) !=
+						HS_IDLE_CLOSED) &&
+						!(port->gs.tty->termios->
+							c_cflag & CLOCAL)) {
+					/* Are we blocking in open? */
+					sx_dprintk(SX_DEBUG_MODEMSIGNALS, "DCD "
+						"active, unblocking open\n");
+					wake_up_interruptible(&port->gs.
+							open_wait);
 				} else {
-					sx_dprintk (SX_DEBUG_MODEMSIGNALS, "DCD raised. Ignoring.\n");
+					sx_dprintk(SX_DEBUG_MODEMSIGNALS, "DCD "
+						"raised. Ignoring.\n");
 				}
 			} else {
 				/* DCD went down! */
-				if (!(port->gs.tty->termios->c_cflag & CLOCAL) ) {
-					sx_dprintk (SX_DEBUG_MODEMSIGNALS, "DCD dropped. hanging up....\n");
-					tty_hangup (port->gs.tty);
+				if (!(port->gs.tty->termios->c_cflag & CLOCAL)){
+					sx_dprintk(SX_DEBUG_MODEMSIGNALS, "DCD "
+						"dropped. hanging up....\n");
+					tty_hangup(port->gs.tty);
 				} else {
-					sx_dprintk (SX_DEBUG_MODEMSIGNALS, "DCD dropped. ignoring.\n");
+					sx_dprintk(SX_DEBUG_MODEMSIGNALS, "DCD "
+						"dropped. ignoring.\n");
 				}
 			}
 		} else {
-			sx_dprintk (SX_DEBUG_MODEMSIGNALS, "Hmmm. card told us DCD changed, but it didn't.\n");
+			sx_dprintk(SX_DEBUG_MODEMSIGNALS, "Hmmm. card told us "
+				"DCD changed, but it didn't.\n");
 		}
 	}
 }
 
-
 /* This is what an interrupt routine should look like. 
  * Small, elegant, clear.
  */
 
-static irqreturn_t sx_interrupt (int irq, void *ptr)
+static irqreturn_t sx_interrupt(int irq, void *ptr)
 {
 	struct sx_board *board = ptr;
 	struct sx_port *port;
 	int i;
 
-	func_enter ();
-	sx_dprintk (SX_DEBUG_FLOW, "sx: enter sx_interrupt (%d/%d)\n", irq, board->irq); 
+	func_enter();
+	sx_dprintk(SX_DEBUG_FLOW, "sx: enter sx_interrupt (%d/%d)\n", irq,
+			board->irq);
 
 	/* AAargh! The order in which to do these things is essential and
 	   not trivial. 
 
 	   - Rate limit goes before "recursive". Otherwise a series of
-	     recursive calls will hang the machine in the interrupt routine. 
+	   recursive calls will hang the machine in the interrupt routine. 
 
 	   - hardware twiddling goes before "recursive". Otherwise when we
-	     poll the card, and a recursive interrupt happens, we won't
-	     ack the card, so it might keep on interrupting us. (especially
-	     level sensitive interrupt systems like PCI).
+	   poll the card, and a recursive interrupt happens, we won't
+	   ack the card, so it might keep on interrupting us. (especially
+	   level sensitive interrupt systems like PCI).
 
 	   - Rate limit goes before hardware twiddling. Otherwise we won't
-	     catch a card that has gone bonkers.
+	   catch a card that has gone bonkers.
 
 	   - The "initialized" test goes after the hardware twiddling. Otherwise
-	     the card will stick us in the interrupt routine again.
+	   the card will stick us in the interrupt routine again.
 
 	   - The initialized test goes before recursive. 
-	*/
-
-
+	 */
 
 #ifdef IRQ_RATE_LIMIT
 	/* Aaargh! I'm ashamed. This costs more lines-of-code than the
-	   actual interrupt routine!. (Well, used to when I wrote that comment) */
+	   actual interrupt routine!. (Well, used to when I wrote that
+	   comment) */
 	{
 		static int lastjif;
-		static int nintr=0;
+		static int nintr = 0;
 
 		if (lastjif == jiffies) {
 			if (++nintr > IRQ_RATE_LIMIT) {
-				free_irq (board->irq, board);
-				printk (KERN_ERR "sx: Too many interrupts. Turning off interrupt %d.\n", 
-					      board->irq);
+				free_irq(board->irq, board);
+				printk(KERN_ERR "sx: Too many interrupts. "
+						"Turning off interrupt %d.\n",
+						board->irq);
 			}
 		} else {
 			lastjif = jiffies;
@@ -1237,19 +1293,20 @@ #ifdef IRQ_RATE_LIMIT
 	}
 #endif
 
-
 	if (board->irq == irq) {
 		/* Tell the card we've noticed the interrupt. */
 
-		sx_write_board_word (board, cc_int_pending, 0);
-		if (IS_SX_BOARD (board)) {
-			write_sx_byte (board, SX_RESET_IRQ, 1);
+		sx_write_board_word(board, cc_int_pending, 0);
+		if (IS_SX_BOARD(board)) {
+			write_sx_byte(board, SX_RESET_IRQ, 1);
 		} else if (IS_EISA_BOARD(board)) {
-			inb(board->eisa_base+0xc03);
-			write_sx_word(board, 8, 0); 
+			inb(board->eisa_base + 0xc03);
+			write_sx_word(board, 8, 0);
 		} else {
-			write_sx_byte (board, SI2_ISA_INTCLEAR, SI2_ISA_INTCLEAR_CLEAR);
-			write_sx_byte (board, SI2_ISA_INTCLEAR, SI2_ISA_INTCLEAR_SET);
+			write_sx_byte(board, SI2_ISA_INTCLEAR,
+					SI2_ISA_INTCLEAR_CLEAR);
+			write_sx_byte(board, SI2_ISA_INTCLEAR,
+					SI2_ISA_INTCLEAR_SET);
 		}
 	}
 
@@ -1258,53 +1315,51 @@ #endif
 	if (!(board->flags & SX_BOARD_INITIALIZED))
 		return IRQ_HANDLED;
 
-	if (test_and_set_bit (SX_BOARD_INTR_LOCK, &board->locks)) {
-		printk (KERN_ERR "Recursive interrupt! (%d)\n", board->irq);
+	if (test_and_set_bit(SX_BOARD_INTR_LOCK, &board->locks)) {
+		printk(KERN_ERR "Recursive interrupt! (%d)\n", board->irq);
 		return IRQ_HANDLED;
 	}
 
-	 for (i=0;i<board->nports;i++) {
+	for (i = 0; i < board->nports; i++) {
 		port = &board->ports[i];
 		if (port->gs.flags & GS_ACTIVE) {
-			if (sx_read_channel_byte (port, hi_state)) {
-				sx_dprintk (SX_DEBUG_INTERRUPTS, 
-				            "Port %d: modem signal change?... \n", i);
-				sx_check_modem_signals (port); 
+			if (sx_read_channel_byte(port, hi_state)) {
+				sx_dprintk(SX_DEBUG_INTERRUPTS, "Port %d: "
+						"modem signal change?... \n",i);
+				sx_check_modem_signals(port);
 			}
 			if (port->gs.xmit_cnt) {
-				sx_transmit_chars (port);
+				sx_transmit_chars(port);
 			}
 			if (!(port->gs.flags & SX_RX_THROTTLE)) {
-				sx_receive_chars (port);
+				sx_receive_chars(port);
 			}
 		}
 	}
 
-	clear_bit (SX_BOARD_INTR_LOCK, &board->locks);
+	clear_bit(SX_BOARD_INTR_LOCK, &board->locks);
 
-	sx_dprintk (SX_DEBUG_FLOW, "sx: exit sx_interrupt (%d/%d)\n", irq, board->irq); 
-        func_exit ();
+	sx_dprintk(SX_DEBUG_FLOW, "sx: exit sx_interrupt (%d/%d)\n", irq,
+			board->irq);
+	func_exit();
 	return IRQ_HANDLED;
 }
 
-
-static void sx_pollfunc (unsigned long data)
+static void sx_pollfunc(unsigned long data)
 {
-	struct sx_board *board = (struct sx_board *) data;
+	struct sx_board *board = (struct sx_board *)data;
 
-	func_enter ();
+	func_enter();
 
-	sx_interrupt (0, board);
+	sx_interrupt(0, board);
 
 	init_timer(&board->timer);
 
 	board->timer.expires = jiffies + sx_poll;
-	add_timer (&board->timer);
-	func_exit ();
+	add_timer(&board->timer);
+	func_exit();
 }
 
-
-
 /* ********************************************************************** *
  *                Here are the routines that actually                     *
  *              interface with the generic_serial driver                  *
@@ -1313,9 +1368,9 @@ static void sx_pollfunc (unsigned long d
 /* Ehhm. I don't know how to fiddle with interrupts on the SX card. --REW */
 /* Hmm. Ok I figured it out. You don't.  */
 
-static void sx_disable_tx_interrupts (void * ptr) 
+static void sx_disable_tx_interrupts(void *ptr)
 {
-	struct sx_port *port = ptr; 
+	struct sx_port *port = ptr;
 	func_enter2();
 
 	port->gs.flags &= ~GS_TX_INTEN;
@@ -1323,30 +1378,28 @@ static void sx_disable_tx_interrupts (vo
 	func_exit();
 }
 
-
-static void sx_enable_tx_interrupts (void * ptr) 
+static void sx_enable_tx_interrupts(void *ptr)
 {
-	struct sx_port *port = ptr; 
+	struct sx_port *port = ptr;
 	int data_in_buffer;
 	func_enter2();
 
 	/* First transmit the characters that we're supposed to */
-	sx_transmit_chars (port);
+	sx_transmit_chars(port);
 
 	/* The sx card will never interrupt us if we don't fill the buffer
 	   past 25%. So we keep considering interrupts off if that's the case. */
-	data_in_buffer = (sx_read_channel_byte (port, hi_txipos) - 
-	                  sx_read_channel_byte (port, hi_txopos)) & 0xff;
+	data_in_buffer = (sx_read_channel_byte(port, hi_txipos) -
+			  sx_read_channel_byte(port, hi_txopos)) & 0xff;
 
 	/* XXX Must be "HIGH_WATER" for SI card according to doc. */
-	if (data_in_buffer < LOW_WATER) 
+	if (data_in_buffer < LOW_WATER)
 		port->gs.flags &= ~GS_TX_INTEN;
 
 	func_exit();
 }
 
-
-static void sx_disable_rx_interrupts (void * ptr) 
+static void sx_disable_rx_interrupts(void *ptr)
 {
 	/*  struct sx_port *port = ptr; */
 	func_enter();
@@ -1354,7 +1407,7 @@ static void sx_disable_rx_interrupts (vo
 	func_exit();
 }
 
-static void sx_enable_rx_interrupts (void * ptr) 
+static void sx_enable_rx_interrupts(void *ptr)
 {
 	/*  struct sx_port *port = ptr; */
 	func_enter();
@@ -1362,55 +1415,48 @@ static void sx_enable_rx_interrupts (voi
 	func_exit();
 }
 
-
 /* Jeez. Isn't this simple? */
-static int sx_get_CD (void * ptr) 
+static int sx_get_CD(void *ptr)
 {
 	struct sx_port *port = ptr;
 	func_enter2();
 
 	func_exit();
-	return ((sx_read_channel_byte (port, hi_ip) & IP_DCD) != 0);
+	return ((sx_read_channel_byte(port, hi_ip) & IP_DCD) != 0);
 }
 
-
 /* Jeez. Isn't this simple? */
-static int sx_chars_in_buffer (void * ptr) 
+static int sx_chars_in_buffer(void *ptr)
 {
 	struct sx_port *port = ptr;
 	func_enter2();
 
 	func_exit();
-	return ((sx_read_channel_byte (port, hi_txipos) - 
-	         sx_read_channel_byte (port, hi_txopos)) & 0xff);
+	return ((sx_read_channel_byte(port, hi_txipos) -
+		 sx_read_channel_byte(port, hi_txopos)) & 0xff);
 }
 
-
-static void sx_shutdown_port (void * ptr) 
+static void sx_shutdown_port(void *ptr)
 {
-	struct sx_port *port = ptr; 
+	struct sx_port *port = ptr;
 
 	func_enter();
 
-	port->gs.flags &= ~ GS_ACTIVE;
+	port->gs.flags &= ~GS_ACTIVE;
 	if (port->gs.tty && (port->gs.tty->termios->c_cflag & HUPCL)) {
-		sx_setsignals (port, 0, 0);
+		sx_setsignals(port, 0, 0);
 		sx_reconfigure_port(port);
 	}
 
 	func_exit();
 }
 
-
-
-
-
 /* ********************************************************************** *
  *                Here are the routines that actually                     *
  *               interface with the rest of the system                    *
  * ********************************************************************** */
 
-static int sx_open  (struct tty_struct * tty, struct file * filp)
+static int sx_open(struct tty_struct *tty, struct file *filp)
 {
 	struct sx_port *port;
 	int retval, line;
@@ -1423,18 +1469,18 @@ static int sx_open  (struct tty_struct *
 	}
 
 	line = tty->index;
-	sx_dprintk (SX_DEBUG_OPEN, "%d: opening line %d. tty=%p ctty=%p, np=%d)\n", 
-	            current->pid, line, tty, current->signal->tty, sx_nports);
+	sx_dprintk(SX_DEBUG_OPEN, "%d: opening line %d. tty=%p ctty=%p, "
+			"np=%d)\n", current->pid, line, tty,
+			current->signal->tty, sx_nports);
 
 	if ((line < 0) || (line >= SX_NPORTS) || (line >= sx_nports))
 		return -ENODEV;
 
-	port = & sx_ports[line];
+	port = &sx_ports[line];
 	port->c_dcd = 0; /* Make sure that the first interrupt doesn't detect a
-	                    1 -> 0 transition. */
-
+			    1 -> 0 transition. */
 
-	sx_dprintk (SX_DEBUG_OPEN, "port = %p c_dcd = %d\n", port, port->c_dcd);
+	sx_dprintk(SX_DEBUG_OPEN, "port = %p c_dcd = %d\n", port, port->c_dcd);
 
 	spin_lock_irqsave(&port->gs.driver_lock, flags);
 
@@ -1443,13 +1489,13 @@ static int sx_open  (struct tty_struct *
 	port->gs.count++;
 	spin_unlock_irqrestore(&port->gs.driver_lock, flags);
 
-	sx_dprintk (SX_DEBUG_OPEN, "starting port\n");
+	sx_dprintk(SX_DEBUG_OPEN, "starting port\n");
 
 	/*
 	 * Start up serial port
 	 */
 	retval = gs_init_port(&port->gs);
-	sx_dprintk (SX_DEBUG_OPEN, "done gs_init\n");
+	sx_dprintk(SX_DEBUG_OPEN, "done gs_init\n");
 	if (retval) {
 		port->gs.count--;
 		return retval;
@@ -1457,19 +1503,20 @@ static int sx_open  (struct tty_struct *
 
 	port->gs.flags |= GS_ACTIVE;
 	if (port->gs.count <= 1)
-		sx_setsignals (port, 1,1);
+		sx_setsignals(port, 1, 1);
 
 #if 0
 	if (sx_debug & SX_DEBUG_OPEN)
-		my_hd (port, sizeof (*port));
+		my_hd(port, sizeof(*port));
 #else
 	if (sx_debug & SX_DEBUG_OPEN)
-		my_hd_io (port->board->base + port->ch_base, sizeof (*port));
+		my_hd_io(port->board->base + port->ch_base, sizeof(*port));
 #endif
 
 	if (port->gs.count <= 1) {
-		if (sx_send_command (port, HS_LOPEN, -1, HS_IDLE_OPEN) != 1) {
-			printk (KERN_ERR "sx: Card didn't respond to LOPEN command.\n");
+		if (sx_send_command(port, HS_LOPEN, -1, HS_IDLE_OPEN) != 1) {
+			printk(KERN_ERR "sx: Card didn't respond to LOPEN "
+					"command.\n");
 			spin_lock_irqsave(&port->gs.driver_lock, flags);
 			port->gs.count--;
 			spin_unlock_irqrestore(&port->gs.driver_lock, flags);
@@ -1478,75 +1525,76 @@ #endif
 	}
 
 	retval = gs_block_til_ready(port, filp);
-	sx_dprintk (SX_DEBUG_OPEN, "Block til ready returned %d. Count=%d\n", 
-	            retval, port->gs.count);
+	sx_dprintk(SX_DEBUG_OPEN, "Block til ready returned %d. Count=%d\n",
+			retval, port->gs.count);
 
 	if (retval) {
-		/* 
-		 * Don't lower gs.count here because sx_close() will be called later
-		 */ 
+/* 
+ * Don't lower gs.count here because sx_close() will be called later
+ */
 
 		return retval;
 	}
 	/* tty->low_latency = 1; */
 
-	port->c_dcd = sx_get_CD (port);
-	sx_dprintk (SX_DEBUG_OPEN, "at open: cd=%d\n", port->c_dcd);
+	port->c_dcd = sx_get_CD(port);
+	sx_dprintk(SX_DEBUG_OPEN, "at open: cd=%d\n", port->c_dcd);
 
 	func_exit();
 	return 0;
 
 }
 
-
-static void sx_close (void *ptr)
+static void sx_close(void *ptr)
 {
-	struct sx_port *port = ptr; 
+	struct sx_port *port = ptr;
 	/* Give the port 5 seconds to close down. */
-	int to = 5 * HZ; 
+	int to = 5 * HZ;
 
-	func_enter ();
+	func_enter();
 
-	sx_setsignals (port, 0, 0);
-	sx_reconfigure_port(port);	
-	sx_send_command (port, HS_CLOSE, 0, 0);
+	sx_setsignals(port, 0, 0);
+	sx_reconfigure_port(port);
+	sx_send_command(port, HS_CLOSE, 0, 0);
 
-	while (to-- && (sx_read_channel_byte (port, hi_hstat) != HS_IDLE_CLOSED))
+	while (to-- && (sx_read_channel_byte(port, hi_hstat) != HS_IDLE_CLOSED))
 		if (msleep_interruptible(10))
 			break;
-	if (sx_read_channel_byte (port, hi_hstat) != HS_IDLE_CLOSED) {
-		if (sx_send_command (port, HS_FORCE_CLOSED, -1, HS_IDLE_CLOSED) != 1) {
-			printk (KERN_ERR 
-			        "sx: sent the force_close command, but card didn't react\n");
+	if (sx_read_channel_byte(port, hi_hstat) != HS_IDLE_CLOSED) {
+		if (sx_send_command(port, HS_FORCE_CLOSED, -1, HS_IDLE_CLOSED)
+				!= 1) {
+			printk(KERN_ERR "sx: sent the force_close command, but "
+					"card didn't react\n");
 		} else
-			sx_dprintk (SX_DEBUG_CLOSE, "sent the force_close command.\n");
+			sx_dprintk(SX_DEBUG_CLOSE, "sent the force_close "
+					"command.\n");
 	}
 
-	sx_dprintk (SX_DEBUG_CLOSE, "waited %d jiffies for close. count=%d\n", 
-	            5 * HZ - to - 1, port->gs.count);
+	sx_dprintk(SX_DEBUG_CLOSE, "waited %d jiffies for close. count=%d\n",
+			5 * HZ - to - 1, port->gs.count);
 
-	if(port->gs.count) {
-		sx_dprintk(SX_DEBUG_CLOSE, "WARNING port count:%d\n", port->gs.count);
-		//printk ("%s SETTING port count to zero: %p count: %d\n", __FUNCTION__, port, port->gs.count);
-		//port->gs.count = 0;
+	if (port->gs.count) {
+		sx_dprintk(SX_DEBUG_CLOSE, "WARNING port count:%d\n",
+				port->gs.count);
+		/*printk("%s SETTING port count to zero: %p count: %d\n",
+				__FUNCTION__, port, port->gs.count);
+		port->gs.count = 0;*/
 	}
 
-	func_exit ();
+	func_exit();
 }
 
-
-
 /* This is relatively thorough. But then again it is only 20 lines. */
-#define MARCHUP    for (i=min;i<max;i++) 
-#define MARCHDOWN  for (i=max-1;i>=min;i--)
-#define W0         write_sx_byte (board, i, 0x55)
-#define W1         write_sx_byte (board, i, 0xaa)
-#define R0         if (read_sx_byte (board, i) != 0x55) return 1
-#define R1         if (read_sx_byte (board, i) != 0xaa) return 1
+#define MARCHUP		for (i = min; i < max; i++)
+#define MARCHDOWN	for (i = max - 1; i >= min; i--)
+#define W0		write_sx_byte(board, i, 0x55)
+#define W1		write_sx_byte(board, i, 0xaa)
+#define R0		if (read_sx_byte(board, i) != 0x55) return 1
+#define R1		if (read_sx_byte(board, i) != 0xaa) return 1
 
 /* This memtest takes a human-noticable time. You normally only do it
    once a boot, so I guess that it is worth it. */
-static int do_memtest (struct sx_board *board, int min, int max)
+static int do_memtest(struct sx_board *board, int min, int max)
 {
 	int i;
 
@@ -1555,16 +1603,37 @@ static int do_memtest (struct sx_board *
 	   intermittent errors. -- REW
 	   (For the theory behind memory testing see: 
 	   Testing Semiconductor Memories by A.J. van de Goor.) */
-	MARCHUP	 {W0;}
-	MARCHUP   {R0;W1;R1;W0;R0;W1;}
-	MARCHUP   {R1;W0;W1;}
-	MARCHDOWN {R1;W0;W1;W0;}
-	MARCHDOWN {R0;W1;W0;}
+	MARCHUP {
+		W0;
+	}
+	MARCHUP {
+		R0;
+		W1;
+		R1;
+		W0;
+		R0;
+		W1;
+	}
+	MARCHUP {
+		R1;
+		W0;
+		W1;
+	}
+	MARCHDOWN {
+		R1;
+		W0;
+		W1;
+		W0;
+	}
+	MARCHDOWN {
+		R0;
+		W1;
+		W0;
+	}
 
 	return 0;
 }
 
-
 #undef MARCHUP
 #undef MARCHDOWN
 #undef W0
@@ -1572,33 +1641,54 @@ #undef W1
 #undef R0
 #undef R1
 
-#define MARCHUP    for (i=min;i<max;i+=2) 
-#define MARCHDOWN  for (i=max-1;i>=min;i-=2)
-#define W0         write_sx_word (board, i, 0x55aa)
-#define W1         write_sx_word (board, i, 0xaa55)
-#define R0         if (read_sx_word (board, i) != 0x55aa) return 1
-#define R1         if (read_sx_word (board, i) != 0xaa55) return 1
+#define MARCHUP		for (i = min; i < max; i += 2)
+#define MARCHDOWN	for (i = max - 1; i >= min; i -= 2)
+#define W0		write_sx_word(board, i, 0x55aa)
+#define W1		write_sx_word(board, i, 0xaa55)
+#define R0		if (read_sx_word(board, i) != 0x55aa) return 1
+#define R1		if (read_sx_word(board, i) != 0xaa55) return 1
 
 #if 0
 /* This memtest takes a human-noticable time. You normally only do it
    once a boot, so I guess that it is worth it. */
-static int do_memtest_w (struct sx_board *board, int min, int max)
+static int do_memtest_w(struct sx_board *board, int min, int max)
 {
 	int i;
 
-	MARCHUP   {W0;}
-	MARCHUP   {R0;W1;R1;W0;R0;W1;}
-	MARCHUP   {R1;W0;W1;}
-	MARCHDOWN {R1;W0;W1;W0;}
-	MARCHDOWN {R0;W1;W0;}
+	MARCHUP {
+		W0;
+	}
+	MARCHUP {
+		R0;
+		W1;
+		R1;
+		W0;
+		R0;
+		W1;
+	}
+	MARCHUP {
+		R1;
+		W0;
+		W1;
+	}
+	MARCHDOWN {
+		R1;
+		W0;
+		W1;
+		W0;
+	}
+	MARCHDOWN {
+		R0;
+		W1;
+		W0;
+	}
 
 	return 0;
 }
 #endif
 
-
-static int sx_fw_ioctl (struct inode *inode, struct file *filp,
-                        unsigned int cmd, unsigned long arg)
+static int sx_fw_ioctl(struct inode *inode, struct file *filp,
+		unsigned int cmd, unsigned long arg)
 {
 	int rc = 0;
 	int __user *descr = (int __user *)arg;
@@ -1610,7 +1700,7 @@ static int sx_fw_ioctl (struct inode *in
 
 	func_enter();
 
-#if 0 
+#if 0
 	/* Removed superuser check: Sysops can use the permissions on the device
 	   file to restrict access. Recommendation: Root only. (root.root 600) */
 	if (!capable(CAP_SYS_ADMIN)) {
@@ -1618,103 +1708,115 @@ #if 0 
 	}
 #endif
 
-	sx_dprintk (SX_DEBUG_FIRMWARE, "IOCTL %x: %lx\n", cmd, arg);
+	sx_dprintk(SX_DEBUG_FIRMWARE, "IOCTL %x: %lx\n", cmd, arg);
 
-	if (!board) board = &boards[0];
+	if (!board)
+		board = &boards[0];
 	if (board->flags & SX_BOARD_PRESENT) {
-		sx_dprintk (SX_DEBUG_FIRMWARE, "Board present! (%x)\n", 
-		            board->flags);
+		sx_dprintk(SX_DEBUG_FIRMWARE, "Board present! (%x)\n",
+				board->flags);
 	} else {
-		sx_dprintk (SX_DEBUG_FIRMWARE, "Board not present! (%x) all:", 
-		            board->flags);
-		for (i=0;i< SX_NBOARDS;i++)
-			sx_dprintk (SX_DEBUG_FIRMWARE, "<%x> ", boards[i].flags);
-		sx_dprintk (SX_DEBUG_FIRMWARE, "\n");
+		sx_dprintk(SX_DEBUG_FIRMWARE, "Board not present! (%x) all:",
+				board->flags);
+		for (i = 0; i < SX_NBOARDS; i++)
+			sx_dprintk(SX_DEBUG_FIRMWARE, "<%x> ", boards[i].flags);
+		sx_dprintk(SX_DEBUG_FIRMWARE, "\n");
 		return -EIO;
 	}
 
 	switch (cmd) {
 	case SXIO_SET_BOARD:
-		sx_dprintk (SX_DEBUG_FIRMWARE, "set board to %ld\n", arg);
-		if (arg >= SX_NBOARDS) return -EIO;
-		sx_dprintk (SX_DEBUG_FIRMWARE, "not out of range\n");
-		if (!(boards[arg].flags	& SX_BOARD_PRESENT)) return -EIO;
-		sx_dprintk (SX_DEBUG_FIRMWARE, ".. and present!\n");
+		sx_dprintk(SX_DEBUG_FIRMWARE, "set board to %ld\n", arg);
+		if (arg >= SX_NBOARDS)
+			return -EIO;
+		sx_dprintk(SX_DEBUG_FIRMWARE, "not out of range\n");
+		if (!(boards[arg].flags & SX_BOARD_PRESENT))
+			return -EIO;
+		sx_dprintk(SX_DEBUG_FIRMWARE, ".. and present!\n");
 		board = &boards[arg];
 		break;
 	case SXIO_GET_TYPE:
-		rc = -ENOENT; /* If we manage to miss one, return error. */
-		if (IS_SX_BOARD (board)) rc = SX_TYPE_SX;
-		if (IS_CF_BOARD (board)) rc = SX_TYPE_CF;
-		if (IS_SI_BOARD (board)) rc = SX_TYPE_SI;
-		if (IS_SI1_BOARD (board)) rc = SX_TYPE_SI;
-		if (IS_EISA_BOARD (board)) rc = SX_TYPE_SI;
-		sx_dprintk (SX_DEBUG_FIRMWARE, "returning type= %d\n", rc);
+		rc = -ENOENT;	/* If we manage to miss one, return error. */
+		if (IS_SX_BOARD(board))
+			rc = SX_TYPE_SX;
+		if (IS_CF_BOARD(board))
+			rc = SX_TYPE_CF;
+		if (IS_SI_BOARD(board))
+			rc = SX_TYPE_SI;
+		if (IS_SI1_BOARD(board))
+			rc = SX_TYPE_SI;
+		if (IS_EISA_BOARD(board))
+			rc = SX_TYPE_SI;
+		sx_dprintk(SX_DEBUG_FIRMWARE, "returning type= %d\n", rc);
 		break;
 	case SXIO_DO_RAMTEST:
-		if (sx_initialized) /* Already initialized: better not ramtest the board.  */
+		if (sx_initialized)	/* Already initialized: better not ramtest the board.  */
 			return -EPERM;
-		if (IS_SX_BOARD (board)) {
-			rc          = do_memtest   (board, 0, 0x7000);
-			if (!rc) rc = do_memtest   (board, 0, 0x7000);
-			/*if (!rc) rc = do_memtest_w (board, 0, 0x7000);*/
+		if (IS_SX_BOARD(board)) {
+			rc = do_memtest(board, 0, 0x7000);
+			if (!rc)
+				rc = do_memtest(board, 0, 0x7000);
+			/*if (!rc) rc = do_memtest_w (board, 0, 0x7000); */
 		} else {
-			rc             = do_memtest   (board, 0, 0x7ff8);
+			rc = do_memtest(board, 0, 0x7ff8);
 			/* if (!rc) rc = do_memtest_w (board, 0, 0x7ff8); */
 		}
-		sx_dprintk (SX_DEBUG_FIRMWARE, "returning memtest result= %d\n", rc);
+		sx_dprintk(SX_DEBUG_FIRMWARE, "returning memtest result= %d\n",
+			   rc);
 		break;
 	case SXIO_DOWNLOAD:
-		if (sx_initialized) /* Already initialized */
+		if (sx_initialized)	/* Already initialized */
 			return -EEXIST;
-		if (!sx_reset (board)) 
+		if (!sx_reset(board))
 			return -EIO;
-		sx_dprintk (SX_DEBUG_INIT, "reset the board...\n");
-
-		tmp = kmalloc (SX_CHUNK_SIZE, GFP_USER);
-		if (!tmp) return -ENOMEM;
-		get_user (nbytes, descr++);
-		get_user (offset, descr++); 
-		get_user (data,	 descr++);
+		sx_dprintk(SX_DEBUG_INIT, "reset the board...\n");
+
+		tmp = kmalloc(SX_CHUNK_SIZE, GFP_USER);
+		if (!tmp)
+			return -ENOMEM;
+		get_user(nbytes, descr++);
+		get_user(offset, descr++);
+		get_user(data, descr++);
 		while (nbytes && data) {
-			for (i=0;i<nbytes;i += SX_CHUNK_SIZE) {
-				if (copy_from_user(tmp, (char __user *)data+i, 
-						   (i + SX_CHUNK_SIZE >
-						    nbytes) ? nbytes - i :
-						   	      SX_CHUNK_SIZE)) {
-					kfree (tmp);
+			for (i = 0; i < nbytes; i += SX_CHUNK_SIZE) {
+				if (copy_from_user(tmp, (char __user *)data + i,
+						(i + SX_CHUNK_SIZE > nbytes) ?
+						nbytes - i : SX_CHUNK_SIZE)) {
+					kfree(tmp);
 					return -EFAULT;
 				}
-				memcpy_toio(board->base2 + offset + i, tmp, 
-				                (i+SX_CHUNK_SIZE>nbytes)?nbytes-i:SX_CHUNK_SIZE);
+				memcpy_toio(board->base2 + offset + i, tmp,
+						(i + SX_CHUNK_SIZE > nbytes) ?
+						nbytes - i : SX_CHUNK_SIZE);
 			}
 
-			get_user (nbytes, descr++);
-			get_user (offset, descr++); 
-			get_user (data,   descr++);
+			get_user(nbytes, descr++);
+			get_user(offset, descr++);
+			get_user(data, descr++);
 		}
-		kfree (tmp);
-		sx_nports += sx_init_board (board);
+		kfree(tmp);
+		sx_nports += sx_init_board(board);
 		rc = sx_nports;
 		break;
 	case SXIO_INIT:
-		if (sx_initialized) /* Already initialized */
+		if (sx_initialized)	/* Already initialized */
 			return -EEXIST;
 		/* This is not allowed until all boards are initialized... */
-		for (i=0;i<SX_NBOARDS;i++) {
-			if ( (boards[i].flags & SX_BOARD_PRESENT) &&
-			     !(boards[i].flags & SX_BOARD_INITIALIZED))
+		for (i = 0; i < SX_NBOARDS; i++) {
+			if ((boards[i].flags & SX_BOARD_PRESENT) &&
+				!(boards[i].flags & SX_BOARD_INITIALIZED))
 				return -EIO;
 		}
-		for (i=0;i<SX_NBOARDS;i++)
-			if (!(boards[i].flags & SX_BOARD_PRESENT)) break;
-
-		sx_dprintk (SX_DEBUG_FIRMWARE, "initing portstructs, %d boards, "
-		            "%d channels, first board: %d ports\n", 
-		            i, sx_nports, boards[0].nports);
-		rc = sx_init_portstructs (i, sx_nports);
-		sx_init_drivers ();
-		if (rc >= 0) 
+		for (i = 0; i < SX_NBOARDS; i++)
+			if (!(boards[i].flags & SX_BOARD_PRESENT))
+				break;
+
+		sx_dprintk(SX_DEBUG_FIRMWARE, "initing portstructs, %d boards, "
+				"%d channels, first board: %d ports\n",
+				i, sx_nports, boards[0].nports);
+		rc = sx_init_portstructs(i, sx_nports);
+		sx_init_drivers();
+		if (rc >= 0)
 			sx_initialized++;
 		break;
 	case SXIO_SETDEBUG:
@@ -1731,32 +1833,32 @@ #endif
 		rc = sx_nports;
 		break;
 	default:
-		printk (KERN_WARNING "Unknown ioctl on firmware device (%x).\n", cmd);
+		printk(KERN_WARNING "Unknown ioctl on firmware device (%x).\n",
+				cmd);
 		break;
 	}
-	func_exit ();
+	func_exit();
 	return rc;
 }
 
-
-static void sx_break (struct tty_struct * tty, int flag)
+static void sx_break(struct tty_struct *tty, int flag)
 {
 	struct sx_port *port = tty->driver_data;
 	int rv;
 
-	func_enter ();
+	func_enter();
 
-	if (flag) 
-		rv = sx_send_command (port, HS_START, -1, HS_IDLE_BREAK);
-	else 
-		rv = sx_send_command (port, HS_STOP, -1, HS_IDLE_OPEN);
-	if (rv != 1) printk (KERN_ERR "sx: couldn't send break (%x).\n",
-			read_sx_byte (port->board, CHAN_OFFSET (port, hi_hstat)));
+	if (flag)
+		rv = sx_send_command(port, HS_START, -1, HS_IDLE_BREAK);
+	else
+		rv = sx_send_command(port, HS_STOP, -1, HS_IDLE_OPEN);
+	if (rv != 1)
+		printk(KERN_ERR "sx: couldn't send break (%x).\n",
+			read_sx_byte(port->board, CHAN_OFFSET(port, hi_hstat)));
 
-	func_exit ();
+	func_exit();
 }
 
-
 static int sx_tiocmget(struct tty_struct *tty, struct file *file)
 {
 	struct sx_port *port = tty->driver_data;
@@ -1764,7 +1866,7 @@ static int sx_tiocmget(struct tty_struct
 }
 
 static int sx_tiocmset(struct tty_struct *tty, struct file *file,
-		       unsigned int set, unsigned int clear)
+		unsigned int set, unsigned int clear)
 {
 	struct sx_port *port = tty->driver_data;
 	int rts = -1, dtr = -1;
@@ -1783,8 +1885,8 @@ static int sx_tiocmset(struct tty_struct
 	return 0;
 }
 
-static int sx_ioctl (struct tty_struct * tty, struct file * filp, 
-                     unsigned int cmd, unsigned long arg)
+static int sx_ioctl(struct tty_struct *tty, struct file *filp,
+		unsigned int cmd, unsigned long arg)
 {
 	int rc;
 	struct sx_port *port = tty->driver_data;
@@ -1797,10 +1899,10 @@ static int sx_ioctl (struct tty_struct *
 	switch (cmd) {
 	case TIOCGSOFTCAR:
 		rc = put_user(((tty->termios->c_cflag & CLOCAL) ? 1 : 0),
-		              (unsigned __user *) argp);
+				(unsigned __user *)argp);
 		break;
 	case TIOCSSOFTCAR:
-		if ((rc = get_user(ival, (unsigned __user *) argp)) == 0) {
+		if ((rc = get_user(ival, (unsigned __user *)argp)) == 0) {
 			tty->termios->c_cflag =
 				(tty->termios->c_cflag & ~CLOCAL) |
 				(ival ? CLOCAL : 0);
@@ -1821,7 +1923,6 @@ static int sx_ioctl (struct tty_struct *
 	return rc;
 }
 
-
 /* The throttle/unthrottle scheme for the Specialix card is different
  * from other drivers and deserves some explanation. 
  * The Specialix hardware takes care of XON/XOFF
@@ -1838,7 +1939,7 @@ static int sx_ioctl (struct tty_struct *
  * flow control scheme is in use for that port. -- Simon Allen
  */
 
-static void sx_throttle (struct tty_struct * tty)
+static void sx_throttle(struct tty_struct *tty)
 {
 	struct sx_port *port = (struct sx_port *)tty->driver_data;
 
@@ -1846,14 +1947,13 @@ static void sx_throttle (struct tty_stru
 	/* If the port is using any type of input flow
 	 * control then throttle the port.
 	 */
-	if((tty->termios->c_cflag & CRTSCTS) || (I_IXOFF(tty)) ) {
+	if ((tty->termios->c_cflag & CRTSCTS) || (I_IXOFF(tty))) {
 		port->gs.flags |= SX_RX_THROTTLE;
 	}
 	func_exit();
 }
 
-
-static void sx_unthrottle (struct tty_struct * tty)
+static void sx_unthrottle(struct tty_struct *tty)
 {
 	struct sx_port *port = (struct sx_port *)tty->driver_data;
 
@@ -1867,15 +1967,11 @@ static void sx_unthrottle (struct tty_st
 	return;
 }
 
-
 /* ********************************************************************** *
  *                    Here are the initialization routines.               *
  * ********************************************************************** */
 
-
-
-
-static int sx_init_board (struct sx_board *board)
+static int sx_init_board(struct sx_board *board)
 {
 	int addr;
 	int chans;
@@ -1887,36 +1983,38 @@ static int sx_init_board (struct sx_boar
 
 	board->flags |= SX_BOARD_INITIALIZED;
 
-	if (read_sx_byte (board, 0))
+	if (read_sx_byte(board, 0))
 		/* CF boards may need this. */
-		write_sx_byte(board,0, 0);
+		write_sx_byte(board, 0, 0);
 
 	/* This resets the processor again, to make sure it didn't do any
 	   foolish things while we were downloading the image */
-	if (!sx_reset (board))
+	if (!sx_reset(board))
 		return 0;
 
-	sx_start_board (board);
-	udelay (10);
-	if (!sx_busy_wait_neq (board, 0, 0xff, 0)) {
-		printk (KERN_ERR "sx: Ooops. Board won't initialize.\n");
+	sx_start_board(board);
+	udelay(10);
+	if (!sx_busy_wait_neq(board, 0, 0xff, 0)) {
+		printk(KERN_ERR "sx: Ooops. Board won't initialize.\n");
 		return 0;
 	}
 
 	/* Ok. So now the processor on the card is running. It gathered
 	   some info for us... */
-	sx_dprintk (SX_DEBUG_INIT, "The sxcard structure:\n");
-	if (sx_debug & SX_DEBUG_INIT) my_hd_io (board->base, 0x10);
-	sx_dprintk (SX_DEBUG_INIT, "the first sx_module structure:\n");
-	if (sx_debug & SX_DEBUG_INIT) my_hd_io (board->base + 0x80, 0x30);
-
-	sx_dprintk (SX_DEBUG_INIT, 
-	            "init_status: %x, %dk memory, firmware V%x.%02x,\n", 
-	            read_sx_byte (board, 0), read_sx_byte(board, 1), 
-	            read_sx_byte (board, 5), read_sx_byte(board, 4));
-
-	if (read_sx_byte (board, 0) == 0xff) {
-		printk (KERN_INFO "sx: No modules found. Sorry.\n");
+	sx_dprintk(SX_DEBUG_INIT, "The sxcard structure:\n");
+	if (sx_debug & SX_DEBUG_INIT)
+		my_hd_io(board->base, 0x10);
+	sx_dprintk(SX_DEBUG_INIT, "the first sx_module structure:\n");
+	if (sx_debug & SX_DEBUG_INIT)
+		my_hd_io(board->base + 0x80, 0x30);
+
+	sx_dprintk(SX_DEBUG_INIT, "init_status: %x, %dk memory, firmware "
+			"V%x.%02x,\n",
+			read_sx_byte(board, 0), read_sx_byte(board, 1),
+			read_sx_byte(board, 5), read_sx_byte(board, 4));
+
+	if (read_sx_byte(board, 0) == 0xff) {
+		printk(KERN_INFO "sx: No modules found. Sorry.\n");
 		board->nports = 0;
 		return 0;
 	}
@@ -1924,81 +2022,97 @@ static int sx_init_board (struct sx_boar
 	chans = 0;
 
 	if (IS_SX_BOARD(board)) {
-		sx_write_board_word (board, cc_int_count, sx_maxints);
+		sx_write_board_word(board, cc_int_count, sx_maxints);
 	} else {
 		if (sx_maxints)
-			sx_write_board_word (board, cc_int_count, SI_PROCESSOR_CLOCK/8/sx_maxints);
+			sx_write_board_word(board, cc_int_count,
+					SI_PROCESSOR_CLOCK / 8 / sx_maxints);
 	}
 
 	/* grab the first module type... */
-	/*  board->ta_type = mod_compat_type (read_sx_byte (board, 0x80 + 0x08)); */
-	board->ta_type = mod_compat_type (sx_read_module_byte (board, 0x80, mc_chip));
+	/* board->ta_type = mod_compat_type (read_sx_byte (board, 0x80 + 0x08)); */
+	board->ta_type = mod_compat_type(sx_read_module_byte(board, 0x80,
+				mc_chip));
 
 	/* XXX byteorder */
-	for (addr = 0x80;addr != 0;addr = read_sx_word (board, addr) & 0x7fff) {
-		type = sx_read_module_byte (board, addr, mc_chip);
-		sx_dprintk (SX_DEBUG_INIT, "Module at %x: %d channels\n", 
-		            addr, read_sx_byte (board, addr + 2));
-
-		chans += sx_read_module_byte (board, addr, mc_type);
-
-		sx_dprintk (SX_DEBUG_INIT, "module is an %s, which has %s/%s panels\n", 
-		            mod_type_s (type),
-		            pan_type_s (sx_read_module_byte (board, addr, mc_mods) & 0xf),
-		            pan_type_s (sx_read_module_byte (board, addr, mc_mods) >> 4));
-
-		sx_dprintk (SX_DEBUG_INIT, "CD1400 versions: %x/%x, ASIC version: %x\n", 
-		            sx_read_module_byte (board, addr, mc_rev1),
-		            sx_read_module_byte (board, addr, mc_rev2),
-		            sx_read_module_byte (board, addr, mc_mtaasic_rev));
+	for (addr = 0x80; addr != 0; addr = read_sx_word(board, addr) & 0x7fff){
+		type = sx_read_module_byte(board, addr, mc_chip);
+		sx_dprintk(SX_DEBUG_INIT, "Module at %x: %d channels\n",
+				addr, read_sx_byte(board, addr + 2));
+
+		chans += sx_read_module_byte(board, addr, mc_type);
+
+		sx_dprintk(SX_DEBUG_INIT, "module is an %s, which has %s/%s "
+				"panels\n",
+				mod_type_s(type),
+				pan_type_s(sx_read_module_byte(board, addr,
+						mc_mods) & 0xf),
+				pan_type_s(sx_read_module_byte(board, addr,
+						mc_mods) >> 4));
+
+		sx_dprintk(SX_DEBUG_INIT, "CD1400 versions: %x/%x, ASIC "
+			"version: %x\n",
+			sx_read_module_byte(board, addr, mc_rev1),
+			sx_read_module_byte(board, addr, mc_rev2),
+			sx_read_module_byte(board, addr, mc_mtaasic_rev));
 
 		/* The following combinations are illegal: It should theoretically
 		   work, but timing problems make the bus HANG. */
 
-		if (mod_compat_type (type) != board->ta_type) {
-			printk (KERN_ERR "sx: This is an invalid configuration.\n"
-			        "Don't mix TA/MTA/SXDC on the same hostadapter.\n");
-			chans=0;
+		if (mod_compat_type(type) != board->ta_type) {
+			printk(KERN_ERR "sx: This is an invalid "
+				"configuration.\nDon't mix TA/MTA/SXDC on the "
+				"same hostadapter.\n");
+			chans = 0;
 			break;
 		}
-		if ((IS_EISA_BOARD(board) || 
-		     IS_SI_BOARD(board)) && (mod_compat_type(type) == 4)) {
-			printk (KERN_ERR "sx: This is an invalid configuration.\n"
-			        "Don't use SXDCs on an SI/XIO adapter.\n");
-			chans=0;
+		if ((IS_EISA_BOARD(board) ||
+				IS_SI_BOARD(board)) &&
+				(mod_compat_type(type) == 4)) {
+			printk(KERN_ERR	"sx: This is an invalid "
+				"configuration.\nDon't use SXDCs on an SI/XIO "
+				"adapter.\n");
+			chans = 0;
 			break;
 		}
-#if 0 /* Problem fixed: firmware 3.05 */
+#if 0				/* Problem fixed: firmware 3.05 */
 		if (IS_SX_BOARD(board) && (type == TA8)) {
 			/* There are some issues with the firmware and the DCD/RTS
 			   lines. It might work if you tie them together or something.
-			   It might also work if you get a newer sx_firmware.	Therefore
+			   It might also work if you get a newer sx_firmware.   Therefore
 			   this is just a warning. */
-			printk (KERN_WARNING "sx: The SX host doesn't work too well "
-			        "with the TA8 adapters.\nSpecialix is working on it.\n");
+			printk(KERN_WARNING
+			       "sx: The SX host doesn't work too well "
+			       "with the TA8 adapters.\nSpecialix is working on it.\n");
 		}
 #endif
 	}
 
 	if (chans) {
-		if(board->irq > 0) {
+		if (board->irq > 0) {
 			/* fixed irq, probably PCI */
-			if(sx_irqmask & (1 << board->irq)) { /* may we use this irq? */
-				if(request_irq(board->irq, sx_interrupt, IRQF_SHARED | IRQF_DISABLED, "sx", board)) {
-					printk(KERN_ERR "sx: Cannot allocate irq %d.\n", board->irq);
+			if (sx_irqmask & (1 << board->irq)) {	/* may we use this irq? */
+				if (request_irq(board->irq, sx_interrupt,
+						IRQF_SHARED | IRQF_DISABLED,
+						"sx", board)) {
+					printk(KERN_ERR "sx: Cannot allocate "
+						"irq %d.\n", board->irq);
 					board->irq = 0;
 				}
 			} else
 				board->irq = 0;
-		} else if(board->irq < 0 && sx_irqmask) {
+		} else if (board->irq < 0 && sx_irqmask) {
 			/* auto-allocate irq */
 			int irqnr;
-			int irqmask = sx_irqmask & (IS_SX_BOARD(board) ? SX_ISA_IRQ_MASK : SI2_ISA_IRQ_MASK);
-			for(irqnr = 15; irqnr > 0; irqnr--)
-				if(irqmask & (1 << irqnr))
-					if(! request_irq(irqnr, sx_interrupt, IRQF_SHARED | IRQF_DISABLED, "sx", board))
+			int irqmask = sx_irqmask & (IS_SX_BOARD(board) ?
+					SX_ISA_IRQ_MASK : SI2_ISA_IRQ_MASK);
+			for (irqnr = 15; irqnr > 0; irqnr--)
+				if (irqmask & (1 << irqnr))
+					if (!request_irq(irqnr, sx_interrupt,
+						IRQF_SHARED | IRQF_DISABLED,
+						"sx", board))
 						break;
-			if(! irqnr)
+			if (!irqnr)
 				printk(KERN_ERR "sx: Cannot allocate IRQ.\n");
 			board->irq = irqnr;
 		} else
@@ -2006,52 +2120,52 @@ #endif
 
 		if (board->irq) {
 			/* Found a valid interrupt, start up interrupts! */
-			sx_dprintk (SX_DEBUG_INIT, "Using irq %d.\n", board->irq);
-			sx_start_interrupts (board);
+			sx_dprintk(SX_DEBUG_INIT, "Using irq %d.\n",
+					board->irq);
+			sx_start_interrupts(board);
 			board->poll = sx_slowpoll;
 			board->flags |= SX_IRQ_ALLOCATED;
 		} else {
 			/* no irq: setup board for polled operation */
 			board->poll = sx_poll;
-			sx_dprintk (SX_DEBUG_INIT, "Using poll-interval %d.\n", board->poll);
+			sx_dprintk(SX_DEBUG_INIT, "Using poll-interval %d.\n",
+					board->poll);
 		}
 
-		/* The timer should be initialized anyway: That way we can safely
-			 del_timer it when the module is unloaded. */
-		init_timer (&board->timer);
+		/* The timer should be initialized anyway: That way we can
+		   safely del_timer it when the module is unloaded. */
+		init_timer(&board->timer);
 
 		if (board->poll) {
-			board->timer.data = (unsigned long) board;
+			board->timer.data = (unsigned long)board;
 			board->timer.function = sx_pollfunc;
 			board->timer.expires = jiffies + board->poll;
-			add_timer (&board->timer);
+			add_timer(&board->timer);
 		}
 	} else {
 		board->irq = 0;
 	}
 
 	board->nports = chans;
-	sx_dprintk (SX_DEBUG_INIT, "returning %d ports.", board->nports);
+	sx_dprintk(SX_DEBUG_INIT, "returning %d ports.", board->nports);
 
 	func_exit();
 	return chans;
 }
 
-
 static void __devinit printheader(void)
 {
 	static int header_printed;
 
 	if (!header_printed) {
-		printk (KERN_INFO "Specialix SX driver "
-		        "(C) 1998/1999 R.E.Wolff@BitWizard.nl \n");
-		printk (KERN_INFO "sx: version " __stringify(SX_VERSION) "\n");
+		printk(KERN_INFO "Specialix SX driver "
+			"(C) 1998/1999 R.E.Wolff@BitWizard.nl\n");
+		printk(KERN_INFO "sx: version " __stringify(SX_VERSION) "\n");
 		header_printed = 1;
 	}
 }
 
-
-static int __devinit probe_sx (struct sx_board *board)
+static int __devinit probe_sx(struct sx_board *board)
 {
 	struct vpd_prom vpdp;
 	char *p;
@@ -2059,51 +2173,57 @@ static int __devinit probe_sx (struct sx
 
 	func_enter();
 
-	if (!IS_CF_BOARD (board)) {    
-		sx_dprintk (SX_DEBUG_PROBE, "Going to verify vpd prom at %p.\n", 
-		            board->base + SX_VPD_ROM);
+	if (!IS_CF_BOARD(board)) {
+		sx_dprintk(SX_DEBUG_PROBE, "Going to verify vpd prom at %p.\n",
+				board->base + SX_VPD_ROM);
 
 		if (sx_debug & SX_DEBUG_PROBE)
 			my_hd_io(board->base + SX_VPD_ROM, 0x40);
 
-		p = (char *) &vpdp;
-		for (i=0;i< sizeof (struct vpd_prom);i++)
-			*p++ = read_sx_byte (board, SX_VPD_ROM + i*2);
+		p = (char *)&vpdp;
+		for (i = 0; i < sizeof(struct vpd_prom); i++)
+			*p++ = read_sx_byte(board, SX_VPD_ROM + i * 2);
 
 		if (sx_debug & SX_DEBUG_PROBE)
-			my_hd (&vpdp, 0x20);
+			my_hd(&vpdp, 0x20);
 
-		sx_dprintk (SX_DEBUG_PROBE, "checking identifier...\n");
+		sx_dprintk(SX_DEBUG_PROBE, "checking identifier...\n");
 
-		if (strncmp (vpdp.identifier, SX_VPD_IDENT_STRING, 16) != 0) {
-			sx_dprintk (SX_DEBUG_PROBE, "Got non-SX identifier: '%s'\n", 
-			            vpdp.identifier); 
+		if (strncmp(vpdp.identifier, SX_VPD_IDENT_STRING, 16) != 0) {
+			sx_dprintk(SX_DEBUG_PROBE, "Got non-SX identifier: "
+					"'%s'\n", vpdp.identifier);
 			return 0;
 		}
 	}
 
-	printheader ();
-
-	if (!IS_CF_BOARD (board)) {
-		printk (KERN_DEBUG "sx: Found an SX board at %lx\n", board->hw_base);
-		printk (KERN_DEBUG "sx: hw_rev: %d, assembly level: %d, uniq ID:%08x, ", 
-		        vpdp.hwrev, vpdp.hwass, vpdp.uniqid);
-		printk (           "Manufactured: %d/%d\n", 
-		        1970 + vpdp.myear, vpdp.mweek);
+	printheader();
 
+	if (!IS_CF_BOARD(board)) {
+		printk(KERN_DEBUG "sx: Found an SX board at %lx\n",
+			board->hw_base);
+		printk(KERN_DEBUG "sx: hw_rev: %d, assembly level: %d, "
+				"uniq ID:%08x, ",
+				vpdp.hwrev, vpdp.hwass, vpdp.uniqid);
+		printk("Manufactured: %d/%d\n", 1970 + vpdp.myear, vpdp.mweek);
 
-		if ((((vpdp.uniqid >> 24) & SX_UNIQUEID_MASK) != SX_PCI_UNIQUEID1) &&
-		    (((vpdp.uniqid >> 24) & SX_UNIQUEID_MASK) != SX_ISA_UNIQUEID1)) {
-			/* This might be a bit harsh. This was the primary reason the
-			   SX/ISA card didn't work at first... */
-			printk (KERN_ERR "sx: Hmm. Not an SX/PCI or SX/ISA card. Sorry: giving up.\n");
+		if ((((vpdp.uniqid >> 24) & SX_UNIQUEID_MASK) !=
+				SX_PCI_UNIQUEID1) && (((vpdp.uniqid >> 24) &
+				SX_UNIQUEID_MASK) != SX_ISA_UNIQUEID1)) {
+			/* This might be a bit harsh. This was the primary
+			   reason the SX/ISA card didn't work at first... */
+			printk(KERN_ERR "sx: Hmm. Not an SX/PCI or SX/ISA "
+					"card. Sorry: giving up.\n");
 			return (0);
 		}
 
-		if (((vpdp.uniqid >> 24) & SX_UNIQUEID_MASK) == SX_ISA_UNIQUEID1) {
+		if (((vpdp.uniqid >> 24) & SX_UNIQUEID_MASK) ==
+				SX_ISA_UNIQUEID1) {
 			if (((unsigned long)board->hw_base) & 0x8000) {
-				printk (KERN_WARNING "sx: Warning: There may be hardware problems with the card at %lx.\n", board->hw_base);
-				printk (KERN_WARNING "sx: Read sx.txt for more info.\n");
+				printk(KERN_WARNING "sx: Warning: There may be "
+					"hardware problems with the card at "
+					"%lx.\n", board->hw_base);
+				printk(KERN_WARNING "sx: Read sx.txt for more "
+						"info.\n");
 			}
 		}
 	}
@@ -2111,9 +2231,9 @@ static int __devinit probe_sx (struct sx
 	board->nports = -1;
 
 	/* This resets the processor, and keeps it off the bus. */
-	if (!sx_reset (board)) 
+	if (!sx_reset(board))
 		return 0;
-	sx_dprintk (SX_DEBUG_INIT, "reset the board...\n");
+	sx_dprintk(SX_DEBUG_INIT, "reset the board...\n");
 
 	func_exit();
 	return 1;
@@ -2127,28 +2247,27 @@ #if defined(CONFIG_ISA) || defined(CONFI
    card. 0xe0000 and 0xf0000 are taken by the BIOS. That only leaves 
    0xc0000, 0xc8000, 0xd0000 and 0xd8000 . */
 
-static int __devinit probe_si (struct sx_board *board)
+static int __devinit probe_si(struct sx_board *board)
 {
 	int i;
 
 	func_enter();
-	sx_dprintk (SX_DEBUG_PROBE, "Going to verify SI signature hw %lx at %p.\n", board->hw_base,
-	            board->base + SI2_ISA_ID_BASE);
+	sx_dprintk(SX_DEBUG_PROBE, "Going to verify SI signature hw %lx at "
+		"%p.\n", board->hw_base, board->base + SI2_ISA_ID_BASE);
 
 	if (sx_debug & SX_DEBUG_PROBE)
 		my_hd_io(board->base + SI2_ISA_ID_BASE, 0x8);
 
 	if (!IS_EISA_BOARD(board)) {
-	  if( IS_SI1_BOARD(board) ) 
-	    {
-		for (i=0;i<8;i++) {
-		  write_sx_byte (board, SI2_ISA_ID_BASE+7-i,i); 
-
+		if (IS_SI1_BOARD(board)) {
+			for (i = 0; i < 8; i++) {
+				write_sx_byte(board, SI2_ISA_ID_BASE + 7 - i,i);
+			}
 		}
-	    }
-		for (i=0;i<8;i++) {
-			if ((read_sx_byte (board, SI2_ISA_ID_BASE+7-i) & 7) != i) {
-				func_exit ();
+		for (i = 0; i < 8; i++) {
+			if ((read_sx_byte(board, SI2_ISA_ID_BASE + 7 - i) & 7)
+					!= i) {
+				func_exit();
 				return 0;
 			}
 		}
@@ -2158,20 +2277,20 @@ static int __devinit probe_si (struct sx
 	   but to prevent trouble, we'd better double check that we don't
 	   have an SI1 board when we're probing for an SI2 board.... */
 
-	write_sx_byte (board, SI2_ISA_ID_BASE,0x10); 
-	if ( IS_SI1_BOARD(board)) {
+	write_sx_byte(board, SI2_ISA_ID_BASE, 0x10);
+	if (IS_SI1_BOARD(board)) {
 		/* This should be an SI1 board, which has this
 		   location writable... */
-		if (read_sx_byte (board, SI2_ISA_ID_BASE) != 0x10) {
-			func_exit ();
-			return 0; 
+		if (read_sx_byte(board, SI2_ISA_ID_BASE) != 0x10) {
+			func_exit();
+			return 0;
 		}
 	} else {
 		/* This should be an SI2 board, which has the bottom
 		   3 bits non-writable... */
-		if (read_sx_byte (board, SI2_ISA_ID_BASE) == 0x10) {
-			func_exit ();
-			return 0; 
+		if (read_sx_byte(board, SI2_ISA_ID_BASE) == 0x10) {
+			func_exit();
+			return 0;
 		}
 	}
 
@@ -2179,35 +2298,35 @@ static int __devinit probe_si (struct sx
 	   but to prevent trouble, we'd better double check that we don't
 	   have an SI1 board when we're probing for an SI2 board.... */
 
-	write_sx_byte (board, SI2_ISA_ID_BASE,0x10); 
-	if ( IS_SI1_BOARD(board)) {
+	write_sx_byte(board, SI2_ISA_ID_BASE, 0x10);
+	if (IS_SI1_BOARD(board)) {
 		/* This should be an SI1 board, which has this
 		   location writable... */
-		if (read_sx_byte (board, SI2_ISA_ID_BASE) != 0x10) {
+		if (read_sx_byte(board, SI2_ISA_ID_BASE) != 0x10) {
 			func_exit();
-			return 0; 
+			return 0;
 		}
 	} else {
 		/* This should be an SI2 board, which has the bottom
 		   3 bits non-writable... */
-		if (read_sx_byte (board, SI2_ISA_ID_BASE) == 0x10) {
-			func_exit ();
-			return 0; 
+		if (read_sx_byte(board, SI2_ISA_ID_BASE) == 0x10) {
+			func_exit();
+			return 0;
 		}
 	}
 
-	printheader ();
+	printheader();
 
-	printk (KERN_DEBUG "sx: Found an SI board at %lx\n", board->hw_base);
+	printk(KERN_DEBUG "sx: Found an SI board at %lx\n", board->hw_base);
 	/* Compared to the SX boards, it is a complete guess as to what
-		 this card is up to... */
+	   this card is up to... */
 
 	board->nports = -1;
 
 	/* This resets the processor, and keeps it off the bus. */
-	if (!sx_reset (board)) 
+	if (!sx_reset(board))
 		return 0;
-	sx_dprintk (SX_DEBUG_INIT, "reset the board...\n");
+	sx_dprintk(SX_DEBUG_INIT, "reset the board...\n");
 
 	func_exit();
 	return 1;
@@ -2216,7 +2335,7 @@ #endif
 
 static const struct tty_operations sx_ops = {
 	.break_ctl = sx_break,
-	.open	= sx_open,
+	.open = sx_open,
 	.close = gs_close,
 	.write = gs_write,
 	.put_char = gs_put_char,
@@ -2251,8 +2370,7 @@ static int sx_init_drivers(void)
 	sx_driver->type = TTY_DRIVER_TYPE_SERIAL;
 	sx_driver->subtype = SERIAL_TYPE_NORMAL;
 	sx_driver->init_termios = tty_std_termios;
-	sx_driver->init_termios.c_cflag =
-	  B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+	sx_driver->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
 	sx_driver->init_termios.c_ispeed = 9600;
 	sx_driver->init_termios.c_ospeed = 9600;
 	sx_driver->flags = TTY_DRIVER_REAL_RAW;
@@ -2261,14 +2379,14 @@ static int sx_init_drivers(void)
 	if ((error = tty_register_driver(sx_driver))) {
 		put_tty_driver(sx_driver);
 		printk(KERN_ERR "sx: Couldn't register sx driver, error = %d\n",
-		       error);
+			error);
 		return 1;
 	}
 	func_exit();
 	return 0;
 }
 
-static int sx_init_portstructs (int nboards, int nports)
+static int sx_init_portstructs(int nboards, int nports)
 {
 	struct sx_board *board;
 	struct sx_port *port;
@@ -2279,7 +2397,8 @@ static int sx_init_portstructs (int nboa
 	func_enter();
 
 	/* Many drivers statically allocate the maximum number of ports
-	   There is no reason not to allocate them dynamically. Is there? -- REW */
+	   There is no reason not to allocate them dynamically.
+	   Is there? -- REW */
 	sx_ports = kcalloc(nports, sizeof(struct sx_port), GFP_KERNEL);
 	if (!sx_ports)
 		return -ENOMEM;
@@ -2288,10 +2407,10 @@ static int sx_init_portstructs (int nboa
 	for (i = 0; i < nboards; i++) {
 		board = &boards[i];
 		board->ports = port;
-		for (j=0; j < boards[i].nports;j++) {
-			sx_dprintk (SX_DEBUG_INIT, "initing port %d\n", j);
+		for (j = 0; j < boards[i].nports; j++) {
+			sx_dprintk(SX_DEBUG_INIT, "initing port %d\n", j);
 			port->gs.magic = SX_MAGIC;
-			port->gs.close_delay = HZ/2;
+			port->gs.close_delay = HZ / 2;
 			port->gs.closing_wait = 30 * HZ;
 			port->board = board;
 			port->gs.rd = &sx_real_driver;
@@ -2303,8 +2422,8 @@ #endif
 			 * Initializing wait queue
 			 */
 			init_waitqueue_head(&port->gs.open_wait);
-			init_waitqueue_head(&port->gs.close_wait); 		
-			
+			init_waitqueue_head(&port->gs.close_wait);
+
 			port++;
 		}
 	}
@@ -2315,28 +2434,36 @@ #endif
 		board = &boards[i];
 		board->port_base = portno;
 		/* Possibly the configuration was rejected. */
-		sx_dprintk (SX_DEBUG_PROBE, "Board has %d channels\n", board->nports);
-		if (board->nports <= 0) continue;
+		sx_dprintk(SX_DEBUG_PROBE, "Board has %d channels\n",
+				board->nports);
+		if (board->nports <= 0)
+			continue;
 		/* XXX byteorder ?? */
-		for (addr = 0x80;addr != 0;addr = read_sx_word (board, addr) & 0x7fff) {
-			chans = sx_read_module_byte (board, addr, mc_type); 
-			sx_dprintk (SX_DEBUG_PROBE, "Module at %x: %d channels\n", addr, chans);
-			sx_dprintk (SX_DEBUG_PROBE, "Port at");
-			for (j=0;j<chans;j++) {
-				/* The "sx-way" is the way it SHOULD be done. That way in the 
-				   future, the firmware may for example pack the structures a bit
-				   more efficient. Neil tells me it isn't going to happen anytime
-				   soon though. */
+		for (addr = 0x80; addr != 0;
+				addr = read_sx_word(board, addr) & 0x7fff) {
+			chans = sx_read_module_byte(board, addr, mc_type);
+			sx_dprintk(SX_DEBUG_PROBE, "Module at %x: %d "
+					"channels\n", addr, chans);
+			sx_dprintk(SX_DEBUG_PROBE, "Port at");
+			for (j = 0; j < chans; j++) {
+				/* The "sx-way" is the way it SHOULD be done.
+				   That way in the future, the firmware may for
+				   example pack the structures a bit more
+				   efficient. Neil tells me it isn't going to
+				   happen anytime soon though. */
 				if (IS_SX_BOARD(board))
-					port->ch_base = sx_read_module_word (board, addr+j*2, mc_chan_pointer);
+					port->ch_base = sx_read_module_word(
+							board, addr + j * 2,
+							mc_chan_pointer);
 				else
-					port->ch_base = addr + 0x100 + 0x300*j;
+					port->ch_base = addr + 0x100 + 0x300 *j;
 
-				sx_dprintk (SX_DEBUG_PROBE, " %x", port->ch_base);
+				sx_dprintk(SX_DEBUG_PROBE, " %x",
+						port->ch_base);
 				port->line = portno++;
 				port++;
 			}
-			sx_dprintk (SX_DEBUG_PROBE, "\n");
+			sx_dprintk(SX_DEBUG_PROBE, "\n");
 		}
 		/* This has to be done earlier. */
 		/* board->flags |= SX_BOARD_INITIALIZED; */
@@ -2350,7 +2477,7 @@ static unsigned int sx_find_free_board(v
 {
 	unsigned int i;
 
-        for (i = 0; i < SX_NBOARDS; i++)
+	for (i = 0; i < SX_NBOARDS; i++)
 		if (!(boards[i].flags & SX_BOARD_PRESENT))
 			break;
 
@@ -2378,7 +2505,7 @@ static void __devexit sx_remove_card(str
 		del_timer(&board->timer);
 		iounmap(board->base);
 
-		board->flags &= ~(SX_BOARD_INITIALIZED|SX_BOARD_PRESENT);
+		board->flags &= ~(SX_BOARD_INITIALIZED | SX_BOARD_PRESENT);
 	}
 }
 
@@ -2403,17 +2530,17 @@ static int __devinit sx_eisa_probe(struc
 	mutex_unlock(&sx_boards_lock);
 
 	dev_info(dev, "XIO : Signature found in EISA slot %lu, "
-			"Product %d Rev %d (REPORT THIS TO LKLM)\n",
-			eisa_slot >> 12,
-			inb(eisa_slot + EISA_VENDOR_ID_OFFSET + 2),
-			inb(eisa_slot + EISA_VENDOR_ID_OFFSET + 3));
+		 "Product %d Rev %d (REPORT THIS TO LKLM)\n",
+		 eisa_slot >> 12,
+		 inb(eisa_slot + EISA_VENDOR_ID_OFFSET + 2),
+		 inb(eisa_slot + EISA_VENDOR_ID_OFFSET + 3));
 
 	board->eisa_base = eisa_slot;
 	board->flags &= ~SX_BOARD_TYPE;
 	board->flags |= SI_EISA_BOARD;
 
 	board->hw_base = ((inb(eisa_slot + 0xc01) << 8) +
-			inb(eisa_slot + 0xc00)) << 16;
+			  inb(eisa_slot + 0xc00)) << 16;
 	board->base2 =
 	board->base = ioremap(board->hw_base, SI2_EISA_WINDOW_LEN);
 
@@ -2448,6 +2575,7 @@ static struct eisa_device_id sx_eisa_tbl
 	{ "SLX" },
 	{ "" }
 };
+
 MODULE_DEVICE_TABLE(eisa, sx_eisa_tbl);
 
 static struct eisa_driver sx_eisadriver = {
@@ -2478,22 +2606,23 @@ static void __devinit fix_sx_pci(struct 
 	void __iomem *rebase;
 	unsigned int t;
 
-#define CNTRL_REG_OFFSET        0x50
-#define CNTRL_REG_GOODVALUE     0x18260000
+#define CNTRL_REG_OFFSET	0x50
+#define CNTRL_REG_GOODVALUE	0x18260000
 
 	pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &hwbase);
 	hwbase &= PCI_BASE_ADDRESS_MEM_MASK;
 	rebase = ioremap(hwbase, 0x80);
-	t = readl (rebase + CNTRL_REG_OFFSET);
+	t = readl(rebase + CNTRL_REG_OFFSET);
 	if (t != CNTRL_REG_GOODVALUE) {
-		printk (KERN_DEBUG "sx: performing cntrl reg fix: %08x -> %08x\n", t, CNTRL_REG_GOODVALUE); 
-		writel (CNTRL_REG_GOODVALUE, rebase + CNTRL_REG_OFFSET);
+		printk(KERN_DEBUG "sx: performing cntrl reg fix: %08x -> "
+			"%08x\n", t, CNTRL_REG_GOODVALUE);
+		writel(CNTRL_REG_GOODVALUE, rebase + CNTRL_REG_OFFSET);
 	}
 	iounmap(rebase);
 }
 
 static int __devinit sx_pci_probe(struct pci_dev *pdev,
-	const struct pci_device_id *ent)
+				  const struct pci_device_id *ent)
 {
 	struct sx_board *board;
 	unsigned int i;
@@ -2515,28 +2644,28 @@ static int __devinit sx_pci_probe(struct
 
 	board->flags &= ~SX_BOARD_TYPE;
 	board->flags |= (pdev->subsystem_vendor == 0x200) ? SX_PCI_BOARD :
-				SX_CFPCI_BOARD;
+		SX_CFPCI_BOARD;
 
 	/* CF boards use base address 3.... */
-	if (IS_CF_BOARD (board))
+	if (IS_CF_BOARD(board))
 		board->hw_base = pci_resource_start(pdev, 3);
 	else
 		board->hw_base = pci_resource_start(pdev, 2);
 	board->base2 =
-	board->base = ioremap(board->hw_base, WINDOW_LEN (board));
+	board->base = ioremap(board->hw_base, WINDOW_LEN(board));
 	if (!board->base) {
 		dev_err(&pdev->dev, "ioremap failed\n");
 		goto err_flag;
 	}
 
 	/* Most of the stuff on the CF board is offset by 0x18000 ....  */
-	if (IS_CF_BOARD (board))
+	if (IS_CF_BOARD(board))
 		board->base += 0x18000;
 
 	board->irq = pdev->irq;
 
 	dev_info(&pdev->dev, "Got a specialix card: %p(%d) %x.\n", board->base,
-			board->irq, board->flags);
+		 board->irq, board->flags);
 
 	if (!probe_sx(board)) {
 		retval = -EIO;
@@ -2567,11 +2696,12 @@ static void __devexit sx_pci_remove(stru
    its because the standard requires it. So check for SUBVENDOR_ID. */
 static struct pci_device_id sx_pci_tbl[] = {
 	{ PCI_VENDOR_ID_SPECIALIX, PCI_DEVICE_ID_SPECIALIX_SX_XIO_IO8,
-			.subvendor = 0x0200, .subdevice = PCI_ANY_ID },
+		.subvendor = 0x0200,.subdevice = PCI_ANY_ID },
 	{ PCI_VENDOR_ID_SPECIALIX, PCI_DEVICE_ID_SPECIALIX_SX_XIO_IO8,
-			.subvendor = 0x0300, .subdevice = PCI_ANY_ID },
+		.subvendor = 0x0300,.subdevice = PCI_ANY_ID },
 	{ 0 }
 };
+
 MODULE_DEVICE_TABLE(pci, sx_pci_tbl);
 
 static struct pci_driver sx_pcidriver = {
@@ -2581,7 +2711,7 @@ static struct pci_driver sx_pcidriver = 
 	.remove = __devexit_p(sx_pci_remove)
 };
 
-static int __init sx_init(void) 
+static int __init sx_init(void)
 {
 #ifdef CONFIG_EISA
 	int retval1;
@@ -2594,29 +2724,30 @@ #endif
 	int retval;
 
 	func_enter();
-	sx_dprintk (SX_DEBUG_INIT, "Initing sx module... (sx_debug=%d)\n", sx_debug);
-	if (abs ((long) (&sx_debug) - sx_debug) < 0x10000) {
-		printk (KERN_WARNING "sx: sx_debug is an address, instead of a value. "
-		        "Assuming -1.\n");
-		printk ("(%p)\n", &sx_debug);
-		sx_debug=-1;
+	sx_dprintk(SX_DEBUG_INIT, "Initing sx module... (sx_debug=%d)\n",
+			sx_debug);
+	if (abs((long)(&sx_debug) - sx_debug) < 0x10000) {
+		printk(KERN_WARNING "sx: sx_debug is an address, instead of a "
+				"value. Assuming -1.\n(%p)\n", &sx_debug);
+		sx_debug = -1;
 	}
 
 	if (misc_register(&sx_fw_device) < 0) {
-		printk(KERN_ERR "SX: Unable to register firmware loader driver.\n");
+		printk(KERN_ERR "SX: Unable to register firmware loader "
+				"driver.\n");
 		return -EIO;
 	}
 #ifdef CONFIG_ISA
-	for (i=0;i<NR_SX_ADDRS;i++) {
+	for (i = 0; i < NR_SX_ADDRS; i++) {
 		board = &boards[found];
 		board->hw_base = sx_probe_addrs[i];
 		board->base2 =
 		board->base = ioremap(board->hw_base, SX_WINDOW_LEN);
 		board->flags &= ~SX_BOARD_TYPE;
-		board->flags |=	SX_ISA_BOARD;
-		board->irq = sx_irqmask?-1:0;
+		board->flags |= SX_ISA_BOARD;
+		board->irq = sx_irqmask ? -1 : 0;
 
-		if (probe_sx (board)) {
+		if (probe_sx(board)) {
 			board->flags |= SX_BOARD_PRESENT;
 			found++;
 		} else {
@@ -2624,36 +2755,36 @@ #ifdef CONFIG_ISA
 		}
 	}
 
-	for (i=0;i<NR_SI_ADDRS;i++) {
+	for (i = 0; i < NR_SI_ADDRS; i++) {
 		board = &boards[found];
 		board->hw_base = si_probe_addrs[i];
 		board->base2 =
 		board->base = ioremap(board->hw_base, SI2_ISA_WINDOW_LEN);
 		board->flags &= ~SX_BOARD_TYPE;
-		board->flags |=  SI_ISA_BOARD;
-		board->irq = sx_irqmask ?-1:0;
+		board->flags |= SI_ISA_BOARD;
+		board->irq = sx_irqmask ? -1 : 0;
 
-		if (probe_si (board)) {
+		if (probe_si(board)) {
 			board->flags |= SX_BOARD_PRESENT;
 			found++;
 		} else {
-			iounmap (board->base);
+			iounmap(board->base);
 		}
 	}
-	for (i=0;i<NR_SI1_ADDRS;i++) {
+	for (i = 0; i < NR_SI1_ADDRS; i++) {
 		board = &boards[found];
 		board->hw_base = si1_probe_addrs[i];
 		board->base2 =
 		board->base = ioremap(board->hw_base, SI1_ISA_WINDOW_LEN);
 		board->flags &= ~SX_BOARD_TYPE;
-		board->flags |=  SI1_ISA_BOARD;
-		board->irq = sx_irqmask ?-1:0;
+		board->flags |= SI1_ISA_BOARD;
+		board->irq = sx_irqmask ? -1 : 0;
 
-		if (probe_si (board)) {
+		if (probe_si(board)) {
 			board->flags |= SX_BOARD_PRESENT;
 			found++;
 		} else {
-			iounmap (board->base);
+			iounmap(board->base);
 		}
 	}
 #endif
@@ -2663,23 +2794,22 @@ #endif
 	retval = pci_register_driver(&sx_pcidriver);
 
 	if (found) {
-		printk (KERN_INFO "sx: total of %d boards detected.\n", found);
+		printk(KERN_INFO "sx: total of %d boards detected.\n", found);
 		retval = 0;
 	} else if (retval) {
 #ifdef CONFIG_EISA
 		if (retval1)
 #endif
-		misc_deregister(&sx_fw_device);
+			misc_deregister(&sx_fw_device);
 	}
 
 	func_exit();
 	return retval;
 }
 
-
-static void __exit sx_exit (void)
+static void __exit sx_exit(void)
 {
-	int i; 
+	int i;
 
 	func_enter();
 #ifdef CONFIG_EISA
@@ -2691,17 +2821,17 @@ #endif
 		sx_remove_card(&boards[i]);
 
 	if (misc_deregister(&sx_fw_device) < 0) {
-		printk (KERN_INFO "sx: couldn't deregister firmware loader device\n");
+		printk(KERN_INFO "sx: couldn't deregister firmware loader "
+				"device\n");
 	}
-	sx_dprintk (SX_DEBUG_CLEANUP, "Cleaning up drivers (%d)\n", sx_initialized);
+	sx_dprintk(SX_DEBUG_CLEANUP, "Cleaning up drivers (%d)\n",
+			sx_initialized);
 	if (sx_initialized)
-		sx_release_drivers ();
+		sx_release_drivers();
 
-	kfree (sx_ports);
+	kfree(sx_ports);
 	func_exit();
 }
 
 module_init(sx_init);
 module_exit(sx_exit);
-
-
