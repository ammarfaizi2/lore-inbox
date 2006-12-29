Return-Path: <linux-kernel-owner+w=401wt.eu-S965166AbWL2Uzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965166AbWL2Uzy (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 15:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbWL2Uzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 15:55:53 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:42654 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965161AbWL2Uzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 15:55:51 -0500
Message-id: <1374860752795517974@wsc.cz>
In-reply-to: <26150293961999718626@wsc.cz>
Subject: [PATCH 2/4] Char: mxser_new, header file cleanup
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Fri, 29 Dec 2006 21:55:57 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, header file cleanup

- Remove no longer used macros
- Move some macros from the header to the code
- Remove c++ comments
- Align backslashes to one column

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit cc46acb974ba967794f7b199fb65ad4abd9531b7
tree 56be354d64287e9b79013b8d8d35fd6ca4dc0d49
parent 15e7e157283a86bb819a0193a8cb137d7640d3a6
author Jiri Slaby <jirislaby@gmail.com> Fri, 29 Dec 2006 20:57:07 +0059
committer Jiri Slaby <jirislaby@gmail.com> Fri, 29 Dec 2006 20:57:07 +0059

 drivers/char/mxser_new.c |    7 -
 drivers/char/mxser_new.h |  461 +++++++++++++++-------------------------------
 2 files changed, 154 insertions(+), 314 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index ec61cf8..945c7e1 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -53,8 +53,6 @@
 #define	MXSERMAJOR	 174
 #define	MXSERCUMAJOR	 175
 
-#define	MXSER_EVENT_TXLOW	1
-
 #define MXSER_BOARDS		4	/* Max. boards */
 #define MXSER_PORTS_PER_BOARD	8	/* Max. ports per board */
 #define MXSER_PORTS		(MXSER_BOARDS * MXSER_PORTS_PER_BOARD)
@@ -65,6 +63,11 @@
 #define	MXSER_ERR_IRQ_CONFLIT	-3
 #define	MXSER_ERR_VECTOR	-4
 
+/*CheckIsMoxaMust return value*/
+#define MOXA_OTHER_UART		0x00
+#define MOXA_MUST_MU150_HWID	0x01
+#define MOXA_MUST_MU860_HWID	0x02
+
 #define WAKEUP_CHARS		256
 
 #define UART_MCR_AFE		0x20
diff --git a/drivers/char/mxser_new.h b/drivers/char/mxser_new.h
index 55b34a0..04fa5fc 100644
--- a/drivers/char/mxser_new.h
+++ b/drivers/char/mxser_new.h
@@ -26,18 +26,8 @@
 #define RS422_MODE		2
 #define RS485_4WIRE_MODE	3
 #define OP_MODE_MASK		3
-// above add by Victor Yu. 01-05-2004
-
-#define TTY_THRESHOLD_THROTTLE  128
-
-#define LO_WATER	 	(TTY_FLIPBUF_SIZE)
-#define HI_WATER		(TTY_FLIPBUF_SIZE*2*3/4)
-
-// added by James. 03-11-2004.
-#define MOXA_SDS_GETICOUNTER  	(MOXA + 68)
-#define MOXA_SDS_RSTICOUNTER  	(MOXA + 69)
-// (above) added by James.
 
+#define MOXA_SDS_RSTICOUNTER	(MOXA + 69)
 #define MOXA_ASPP_OQUEUE  	(MOXA + 70)
 #define MOXA_ASPP_SETBAUD 	(MOXA + 71)
 #define MOXA_ASPP_GETBAUD 	(MOXA + 72)
@@ -46,7 +36,6 @@
 #define MOXA_ASPP_MON_EXT 	(MOXA + 75)
 #define MOXA_SET_BAUD_METHOD	(MOXA + 76)
 
-
 /* --------------------------------------------------- */
 
 #define NPPI_NOTIFY_PARITY	0x01
@@ -55,51 +44,46 @@
 #define NPPI_NOTIFY_SW_OVERRUN	0x08
 #define NPPI_NOTIFY_BREAK	0x10
 
-#define NPPI_NOTIFY_CTSHOLD         0x01	// Tx hold by CTS low
-#define NPPI_NOTIFY_DSRHOLD         0x02	// Tx hold by DSR low
-#define NPPI_NOTIFY_XOFFHOLD        0x08	// Tx hold by Xoff received
-#define NPPI_NOTIFY_XOFFXENT        0x10	// Xoff Sent
-
-//CheckIsMoxaMust return value
-#define MOXA_OTHER_UART			0x00
-#define MOXA_MUST_MU150_HWID		0x01
-#define MOXA_MUST_MU860_HWID		0x02
-
-// follow just for Moxa Must chip define.
-//
-// when LCR register (offset 0x03) write following value,
-// the Must chip will enter enchance mode. And write value
-// on EFR (offset 0x02) bit 6,7 to change bank.
+#define NPPI_NOTIFY_CTSHOLD         0x01	/* Tx hold by CTS low */
+#define NPPI_NOTIFY_DSRHOLD         0x02	/* Tx hold by DSR low */
+#define NPPI_NOTIFY_XOFFHOLD        0x08	/* Tx hold by Xoff received */
+#define NPPI_NOTIFY_XOFFXENT        0x10	/* Xoff Sent */
+
+/* follow just for Moxa Must chip define. */
+/* */
+/* when LCR register (offset 0x03) write following value, */
+/* the Must chip will enter enchance mode. And write value */
+/* on EFR (offset 0x02) bit 6,7 to change bank. */
 #define MOXA_MUST_ENTER_ENCHANCE	0xBF
 
-// when enhance mode enable, access on general bank register
+/* when enhance mode enable, access on general bank register */
 #define MOXA_MUST_GDL_REGISTER		0x07
 #define MOXA_MUST_GDL_MASK		0x7F
 #define MOXA_MUST_GDL_HAS_BAD_DATA	0x80
 
-#define MOXA_MUST_LSR_RERR		0x80	// error in receive FIFO
-// enchance register bank select and enchance mode setting register
-// when LCR register equal to 0xBF
+#define MOXA_MUST_LSR_RERR		0x80	/* error in receive FIFO */
+/* enchance register bank select and enchance mode setting register */
+/* when LCR register equal to 0xBF */
 #define MOXA_MUST_EFR_REGISTER		0x02
-// enchance mode enable
+/* enchance mode enable */
 #define MOXA_MUST_EFR_EFRB_ENABLE	0x10
-// enchance reister bank set 0, 1, 2
+/* enchance reister bank set 0, 1, 2 */
 #define MOXA_MUST_EFR_BANK0		0x00
 #define MOXA_MUST_EFR_BANK1		0x40
 #define MOXA_MUST_EFR_BANK2		0x80
 #define MOXA_MUST_EFR_BANK3		0xC0
 #define MOXA_MUST_EFR_BANK_MASK		0xC0
 
-// set XON1 value register, when LCR=0xBF and change to bank0
+/* set XON1 value register, when LCR=0xBF and change to bank0 */
 #define MOXA_MUST_XON1_REGISTER		0x04
 
-// set XON2 value register, when LCR=0xBF and change to bank0
+/* set XON2 value register, when LCR=0xBF and change to bank0 */
 #define MOXA_MUST_XON2_REGISTER		0x05
 
-// set XOFF1 value register, when LCR=0xBF and change to bank0
+/* set XOFF1 value register, when LCR=0xBF and change to bank0 */
 #define MOXA_MUST_XOFF1_REGISTER	0x06
 
-// set XOFF2 value register, when LCR=0xBF and change to bank0
+/* set XOFF2 value register, when LCR=0xBF and change to bank0 */
 #define MOXA_MUST_XOFF2_REGISTER	0x07
 
 #define MOXA_MUST_RBRTL_REGISTER	0x04
@@ -111,32 +95,32 @@
 #define MOXA_MUST_ECR_REGISTER		0x06
 #define MOXA_MUST_CSR_REGISTER		0x07
 
-// good data mode enable
+/* good data mode enable */
 #define MOXA_MUST_FCR_GDA_MODE_ENABLE	0x20
-// only good data put into RxFIFO
+/* only good data put into RxFIFO */
 #define MOXA_MUST_FCR_GDA_ONLY_ENABLE	0x10
 
-// enable CTS interrupt
+/* enable CTS interrupt */
 #define MOXA_MUST_IER_ECTSI		0x80
-// enable RTS interrupt
+/* enable RTS interrupt */
 #define MOXA_MUST_IER_ERTSI		0x40
-// enable Xon/Xoff interrupt
+/* enable Xon/Xoff interrupt */
 #define MOXA_MUST_IER_XINT		0x20
-// enable GDA interrupt
+/* enable GDA interrupt */
 #define MOXA_MUST_IER_EGDAI		0x10
 
 #define MOXA_MUST_RECV_ISR		(UART_IER_RDI | MOXA_MUST_IER_EGDAI)
 
-// GDA interrupt pending
+/* GDA interrupt pending */
 #define MOXA_MUST_IIR_GDA		0x1C
 #define MOXA_MUST_IIR_RDA		0x04
 #define MOXA_MUST_IIR_RTO		0x0C
 #define MOXA_MUST_IIR_LSR		0x06
 
-// recieved Xon/Xoff or specical interrupt pending
+/* recieved Xon/Xoff or specical interrupt pending */
 #define MOXA_MUST_IIR_XSC		0x10
 
-// RTS/CTS change state interrupt pending
+/* RTS/CTS change state interrupt pending */
 #define MOXA_MUST_IIR_RTSCTS		0x20
 #define MOXA_MUST_IIR_MASK		0x3E
 
@@ -144,299 +128,152 @@
 #define MOXA_MUST_MCR_XON_ANY		0x80
 #define MOXA_MUST_MCR_TX_XON		0x08
 
-
-// software flow control on chip mask value
+/* software flow control on chip mask value */
 #define MOXA_MUST_EFR_SF_MASK		0x0F
-// send Xon1/Xoff1
+/* send Xon1/Xoff1 */
 #define MOXA_MUST_EFR_SF_TX1		0x08
-// send Xon2/Xoff2
+/* send Xon2/Xoff2 */
 #define MOXA_MUST_EFR_SF_TX2		0x04
-// send Xon1,Xon2/Xoff1,Xoff2
+/* send Xon1,Xon2/Xoff1,Xoff2 */
 #define MOXA_MUST_EFR_SF_TX12		0x0C
-// don't send Xon/Xoff
+/* don't send Xon/Xoff */
 #define MOXA_MUST_EFR_SF_TX_NO		0x00
-// Tx software flow control mask
+/* Tx software flow control mask */
 #define MOXA_MUST_EFR_SF_TX_MASK	0x0C
-// don't receive Xon/Xoff
+/* don't receive Xon/Xoff */
 #define MOXA_MUST_EFR_SF_RX_NO		0x00
-// receive Xon1/Xoff1
+/* receive Xon1/Xoff1 */
 #define MOXA_MUST_EFR_SF_RX1		0x02
-// receive Xon2/Xoff2
+/* receive Xon2/Xoff2 */
 #define MOXA_MUST_EFR_SF_RX2		0x01
-// receive Xon1,Xon2/Xoff1,Xoff2
+/* receive Xon1,Xon2/Xoff1,Xoff2 */
 #define MOXA_MUST_EFR_SF_RX12		0x03
-// Rx software flow control mask
+/* Rx software flow control mask */
 #define MOXA_MUST_EFR_SF_RX_MASK	0x03
 
-//#define MOXA_MUST_MIN_XOFFLIMIT               66
-//#define MOXA_MUST_MIN_XONLIMIT                20
-//#define ID1_RX_TRIG                   120
-
-
-#define CHECK_MOXA_MUST_XOFFLIMIT(info) { 	\
-	if ( (info)->IsMoxaMustChipFlag && 	\
-	 (info)->HandFlow.XoffLimit < MOXA_MUST_MIN_XOFFLIMIT ) {	\
-		(info)->HandFlow.XoffLimit = MOXA_MUST_MIN_XOFFLIMIT;	\
-		(info)->HandFlow.XonLimit = MOXA_MUST_MIN_XONLIMIT;	\
-	}	\
-}
-
-#define ENABLE_MOXA_MUST_ENCHANCE_MODE(baseio) { \
-	u8	__oldlcr, __efr;	\
-	__oldlcr = inb((baseio)+UART_LCR);	\
+#define ENABLE_MOXA_MUST_ENCHANCE_MODE(baseio) do { 		\
+	u8	__oldlcr, __efr;				\
+	__oldlcr = inb((baseio)+UART_LCR);			\
 	outb(MOXA_MUST_ENTER_ENCHANCE, (baseio)+UART_LCR);	\
