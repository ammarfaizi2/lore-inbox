Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262986AbUKXX0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262986AbUKXX0K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 18:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbUKXXXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 18:23:19 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44043 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262894AbUKXXLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 18:11:06 -0500
Date: Thu, 25 Nov 2004 00:11:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] misc drivers/char/ cleanups (fwd)
Message-ID: <20041124231102.GO19873@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch forwarded below still applies and compiles against 
2.6.10-rc2-mm3.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sun, 7 Nov 2004 01:58:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] misc drivers/char/ cleanups

Below are misc drivers/char/ cleanups.
Most of this consists of:
- removal of unused code
- make needlessly global code static

Please review and comment on this patch.


diffstat output:
 drivers/char/esp.c                |    2 
 drivers/char/genrtc.c             |    2 
 drivers/char/hw_random.c          |    2 
 drivers/char/ip2/fip_firm.h       |    2 
 drivers/char/ip2/i2cmd.c          |   59 -----
 drivers/char/ip2/i2cmd.h          |   17 -
 drivers/char/ip2/i2lib.c          |    2 
 drivers/char/ip2main.c            |    5 
 drivers/char/istallion.c          |   40 ---
 drivers/char/keyboard.c           |   20 -
 drivers/char/lp.c                 |    4 
 drivers/char/moxa.c               |   18 -
 drivers/char/mwave/3780i.c        |   29 --
 drivers/char/mwave/3780i.h        |    5 
 drivers/char/mwave/smapi.c        |   16 -
 drivers/char/mxser.c              |    4 
 drivers/char/n_tty.c              |    4 
 drivers/char/pcmcia/synclink_cs.c |   24 +-
 drivers/char/pty.c                |    2 
 drivers/char/specialix.c          |   91 ++------
 drivers/char/stallion.c           |   37 ---
 drivers/char/synclink.c           |  313 ++++++++++++++----------------
 drivers/char/tipar.c              |    4 
 drivers/char/toshiba.c            |    2 
 drivers/char/tty_io.c             |   36 ---
 drivers/char/tty_ioctl.c          |    2 
 include/linux/lp.h                |    6 
 27 files changed, 244 insertions(+), 504 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/char/esp.c.old	2004-11-07 00:09:28.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/esp.c	2004-11-07 00:09:39.000000000 +0100
@@ -2401,7 +2401,7 @@
 /*
  * The serial driver boot-time initialization code!
  */
-int __init espserial_init(void)
+static int __init espserial_init(void)
 {
 	int i, offset;
 	struct esp_struct * info;
--- linux-2.6.10-rc1-mm3-full/drivers/char/genrtc.c.old	2004-11-07 00:09:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/genrtc.c	2004-11-07 00:09:10.000000000 +0100
@@ -83,7 +83,7 @@
 static int irq_active;
 
 #ifdef CONFIG_GEN_RTC_X
-struct work_struct genrtc_task;
+static struct work_struct genrtc_task;
 static struct timer_list timer_task;
 
 static unsigned int oldsecs;
--- linux-2.6.10-rc1-mm3-full/drivers/char/hw_random.c.old	2004-11-07 00:10:30.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/hw_random.c	2004-11-07 00:10:39.000000000 +0100
@@ -369,7 +369,7 @@
 	VIA_RNG_CHUNK_1_MASK	= 0xFF,
 };
 
-u32 via_rng_datum;
+static u32 via_rng_datum;
 
 /*
  * Investigate using the 'rep' prefix to obtain 32 bits of random data
--- linux-2.6.10-rc1-mm3-full/drivers/char/ip2/fip_firm.h.old	2004-11-07 00:11:09.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/ip2/fip_firm.h	2004-11-07 00:11:15.000000000 +0100
@@ -1,7 +1,7 @@
 /* fip_firm.h - Intelliport II loadware */
 /* -31232 bytes read from ff.lod */
 
