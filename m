Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbULEQ5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbULEQ5k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 11:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbULEQ5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 11:57:40 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:11786 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261315AbULEQ5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 11:57:18 -0500
Date: Sun, 5 Dec 2004 17:57:14 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/ip2*: misc cleanups
Message-ID: <20041205165714.GL2953@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains cleanups including the following:
- remove unused variables and functions
- make needlessly global code static


diffstat output:
 drivers/char/ip2/fip_firm.h |    2 -
 drivers/char/ip2/i2cmd.c    |   59 +-----------------------------------
 drivers/char/ip2/i2cmd.h    |   17 ----------
 drivers/char/ip2/i2lib.c    |    2 -
 drivers/char/ip2main.c      |    5 +--
 5 files changed, 6 insertions(+), 79 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