-	__efr = inb((baseio)+MOXA_MUST_EFR_REGISTER);	\
-	__efr |= MOXA_MUST_EFR_EFRB_ENABLE;	\
-	outb(__efr, (baseio)+MOXA_MUST_EFR_REGISTER);	\
-	outb(__oldlcr, (baseio)+UART_LCR);	\
-}
-
-#define DISABLE_MOXA_MUST_ENCHANCE_MODE(baseio) {	\
-	u8	__oldlcr, __efr;	\
-	__oldlcr = inb((baseio)+UART_LCR);	\
+	__efr = inb((baseio)+MOXA_MUST_EFR_REGISTER);		\
+	__efr |= MOXA_MUST_EFR_EFRB_ENABLE;			\
+	outb(__efr, (baseio)+MOXA_MUST_EFR_REGISTER);		\
+	outb(__oldlcr, (baseio)+UART_LCR);			\
+} while (0)
+
+#define DISABLE_MOXA_MUST_ENCHANCE_MODE(baseio) do {		\
+	u8	__oldlcr, __efr;				\
+	__oldlcr = inb((baseio)+UART_LCR);			\
 	outb(MOXA_MUST_ENTER_ENCHANCE, (baseio)+UART_LCR);	\
-	__efr = inb((baseio)+MOXA_MUST_EFR_REGISTER);	\
-	__efr &= ~MOXA_MUST_EFR_EFRB_ENABLE;	\
-	outb(__efr, (baseio)+MOXA_MUST_EFR_REGISTER);	\
-	outb(__oldlcr, (baseio)+UART_LCR);	\
-}
-
-#define SET_MOXA_MUST_XON1_VALUE(baseio, Value) {	\
-	u8	__oldlcr, __efr;	\
-	__oldlcr = inb((baseio)+UART_LCR);	\
+	__efr = inb((baseio)+MOXA_MUST_EFR_REGISTER);		\
+	__efr &= ~MOXA_MUST_EFR_EFRB_ENABLE;			\
+	outb(__efr, (baseio)+MOXA_MUST_EFR_REGISTER);		\
+	outb(__oldlcr, (baseio)+UART_LCR);			\
+} while (0)
+
+#define SET_MOXA_MUST_XON1_VALUE(baseio, Value) do {		\
+	u8	__oldlcr, __efr;				\
+	__oldlcr = inb((baseio)+UART_LCR);			\
 	outb(MOXA_MUST_ENTER_ENCHANCE, (baseio)+UART_LCR);	\