-unsigned char fip_firm[] __initdata = {
+static unsigned char fip_firm[] __initdata = {
 0x3C,0x42,0x37,0x18,0x02,0x01,0x03,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
 0x57,0x65,0x64,0x20,0x44,0x65,0x63,0x20,0x30,0x31,0x20,0x31,0x32,0x3A,0x32,0x34,
 0x3A,0x33,0x30,0x20,0x31,0x39,0x39,0x39,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
--- linux-2.6.10-rc1-mm3-full/drivers/char/ip2/i2lib.c.old	2004-11-07 00:11:52.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/ip2/i2lib.c	2004-11-07 00:12:01.000000000 +0100
@@ -141,7 +141,7 @@
 //* Code *
 //********
 
-inline int
+static inline int
 i2Validate ( i2ChanStrPtr pCh )
 {
 	//ip2trace(pCh->port_index, ITRC_VERIFY,ITRC_ENTER,2,pCh->validity,
--- linux-2.6.10-rc1-mm3-full/drivers/char/ip2/i2cmd.h.old	2004-11-07 00:14:35.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/ip2/i2cmd.h	2004-11-07 00:16:06.000000000 +0100
@@ -71,9 +71,7 @@
 // there is more than one parameter to assign, we must use a function rather
 // than a macro (used usually).
 //
-extern cmdSyntaxPtr i2cmdSetSeq(UCHAR seqno, UCHAR size, UCHAR *string);
 extern cmdSyntaxPtr i2cmdUnixFlags(USHORT iflag,USHORT cflag,USHORT lflag);
-extern cmdSyntaxPtr i2cmdBaudRemap(UCHAR dest, UCHAR src);
 extern cmdSyntaxPtr i2cmdBaudDef(int which, USHORT rate);
 
 // Declarations for the global arrays used to bear the commands and their
@@ -397,14 +395,6 @@
 // library code in response to data movement and shouldn't ever be sent by the
 // user code. See i2pack.h and the body of i2lib.c for details.
 
-// COMMAND 38: Define the hot-key sequence
-// seqno:  sequence number 0-15
-// size:   number of characters in sequence (1-8)
-// string: pointer to the characters
-// (if size == 0, "undefines" this sequence
-//
-#define CMD_SET_SEQ(seqno,size,string) i2cmdSetSeq(seqno,size,string)
-
 // Enable on-board post-processing, using options given in oflag argument.
 // Formerly, this command was automatically preceded by a CMD_OPOST_OFF command
 // because the loadware does not permit sending back-to-back CMD_OPOST_ON
@@ -458,13 +448,6 @@
 #define CMD_DTRFL_DSAB  (cmdSyntaxPtr)(ct51) // Disable DTR flow control
 #define CMD_BAUD_RESET  (cmdSyntaxPtr)(ct52) // Reset baudrate table
 
-// COMMAND 53: Remap baud rate table
-// dest = index of table entry to be changed
-// src  = index value to substitute.
-// at default mapping table is f(x) = x
-//
-#define CMD_BAUD_REMAP(dest,src) i2cmdBaudRemap(dest,src)
-
 // COMMAND 54: Define custom rate #1
 // rate = (short) 1/10 of the desired baud rate
 //
--- linux-2.6.10-rc1-mm3-full/drivers/char/ip2/i2cmd.c.old	2004-11-07 00:15:10.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/ip2/i2cmd.c	2004-11-07 01:41:45.000000000 +0100
@@ -88,7 +88,7 @@
 //static UCHAR ct37[]={ 5, BYP|VIP, 0x25,0,0,0,0             }; // FLOW PACKET
 
 // Back to normal
-static UCHAR ct38[] = {11, BTH|VAR, 0x26,0,0,0,0,0,0,0,0,0,0 }; // DEF KEY SEQ
+//static UCHAR ct38[] = {11, BTH|VAR, 0x26,0,0,0,0,0,0,0,0,0,0 }; // DEF KEY SEQ
 //static UCHAR ct39[]={ 3, BTH|END, 0x27,0,0                 }; // OPOSTON
 //static UCHAR ct40[]={ 1, BTH|END, 0x28                     }; // OPOSTOFF
 static UCHAR ct41[] = { 1, BYP,     0x29                     }; // RESUME
@@ -103,7 +103,7 @@
 //static UCHAR ct50[]={ 1, BTH,     0x32                     }; // DTRFLOWENAB
 //static UCHAR ct51[]={ 1, BTH,     0x33                     }; // DTRFLOWDSAB
 //static UCHAR ct52[]={ 1, BTH,     0x34                     }; // BAUDTABRESET
-static UCHAR ct53[] = { 3, BTH,     0x35,0,0                 }; // BAUDREMAP
+//static UCHAR ct53[] = { 3, BTH,     0x35,0,0                 }; // BAUDREMAP
 static UCHAR ct54[] = { 3, BTH,     0x36,0,0                 }; // CUSTOMBAUD1
 static UCHAR ct55[] = { 3, BTH,     0x37,0,0                 }; // CUSTOMBAUD2
 static UCHAR ct56[] = { 2, BTH|END, 0x38,0                   }; // PAUSE
@@ -152,40 +152,6 @@
 //********
 
 //******************************************************************************
-// Function:   i2cmdSetSeq(type, size, string)
-// Parameters: type   - sequence number
-//             size   - length of sequence
-//             string - substitution string
-//
-// Returns:    Pointer to command structure
-//
-// Description:
-//
-// This routine sets the parameters of command 38 Define Hot Key sequence (alias
-// "special receive sequence"). Returns a pointer to the structure. Endeavours
-// to be bullet-proof in that the sequence number is forced in range, and any
-// out-of-range sizes are forced to zero.
-//******************************************************************************
-cmdSyntaxPtr
-i2cmdSetSeq(unsigned char type, unsigned char size, unsigned char *string)
-{
-	cmdSyntaxPtr pCM = (cmdSyntaxPtr) ct38;
-	unsigned char *pc;
-
-	pCM->cmd[1] = ((type > 0xf) ? 0xf : type);   // Sequence number
-	size = ((size > 0x8) ? 0 : size);            // size
-	pCM->cmd[2] = size;
-	pCM->length = 3 + size;                      // UPDATES THE LENGTH!
-
-	pc = &(pCM->cmd[3]);
-
-	while(size--) {
-		*pc++ = *string++;
-	}
-	return pCM;
-}
-
-//******************************************************************************
 // Function:   i2cmdUnixFlags(iflag, cflag, lflag)
 // Parameters: Unix tty flags
 //
@@ -211,27 +177,6 @@
 }
 
 //******************************************************************************
-// Function:   i2cmdBaudRemap(dest,src)
-// Parameters: ?
-//
-// Returns:    Pointer to command structure
-//
-// Description:
-//
-// This routine sets the parameters of command 53 and returns a pointer to the
-// appropriate structure.
-//******************************************************************************
-cmdSyntaxPtr
-i2cmdBaudRemap(unsigned char dest, unsigned char src)
-{
-	cmdSyntaxPtr pCM = (cmdSyntaxPtr) ct53;
-
-	pCM->cmd[1] = dest;
-	pCM->cmd[2] = src;
-	return pCM;
-}
-
-//******************************************************************************
 // Function:   i2cmdBaudDef(which, rate)
 // Parameters: ?
 //
--- linux-2.6.10-rc1-mm3-full/drivers/char/ip2main.c.old	2004-11-07 00:17:07.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/ip2main.c	2004-11-07 01:41:13.000000000 +0100
@@ -138,7 +138,7 @@
 #include <linux/proc_fs.h>
 
 static int ip2_read_procmem(char *, char **, off_t, int);
-int ip2_read_proc(char *, char **, off_t, int, int *, void * );
+static int ip2_read_proc(char *, char **, off_t, int, int *, void * );
 
 /********************/
 /* Type Definitions */
@@ -202,7 +202,6 @@
 static void ip2_wait_until_sent(PTTY,int);
 
 static void set_params (i2ChanStrPtr, struct termios *);
-static int set_modem_info(i2ChanStrPtr, unsigned int, unsigned int *);
 static int get_serial_info(i2ChanStrPtr, struct serial_struct __user *);
 static int set_serial_info(i2ChanStrPtr, struct serial_struct __user *);
 
@@ -3097,7 +3096,7 @@
  * different sources including ip2mkdev.c and a couple of other drivers.
  * The bugs are all mine.  :-)	=mhw=
  */
-int ip2_read_proc(char *page, char **start, off_t off,
+static int ip2_read_proc(char *page, char **start, off_t off,
 				int count, int *eof, void *data)
 {
 	int	i, j, box;
--- linux-2.6.10-rc1-mm3-full/drivers/char/istallion.c.old	2004-11-07 00:18:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/istallion.c	2004-11-07 01:39:52.000000000 +0100
@@ -288,7 +288,6 @@
 
 /*****************************************************************************/
 
-#ifdef MODULE
 /*
  *	Define some string labels for arguments passed from the module
  *	load line. These allow for easy board definitions, and easy
@@ -387,8 +386,6 @@
 MODULE_PARM(board3, "1-3s");
 MODULE_PARM_DESC(board3, "Board 3 config -> name[,ioaddr[,memaddr]");
 
-#endif
-
 /*
  *	Set up a default memory address table for EISA board probing.
  *	The default addresses are all bellow 1Mbyte, which has to be the
@@ -406,7 +403,6 @@
 };
 
 static int	stli_eisamempsize = sizeof(stli_eisamemprobeaddrs) / sizeof(unsigned long);
-int		stli_eisaprobe = STLI_EISAPROBE;
 
 /*
  *	Define the Stallion PCI vendor and device IDs.
@@ -650,14 +646,12 @@
  *	Prototype all functions in this driver!
  */
 
-#ifdef MODULE
 static void	stli_argbrds(void);
 static int	stli_parsebrd(stlconf_t *confp, char **argp);
 
 static unsigned long	stli_atol(char *str);
-#endif
 
-int		stli_init(void);
+static int	stli_init(void);
 static int	stli_open(struct tty_struct *tty, struct file *filp);
 static void	stli_close(struct tty_struct *tty, struct file *filp);
 static int	stli_write(struct tty_struct *tty, const unsigned char *buf, int count);
@@ -793,20 +787,10 @@
 
 static struct class_simple *istallion_class;
 
-#ifdef MODULE
-
-/*
- *	Loadable module initialization stuff.
- */
-
-static int __init istallion_module_init(void)
+static int __init istallion_init(void)
 {
 	unsigned long	flags;
 
-#ifdef DEBUG
-	printk("init_module()\n");
-#endif
-
 	save_flags(flags);
 	cli();
 	stli_init();
@@ -817,17 +801,13 @@
 
 /*****************************************************************************/
 
-static void __exit istallion_module_exit(void)
+static void __exit istallion_exit(void)
 {
 	stlibrd_t	*brdp;
 	stliport_t	*portp;
 	unsigned long	flags;
 	int		i, j;
 
-#ifdef DEBUG
-	printk("cleanup_module()\n");
-#endif
-
 	printk(KERN_INFO "Unloading %s: version %s\n", stli_drvtitle,
 		stli_drvversion);
 
@@ -887,8 +867,8 @@
 	restore_flags(flags);
 }
 
-module_init(istallion_module_init);
-module_exit(istallion_module_exit);
+module_init(istallion_init);
+module_exit(istallion_exit);
 
 /*****************************************************************************/
 
@@ -998,8 +978,6 @@
 	return(1);
 }
 
-#endif
-
 /*****************************************************************************/
 
 /*
@@ -4676,9 +4654,7 @@
  */
 	for (i = 0; (i < stli_nrbrds); i++) {
 		confp = &stli_brdconf[i];
-#ifdef MODULE
 		stli_parsebrd(confp, stli_brdsp[i]);
-#endif
 		if ((brdp = stli_allocbrd()) == (stlibrd_t *) NULL)
 			return(-ENOMEM);
 		brdp->brdnr = i;
@@ -4692,10 +4668,8 @@
  *	Static configuration table done, so now use dynamic methods to
  *	see if any more boards should be configured.
  */
-#ifdef MODULE
 	stli_argbrds();
-#endif
-	if (stli_eisaprobe)
+	if (STLI_EISAPROBE)
 		stli_findeisabrds();
 #ifdef CONFIG_PCI
 	stli_findpcibrds();
@@ -5220,7 +5194,7 @@
 
 /*****************************************************************************/
 
-int __init stli_init(void)
+static int __init stli_init(void)
 {
 	int i;
 	printk(KERN_INFO "%s: version %s\n", stli_drvtitle, stli_drvversion);
--- linux-2.6.10-rc1-mm3-full/drivers/char/keyboard.c.old	2004-11-07 00:20:09.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/keyboard.c	2004-11-07 00:21:52.000000000 +0100
@@ -330,7 +330,7 @@
  * in utf-8 already. UTF-8 is defined for words of up to 31 bits,
  * but we need only 16 bits here
  */
-void to_utf8(struct vc_data *vc, ushort c) 
+static void to_utf8(struct vc_data *vc, ushort c) 
 {
 	if (c < 0x80)
 		/*  0******* */
@@ -392,7 +392,7 @@
  * Otherwise, conclude that DIACR was not combining after all,
  * queue it and return CH.
  */
-unsigned char handle_diacr(struct vc_data *vc, unsigned char ch)
+static unsigned char handle_diacr(struct vc_data *vc, unsigned char ch)
 {
 	int d = diacr;
 	int i;
@@ -853,18 +853,6 @@
 	set_leds();
 }
 
-void register_leds(struct kbd_struct *kbd, unsigned int led,
-		   unsigned int *addr, unsigned int mask)
-{
-	if (led < 3) {
-		ledptrs[led].addr = addr;
-		ledptrs[led].mask = mask;
-		ledptrs[led].valid = 1;
-		kbd->ledmode = LED_SHOW_MEM;
-	} else
-		kbd->ledmode = LED_SHOW_FLAGS;
-}
-
 static inline unsigned char getleds(void)
 {
 	struct kbd_struct *kbd = kbd_table + fg_console;
@@ -925,7 +913,7 @@
 /*
  * This allows a newly plugged keyboard to pick the LED state.
  */
-void kbd_refresh_leds(struct input_handle *handle)
+static void kbd_refresh_leds(struct input_handle *handle)
 {
 	unsigned char leds = ledstate;
 
@@ -1027,7 +1015,7 @@
 }
 #endif
 
-void kbd_rawcode(unsigned char data)
+static void kbd_rawcode(unsigned char data)
 {
 	struct vc_data *vc = vc_cons[fg_console].d;
 	kbd = kbd_table + fg_console;
--- linux-2.6.10-rc1-mm3-full/include/linux/lp.h.old	2004-11-07 00:22:38.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/include/linux/lp.h	2004-11-07 00:22:51.000000000 +0100
@@ -186,12 +186,6 @@
  */
 #define LP_DELAY 	50
 
-/*
- * function prototypes
- */
-
-extern int lp_init(void);
-
 #endif
 
 #endif
--- linux-2.6.10-rc1-mm3-full/drivers/char/lp.c.old	2004-11-07 00:23:01.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/lp.c	2004-11-07 00:27:41.000000000 +0100
@@ -142,7 +142,7 @@
 /* ROUND_UP macro from fs/select.c */
 #define ROUND_UP(x,y) (((x)+(y)-1)/(y))
 
-struct lp_struct lp_table[LP_NO];
+static struct lp_struct lp_table[LP_NO];
 
 static unsigned int lp_count = 0;
 static struct class_simple *lp_class;
@@ -867,7 +867,7 @@
 	.detach = lp_detach,
 };
 
-int __init lp_init (void)
+static int __init lp_init (void)
 {
 	int i, err = 0;
 
--- linux-2.6.10-rc1-mm3-full/drivers/char/moxa.c.old	2004-11-07 00:28:05.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/moxa.c	2004-11-07 00:28:41.000000000 +0100
@@ -1765,7 +1765,6 @@
  *	2.  MoxaPortEnable(int port);					     *
  *	3.  MoxaPortDisable(int port);					     *
  *	4.  MoxaPortGetMaxBaud(int port);				     *
- *	5.  MoxaPortGetCurBaud(int port);				     *
  *	6.  MoxaPortSetBaud(int port, long baud);			     *
  *	7.  MoxaPortSetMode(int port, int databit, int stopbit, int parity); *
  *	8.  MoxaPortSetTermio(int port, unsigned char *termio); 	     *
@@ -1876,15 +1875,6 @@
  *                      38400/57600/115200 bps
  *
  *
- *      Function 9:     Get the current baud rate of this port.
- *      Syntax:
- *      long MoxaPortGetCurBaud(int port);
- *           int port           : port number (0 - 127)
- *
- *           return:    0       : this port is invalid
- *                      50 - 115200 bps
- *
- *
  *      Function 10:    Setting baud rate of this port.
  *      Syntax:
  *      long MoxaPortSetBaud(int port, long baud);
@@ -3093,14 +3083,6 @@
 	return (0);
 }
 
-long MoxaPortGetCurBaud(int port)
-{
-
-	if (moxaChkPort[port] == 0)
-		return (0);
-	return (moxaCurBaud[port]);
-}
-
 static void MoxaSetFifo(int port, int enable)
 {
 	void __iomem *ofsAddr = moxaTableAddr[port];
--- linux-2.6.10-rc1-mm3-full/drivers/char/mwave/3780i.h.old	2004-11-07 01:43:07.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/mwave/3780i.h	2004-11-07 01:46:15.000000000 +0100
@@ -338,10 +338,6 @@
                                    unsigned long ulMsaAddr);
 void dsp3780I_WriteMsaCfg(unsigned short usDspBaseIO,
                           unsigned long ulMsaAddr, unsigned short usValue);
-void dsp3780I_WriteGenCfg(unsigned short usDspBaseIO, unsigned uIndex,
-                          unsigned char ucValue);
-unsigned char dsp3780I_ReadGenCfg(unsigned short usDspBaseIO,
-                                  unsigned uIndex);
 int dsp3780I_GetIPCSource(unsigned short usDspBaseIO,
                           unsigned short *pusIPCSource);
 
@@ -352,7 +348,6 @@
 #define WriteMsaCfg(addr,value) dsp3780I_WriteMsaCfg(usDspBaseIO,addr,value)
 #define ReadMsaCfg(addr) dsp3780I_ReadMsaCfg(usDspBaseIO,addr)
 #define WriteGenCfg(index,value) dsp3780I_WriteGenCfg(usDspBaseIO,index,value)
-#define ReadGenCfg(index) dsp3780I_ReadGenCfg(usDspBaseIO,index)
 
 #define InWordDsp(index)          inw(usDspBaseIO+index)
 #define InByteDsp(index)          inb(usDspBaseIO+index)
--- linux-2.6.10-rc1-mm3-full/drivers/char/mwave/3780i.c.old	2004-11-07 00:29:29.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/mwave/3780i.c	2004-11-07 01:46:23.000000000 +0100
@@ -107,7 +107,7 @@
 	spin_unlock_irqrestore(&dsp_lock, flags);
 }
 
-void dsp3780I_WriteGenCfg(unsigned short usDspBaseIO, unsigned uIndex,
+static void dsp3780I_WriteGenCfg(unsigned short usDspBaseIO, unsigned uIndex,
                           unsigned char ucValue)
 {
 	DSP_ISA_SLAVE_CONTROL rSlaveControl;
@@ -141,33 +141,6 @@
 
 }
 
-unsigned char dsp3780I_ReadGenCfg(unsigned short usDspBaseIO,
-                                  unsigned uIndex)
-{
-	DSP_ISA_SLAVE_CONTROL rSlaveControl;
-	DSP_ISA_SLAVE_CONTROL rSlaveControl_Save;
-	unsigned char ucValue;
-
-
-	PRINTK_3(TRACE_3780I,
-		"3780i::dsp3780i_ReadGenCfg entry usDspBaseIO %x uIndex %x\n",
-		usDspBaseIO, uIndex);
-
-	MKBYTE(rSlaveControl) = InByteDsp(DSP_IsaSlaveControl);
-	rSlaveControl_Save = rSlaveControl;
-	rSlaveControl.ConfigMode = TRUE;
-	OutByteDsp(DSP_IsaSlaveControl, MKBYTE(rSlaveControl));
-	OutByteDsp(DSP_ConfigAddress, (unsigned char) uIndex);
-	ucValue = InByteDsp(DSP_ConfigData);
-	OutByteDsp(DSP_IsaSlaveControl, MKBYTE(rSlaveControl_Save));
-
-	PRINTK_2(TRACE_3780I,
-		"3780i::dsp3780i_ReadGenCfg exit ucValue %x\n", ucValue);
-
-
-	return ucValue;
-}
-
 int dsp3780I_EnableDSP(DSP_3780I_CONFIG_SETTINGS * pSettings,
                        unsigned short *pIrqMap,
                        unsigned short *pDmaMap)
--- linux-2.6.10-rc1-mm3-full/drivers/char/mwave/smapi.c.old	2004-11-07 00:30:15.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/mwave/smapi.c	2004-11-07 00:32:07.000000000 +0100
@@ -54,11 +54,11 @@
 static unsigned short g_usSmapiPort = 0;
 
 
-int smapi_request(unsigned short inBX, unsigned short inCX,
-                  unsigned short inDI, unsigned short inSI,
-                  unsigned short *outAX, unsigned short *outBX,
-                  unsigned short *outCX, unsigned short *outDX,
-                  unsigned short *outDI, unsigned short *outSI)
+static int smapi_request(unsigned short inBX, unsigned short inCX,
+                         unsigned short inDI, unsigned short inSI,
+                         unsigned short *outAX, unsigned short *outBX,
+                         unsigned short *outCX, unsigned short *outDX,
+                         unsigned short *outDI, unsigned short *outSI)
 {
 	unsigned short myoutAX = 2, *pmyoutAX = &myoutAX;
 	unsigned short myoutBX = 3, *pmyoutBX = &myoutBX;
@@ -511,8 +511,8 @@
 	return bRC;
 }
 
-
-int SmapiQuerySystemID(void)
+#if 0
+static int SmapiQuerySystemID(void)
 {
 	int bRC = -EIO;
 	unsigned short usAX = 0xffff, usBX = 0xffff, usCX = 0xffff,
@@ -531,7 +531,7 @@
 
 	return bRC;
 }
-
+#endif  /*  0  */
 
 int smapi_init(void)
 {
--- linux-2.6.10-rc1-mm3-full/drivers/char/mxser.c.old	2004-11-07 00:32:24.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/mxser.c	2004-11-07 00:33:20.000000000 +0100
@@ -321,7 +321,7 @@
 	0, 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800, 2400, 4800,
 	9600, 19200, 38400, 57600, 115200, 230400, 460800, 921600, 0};
 
-struct mxser_hwconf mxsercfg[MXSER_BOARDS];
+static struct mxser_hwconf mxsercfg[MXSER_BOARDS];
 
 /*
  * static functions:
@@ -389,7 +389,7 @@
 
 }
 
-int mxser_initbrd(int board, struct mxser_hwconf *hwconf)
+static int mxser_initbrd(int board, struct mxser_hwconf *hwconf)
 {
 	struct mxser_struct *info;
 	unsigned long flags;
--- linux-2.6.10-rc1-mm3-full/drivers/char/n_tty.c.old	2004-11-07 00:33:36.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/n_tty.c	2004-11-07 00:34:05.000000000 +0100
@@ -152,7 +152,7 @@
  *	lock_kernel() still.
  */
  
-void n_tty_flush_buffer(struct tty_struct * tty)
+static void n_tty_flush_buffer(struct tty_struct * tty)
 {
 	/* clear everything and unthrottle the driver */
 	reset_buffer_flags(tty);
@@ -174,7 +174,7 @@
  *	at this instant in time. 
  */
  
-ssize_t n_tty_chars_in_buffer(struct tty_struct *tty)
+static ssize_t n_tty_chars_in_buffer(struct tty_struct *tty)
 {
 	unsigned long flags;
 	ssize_t n = 0;
--- linux-2.6.10-rc1-mm3-full/drivers/char/pcmcia/synclink_cs.c.old	2004-11-07 00:36:23.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/pcmcia/synclink_cs.c	2004-11-07 00:39:15.000000000 +0100
@@ -923,7 +923,7 @@
 /* Return next bottom half action to perform.
  * or 0 if nothing to do.
  */
-int bh_action(MGSLPC_INFO *info)
+static int bh_action(MGSLPC_INFO *info)
 {
 	unsigned long flags;
 	int rc = 0;
@@ -1017,7 +1017,7 @@
 }
 
 /* eom: non-zero = end of frame */ 
-void rx_ready_hdlc(MGSLPC_INFO *info, int eom) 
+static void rx_ready_hdlc(MGSLPC_INFO *info, int eom) 
 {
 	unsigned char data[2];
 	unsigned char fifo_count, read_count, i;
@@ -1079,7 +1079,7 @@
 	issue_command(info, CHA, CMD_RXFIFO);
 }
 
-void rx_ready_async(MGSLPC_INFO *info, int tcd) 
+static void rx_ready_async(MGSLPC_INFO *info, int tcd) 
 {
 	unsigned char data, status;
 	int fifo_count;
@@ -1153,7 +1153,7 @@
 }
 
 
-void tx_done(MGSLPC_INFO *info) 
+static void tx_done(MGSLPC_INFO *info) 
 {
 	if (!info->tx_active)
 		return;
@@ -1190,7 +1190,7 @@
 	}
 }
 
-void tx_ready(MGSLPC_INFO *info) 
+static void tx_ready(MGSLPC_INFO *info) 
 {
 	unsigned char fifo_count = 32;
 	int c;
@@ -1239,7 +1239,7 @@
 	}
 }
 
-void cts_change(MGSLPC_INFO *info) 
+static void cts_change(MGSLPC_INFO *info) 
 {
 	get_signals(info);
 	if ((info->cts_chkcount)++ >= IO_PIN_SHUTDOWN_LIMIT)
@@ -1276,7 +1276,7 @@
 	info->pending_bh |= BH_STATUS;
 }
 
-void dcd_change(MGSLPC_INFO *info) 
+static void dcd_change(MGSLPC_INFO *info) 
 {
 	get_signals(info);
 	if ((info->dcd_chkcount)++ >= IO_PIN_SHUTDOWN_LIMIT)
@@ -1310,7 +1310,7 @@
 	info->pending_bh |= BH_STATUS;
 }
 
-void dsr_change(MGSLPC_INFO *info) 
+static void dsr_change(MGSLPC_INFO *info) 
 {
 	get_signals(info);
 	if ((info->dsr_chkcount)++ >= IO_PIN_SHUTDOWN_LIMIT)
@@ -1325,7 +1325,7 @@
 	info->pending_bh |= BH_STATUS;
 }
 
-void ri_change(MGSLPC_INFO *info) 
+static void ri_change(MGSLPC_INFO *info) 
 {
 	get_signals(info);
 	if ((info->ri_chkcount)++ >= IO_PIN_SHUTDOWN_LIMIT)
@@ -2955,7 +2955,7 @@
 
 /* Called to print information about devices
  */
-int mgslpc_read_proc(char *page, char **start, off_t off, int count,
+static int mgslpc_read_proc(char *page, char **start, off_t off, int count,
 		 int *eof, void *data)
 {
 	int len = 0, l;
@@ -3212,7 +3212,7 @@
 module_init(synclink_cs_init);
 module_exit(synclink_cs_exit);
 
-void mgslpc_set_rate(MGSLPC_INFO *info, unsigned char channel, unsigned int rate) 
+static void mgslpc_set_rate(MGSLPC_INFO *info, unsigned char channel, unsigned int rate) 
 {
 	unsigned int M, N;
 	unsigned char val;
@@ -3248,7 +3248,7 @@
 
 /* Enabled the AUX clock output at the specified frequency.
  */
-void enable_auxclk(MGSLPC_INFO *info)
+static void enable_auxclk(MGSLPC_INFO *info)
 {
 	unsigned char val;
 	
--- linux-2.6.10-rc1-mm3-full/drivers/char/pty.c.old	2004-11-07 00:39:33.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/pty.c	2004-11-07 00:39:53.000000000 +0100
@@ -35,7 +35,7 @@
 /* These are global because they are accessed in tty_io.c */
 #ifdef CONFIG_UNIX98_PTYS
 struct tty_driver *ptm_driver;
-struct tty_driver *pts_driver;
+static struct tty_driver *pts_driver;
 #endif
 
 static void pty_close(struct tty_struct * tty, struct file * filp)
--- linux-2.6.10-rc1-mm3-full/drivers/char/specialix.c.old	2004-11-07 00:55:20.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/specialix.c	2004-11-07 01:37:43.000000000 +0100
@@ -315,7 +315,7 @@
 
 
 /* Set the IRQ using the RTS lines that run to the PAL on the board.... */
-int sx_set_irq ( struct specialix_board *bp)
+static int sx_set_irq ( struct specialix_board *bp)
 {
 	int virq;
 	int i;
@@ -379,7 +379,7 @@
 }
 
 
-int read_cross_byte (struct specialix_board *bp, int reg, int bit)
+static int read_cross_byte (struct specialix_board *bp, int reg, int bit)
 {
 	int i;
 	int t;
@@ -878,7 +878,7 @@
  *  Routines for open & close processing.
  */
 
-void turn_ints_off (struct specialix_board *bp)
+static void turn_ints_off (struct specialix_board *bp)
 {
 	if (bp->flags & SX_BOARD_IS_PCI) {
 		/* This was intended for enabeling the interrupt on the
@@ -889,7 +889,7 @@
 	(void) sx_in_off (bp, 0); /* Turn off interrupts. */
 }
 
-void turn_ints_on (struct specialix_board *bp)
+static void turn_ints_on (struct specialix_board *bp)
 {
 	if (bp->flags & SX_BOARD_IS_PCI) {
 		/* play with the PCI chip. See comment above. */
@@ -2094,41 +2094,34 @@
 }
 
 
-#ifndef MODULE
+static int iobase[SX_NBOARD]  = {0,};
+
+static int irq [SX_NBOARD] = {0,};
+
+module_param_array(iobase, int, NULL, 0);
+module_param_array(irq, int, NULL, 0);
+
 /*
- * Called at boot time.
+ * You can setup up to 4 boards.
+ * by specifying "iobase=0xXXX,0xXXX ..." as insmod parameter.
+ * You should specify the IRQs too in that case "irq=....,...". 
  * 
- * You can specify IO base for up to SX_NBOARD cards,
- * using line "specialix=0xiobase1,0xiobase2,.." at LILO prompt.
- * Note that there will be no probing at default
- * addresses in this case.
+ * More than 4 boards in one computer is not possible, as the card can
+ * only use 4 different interrupts. 
  *
- */ 
-void specialix_setup(char *str, int * ints)
-{
-	int i;
-        
-	for (i=0;i<SX_NBOARD;i++) {
-		sx_board[i].base = 0;
-	}
-
-	for (i = 1; i <= ints[0]; i++) {
-		if (i&1)
-			sx_board[i/2].base = ints[i];
-		else
-			sx_board[i/2 -1].irq = ints[i];
-	}
-}
-#endif
-
-/* 
- * This routine must be called by kernel at boot time 
  */
 static int __init specialix_init(void)
 {
 	int i;
 	int found = 0;
 
+	if (iobase[0] || iobase[1] || iobase[2] || iobase[3]) {
+		for(i = 0; i < SX_NBOARD; i++) {
+			sx_board[i].base = iobase[i];
+			sx_board[i].irq = irq[i];
+		}
+	}
+
 	printk(KERN_INFO "sx: Specialix IO8+ driver v" VERSION ", (c) R.E.Wolff 1997/1998.\n");
 	printk(KERN_INFO "sx: derived from work (c) D.Gorodchanin 1994-1996.\n");
 #ifdef CONFIG_SPECIALIX_RTSCTS
@@ -2148,7 +2141,7 @@
 	{
 		struct pci_dev *pdev = NULL;
 
-		i=0;
+		i = 0;
 		while (i < SX_NBOARD) {
 			if (sx_board[i].flags & SX_BOARD_PRESENT) {
 				i++;
@@ -2181,38 +2174,8 @@
 
 	return 0;
 }
-
-int iobase[SX_NBOARD]  = {0,};
-
-int irq [SX_NBOARD] = {0,};
-
-module_param_array(iobase, int, NULL, 0);
-module_param_array(irq, int, NULL, 0);
-
-/*
- * You can setup up to 4 boards.
- * by specifying "iobase=0xXXX,0xXXX ..." as insmod parameter.
- * You should specify the IRQs too in that case "irq=....,...". 
- * 
- * More than 4 boards in one computer is not possible, as the card can
- * only use 4 different interrupts. 
- *
- */
-static int __init specialix_init_module(void)
-{
-	int i;
-
-	if (iobase[0] || iobase[1] || iobase[2] || iobase[3]) {
-		for(i = 0; i < SX_NBOARD; i++) {
-			sx_board[i].base = iobase[i];
-			sx_board[i].irq = irq[i];
-		}
-	}
-
-	return specialix_init();
-}
 	
-static void __exit specialix_exit_module(void)
+static void __exit specialix_exit(void)
 {
 	int i;
 	
@@ -2226,7 +2189,7 @@
 	
 }
 
-module_init(specialix_init_module);
-module_exit(specialix_exit_module);
+module_init(specialix_init);
+module_exit(specialix_exit);
 
 MODULE_LICENSE("GPL");
--- linux-2.6.10-rc1-mm3-full/drivers/char/stallion.c.old	2004-11-07 00:57:29.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/stallion.c	2004-11-07 01:39:31.000000000 +0100
@@ -240,7 +240,6 @@
 
 /*****************************************************************************/
 
-#ifdef MODULE
 /*
  *	Define some string labels for arguments passed from the module
  *	load line. These allow for easy board definitions, and easy
@@ -316,8 +315,6 @@
 MODULE_PARM(board3, "1-4s");
 MODULE_PARM_DESC(board3, "Board 3 config -> name[,ioaddr[,ioaddr2][,irq]]");
 
-#endif
-
 /*****************************************************************************/
 
 /*
@@ -472,14 +469,12 @@
  *	Declare all those functions in this driver!
  */
 
-#ifdef MODULE
 static void	stl_argbrds(void);
 static int	stl_parsebrd(stlconf_t *confp, char **argp);
 
 static unsigned long stl_atol(char *str);
-#endif
 
-int		stl_init(void);
+static int	stl_init(void);
 static int	stl_open(struct tty_struct *tty, struct file *filp);
 static void	stl_close(struct tty_struct *tty, struct file *filp);
 static int	stl_write(struct tty_struct *tty, const unsigned char *buf, int count);
@@ -735,20 +730,10 @@
 
 static struct class_simple *stallion_class;
 
-#ifdef MODULE
-
-/*
- *	Loadable module initialization stuff.
- */
-
-static int __init stallion_module_init(void)
+static int __init stallion_init(void)
 {
 	unsigned long	flags;
 
-#ifdef DEBUG
-	printk("init_module()\n");
-#endif
-
 	save_flags(flags);
 	cli();
 	stl_init();
@@ -759,7 +744,7 @@
 
 /*****************************************************************************/
 
-static void __exit stallion_module_exit(void)
+static void __exit stallion_exit(void)
 {
 	stlbrd_t	*brdp;
 	stlpanel_t	*panelp;
@@ -767,10 +752,6 @@
 	unsigned long	flags;
 	int		i, j, k;
 
-#ifdef DEBUG
-	printk("cleanup_module()\n");
-#endif
-
 	printk(KERN_INFO "Unloading %s: version %s\n", stl_drvtitle,
 		stl_drvversion);
 
@@ -838,8 +819,8 @@
 	restore_flags(flags);
 }
 
-module_init(stallion_module_init);
-module_exit(stallion_module_exit);
+module_init(stallion_init);
+module_exit(stallion_exit);
 
 /*****************************************************************************/
 
@@ -959,8 +940,6 @@
 	return(1);
 }
 
-#endif
-
 /*****************************************************************************/
 
 /*
@@ -2807,9 +2786,7 @@
  */
 	for (i = 0; (i < stl_nrbrds); i++) {
 		confp = &stl_brdconf[i];
-#ifdef MODULE
 		stl_parsebrd(confp, stl_brdsp[i]);
-#endif
 		if ((brdp = stl_allocbrd()) == (stlbrd_t *) NULL)
 			return(-ENOMEM);
 		brdp->brdnr = i;
@@ -2825,9 +2802,7 @@
  *	Find any dynamically supported boards. That is via module load
  *	line options or auto-detected on the PCI bus.
  */
-#ifdef MODULE
 	stl_argbrds();
-#endif
 #ifdef CONFIG_PCI
 	stl_findpcibrds();
 #endif
@@ -3098,7 +3073,7 @@
 
 /*****************************************************************************/
 
-int __init stl_init(void)
+static int __init stl_init(void)
 {
 	int i;
 	printk(KERN_INFO "%s: version %s\n", stl_drvtitle, stl_drvversion);
--- linux-2.6.10-rc1-mm3-full/drivers/char/synclink.c.old	2004-11-07 00:59:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/synclink.c	2004-11-07 01:42:07.000000000 +0100
@@ -53,7 +53,6 @@
  * OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-#define VERSION(ver,rel,seq) (((ver)<<16) | ((rel)<<8) | (seq))
 #if defined(__i386__)
 #  define BREAKPOINT() asm("   int $3");
 #else
@@ -118,7 +117,7 @@
 
 #define RCLRVALUE 0xffff
 
-MGSL_PARAMS default_params = {
+static MGSL_PARAMS default_params = {
 	MGSL_MODE_HDLC,			/* unsigned long mode */
 	0,				/* unsigned char loopback; */
 	HDLC_FLAG_UNDERRUN_ABORT15,	/* unsigned short flags; */
@@ -679,13 +678,13 @@
 #define usc_EnableReceiver(a,b) \
 	usc_OutReg( (a), RMR, (u16)((usc_InReg((a),RMR) & 0xfffc) | (b)) )
 
-u16  usc_InDmaReg( struct mgsl_struct *info, u16 Port );
-void usc_OutDmaReg( struct mgsl_struct *info, u16 Port, u16 Value );
-void usc_DmaCmd( struct mgsl_struct *info, u16 Cmd );
-
-u16  usc_InReg( struct mgsl_struct *info, u16 Port );
-void usc_OutReg( struct mgsl_struct *info, u16 Port, u16 Value );
-void usc_RTCmd( struct mgsl_struct *info, u16 Cmd );
+static u16  usc_InDmaReg( struct mgsl_struct *info, u16 Port );
+static void usc_OutDmaReg( struct mgsl_struct *info, u16 Port, u16 Value );
+static void usc_DmaCmd( struct mgsl_struct *info, u16 Cmd );
+
+static u16  usc_InReg( struct mgsl_struct *info, u16 Port );
+static void usc_OutReg( struct mgsl_struct *info, u16 Port, u16 Value );
+static void usc_RTCmd( struct mgsl_struct *info, u16 Cmd );
 void usc_RCmd( struct mgsl_struct *info, u16 Cmd );
 void usc_TCmd( struct mgsl_struct *info, u16 Cmd );
 
@@ -694,40 +693,39 @@
 
 #define usc_SetTransmitSyncChars(a,s0,s1) usc_OutReg((a), TSR, (u16)(((u16)s0<<8)|(u16)s1))
 
-void usc_process_rxoverrun_sync( struct mgsl_struct *info );
-void usc_start_receiver( struct mgsl_struct *info );
-void usc_stop_receiver( struct mgsl_struct *info );
+static void usc_process_rxoverrun_sync( struct mgsl_struct *info );
+static void usc_start_receiver( struct mgsl_struct *info );
+static void usc_stop_receiver( struct mgsl_struct *info );
 
-void usc_start_transmitter( struct mgsl_struct *info );
-void usc_stop_transmitter( struct mgsl_struct *info );
-void usc_set_txidle( struct mgsl_struct *info );
-void usc_load_txfifo( struct mgsl_struct *info );
+static void usc_start_transmitter( struct mgsl_struct *info );
+static void usc_stop_transmitter( struct mgsl_struct *info );
+static void usc_set_txidle( struct mgsl_struct *info );
+static void usc_load_txfifo( struct mgsl_struct *info );
 
-void usc_enable_aux_clock( struct mgsl_struct *info, u32 DataRate );
-void usc_enable_loopback( struct mgsl_struct *info, int enable );
+static void usc_enable_aux_clock( struct mgsl_struct *info, u32 DataRate );
+static void usc_enable_loopback( struct mgsl_struct *info, int enable );
 
-void usc_get_serial_signals( struct mgsl_struct *info );
-void usc_set_serial_signals( struct mgsl_struct *info );
+static void usc_get_serial_signals( struct mgsl_struct *info );
+static void usc_set_serial_signals( struct mgsl_struct *info );
 
-void usc_reset( struct mgsl_struct *info );
+static void usc_reset( struct mgsl_struct *info );
 
-void usc_set_sync_mode( struct mgsl_struct *info );
-void usc_set_sdlc_mode( struct mgsl_struct *info );
-void usc_set_async_mode( struct mgsl_struct *info );
-void usc_enable_async_clock( struct mgsl_struct *info, u32 DataRate );
+static void usc_set_sync_mode( struct mgsl_struct *info );
+static void usc_set_sdlc_mode( struct mgsl_struct *info );
+static void usc_set_async_mode( struct mgsl_struct *info );
+static void usc_enable_async_clock( struct mgsl_struct *info, u32 DataRate );
 
-void usc_loopback_frame( struct mgsl_struct *info );
+static void usc_loopback_frame( struct mgsl_struct *info );
 
-void mgsl_tx_timeout(unsigned long context);
+static void mgsl_tx_timeout(unsigned long context);
 
 
-void usc_loopmode_cancel_transmit( struct mgsl_struct * info );
-void usc_loopmode_insert_request( struct mgsl_struct * info );
-int usc_loopmode_active( struct mgsl_struct * info);
-void usc_loopmode_send_done( struct mgsl_struct * info );
-int usc_loopmode_send_active( struct mgsl_struct * info );
+static void usc_loopmode_cancel_transmit( struct mgsl_struct * info );
+static void usc_loopmode_insert_request( struct mgsl_struct * info );
+static int usc_loopmode_active( struct mgsl_struct * info);
+static void usc_loopmode_send_done( struct mgsl_struct * info );
 
-int mgsl_ioctl_common(struct mgsl_struct *info, unsigned int cmd, unsigned long arg);
+static int mgsl_ioctl_common(struct mgsl_struct *info, unsigned int cmd, unsigned long arg);
 
 #ifdef CONFIG_HDLC
 #define dev_to_port(D) (dev_to_hdlc(D)->priv)
@@ -753,77 +751,77 @@
 ((Nrdd)   << 11) + \
 ((Nrad)   <<  6) )
 
-void mgsl_trace_block(struct mgsl_struct *info,const char* data, int count, int xmit);
+static void mgsl_trace_block(struct mgsl_struct *info,const char* data, int count, int xmit);
 
 /*
  * Adapter diagnostic routines
  */
-BOOLEAN mgsl_register_test( struct mgsl_struct *info );
-BOOLEAN mgsl_irq_test( struct mgsl_struct *info );
-BOOLEAN mgsl_dma_test( struct mgsl_struct *info );
-BOOLEAN mgsl_memory_test( struct mgsl_struct *info );
-int mgsl_adapter_test( struct mgsl_struct *info );
+static BOOLEAN mgsl_register_test( struct mgsl_struct *info );
+static BOOLEAN mgsl_irq_test( struct mgsl_struct *info );
+static BOOLEAN mgsl_dma_test( struct mgsl_struct *info );
+static BOOLEAN mgsl_memory_test( struct mgsl_struct *info );
+static int mgsl_adapter_test( struct mgsl_struct *info );
 
 /*
  * device and resource management routines
  */
-int mgsl_claim_resources(struct mgsl_struct *info);
-void mgsl_release_resources(struct mgsl_struct *info);
-void mgsl_add_device(struct mgsl_struct *info);
-struct mgsl_struct* mgsl_allocate_device(void);
+static int mgsl_claim_resources(struct mgsl_struct *info);
+static void mgsl_release_resources(struct mgsl_struct *info);
+static void mgsl_add_device(struct mgsl_struct *info);
+static struct mgsl_struct* mgsl_allocate_device(void);
 
 /*
  * DMA buffer manupulation functions.
  */
-void mgsl_free_rx_frame_buffers( struct mgsl_struct *info, unsigned int StartIndex, unsigned int EndIndex );
-int  mgsl_get_rx_frame( struct mgsl_struct *info );
-int  mgsl_get_raw_rx_frame( struct mgsl_struct *info );
-void mgsl_reset_rx_dma_buffers( struct mgsl_struct *info );
-void mgsl_reset_tx_dma_buffers( struct mgsl_struct *info );
-int num_free_tx_dma_buffers(struct mgsl_struct *info);
-void mgsl_load_tx_dma_buffer( struct mgsl_struct *info, const char *Buffer, unsigned int BufferSize);
-void mgsl_load_pci_memory(char* TargetPtr, const char* SourcePtr, unsigned short count);
+static void mgsl_free_rx_frame_buffers( struct mgsl_struct *info, unsigned int StartIndex, unsigned int EndIndex );
+static int  mgsl_get_rx_frame( struct mgsl_struct *info );
+static int  mgsl_get_raw_rx_frame( struct mgsl_struct *info );
+static void mgsl_reset_rx_dma_buffers( struct mgsl_struct *info );
+static void mgsl_reset_tx_dma_buffers( struct mgsl_struct *info );
+static int num_free_tx_dma_buffers(struct mgsl_struct *info);
+static void mgsl_load_tx_dma_buffer( struct mgsl_struct *info, const char *Buffer, unsigned int BufferSize);
+static void mgsl_load_pci_memory(char* TargetPtr, const char* SourcePtr, unsigned short count);
 
 /*
  * DMA and Shared Memory buffer allocation and formatting
  */
-int  mgsl_allocate_dma_buffers(struct mgsl_struct *info);
-void mgsl_free_dma_buffers(struct mgsl_struct *info);
-int  mgsl_alloc_frame_memory(struct mgsl_struct *info, DMABUFFERENTRY *BufferList,int Buffercount);
-void mgsl_free_frame_memory(struct mgsl_struct *info, DMABUFFERENTRY *BufferList,int Buffercount);
-int  mgsl_alloc_buffer_list_memory(struct mgsl_struct *info);
-void mgsl_free_buffer_list_memory(struct mgsl_struct *info);
-int mgsl_alloc_intermediate_rxbuffer_memory(struct mgsl_struct *info);
-void mgsl_free_intermediate_rxbuffer_memory(struct mgsl_struct *info);
-int mgsl_alloc_intermediate_txbuffer_memory(struct mgsl_struct *info);
-void mgsl_free_intermediate_txbuffer_memory(struct mgsl_struct *info);
-int load_next_tx_holding_buffer(struct mgsl_struct *info);
-int save_tx_buffer_request(struct mgsl_struct *info,const char *Buffer, unsigned int BufferSize);
+static int  mgsl_allocate_dma_buffers(struct mgsl_struct *info);
+static void mgsl_free_dma_buffers(struct mgsl_struct *info);
+static int  mgsl_alloc_frame_memory(struct mgsl_struct *info, DMABUFFERENTRY *BufferList,int Buffercount);
+static void mgsl_free_frame_memory(struct mgsl_struct *info, DMABUFFERENTRY *BufferList,int Buffercount);
+static int  mgsl_alloc_buffer_list_memory(struct mgsl_struct *info);
+static void mgsl_free_buffer_list_memory(struct mgsl_struct *info);
+static int mgsl_alloc_intermediate_rxbuffer_memory(struct mgsl_struct *info);
+static void mgsl_free_intermediate_rxbuffer_memory(struct mgsl_struct *info);
+static int mgsl_alloc_intermediate_txbuffer_memory(struct mgsl_struct *info);
+static void mgsl_free_intermediate_txbuffer_memory(struct mgsl_struct *info);
+static int load_next_tx_holding_buffer(struct mgsl_struct *info);
+static int save_tx_buffer_request(struct mgsl_struct *info,const char *Buffer, unsigned int BufferSize);
 
 /*
  * Bottom half interrupt handlers
  */
-void mgsl_bh_handler(void* Context);
-void mgsl_bh_receive(struct mgsl_struct *info);
-void mgsl_bh_transmit(struct mgsl_struct *info);
-void mgsl_bh_status(struct mgsl_struct *info);
+static void mgsl_bh_handler(void* Context);
+static void mgsl_bh_receive(struct mgsl_struct *info);
+static void mgsl_bh_transmit(struct mgsl_struct *info);
+static void mgsl_bh_status(struct mgsl_struct *info);
 
 /*
  * Interrupt handler routines and dispatch table.
  */
-void mgsl_isr_null( struct mgsl_struct *info );
-void mgsl_isr_transmit_data( struct mgsl_struct *info );
-void mgsl_isr_receive_data( struct mgsl_struct *info );
-void mgsl_isr_receive_status( struct mgsl_struct *info );
-void mgsl_isr_transmit_status( struct mgsl_struct *info );
-void mgsl_isr_io_pin( struct mgsl_struct *info );
-void mgsl_isr_misc( struct mgsl_struct *info );
-void mgsl_isr_receive_dma( struct mgsl_struct *info );
-void mgsl_isr_transmit_dma( struct mgsl_struct *info );
+static void mgsl_isr_null( struct mgsl_struct *info );
+static void mgsl_isr_transmit_data( struct mgsl_struct *info );
+static void mgsl_isr_receive_data( struct mgsl_struct *info );
+static void mgsl_isr_receive_status( struct mgsl_struct *info );
+static void mgsl_isr_transmit_status( struct mgsl_struct *info );
+static void mgsl_isr_io_pin( struct mgsl_struct *info );
+static void mgsl_isr_misc( struct mgsl_struct *info );
+static void mgsl_isr_receive_dma( struct mgsl_struct *info );
+static void mgsl_isr_transmit_dma( struct mgsl_struct *info );
 
 typedef void (*isr_dispatch_func)(struct mgsl_struct *);
 
-isr_dispatch_func UscIsrTable[7] =
+static isr_dispatch_func UscIsrTable[7] =
 {
 	mgsl_isr_null,
 	mgsl_isr_misc,
@@ -858,7 +856,7 @@
 /*
  * Global linked list of SyncLink devices
  */
-struct mgsl_struct *mgsl_device_list;
+static struct mgsl_struct *mgsl_device_list;
 static int mgsl_device_count;
 
 /*
@@ -935,7 +933,7 @@
  * (gdb) to get the .text address for the add-symbol-file command.
  * This allows remote debugging of dynamically loadable modules.
  */
-void* mgsl_get_text_ptr(void)
+static void* mgsl_get_text_ptr(void)
 {
 	return mgsl_get_text_ptr;
 }
@@ -1052,7 +1050,7 @@
 /* mgsl_bh_action()	Return next bottom half action to perform.
  * Return Value:	BH action code or 0 if nothing to do.
  */
-int mgsl_bh_action(struct mgsl_struct *info)
+static int mgsl_bh_action(struct mgsl_struct *info)
 {
 	unsigned long flags;
 	int rc = 0;
@@ -1084,7 +1082,7 @@
 /*
  * 	Perform bottom half processing of work items queued by ISR.
  */
-void mgsl_bh_handler(void* Context)
+static void mgsl_bh_handler(void* Context)
 {
 	struct mgsl_struct *info = (struct mgsl_struct*)Context;
 	int action;
@@ -1128,7 +1126,7 @@
 			__FILE__,__LINE__,info->device_name);
 }
 
-void mgsl_bh_receive(struct mgsl_struct *info)
+static void mgsl_bh_receive(struct mgsl_struct *info)
 {
 	int (*get_rx_frame)(struct mgsl_struct *info) =
 		(info->params.mode == MGSL_MODE_HDLC ? mgsl_get_rx_frame : mgsl_get_raw_rx_frame);
@@ -1149,7 +1147,7 @@
 	} while(get_rx_frame(info));
 }
 
-void mgsl_bh_transmit(struct mgsl_struct *info)
+static void mgsl_bh_transmit(struct mgsl_struct *info)
 {
 	struct tty_struct *tty = info->tty;
 	unsigned long flags;
@@ -1172,7 +1170,7 @@
 	spin_unlock_irqrestore(&info->irq_spinlock,flags);
 }
 
-void mgsl_bh_status(struct mgsl_struct *info)
+static void mgsl_bh_status(struct mgsl_struct *info)
 {
 	if ( debug_level >= DEBUG_LEVEL_BH )
 		printk( "%s(%d):mgsl_bh_status() entry on %s\n",
@@ -1193,7 +1191,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	None
  */
-void mgsl_isr_receive_status( struct mgsl_struct *info )
+static void mgsl_isr_receive_status( struct mgsl_struct *info )
 {
 	u16 status = usc_InReg( info, RCSR );
 
@@ -1245,7 +1243,7 @@
  * Arguments:		info	       pointer to device instance data
  * Return Value:	None
  */
-void mgsl_isr_transmit_status( struct mgsl_struct *info )
+static void mgsl_isr_transmit_status( struct mgsl_struct *info )
 {
 	u16 status = usc_InReg( info, TCSR );
 
@@ -1312,7 +1310,7 @@
  * Arguments:		info	       pointer to device instance data
  * Return Value:	None
  */
-void mgsl_isr_io_pin( struct mgsl_struct *info )
+static void mgsl_isr_io_pin( struct mgsl_struct *info )
 {
  	struct	mgsl_icount *icount;
 	u16 status = usc_InReg( info, MISR );
@@ -1430,7 +1428,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	None
  */
-void mgsl_isr_transmit_data( struct mgsl_struct *info )
+static void mgsl_isr_transmit_data( struct mgsl_struct *info )
 {
 	if ( debug_level >= DEBUG_LEVEL_ISR )	
 		printk("%s(%d):mgsl_isr_transmit_data xmit_cnt=%d\n",
@@ -1462,7 +1460,7 @@
  * Arguments:		info		pointer to device instance data
  * Return Value:	None
  */
-void mgsl_isr_receive_data( struct mgsl_struct *info )
+static void mgsl_isr_receive_data( struct mgsl_struct *info )
 {
 	int Fifocount;
 	u16 status;
@@ -1574,7 +1572,7 @@
  * Arguments:		info		pointer to device extension (instance data)
  * Return Value:	None
  */
-void mgsl_isr_misc( struct mgsl_struct *info )
+static void mgsl_isr_misc( struct mgsl_struct *info )
 {
 	u16 status = usc_InReg( info, MISR );
 
@@ -1610,7 +1608,7 @@
  * Arguments:		info		pointer to device extension (instance data)
  * Return Value:	None
  */
-void mgsl_isr_null( struct mgsl_struct *info )
+static void mgsl_isr_null( struct mgsl_struct *info )
 {
 
 }	/* end of mgsl_isr_null() */
@@ -1634,7 +1632,7 @@
  * Arguments:		info		pointer to device instance data
  * Return Value:	None
  */
-void mgsl_isr_receive_dma( struct mgsl_struct *info )
+static void mgsl_isr_receive_dma( struct mgsl_struct *info )
 {
 	u16 status;
 	
@@ -1678,7 +1676,7 @@
  * Arguments:		info		pointer to device instance data
  * Return Value:	None
  */
-void mgsl_isr_transmit_dma( struct mgsl_struct *info )
+static void mgsl_isr_transmit_dma( struct mgsl_struct *info )
 {
 	u16 status;
 
@@ -2990,7 +2988,7 @@
 	return mgsl_ioctl_common(info, cmd, arg);
 }
 
-int mgsl_ioctl_common(struct mgsl_struct *info, unsigned int cmd, unsigned long arg)
+static int mgsl_ioctl_common(struct mgsl_struct *info, unsigned int cmd, unsigned long arg)
 {
 	int error;
 	struct mgsl_icount cnow;	/* kernel counter temps */
@@ -3649,7 +3647,7 @@
  * 	
  * Return Value:
  */
-int mgsl_read_proc(char *page, char **start, off_t off, int count,
+static int mgsl_read_proc(char *page, char **start, off_t off, int count,
 		 int *eof, void *data)
 {
 	int len = 0, l;
@@ -3688,7 +3686,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	0 if success, otherwise error
  */
-int mgsl_allocate_dma_buffers(struct mgsl_struct *info)
+static int mgsl_allocate_dma_buffers(struct mgsl_struct *info)
 {
 	unsigned short BuffersPerFrame;
 
@@ -3795,7 +3793,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	0 if success, otherwise error
  */
-int mgsl_alloc_buffer_list_memory( struct mgsl_struct *info )
+static int mgsl_alloc_buffer_list_memory( struct mgsl_struct *info )
 {
 	unsigned int i;
 
@@ -3880,7 +3878,7 @@
  * 	the buffer list contains the information necessary to free
  * 	the individual buffers!
  */
-void mgsl_free_buffer_list_memory( struct mgsl_struct *info )
+static void mgsl_free_buffer_list_memory( struct mgsl_struct *info )
 {
 	if ( info->buffer_list && info->bus_type != MGSL_BUS_TYPE_PCI )
 		kfree(info->buffer_list);
@@ -3907,7 +3905,7 @@
  * 
  * Return Value:	0 if success, otherwise -ENOMEM
  */
-int mgsl_alloc_frame_memory(struct mgsl_struct *info,DMABUFFERENTRY *BufferList,int Buffercount)
+static int mgsl_alloc_frame_memory(struct mgsl_struct *info,DMABUFFERENTRY *BufferList,int Buffercount)
 {
 	int i;
 	unsigned long phys_addr;
@@ -3949,7 +3947,7 @@
  * 
  * Return Value:	None
  */
-void mgsl_free_frame_memory(struct mgsl_struct *info, DMABUFFERENTRY *BufferList, int Buffercount)
+static void mgsl_free_frame_memory(struct mgsl_struct *info, DMABUFFERENTRY *BufferList, int Buffercount)
 {
 	int i;
 
@@ -3972,7 +3970,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	None
  */
-void mgsl_free_dma_buffers( struct mgsl_struct *info )
+static void mgsl_free_dma_buffers( struct mgsl_struct *info )
 {
 	mgsl_free_frame_memory( info, info->rx_buffer_list, info->rx_buffer_count );
 	mgsl_free_frame_memory( info, info->tx_buffer_list, info->tx_buffer_count );
@@ -3993,7 +3991,7 @@
  * 
  * Return Value:	0 if success, otherwise -ENOMEM
  */
-int mgsl_alloc_intermediate_rxbuffer_memory(struct mgsl_struct *info)
+static int mgsl_alloc_intermediate_rxbuffer_memory(struct mgsl_struct *info)
 {
 	info->intermediate_rxbuffer = kmalloc(info->max_frame_size, GFP_KERNEL | GFP_DMA);
 	if ( info->intermediate_rxbuffer == NULL )
@@ -4013,7 +4011,7 @@
  * 
  * Return Value:	None
  */
-void mgsl_free_intermediate_rxbuffer_memory(struct mgsl_struct *info)
+static void mgsl_free_intermediate_rxbuffer_memory(struct mgsl_struct *info)
 {
 	if ( info->intermediate_rxbuffer )
 		kfree(info->intermediate_rxbuffer);
@@ -4035,7 +4033,7 @@
  *
  * Return Value:	0 if success, otherwise -ENOMEM
  */
-int mgsl_alloc_intermediate_txbuffer_memory(struct mgsl_struct *info)
+static int mgsl_alloc_intermediate_txbuffer_memory(struct mgsl_struct *info)
 {
 	int i;
 
@@ -4066,7 +4064,7 @@
  *
  * Return Value:	None
  */
-void mgsl_free_intermediate_txbuffer_memory(struct mgsl_struct *info)
+static void mgsl_free_intermediate_txbuffer_memory(struct mgsl_struct *info)
 {
 	int i;
 
@@ -4098,7 +4096,7 @@
  * 			into adapter's tx dma buffer,
  * 			0 otherwise
  */
-int load_next_tx_holding_buffer(struct mgsl_struct *info)
+static int load_next_tx_holding_buffer(struct mgsl_struct *info)
 {
 	int ret = 0;
 
@@ -4144,7 +4142,7 @@
  *
  * Return Value:	1 if able to store, 0 otherwise
  */
-int save_tx_buffer_request(struct mgsl_struct *info,const char *Buffer, unsigned int BufferSize)
+static int save_tx_buffer_request(struct mgsl_struct *info,const char *Buffer, unsigned int BufferSize)
 {
 	struct tx_holding_buffer *ptx;
 
@@ -4163,7 +4161,7 @@
 	return 1;
 }
 
-int mgsl_claim_resources(struct mgsl_struct *info)
+static int mgsl_claim_resources(struct mgsl_struct *info)
 {
 	if (request_region(info->io_base,info->io_addr_size,"synclink") == NULL) {
 		printk( "%s(%d):I/O address conflict on device %s Addr=%08X\n",
@@ -4243,7 +4241,7 @@
 
 }	/* end of mgsl_claim_resources() */
 
-void mgsl_release_resources(struct mgsl_struct *info)
+static void mgsl_release_resources(struct mgsl_struct *info)
 {
 	if ( debug_level >= DEBUG_LEVEL_INFO )
 		printk( "%s(%d):mgsl_release_resources(%s) entry\n",
@@ -4297,7 +4295,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	None
  */
-void mgsl_add_device( struct mgsl_struct *info )
+static void mgsl_add_device( struct mgsl_struct *info )
 {
 	info->next_device = NULL;
 	info->line = mgsl_device_count;
@@ -4363,7 +4361,7 @@
  * Arguments:		none
  * Return Value:	pointer to mgsl_struct if success, otherwise NULL
  */
-struct mgsl_struct* mgsl_allocate_device(void)
+static struct mgsl_struct* mgsl_allocate_device(void)
 {
 	struct mgsl_struct *info;
 	
@@ -4582,7 +4580,7 @@
  *
  *    None
  */
-void usc_RTCmd( struct mgsl_struct *info, u16 Cmd )
+static void usc_RTCmd( struct mgsl_struct *info, u16 Cmd )
 {
 	/* output command to CCAR in bits <15..11> */
 	/* preserve bits <10..7>, bits <6..0> must be zero */
@@ -4609,7 +4607,7 @@
  *
  *       None
  */
-void usc_DmaCmd( struct mgsl_struct *info, u16 Cmd )
+static void usc_DmaCmd( struct mgsl_struct *info, u16 Cmd )
 {
 	/* write command mask to DCAR */
 	outw( Cmd + info->mbre_bit, info->io_base );
@@ -4636,7 +4634,7 @@
  *    None
  *
  */
-void usc_OutDmaReg( struct mgsl_struct *info, u16 RegAddr, u16 RegValue )
+static void usc_OutDmaReg( struct mgsl_struct *info, u16 RegAddr, u16 RegValue )
 {
 	/* Note: The DCAR is located at the adapter base address */
 	/* Note: must preserve state of BIT8 in DCAR */
@@ -4665,7 +4663,7 @@
  *    The 16-bit value read from register
  *
  */
-u16 usc_InDmaReg( struct mgsl_struct *info, u16 RegAddr )
+static u16 usc_InDmaReg( struct mgsl_struct *info, u16 RegAddr )
 {
 	/* Note: The DCAR is located at the adapter base address */
 	/* Note: must preserve state of BIT8 in DCAR */
@@ -4692,7 +4690,7 @@
  *    None
  *
  */
-void usc_OutReg( struct mgsl_struct *info, u16 RegAddr, u16 RegValue )
+static void usc_OutReg( struct mgsl_struct *info, u16 RegAddr, u16 RegValue )
 {
 	outw( RegAddr + info->loopback_bits, info->io_base + CCAR );
 	outw( RegValue, info->io_base + CCAR );
@@ -4717,7 +4715,7 @@
  *
  *    16-bit value read from register
  */
-u16 usc_InReg( struct mgsl_struct *info, u16 RegAddr )
+static u16 usc_InReg( struct mgsl_struct *info, u16 RegAddr )
 {
 	outw( RegAddr + info->loopback_bits, info->io_base + CCAR );
 	return inw( info->io_base + CCAR );
@@ -4731,7 +4729,7 @@
  * Arguments:		info    pointer to device instance data
  * Return Value: 	NONE
  */
-void usc_set_sdlc_mode( struct mgsl_struct *info )
+static void usc_set_sdlc_mode( struct mgsl_struct *info )
 {
 	u16 RegValue;
 	int PreSL1660;
@@ -5311,7 +5309,7 @@
  *			enable	1 = enable loopback, 0 = disable
  * Return Value:	None
  */
-void usc_enable_loopback(struct mgsl_struct *info, int enable)
+static void usc_enable_loopback(struct mgsl_struct *info, int enable)
 {
 	if (enable) {
 		/* blank external TXD output */
@@ -5375,7 +5373,7 @@
  *
  * Return Value:	None
  */
-void usc_enable_aux_clock( struct mgsl_struct *info, u32 data_rate )
+static void usc_enable_aux_clock( struct mgsl_struct *info, u32 data_rate )
 {
 	u32 XtalSpeed;
 	u16 Tc;
@@ -5432,7 +5430,7 @@
  *
  * Return Value: None
  */
-void usc_process_rxoverrun_sync( struct mgsl_struct *info )
+static void usc_process_rxoverrun_sync( struct mgsl_struct *info )
 {
 	int start_index;
 	int end_index;
@@ -5571,7 +5569,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	None
  */
-void usc_stop_receiver( struct mgsl_struct *info )
+static void usc_stop_receiver( struct mgsl_struct *info )
 {
 	if (debug_level >= DEBUG_LEVEL_ISR)
 		printk("%s(%d):usc_stop_receiver(%s)\n",
@@ -5604,7 +5602,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	None
  */
-void usc_start_receiver( struct mgsl_struct *info )
+static void usc_start_receiver( struct mgsl_struct *info )
 {
 	u32 phys_addr;
 	
@@ -5668,7 +5666,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	None
  */
-void usc_start_transmitter( struct mgsl_struct *info )
+static void usc_start_transmitter( struct mgsl_struct *info )
 {
 	u32 phys_addr;
 	unsigned int FrameSize;
@@ -5774,7 +5772,7 @@
  * Arguments:		info	pointer to device isntance data
  * Return Value:	None
  */
-void usc_stop_transmitter( struct mgsl_struct *info )
+static void usc_stop_transmitter( struct mgsl_struct *info )
 {
 	if (debug_level >= DEBUG_LEVEL_ISR)
 		printk("%s(%d):usc_stop_transmitter(%s)\n",
@@ -5803,7 +5801,7 @@
  * Arguments:		info	pointer to device extension (instance data)
  * Return Value:	None
  */
-void usc_load_txfifo( struct mgsl_struct *info )
+static void usc_load_txfifo( struct mgsl_struct *info )
 {
 	int Fifocount;
 	u8 TwoBytes[2];
@@ -5860,7 +5858,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	None
  */
-void usc_reset( struct mgsl_struct *info )
+static void usc_reset( struct mgsl_struct *info )
 {
 	if ( info->bus_type == MGSL_BUS_TYPE_PCI ) {
 		int i;
@@ -5974,7 +5972,7 @@
  * Arguments:		info		pointer to device instance data
  * Return Value:	None
  */
-void usc_set_async_mode( struct mgsl_struct *info )
+static void usc_set_async_mode( struct mgsl_struct *info )
 {
 	u16 RegValue;
 
@@ -6167,7 +6165,7 @@
  * Arguments:		info		pointer to device instance data
  * Return Value:	None
  */
-void usc_loopback_frame( struct mgsl_struct *info )
+static void usc_loopback_frame( struct mgsl_struct *info )
 {
 	int i;
 	unsigned long oldmode = info->params.mode;
@@ -6235,7 +6233,7 @@
  * Arguments:		info	pointer to adapter info structure
  * Return Value:	None
  */
-void usc_set_sync_mode( struct mgsl_struct *info )
+static void usc_set_sync_mode( struct mgsl_struct *info )
 {
 	usc_loopback_frame( info );
 	usc_set_sdlc_mode( info );
@@ -6258,7 +6256,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	None
  */
-void usc_set_txidle( struct mgsl_struct *info )
+static void usc_set_txidle( struct mgsl_struct *info )
 {
 	u16 usc_idle_mode = IDLEMODE_FLAGS;
 
@@ -6321,7 +6319,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	None
  */
-void usc_get_serial_signals( struct mgsl_struct *info )
+static void usc_get_serial_signals( struct mgsl_struct *info )
 {
 	u16 status;
 
@@ -6357,7 +6355,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	None
  */
-void usc_set_serial_signals( struct mgsl_struct *info )
+static void usc_set_serial_signals( struct mgsl_struct *info )
 {
 	u16 Control;
 	unsigned char V24Out = info->serial_signals;
@@ -6389,7 +6387,7 @@
  *					0 disables the AUX clock.
  * Return Value:	None
  */
-void usc_enable_async_clock( struct mgsl_struct *info, u32 data_rate )
+static void usc_enable_async_clock( struct mgsl_struct *info, u32 data_rate )
 {
 	if ( data_rate )	{
 		/*
@@ -6499,7 +6497,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	None
  */
-void mgsl_reset_tx_dma_buffers( struct mgsl_struct *info )
+static void mgsl_reset_tx_dma_buffers( struct mgsl_struct *info )
 {
 	unsigned int i;
 
@@ -6525,7 +6523,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	number of free tx dma buffers
  */
-int num_free_tx_dma_buffers(struct mgsl_struct *info)
+static int num_free_tx_dma_buffers(struct mgsl_struct *info)
 {
 	return info->tx_buffer_count - info->tx_dma_buffers_used;
 }
@@ -6540,7 +6538,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	None
  */
-void mgsl_reset_rx_dma_buffers( struct mgsl_struct *info )
+static void mgsl_reset_rx_dma_buffers( struct mgsl_struct *info )
 {
 	unsigned int i;
 
@@ -6568,7 +6566,7 @@
  * 
  * Return Value:	None
  */
-void mgsl_free_rx_frame_buffers( struct mgsl_struct *info, unsigned int StartIndex, unsigned int EndIndex )
+static void mgsl_free_rx_frame_buffers( struct mgsl_struct *info, unsigned int StartIndex, unsigned int EndIndex )
 {
 	int Done = 0;
 	DMABUFFERENTRY *pBufEntry;
@@ -6611,7 +6609,7 @@
  * Arguments:	 	info	pointer to device extension
  * Return Value:	1 if frame returned, otherwise 0
  */
-int mgsl_get_rx_frame(struct mgsl_struct *info)
+static int mgsl_get_rx_frame(struct mgsl_struct *info)
 {
 	unsigned int StartIndex, EndIndex;	/* index of 1st and last buffers of Rx frame */
 	unsigned short status;
@@ -6810,7 +6808,7 @@
  * Arguments:	 	info	pointer to device extension
  * Return Value:	1 if frame returned, otherwise 0
  */
-int mgsl_get_raw_rx_frame(struct mgsl_struct *info)
+static int mgsl_get_raw_rx_frame(struct mgsl_struct *info)
 {
 	unsigned int CurrentIndex, NextIndex;
 	unsigned short status;
@@ -6975,8 +6973,8 @@
  * 
  * Return Value: 	None
  */
-void mgsl_load_tx_dma_buffer(struct mgsl_struct *info, const char *Buffer,
-	 unsigned int BufferSize)
+static void mgsl_load_tx_dma_buffer(struct mgsl_struct *info,
+		const char *Buffer, unsigned int BufferSize)
 {
 	unsigned short Copycount;
 	unsigned int i = 0;
@@ -7052,7 +7050,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:		TRUE if test passed, otherwise FALSE
  */
-BOOLEAN mgsl_register_test( struct mgsl_struct *info )
+static BOOLEAN mgsl_register_test( struct mgsl_struct *info )
 {
 	static unsigned short BitPatterns[] =
 		{ 0x0000, 0xffff, 0xaaaa, 0x5555, 0x1234, 0x6969, 0x9696, 0x0f0f };
@@ -7108,7 +7106,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	TRUE if test passed, otherwise FALSE
  */
-BOOLEAN mgsl_irq_test( struct mgsl_struct *info )
+static BOOLEAN mgsl_irq_test( struct mgsl_struct *info )
 {
 	unsigned long EndTime;
 	unsigned long flags;
@@ -7163,7 +7161,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	TRUE if test passed, otherwise FALSE
  */
-BOOLEAN mgsl_dma_test( struct mgsl_struct *info )
+static BOOLEAN mgsl_dma_test( struct mgsl_struct *info )
 {
 	unsigned short FifoLevel;
 	unsigned long phys_addr;
@@ -7455,7 +7453,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	0 if success, otherwise -ENODEV
  */
-int mgsl_adapter_test( struct mgsl_struct *info )
+static int mgsl_adapter_test( struct mgsl_struct *info )
 {
 	if ( debug_level >= DEBUG_LEVEL_INFO )
 		printk( "%s(%d):Testing device %s\n",
@@ -7497,7 +7495,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	TRUE if test passed, otherwise FALSE
  */
-BOOLEAN mgsl_memory_test( struct mgsl_struct *info )
+static BOOLEAN mgsl_memory_test( struct mgsl_struct *info )
 {
 	static unsigned long BitPatterns[] = { 0x0, 0x55555555, 0xaaaaaaaa,
 											0x66666666, 0x99999999, 0xffffffff, 0x12345678 };
@@ -7578,7 +7576,7 @@
  *
  * Return Value:	None
  */
-void mgsl_load_pci_memory( char* TargetPtr, const char* SourcePtr, 
+static void mgsl_load_pci_memory( char* TargetPtr, const char* SourcePtr, 
 	unsigned short count )
 {
 	/* 16 32-bit writes @ 60ns each = 960ns max latency on local bus */
@@ -7600,7 +7598,7 @@
 
 }	/* End Of mgsl_load_pci_memory() */
 
-void mgsl_trace_block(struct mgsl_struct *info,const char* data, int count, int xmit)
+static void mgsl_trace_block(struct mgsl_struct *info,const char* data, int count, int xmit)
 {
 	int i;
 	int linecount;
@@ -7640,7 +7638,7 @@
  * Arguments:	context		pointer to device instance data
  * Return Value:	None
  */
-void mgsl_tx_timeout(unsigned long context)
+static void mgsl_tx_timeout(unsigned long context)
 {
 	struct mgsl_struct *info = (struct mgsl_struct*)context;
 	unsigned long flags;
@@ -7694,7 +7692,7 @@
 /* release the line by echoing RxD to TxD
  * upon completion of a transmit frame
  */
-void usc_loopmode_send_done( struct mgsl_struct * info )
+static void usc_loopmode_send_done( struct mgsl_struct * info )
 {
  	info->loopmode_send_done_requested = FALSE;
  	/* clear CMR:13 to 0 to start echoing RxData to TxData */
@@ -7704,7 +7702,7 @@
 
 /* abort a transmit in progress while in HDLC LoopMode
  */
-void usc_loopmode_cancel_transmit( struct mgsl_struct * info )
+static void usc_loopmode_cancel_transmit( struct mgsl_struct * info )
 {
  	/* reset tx dma channel and purge TxFifo */
  	usc_RTCmd( info, RTCmd_PurgeTxFifo );
@@ -7716,7 +7714,7 @@
  * is an Insert Into Loop action. Upon receipt of a GoAhead sequence (RxAbort)
  * we must clear CMR:13 to begin repeating TxData to RxData
  */
-void usc_loopmode_insert_request( struct mgsl_struct * info )
+static void usc_loopmode_insert_request( struct mgsl_struct * info )
 {
  	info->loopmode_insert_requested = TRUE;
  
@@ -7733,18 +7731,11 @@
 
 /* return 1 if station is inserted into the loop, otherwise 0
  */
-int usc_loopmode_active( struct mgsl_struct * info)
+static int usc_loopmode_active( struct mgsl_struct * info)
 {
  	return usc_InReg( info, CCSR ) & BIT7 ? 1 : 0 ;
 }
 
-/* return 1 if USC is in loop send mode, otherwise 0
- */
-int usc_loopmode_send_active( struct mgsl_struct * info )
-{
-	return usc_InReg( info, CCSR ) & BIT6 ? 1 : 0 ;
-}			  
-
 #ifdef CONFIG_HDLC
 
 /**
--- linux-2.6.10-rc1-mm3-full/drivers/char/tipar.c.old	2004-11-07 01:24:23.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/tipar.c	2004-11-07 01:24:45.000000000 +0100
@@ -489,7 +489,7 @@
 	.detach = tipar_detach,
 };
 
-int __init
+static int __init
 tipar_init_module(void)
 {
 	int err = 0;
@@ -526,7 +526,7 @@
 	return err;	
 }
 
-void __exit
+static void __exit
 tipar_cleanup_module(void)
 {
 	unsigned int i;
--- linux-2.6.10-rc1-mm3-full/drivers/char/toshiba.c.old	2004-11-07 01:25:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/toshiba.c	2004-11-07 01:25:08.000000000 +0100
@@ -407,7 +407,7 @@
  *   laptop, otherwise zero and determines the Machine ID, BIOS version and
  *   date, and SCI version.
  */
-int tosh_probe(void)
+static int tosh_probe(void)
 {
 	int i,major,minor,day,year,month,flag;
 	unsigned char signature[7] = { 0x54,0x4f,0x53,0x48,0x49,0x42,0x41 };
--- linux-2.6.10-rc1-mm3-full/drivers/char/tty_io.c.old	2004-11-07 01:25:45.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/tty_io.c	2004-11-07 01:28:36.000000000 +0100
@@ -149,8 +149,8 @@
 static int tty_open(struct inode *, struct file *);
 static int ptmx_open(struct inode *, struct file *);
 static int tty_release(struct inode *, struct file *);
-int tty_ioctl(struct inode * inode, struct file * file,
-	      unsigned int cmd, unsigned long arg);
+static int tty_ioctl(struct inode * inode, struct file * file,
+		     unsigned int cmd, unsigned long arg);
 static int tty_fasync(int fd, struct file * filp, int on);
 extern void rs_360_init(void);
 static void release_mem(struct tty_struct *tty, int idx);
@@ -327,7 +327,7 @@
 	
 EXPORT_SYMBOL_GPL(tty_ldisc_put);
 
-void tty_ldisc_assign(struct tty_struct *tty, struct tty_ldisc *ld)
+static void tty_ldisc_assign(struct tty_struct *tty, struct tty_ldisc *ld)
 {
 	tty->ldisc = *ld;
 	tty->ldisc.refcount = 0;
@@ -583,7 +583,7 @@
 /*
  * This routine returns a tty driver structure, given a device number
  */
-struct tty_driver *get_tty_driver(dev_t device, int *index)
+static struct tty_driver *get_tty_driver(dev_t device, int *index)
 {
 	struct tty_driver *p;
 
@@ -744,7 +744,7 @@
  * but doesn't hold any locks, so we need to make sure we have the appropriate
  * locks for what we're doing..
  */
-void do_tty_hangup(void *data)
+static void do_tty_hangup(void *data)
 {
 	struct tty_struct *tty = (struct tty_struct *) data;
 	struct file * cons_filp = NULL;
@@ -2211,8 +2211,8 @@
 /*
  * Split this up, as gcc can choke on it otherwise..
  */
-int tty_ioctl(struct inode * inode, struct file * file,
-	      unsigned int cmd, unsigned long arg)
+static int tty_ioctl(struct inode * inode, struct file * file,
+		     unsigned int cmd, unsigned long arg)
 {
 	struct tty_struct *tty, *real_tty;
 	void __user *p = (void __user *)arg;
@@ -2504,28 +2504,6 @@
 }
 
 /*
- *	Call the ldisc flush directly from a driver. This function may
- *	return an error and need retrying by the user.
- */
-
-int tty_push_data(struct tty_struct *tty, unsigned char *cp, unsigned char *fp, int count)
-{
-	int ret = 0;
-	struct tty_ldisc *disc;
-	
-	disc = tty_ldisc_ref(tty);
-	if(test_bit(TTY_DONT_FLIP, &tty->flags))
-		ret = -EAGAIN;
-	else if(disc == NULL)
-		ret = -EIO;
-	else
-		disc->receive_buf(tty, cp, fp, count);
-	tty_ldisc_deref(disc);
-	return ret;
-	
-}
-
-/*
  * Routine which returns the baud rate of the tty
  *
  * Note that the baud_table needs to be kept in sync with the
--- linux-2.6.10-rc1-mm3-full/drivers/char/tty_ioctl.c.old	2004-11-07 01:28:51.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/tty_ioctl.c	2004-11-07 01:29:04.000000000 +0100
@@ -372,7 +372,7 @@
 /*
  * Send a high priority character to the tty.
  */
-void send_prio_char(struct tty_struct *tty, char ch)
+static void send_prio_char(struct tty_struct *tty, char ch)
 {
 	int	was_stopped = tty->stopped;
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