-	__efr = inb((baseio)+MOXA_MUST_EFR_REGISTER);	\
-	__efr &= ~MOXA_MUST_EFR_BANK_MASK;	\
-	__efr |= MOXA_MUST_EFR_BANK0;	\
-	outb(__efr, (baseio)+MOXA_MUST_EFR_REGISTER);	\
+	__efr = inb((baseio)+MOXA_MUST_EFR_REGISTER);		\
+	__efr &= ~MOXA_MUST_EFR_BANK_MASK;			\
+	__efr |= MOXA_MUST_EFR_BANK0;				\
+	outb(__efr, (baseio)+MOXA_MUST_EFR_REGISTER);		\
 	outb((u8)(Value), (baseio)+MOXA_MUST_XON1_REGISTER);	\
-	outb(__oldlcr, (baseio)+UART_LCR);	\
-}
+	outb(__oldlcr, (baseio)+UART_LCR);			\
+} while (0)
 
-#define SET_MOXA_MUST_XON2_VALUE(baseio, Value) {	\
-	u8	__oldlcr, __efr;	\
-	__oldlcr = inb((baseio)+UART_LCR);	\
+#define SET_MOXA_MUST_XOFF1_VALUE(baseio, Value) do {		\
+	u8	__oldlcr, __efr;				\
+	__oldlcr = inb((baseio)+UART_LCR);			\
 	outb(MOXA_MUST_ENTER_ENCHANCE, (baseio)+UART_LCR);	\
-	__efr = inb((baseio)+MOXA_MUST_EFR_REGISTER);	\
-	__efr &= ~MOXA_MUST_EFR_BANK_MASK;	\
-	__efr |= MOXA_MUST_EFR_BANK0;	\
-	outb(__efr, (baseio)+MOXA_MUST_EFR_REGISTER);	\
-	outb((u8)(Value), (baseio)+MOXA_MUST_XON2_REGISTER);	\
-	outb(__oldlcr, (baseio)+UART_LCR);	\
-}
-
-#define SET_MOXA_MUST_XOFF1_VALUE(baseio, Value) {	\
-	u8	__oldlcr, __efr;	\
-	__oldlcr = inb((baseio)+UART_LCR);	\
-	outb(MOXA_MUST_ENTER_ENCHANCE, (baseio)+UART_LCR);	\
-	__efr = inb((baseio)+MOXA_MUST_EFR_REGISTER);	\
-	__efr &= ~MOXA_MUST_EFR_BANK_MASK;	\
-	__efr |= MOXA_MUST_EFR_BANK0;	\
-	outb(__efr, (baseio)+MOXA_MUST_EFR_REGISTER);	\
+	__efr = inb((baseio)+MOXA_MUST_EFR_REGISTER);		\
+	__efr &= ~MOXA_MUST_EFR_BANK_MASK;			\
+	__efr |= MOXA_MUST_EFR_BANK0;				\
+	outb(__efr, (baseio)+MOXA_MUST_EFR_REGISTER);		\
 	outb((u8)(Value), (baseio)+MOXA_MUST_XOFF1_REGISTER);	\
-	outb(__oldlcr, (baseio)+UART_LCR);	\
-}
+	outb(__oldlcr, (baseio)+UART_LCR);			\
+} while (0)
 
-#define SET_MOXA_MUST_XOFF2_VALUE(baseio, Value) {	\
-	u8	__oldlcr, __efr;	\
-	__oldlcr = inb((baseio)+UART_LCR);	\
-	outb(MOXA_MUST_ENTER_ENCHANCE, (baseio)+UART_LCR);	\
-	__efr = inb((baseio)+MOXA_MUST_EFR_REGISTER);	\
-	__efr &= ~MOXA_MUST_EFR_BANK_MASK;	\
-	__efr |= MOXA_MUST_EFR_BANK0;	\
-	outb(__efr, (baseio)+MOXA_MUST_EFR_REGISTER);	\
-	outb((u8)(Value), (baseio)+MOXA_MUST_XOFF2_REGISTER);	\
-	outb(__oldlcr, (baseio)+UART_LCR);	\
-}
-
-#define SET_MOXA_MUST_RBRTL_VALUE(baseio, Value) {	\
-	u8	__oldlcr, __efr;	\
-	__oldlcr = inb((baseio)+UART_LCR);	\
-	outb(MOXA_MUST_ENTER_ENCHANCE, (baseio)+UART_LCR);	\
-	__efr = inb((baseio)+MOXA_MUST_EFR_REGISTER);	\
-	__efr &= ~MOXA_MUST_EFR_BANK_MASK;	\
-	__efr |= MOXA_MUST_EFR_BANK1;	\
-	outb(__efr, (baseio)+MOXA_MUST_EFR_REGISTER);	\
-	outb((u8)(Value), (baseio)+MOXA_MUST_RBRTL_REGISTER);	\
-	outb(__oldlcr, (baseio)+UART_LCR);	\
-}
-
-#define SET_MOXA_MUST_RBRTH_VALUE(baseio, Value) {	\
-	u8	__oldlcr, __efr;	\
-	__oldlcr = inb((baseio)+UART_LCR);	\
-	outb(MOXA_MUST_ENTER_ENCHANCE, (baseio)+UART_LCR);	\
-	__efr = inb((baseio)+MOXA_MUST_EFR_REGISTER);	\
-	__efr &= ~MOXA_MUST_EFR_BANK_MASK;	\
-	__efr |= MOXA_MUST_EFR_BANK1;	\
-	outb(__efr, (baseio)+MOXA_MUST_EFR_REGISTER);	\
-	outb((u8)(Value), (baseio)+MOXA_MUST_RBRTH_REGISTER);	\
-	outb(__oldlcr, (baseio)+UART_LCR);	\
-}
-
-#define SET_MOXA_MUST_RBRTI_VALUE(baseio, Value) {	\
-	u8	__oldlcr, __efr;	\
-	__oldlcr = inb((baseio)+UART_LCR);	\
-	outb(MOXA_MUST_ENTER_ENCHANCE, (baseio)+UART_LCR);	\
-	__efr = inb((baseio)+MOXA_MUST_EFR_REGISTER);	\
-	__efr &= ~MOXA_MUST_EFR_BANK_MASK;	\
-	__efr |= MOXA_MUST_EFR_BANK1;	\
-	outb(__efr, (baseio)+MOXA_MUST_EFR_REGISTER);	\
-	outb((u8)(Value), (baseio)+MOXA_MUST_RBRTI_REGISTER);	\
-	outb(__oldlcr, (baseio)+UART_LCR);	\
-}
-
-#define SET_MOXA_MUST_THRTL_VALUE(baseio, Value) {	\
-	u8	__oldlcr, __efr;	\
-	__oldlcr = inb((baseio)+UART_LCR);	\
-	outb(MOXA_MUST_ENTER_ENCHANCE, (baseio)+UART_LCR);	\
-	__efr = inb((baseio)+MOXA_MUST_EFR_REGISTER);	\
-	__efr &= ~MOXA_MUST_EFR_BANK_MASK;	\
-	__efr |= MOXA_MUST_EFR_BANK1;	\
-	outb(__efr, (baseio)+MOXA_MUST_EFR_REGISTER);	\
-	outb((u8)(Value), (baseio)+MOXA_MUST_THRTL_REGISTER);	\
-	outb(__oldlcr, (baseio)+UART_LCR);	\
-}
-
-//#define MOXA_MUST_RBRL_VALUE  4
-#define SET_MOXA_MUST_FIFO_VALUE(info) {	\
-	u8	__oldlcr, __efr;	\
-	__oldlcr = inb((info)->ioaddr+UART_LCR);	\
-	outb(MOXA_MUST_ENTER_ENCHANCE, (info)->ioaddr+UART_LCR);	\
+#define SET_MOXA_MUST_FIFO_VALUE(info) do {			\
+	u8	__oldlcr, __efr;				\
+	__oldlcr = inb((info)->ioaddr+UART_LCR);		\
+	outb(MOXA_MUST_ENTER_ENCHANCE, (info)->ioaddr+UART_LCR);\
 	__efr = inb((info)->ioaddr+MOXA_MUST_EFR_REGISTER);	\
-	__efr &= ~MOXA_MUST_EFR_BANK_MASK;	\
-	__efr |= MOXA_MUST_EFR_BANK1;	\
+	__efr &= ~MOXA_MUST_EFR_BANK_MASK;			\
+	__efr |= MOXA_MUST_EFR_BANK1;				\
 	outb(__efr, (info)->ioaddr+MOXA_MUST_EFR_REGISTER);	\
-	outb((u8)((info)->rx_high_water), (info)->ioaddr+MOXA_MUST_RBRTH_REGISTER);	\
-	outb((u8)((info)->rx_trigger), (info)->ioaddr+MOXA_MUST_RBRTI_REGISTER);	\
-	outb((u8)((info)->rx_low_water), (info)->ioaddr+MOXA_MUST_RBRTL_REGISTER);	\
-	outb(__oldlcr, (info)->ioaddr+UART_LCR);	\
-}
-
-
-
-#define SET_MOXA_MUST_ENUM_VALUE(baseio, Value) {	\
-	u8	__oldlcr, __efr;	\
-	__oldlcr = inb((baseio)+UART_LCR);	\
-	outb(MOXA_MUST_ENTER_ENCHANCE, (baseio)+UART_LCR);	\
-	__efr = inb((baseio)+MOXA_MUST_EFR_REGISTER);	\
-	__efr &= ~MOXA_MUST_EFR_BANK_MASK;	\
-	__efr |= MOXA_MUST_EFR_BANK2;	\
-	outb(__efr, (baseio)+MOXA_MUST_EFR_REGISTER);	\
-	outb((u8)(Value), (baseio)+MOXA_MUST_ENUM_REGISTER);	\
-	outb(__oldlcr, (baseio)+UART_LCR);	\
-}
-
-#define GET_MOXA_MUST_HARDWARE_ID(baseio, pId) {	\
-	u8	__oldlcr, __efr;	\
-	__oldlcr = inb((baseio)+UART_LCR);	\
-	outb(MOXA_MUST_ENTER_ENCHANCE, (baseio)+UART_LCR);	\
-	__efr = inb((baseio)+MOXA_MUST_EFR_REGISTER);	\
-	__efr &= ~MOXA_MUST_EFR_BANK_MASK;	\
-	__efr |= MOXA_MUST_EFR_BANK2;	\
-	outb(__efr, (baseio)+MOXA_MUST_EFR_REGISTER);	\
-	*pId = inb((baseio)+MOXA_MUST_HWID_REGISTER);	\
-	outb(__oldlcr, (baseio)+UART_LCR);	\
-}
-
-#define SET_MOXA_MUST_NO_SOFTWARE_FLOW_CONTROL(baseio) {	\
-	u8	__oldlcr, __efr;	\
-	__oldlcr = inb((baseio)+UART_LCR);	\
-	outb(MOXA_MUST_ENTER_ENCHANCE, (baseio)+UART_LCR);	\
-	__efr = inb((baseio)+MOXA_MUST_EFR_REGISTER);	\
-	__efr &= ~MOXA_MUST_EFR_SF_MASK;	\
-	outb(__efr, (baseio)+MOXA_MUST_EFR_REGISTER);	\
-	outb(__oldlcr, (baseio)+UART_LCR);	\
-}
-
-#define SET_MOXA_MUST_JUST_TX_SOFTWARE_FLOW_CONTROL(baseio) {	\
-	u8	__oldlcr, __efr;	\
-	__oldlcr = inb((baseio)+UART_LCR);	\
-	outb(MOXA_MUST_ENTER_ENCHANCE, (baseio)+UART_LCR);	\
-	__efr = inb((baseio)+MOXA_MUST_EFR_REGISTER);	\
-	__efr &= ~MOXA_MUST_EFR_SF_MASK;	\
-	__efr |= MOXA_MUST_EFR_SF_TX1;	\
-	outb(__efr, (baseio)+MOXA_MUST_EFR_REGISTER);	\
-	outb(__oldlcr, (baseio)+UART_LCR);	\
-}
-
-#define ENABLE_MOXA_MUST_TX_SOFTWARE_FLOW_CONTROL(baseio) {	\
-	u8	__oldlcr, __efr;	\
-	__oldlcr = inb((baseio)+UART_LCR);	\
+	outb((u8)((info)->rx_high_water), (info)->ioaddr+	\
+			MOXA_MUST_RBRTH_REGISTER);		\
+	outb((u8)((info)->rx_trigger), (info)->ioaddr+		\
+			MOXA_MUST_RBRTI_REGISTER);		\
+	outb((u8)((info)->rx_low_water), (info)->ioaddr+	\
+			MOXA_MUST_RBRTL_REGISTER);		\
+	outb(__oldlcr, (info)->ioaddr+UART_LCR);		\
+} while (0)
+
+#define GET_MOXA_MUST_HARDWARE_ID(baseio, pId) do {		\
+	u8	__oldlcr, __efr;				\
+	__oldlcr = inb((baseio)+UART_LCR);			\
 	outb(MOXA_MUST_ENTER_ENCHANCE, (baseio)+UART_LCR);	\
-	__efr = inb((baseio)+MOXA_MUST_EFR_REGISTER);	\
-	__efr &= ~MOXA_MUST_EFR_SF_TX_MASK;	\
-	__efr |= MOXA_MUST_EFR_SF_TX1;	\
-	outb(__efr, (baseio)+MOXA_MUST_EFR_REGISTER);	\
-	outb(__oldlcr, (baseio)+UART_LCR);	\
-}
-
-#define DISABLE_MOXA_MUST_TX_SOFTWARE_FLOW_CONTROL(baseio) {	\
-	u8	__oldlcr, __efr;	\
-	__oldlcr = inb((baseio)+UART_LCR);	\
+	__efr = inb((baseio)+MOXA_MUST_EFR_REGISTER);		\
+	__efr &= ~MOXA_MUST_EFR_BANK_MASK;			\
+	__efr |= MOXA_MUST_EFR_BANK2;				\
+	outb(__efr, (baseio)+MOXA_MUST_EFR_REGISTER);		\
+	*pId = inb((baseio)+MOXA_MUST_HWID_REGISTER);		\
+	outb(__oldlcr, (baseio)+UART_LCR);			\
+} while (0)
+
+#define SET_MOXA_MUST_NO_SOFTWARE_FLOW_CONTROL(baseio) do {	\
+	u8	__oldlcr, __efr;				\
+	__oldlcr = inb((baseio)+UART_LCR);			\
 	outb(MOXA_MUST_ENTER_ENCHANCE, (baseio)+UART_LCR);	\
-	__efr = inb((baseio)+MOXA_MUST_EFR_REGISTER);	\
-	__efr &= ~MOXA_MUST_EFR_SF_TX_MASK;	\
-	outb(__efr, (baseio)+MOXA_MUST_EFR_REGISTER);	\
-	outb(__oldlcr, (baseio)+UART_LCR);	\
-}
-
-#define SET_MOXA_MUST_JUST_RX_SOFTWARE_FLOW_CONTROL(baseio) {	\
-	u8	__oldlcr, __efr;	\
-	__oldlcr = inb((baseio)+UART_LCR);	\
+	__efr = inb((baseio)+MOXA_MUST_EFR_REGISTER);		\
+	__efr &= ~MOXA_MUST_EFR_SF_MASK;			\
+	outb(__efr, (baseio)+MOXA_MUST_EFR_REGISTER);		\
+	outb(__oldlcr, (baseio)+UART_LCR);			\
+} while (0)
+
+#define ENABLE_MOXA_MUST_TX_SOFTWARE_FLOW_CONTROL(baseio) do {	\
+	u8	__oldlcr, __efr;				\
+	__oldlcr = inb((baseio)+UART_LCR);			\
 	outb(MOXA_MUST_ENTER_ENCHANCE, (baseio)+UART_LCR);	\
-	__efr = inb((baseio)+MOXA_MUST_EFR_REGISTER);	\
-	__efr &= ~MOXA_MUST_EFR_SF_MASK;	\
-	__efr |= MOXA_MUST_EFR_SF_RX1;	\
-	outb(__efr, (baseio)+MOXA_MUST_EFR_REGISTER);	\
-	outb(__oldlcr, (baseio)+UART_LCR);	\
-}
-
-#define ENABLE_MOXA_MUST_RX_SOFTWARE_FLOW_CONTROL(baseio) {	\
-	u8	__oldlcr, __efr;	\
-	__oldlcr = inb((baseio)+UART_LCR);	\
+	__efr = inb((baseio)+MOXA_MUST_EFR_REGISTER);		\
+	__efr &= ~MOXA_MUST_EFR_SF_TX_MASK;			\
+	__efr |= MOXA_MUST_EFR_SF_TX1;				\
+	outb(__efr, (baseio)+MOXA_MUST_EFR_REGISTER);		\
+	outb(__oldlcr, (baseio)+UART_LCR);			\
+} while (0)
+
+#define DISABLE_MOXA_MUST_TX_SOFTWARE_FLOW_CONTROL(baseio) do {	\
+	u8	__oldlcr, __efr;				\
+	__oldlcr = inb((baseio)+UART_LCR);			\
 	outb(MOXA_MUST_ENTER_ENCHANCE, (baseio)+UART_LCR);	\
-	__efr = inb((baseio)+MOXA_MUST_EFR_REGISTER);	\
-	__efr &= ~MOXA_MUST_EFR_SF_RX_MASK;	\
-	__efr |= MOXA_MUST_EFR_SF_RX1;	\
-	outb(__efr, (baseio)+MOXA_MUST_EFR_REGISTER);	\
-	outb(__oldlcr, (baseio)+UART_LCR);	\
-}
-
-#define DISABLE_MOXA_MUST_RX_SOFTWARE_FLOW_CONTROL(baseio) {	\
-	u8	__oldlcr, __efr;	\
-	__oldlcr = inb((baseio)+UART_LCR);	\
+	__efr = inb((baseio)+MOXA_MUST_EFR_REGISTER);		\
+	__efr &= ~MOXA_MUST_EFR_SF_TX_MASK;			\
+	outb(__efr, (baseio)+MOXA_MUST_EFR_REGISTER);		\
+	outb(__oldlcr, (baseio)+UART_LCR);			\
+} while (0)
+
+#define ENABLE_MOXA_MUST_RX_SOFTWARE_FLOW_CONTROL(baseio) do {	\
+	u8	__oldlcr, __efr;				\
+	__oldlcr = inb((baseio)+UART_LCR);			\
 	outb(MOXA_MUST_ENTER_ENCHANCE, (baseio)+UART_LCR);	\
-	__efr = inb((baseio)+MOXA_MUST_EFR_REGISTER);	\
-	__efr &= ~MOXA_MUST_EFR_SF_RX_MASK;	\
-	outb(__efr, (baseio)+MOXA_MUST_EFR_REGISTER);	\
-	outb(__oldlcr, (baseio)+UART_LCR);	\
-}
-
-#define ENABLE_MOXA_MUST_TX_RX_SOFTWARE_FLOW_CONTROL(baseio) {	\
-	u8	__oldlcr, __efr;	\
-	__oldlcr = inb((baseio)+UART_LCR);	\
+	__efr = inb((baseio)+MOXA_MUST_EFR_REGISTER);		\
+	__efr &= ~MOXA_MUST_EFR_SF_RX_MASK;			\
+	__efr |= MOXA_MUST_EFR_SF_RX1;				\
+	outb(__efr, (baseio)+MOXA_MUST_EFR_REGISTER);		\
+	outb(__oldlcr, (baseio)+UART_LCR);			\
+} while (0)
+
+#define DISABLE_MOXA_MUST_RX_SOFTWARE_FLOW_CONTROL(baseio) do {	\
+	u8	__oldlcr, __efr;				\
+	__oldlcr = inb((baseio)+UART_LCR);			\
 	outb(MOXA_MUST_ENTER_ENCHANCE, (baseio)+UART_LCR);	\
-	__efr = inb((baseio)+MOXA_MUST_EFR_REGISTER);	\
-	__efr &= ~MOXA_MUST_EFR_SF_MASK;	\
-	__efr |= (MOXA_MUST_EFR_SF_RX1|MOXA_MUST_EFR_SF_TX1);	\
-	outb(__efr, (baseio)+MOXA_MUST_EFR_REGISTER);	\
-	outb(__oldlcr, (baseio)+UART_LCR);	\
-}
-
-#define ENABLE_MOXA_MUST_XON_ANY_FLOW_CONTROL(baseio) {	\
-	u8	__oldmcr;	\
-	__oldmcr = inb((baseio)+UART_MCR);	\
-	__oldmcr |= MOXA_MUST_MCR_XON_ANY;	\
-	outb(__oldmcr, (baseio)+UART_MCR);	\
-}
-
-#define DISABLE_MOXA_MUST_XON_ANY_FLOW_CONTROL(baseio) {	\
-	u8	__oldmcr;	\
-	__oldmcr = inb((baseio)+UART_MCR);	\
-	__oldmcr &= ~MOXA_MUST_MCR_XON_ANY;	\
-	outb(__oldmcr, (baseio)+UART_MCR);	\
-}
-
-#define READ_MOXA_MUST_GDL(baseio)	inb((baseio)+MOXA_MUST_GDL_REGISTER)
+	__efr = inb((baseio)+MOXA_MUST_EFR_REGISTER);		\
+	__efr &= ~MOXA_MUST_EFR_SF_RX_MASK;			\
+	outb(__efr, (baseio)+MOXA_MUST_EFR_REGISTER);		\
+	outb(__oldlcr, (baseio)+UART_LCR);			\
+} while (0)
 
 #endif
