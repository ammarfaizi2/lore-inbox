Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281188AbRKPBws>; Thu, 15 Nov 2001 20:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281194AbRKPBwe>; Thu, 15 Nov 2001 20:52:34 -0500
Received: from shell7.ba.best.com ([206.184.139.138]:44557 "EHLO
	shell7.ba.best.com") by vger.kernel.org with ESMTP
	id <S281188AbRKPBwQ>; Thu, 15 Nov 2001 20:52:16 -0500
Date: Thu, 15 Nov 2001 17:51:44 -0800
From: Nathan Myers <ncm@nospam.cantrip.org>
To: linux-kernel@vger.kernel.org
Cc: alan@redhat.com, torvalds@transmeta.com
Subject: [PATCH] omnibus include/ cleanup (biggish)
Message-ID: <20011115175144.A6622@shell7.ba.best.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have located every place under linux/include/ that #defines
a macro with an improper unary expression, like any of

  #define X -1
  #define Y ~0xf
  #define Z !X
  #define V *(char*)bleah
  #define cpu_data &boot_cpu_data

The last example above caused an error in 2.4.15-pre4.
The patch below parenthesizes them.

It is archived at http://www.cantrip.org/patch-includes.diff
It applies to kernel 2.4.14-pre4.  Note that it doesn't fix the example 
noted above as found in asm-i386/processor.h, because that has already 
been noted on the list.  (Nobody else seems to have noticed that the 
same error appears in include/asm-mips/processor.h.)

Another patch for headers not under include/ might follow if anybody
acknowledges this one.

There are undoubtedly hundreds more such violations involving 
dyadic operators, but grep isn't so good at finding them.

Nathan Myers
ncm at cantrip dot org

-------------------------------------------------------------

diff -u -r include-bak/asm-alpha/gentrap.h include/asm-alpha/gentrap.h
--- include-bak/asm-alpha/gentrap.h	Thu Nov 15 16:09:57 2001
+++ include/asm-alpha/gentrap.h	Thu Nov 15 16:15:06 2001
@@ -6,31 +6,31 @@
  * programs and therefore should be compatible with the corresponding
  * OSF/1 definitions.
  */
-#define GEN_INTOVF	-1	/* integer overflow */
-#define GEN_INTDIV	-2	/* integer division by zero */
-#define GEN_FLTOVF	-3	/* fp overflow */
-#define GEN_FLTDIV	-4	/* fp division by zero */
-#define GEN_FLTUND	-5	/* fp underflow */
-#define GEN_FLTINV	-6	/* invalid fp operand */
-#define GEN_FLTINE	-7	/* inexact fp operand */
-#define GEN_DECOVF	-8	/* decimal overflow (for COBOL??) */
-#define GEN_DECDIV	-9	/* decimal division by zero */
-#define GEN_DECINV	-10	/* invalid decimal operand */
-#define GEN_ROPRAND	-11	/* reserved operand */
-#define GEN_ASSERTERR	-12	/* assertion error */
-#define GEN_NULPTRERR	-13	/* null pointer error */
-#define GEN_STKOVF	-14	/* stack overflow */
-#define GEN_STRLENERR	-15	/* string length error */
-#define GEN_SUBSTRERR	-16	/* substring error */
-#define GEN_RANGERR	-17	/* range error */
-#define GEN_SUBRNG	-18
-#define GEN_SUBRNG1	-19	 
-#define GEN_SUBRNG2	-20
-#define GEN_SUBRNG3	-21	/* these report range errors for */
-#define GEN_SUBRNG4	-22	/* subscripting (indexing) at levels 0..7 */
-#define GEN_SUBRNG5	-23
-#define GEN_SUBRNG6	-24
-#define GEN_SUBRNG7	-25
+#define GEN_INTOVF	(-1)	/* integer overflow */
+#define GEN_INTDIV	(-2)	/* integer division by zero */
+#define GEN_FLTOVF	(-3)	/* fp overflow */
+#define GEN_FLTDIV	(-4)	/* fp division by zero */
+#define GEN_FLTUND	(-5)	/* fp underflow */
+#define GEN_FLTINV	(-6)	/* invalid fp operand */
+#define GEN_FLTINE	(-7)	/* inexact fp operand */
+#define GEN_DECOVF	(-8)	/* decimal overflow (for COBOL??) */
+#define GEN_DECDIV	(-9)	/* decimal division by zero */
+#define GEN_DECINV	(-10)	/* invalid decimal operand */
+#define GEN_ROPRAND	(-11)	/* reserved operand */
+#define GEN_ASSERTERR	(-12)	/* assertion error */
+#define GEN_NULPTRERR	(-13)	/* null pointer error */
+#define GEN_STKOVF	(-14)	/* stack overflow */
+#define GEN_STRLENERR	(-15)	/* string length error */
+#define GEN_SUBSTRERR	(-16)	/* substring error */
+#define GEN_RANGERR	(-17)	/* range error */
+#define GEN_SUBRNG	(-18)
+#define GEN_SUBRNG1	(-19)	 
+#define GEN_SUBRNG2	(-20)
+#define GEN_SUBRNG3	(-21)	/* these report range errors for */
+#define GEN_SUBRNG4	(-22)	/* subscripting (indexing) at levels 0..7 */
+#define GEN_SUBRNG5	(-23)
+#define GEN_SUBRNG6	(-24)
+#define GEN_SUBRNG7	(-25)
 
 /* the remaining codes (-26..-1023) are reserved. */
 
diff -u -r include-bak/asm-alpha/siginfo.h include/asm-alpha/siginfo.h
--- include-bak/asm-alpha/siginfo.h	Thu Nov 15 16:09:58 2001
+++ include/asm-alpha/siginfo.h	Thu Nov 15 16:16:02 2001
@@ -102,11 +102,11 @@
  */
 #define SI_USER		0		/* sent by kill, sigsend, raise */
 #define SI_KERNEL	0x80		/* sent by the kernel from somewhere */
-#define SI_QUEUE	-1		/* sent by sigqueue */
+#define SI_QUEUE	(-1)		/* sent by sigqueue */
 #define SI_TIMER __SI_CODE(__SI_TIMER,-2) /* sent by timer expiration */
-#define SI_MESGQ	-3		/* sent by real time mesq state change */
-#define SI_ASYNCIO	-4		/* sent by AIO completion */
-#define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_MESGQ	(-3)		/* sent by real time mesq state change */
+#define SI_ASYNCIO	(-4)		/* sent by AIO completion */
+#define SI_SIGIO	(-5)		/* sent by queued SIGIO */
 
 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
diff -u -r include-bak/asm-arm/arch-l7200/aux_reg.h include/asm-arm/arch-l7200/aux_reg.h
--- include-bak/asm-arm/arch-l7200/aux_reg.h	Thu Nov 15 16:10:12 2001
+++ include/asm-arm/arch-l7200/aux_reg.h	Thu Nov 15 16:56:01 2001
@@ -11,7 +11,7 @@
 
 #include <asm/arch/hardware.h>
 
-#define l7200aux_reg	*((volatile unsigned int *) (AUX_BASE))
+#define l7200aux_reg	(*((volatile unsigned int *) (AUX_BASE)))
 
 /*
  * Auxillary register values
diff -u -r include-bak/asm-arm/arch-sa1100/assabet.h include/asm-arm/arch-sa1100/assabet.h
--- include-bak/asm-arm/arch-sa1100/assabet.h	Thu Nov 15 16:10:08 2001
+++ include/asm-arm/arch-sa1100/assabet.h	Thu Nov 15 16:55:38 2001
@@ -21,7 +21,7 @@
 #define ASSABET_SCR_GFX		(1<<8)	/* Graphics Accelerator (0 = present) */
 #define ASSABET_SCR_SA1111	(1<<9)	/* Neponset (0 = present) */
 
-#define ASSABET_SCR_INIT	-1
+#define ASSABET_SCR_INIT	(-1)
 
 
 /* Board Control Register */
diff -u -r include-bak/asm-arm/siginfo.h include/asm-arm/siginfo.h
--- include-bak/asm-arm/siginfo.h	Thu Nov 15 16:10:11 2001
+++ include/asm-arm/siginfo.h	Thu Nov 15 16:16:59 2001
@@ -102,11 +102,11 @@
  */
 #define SI_USER		0		/* sent by kill, sigsend, raise */
 #define SI_KERNEL	0x80		/* sent by the kernel from somewhere */
-#define SI_QUEUE	-1		/* sent by sigqueue */
+#define SI_QUEUE	(-1)		/* sent by sigqueue */
 #define SI_TIMER __SI_CODE(__SI_TIMER,-2) /* sent by timer expiration */
-#define SI_MESGQ	-3		/* sent by real time mesq state change */
-#define SI_ASYNCIO	-4		/* sent by AIO completion */
-#define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_MESGQ	(-3)		/* sent by real time mesq state change */
+#define SI_ASYNCIO	(-4)		/* sent by AIO completion */
+#define SI_SIGIO	(-5)		/* sent by queued SIGIO */
 
 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
diff -u -r include-bak/asm-cris/siginfo.h include/asm-cris/siginfo.h
--- include-bak/asm-cris/siginfo.h	Thu Nov 15 16:10:34 2001
+++ include/asm-cris/siginfo.h	Thu Nov 15 16:17:33 2001
@@ -102,11 +102,11 @@
  */
 #define SI_USER		0		/* sent by kill, sigsend, raise */
 #define SI_KERNEL	0x80		/* sent by the kernel from somewhere */
-#define SI_QUEUE	-1		/* sent by sigqueue */
+#define SI_QUEUE	(-1)		/* sent by sigqueue */
 #define SI_TIMER __SI_CODE(__SI_TIMER,-2) /* sent by timer expiration */
-#define SI_MESGQ	-3		/* sent by real time mesq state change */
-#define SI_ASYNCIO	-4		/* sent by AIO completion */
-#define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_MESGQ	(-3)		/* sent by real time mesq state change */
+#define SI_ASYNCIO	(-4)		/* sent by AIO completion */
+#define SI_SIGIO	(-5)		/* sent by queued SIGIO */
 
 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
diff -u -r include-bak/asm-i386/siginfo.h include/asm-i386/siginfo.h
--- include-bak/asm-i386/siginfo.h	Thu Nov 15 16:09:54 2001
+++ include/asm-i386/siginfo.h	Thu Nov 15 16:18:00 2001
@@ -102,11 +102,11 @@
  */
 #define SI_USER		0		/* sent by kill, sigsend, raise */
 #define SI_KERNEL	0x80		/* sent by the kernel from somewhere */
-#define SI_QUEUE	-1		/* sent by sigqueue */
+#define SI_QUEUE	(-1)		/* sent by sigqueue */
 #define SI_TIMER __SI_CODE(__SI_TIMER,-2) /* sent by timer expiration */
-#define SI_MESGQ	-3		/* sent by real time mesq state change */
-#define SI_ASYNCIO	-4		/* sent by AIO completion */
-#define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_MESGQ	(-3)		/* sent by real time mesq state change */
+#define SI_ASYNCIO	(-4)		/* sent by AIO completion */
+#define SI_SIGIO	(-5)		/* sent by queued SIGIO */
 
 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
diff -u -r include-bak/asm-ia64/pal.h include/asm-ia64/pal.h
--- include-bak/asm-ia64/pal.h	Thu Nov 15 16:10:16 2001
+++ include/asm-ia64/pal.h	Thu Nov 15 16:18:50 2001
@@ -88,10 +88,10 @@
 typedef s64				pal_status_t;
 
 #define PAL_STATUS_SUCCESS		0	/* No error */
-#define PAL_STATUS_UNIMPLEMENTED	-1	/* Unimplemented procedure */
-#define PAL_STATUS_EINVAL		-2	/* Invalid argument */
-#define PAL_STATUS_ERROR		-3	/* Error */
-#define PAL_STATUS_CACHE_INIT_FAIL	-4	/* Could not initialize the
+#define PAL_STATUS_UNIMPLEMENTED	(-1)	/* Unimplemented procedure */
+#define PAL_STATUS_EINVAL		(-2)	/* Invalid argument */
+#define PAL_STATUS_ERROR		(-3)	/* Error */
+#define PAL_STATUS_CACHE_INIT_FAIL	(-4)	/* Could not initialize the
 						 * specified level and type of
 						 * cache without sideeffects
 						 * and "restrict" was 1
diff -u -r include-bak/asm-ia64/siginfo.h include/asm-ia64/siginfo.h
--- include-bak/asm-ia64/siginfo.h	Thu Nov 15 16:10:17 2001
+++ include/asm-ia64/siginfo.h	Thu Nov 15 16:19:26 2001
@@ -119,11 +119,11 @@
 
 #define SI_USER		0		/* sent by kill, sigsend, raise */
 #define SI_KERNEL	0x80		/* sent by the kernel from somewhere */
-#define SI_QUEUE	-1		/* sent by sigqueue */
+#define SI_QUEUE	(-1)		/* sent by sigqueue */
 #define SI_TIMER __SI_CODE(__SI_TIMER,-2) /* sent by timer expiration */
-#define SI_MESGQ	-3		/* sent by real time mesq state change */
-#define SI_ASYNCIO	-4		/* sent by AIO completion */
-#define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_MESGQ	(-3)		/* sent by real time mesq state change */
+#define SI_ASYNCIO	(-4)		/* sent by AIO completion */
+#define SI_SIGIO	(-5)		/* sent by queued SIGIO */
 
 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
diff -u -r include-bak/asm-ia64/sn/alenlist.h include/asm-ia64/sn/alenlist.h
--- include-bak/asm-ia64/sn/alenlist.h	Thu Nov 15 16:10:17 2001
+++ include/asm-ia64/sn/alenlist.h	Thu Nov 15 16:56:22 2001
@@ -51,7 +51,7 @@
 
 
 /* Return codes from alenlist routines.  */
-#define ALENLIST_FAILURE -1
+#define ALENLIST_FAILURE (-1)
 #define ALENLIST_SUCCESS 0
 
 
diff -u -r include-bak/asm-ia64/sn/clksupport.h include/asm-ia64/sn/clksupport.h
--- include-bak/asm-ia64/sn/clksupport.h	Thu Nov 15 16:10:17 2001
+++ include/asm-ia64/sn/clksupport.h	Thu Nov 15 16:57:18 2001
@@ -50,7 +50,7 @@
 typedef heartreg_t clkreg_t;
 #define NSEC_PER_CYCLE		80
 #define CYCLE_PER_SEC		(NSEC_PER_SEC/NSEC_PER_CYCLE)
-#define GET_LOCAL_RTC	*((volatile clkreg_t *)PHYS_TO_COMPATK1(HEART_COUNT))
+#define GET_LOCAL_RTC  (*((volatile clkreg_t *)PHYS_TO_COMPATK1(HEART_COUNT)))
 #define DISABLE_TMO_INTR()
 #define CLK_CYCLE_ADDRESS_FOR_USER PHYS_TO_K1(HEART_COUNT)
 #define CLK_FCLOCK_SLOW_FREQ (CYCLE_PER_SEC / HZ)
diff -u -r include-bak/asm-ia64/sn/intr.h include/asm-ia64/sn/intr.h
--- include-bak/asm-ia64/sn/intr.h	Thu Nov 15 16:10:17 2001
+++ include/asm-ia64/sn/intr.h	Thu Nov 15 16:57:47 2001
@@ -11,7 +11,7 @@
 #define _ASM_SN_INTR_H
 
 /* Subnode wildcard */
-#define SUBNODE_ANY		-1
+#define SUBNODE_ANY		(-1)
 
 /* Number of interrupt levels associated with each interrupt register. */
 #define N_INTPEND_BITS		64
@@ -79,7 +79,7 @@
 /*
  * Interrupt level wildcard
  */
-#define INTRCONNECT_ANYBIT	-1
+#define INTRCONNECT_ANYBIT	(-1)
 
 /*
  * This structure holds information needed both to call and to maintain
diff -u -r include-bak/asm-ia64/sn/ksys/elsc.h include/asm-ia64/sn/ksys/elsc.h
--- include-bak/asm-ia64/sn/ksys/elsc.h	Thu Nov 15 16:10:17 2001
+++ include/asm-ia64/sn/ksys/elsc.h	Thu Nov 15 17:08:54 2001
@@ -142,23 +142,23 @@
 
 #define ELSC_ERROR_NONE			0
 
-#define ELSC_ERROR_CMD_SEND	       -100	/* Error sending command    */
-#define ELSC_ERROR_CMD_CHECKSUM	       -101	/* Command checksum bad     */
-#define ELSC_ERROR_CMD_UNKNOWN	       -102	/* Unknown command          */
-#define ELSC_ERROR_CMD_ARGS	       -103	/* Invalid argument(s)      */
-#define ELSC_ERROR_CMD_PERM	       -104	/* Permission denied	    */
-#define ELSC_ERROR_CMD_STATE	       -105	/* not allowed in this state*/
+#define ELSC_ERROR_CMD_SEND	       (-100)	/* Error sending command    */
+#define ELSC_ERROR_CMD_CHECKSUM	       (-101)	/* Command checksum bad     */
+#define ELSC_ERROR_CMD_UNKNOWN	       (-102)	/* Unknown command          */
+#define ELSC_ERROR_CMD_ARGS	       (-103)	/* Invalid argument(s)      */
+#define ELSC_ERROR_CMD_PERM	       (-104)	/* Permission denied	    */
+#define ELSC_ERROR_CMD_STATE	       (-105)	/* not allowed in this state*/
 
-#define ELSC_ERROR_RESP_TIMEOUT	       -110	/* ELSC response timeout    */
-#define ELSC_ERROR_RESP_CHECKSUM       -111	/* Response checksum bad    */
-#define ELSC_ERROR_RESP_FORMAT	       -112	/* Response format error    */
-#define ELSC_ERROR_RESP_DIR	       -113	/* Response direction error */
+#define ELSC_ERROR_RESP_TIMEOUT	       (-110)	/* ELSC response timeout    */
+#define ELSC_ERROR_RESP_CHECKSUM       (-111)	/* Response checksum bad    */
+#define ELSC_ERROR_RESP_FORMAT	       (-112)	/* Response format error    */
+#define ELSC_ERROR_RESP_DIR	       (-113)	/* Response direction error */
 
-#define ELSC_ERROR_MSG_LOST	       -120	/* Queue full; msg. lost    */
-#define ELSC_ERROR_LOCK_TIMEOUT	       -121	/* ELSC response timeout    */
-#define ELSC_ERROR_DATA_SEND	       -122	/* Error sending data       */
-#define ELSC_ERROR_NIC		       -123	/* NIC processing error     */
-#define ELSC_ERROR_NVMAGIC	       -124	/* Bad magic no. in NVRAM   */
-#define ELSC_ERROR_MODULE	       -125	/* Moduleid processing err  */
+#define ELSC_ERROR_MSG_LOST	       (-120)	/* Queue full; msg. lost    */
+#define ELSC_ERROR_LOCK_TIMEOUT	       (-121)	/* ELSC response timeout    */
+#define ELSC_ERROR_DATA_SEND	       (-122)	/* Error sending data       */
+#define ELSC_ERROR_NIC		       (-123)	/* NIC processing error     */
+#define ELSC_ERROR_NVMAGIC	       (-124)	/* Bad magic no. in NVRAM   */
+#define ELSC_ERROR_MODULE	       (-125)	/* Moduleid processing err  */
 
 #endif /* _ASM_SN_KSYS_ELSC_H */
diff -u -r include-bak/asm-ia64/sn/ksys/i2c.h include/asm-ia64/sn/ksys/i2c.h
--- include-bak/asm-ia64/sn/ksys/i2c.h	Thu Nov 15 16:10:17 2001
+++ include/asm-ia64/sn/ksys/i2c.h	Thu Nov 15 17:09:43 2001
@@ -62,16 +62,16 @@
  */
 
 #define I2C_ERROR_NONE		 0
-#define I2C_ERROR_INIT		-1	/* Initialization error             */
-#define I2C_ERROR_STATE		-2	/* Unexpected chip state	    */
-#define I2C_ERROR_NAK		-3	/* Addressed slave not responding   */
-#define I2C_ERROR_TO_ARB	-4	/* Timeout waiting for sysctlr arb  */
-#define I2C_ERROR_TO_BUSY	-5	/* Timeout waiting for busy bus     */
-#define I2C_ERROR_TO_SENDA	-6	/* Timeout sending address byte     */
-#define I2C_ERROR_TO_SENDD	-7	/* Timeout sending data byte        */
-#define I2C_ERROR_TO_RECVA	-8	/* Timeout receiving address byte   */
-#define I2C_ERROR_TO_RECVD	-9	/* Timeout receiving data byte      */
-#define I2C_ERROR_NO_MESSAGE	-10	/* No message was waiting	    */
-#define I2C_ERROR_NO_ELSC	-11	/* ELSC is disabled for access 	    */ 	
+#define I2C_ERROR_INIT		(-1)	/* Initialization error             */
+#define I2C_ERROR_STATE		(-2)	/* Unexpected chip state	    */
+#define I2C_ERROR_NAK		(-3)	/* Addressed slave not responding   */
+#define I2C_ERROR_TO_ARB	(-4)	/* Timeout waiting for sysctlr arb  */
+#define I2C_ERROR_TO_BUSY	(-5)	/* Timeout waiting for busy bus     */
+#define I2C_ERROR_TO_SENDA	(-6)	/* Timeout sending address byte     */
+#define I2C_ERROR_TO_SENDD	(-7)	/* Timeout sending data byte        */
+#define I2C_ERROR_TO_RECVA	(-8)	/* Timeout receiving address byte   */
+#define I2C_ERROR_TO_RECVD	(-9)	/* Timeout receiving data byte      */
+#define I2C_ERROR_NO_MESSAGE	(-10)	/* No message was waiting	    */
+#define I2C_ERROR_NO_ELSC	(-11)	/* ELSC is disabled for access 	    */ 	
 
 #endif /* _ASM_SN_KSYS_I2C_H */
diff -u -r include-bak/asm-ia64/sn/labelcl.h include/asm-ia64/sn/labelcl.h
--- include-bak/asm-ia64/sn/labelcl.h	Thu Nov 15 16:10:17 2001
+++ include/asm-ia64/sn/labelcl.h	Thu Nov 15 16:58:05 2001
@@ -12,7 +12,7 @@
 
 #define LABELCL_MAGIC 0x4857434c	/* 'HWLC' */
 #define LABEL_LENGTH_MAX 256		/* Includes NULL char */
-#define INFO_DESC_PRIVATE -1      	/* default */
+#define INFO_DESC_PRIVATE (-1)      	/* default */
 #define INFO_DESC_EXPORT  0       	/* export info itself */
 
 /*
diff -u -r include-bak/asm-ia64/sn/pci/pciio.h include/asm-ia64/sn/pci/pciio.h
--- include-bak/asm-ia64/sn/pci/pciio.h	Thu Nov 15 16:10:17 2001
+++ include/asm-ia64/sn/pci/pciio.h	Thu Nov 15 17:10:27 2001
@@ -29,11 +29,11 @@
 
 typedef int pciio_vendor_id_t;
 
-#define PCIIO_VENDOR_ID_NONE	-1
+#define PCIIO_VENDOR_ID_NONE	(-1)
 
 typedef int pciio_device_id_t;
 
-#define PCIIO_DEVICE_ID_NONE	-1
+#define PCIIO_DEVICE_ID_NONE	(-1)
 
 typedef uint8_t pciio_bus_t;       /* PCI bus number (0..255) */
 typedef uint8_t pciio_slot_t;      /* PCI slot number (0..31, 255) */
diff -u -r include-bak/asm-ia64/sn/pio.h include/asm-ia64/sn/pio.h
--- include-bak/asm-ia64/sn/pio.h	Thu Nov 15 16:10:17 2001
+++ include/asm-ia64/sn/pio.h	Thu Nov 15 16:58:26 2001
@@ -143,7 +143,7 @@
 #define LAN_RAM         2
 #define LAN_IO          3
 
-#define PIOREG_NULL	-1
+#define PIOREG_NULL	(-1)
 
 /* standard flags values for pio_map routines,
  * including {xtalk,pciio}_piomap calls.
diff -u -r include-bak/asm-ia64/sn/prio.h include/asm-ia64/sn/prio.h
--- include-bak/asm-ia64/sn/prio.h	Thu Nov 15 16:10:18 2001
+++ include/asm-ia64/sn/prio.h	Thu Nov 15 16:58:40 2001
@@ -33,6 +33,6 @@
 
 /* Error returns */
 #define PRIO_SUCCESS     0
-#define PRIO_FAIL       -1 
+#define PRIO_FAIL       (-1)
 
 #endif /* _ASM_SN_PRIO_H */
diff -u -r include-bak/asm-ia64/sn/sn1/ip27config.h include/asm-ia64/sn/sn1/ip27config.h
--- include-bak/asm-ia64/sn/sn1/ip27config.h	Thu Nov 15 16:10:18 2001
+++ include/asm-ia64/sn/sn1/ip27config.h	Thu Nov 15 17:11:03 2001
@@ -258,7 +258,7 @@
  */
 
 /* these numbers are as the are ordered in the table below */
-#define	IP27_CONFIG_UNKNOWN -1
+#define	IP27_CONFIG_UNKNOWN (-1)
 #define IP27_CONFIG_SN1_1MB_200_400_200_TABLE 0
 #define IP27_CONFIG_SN00_4MB_100_200_133_TABLE 1
 #define IP27_CONFIG_SN1_4MB_200_400_267_TABLE 2
diff -u -r include-bak/asm-ia64/sn/sn1/kldir.h include/asm-ia64/sn/sn1/kldir.h
--- include-bak/asm-ia64/sn/sn1/kldir.h	Thu Nov 15 16:10:18 2001
+++ include/asm-ia64/sn/sn1/kldir.h	Thu Nov 15 17:11:26 2001
@@ -193,7 +193,7 @@
 #define IP27_SYMMON_STK_STRIDE		0x8000
 
 #define IP27_FREEMEM_OFFSET		0x40000
-#define IP27_FREEMEM_SIZE		-1
+#define IP27_FREEMEM_SIZE		(-1)
 #define IP27_FREEMEM_COUNT		1
 #define IP27_FREEMEM_STRIDE		0
 
diff -u -r include-bak/asm-ia64/sn/sn1/promlog.h include/asm-ia64/sn/sn1/promlog.h
--- include-bak/asm-ia64/sn/sn1/promlog.h	Thu Nov 15 16:10:18 2001
+++ include/asm-ia64/sn/sn1/promlog.h	Thu Nov 15 17:12:18 2001
@@ -22,17 +22,17 @@
 #define PROMLOG_OFFSET_ENTRY0		0x100
 
 #define PROMLOG_ERROR_NONE		0
-#define PROMLOG_ERROR_PROM	       -1
-#define PROMLOG_ERROR_MAGIC	       -2
-#define PROMLOG_ERROR_CORRUPT	       -3
-#define PROMLOG_ERROR_BOL	       -4
-#define PROMLOG_ERROR_EOL	       -5
-#define PROMLOG_ERROR_POS	       -6
-#define PROMLOG_ERROR_REPLACE	       -7
-#define PROMLOG_ERROR_COMPACT	       -8
-#define PROMLOG_ERROR_FULL	       -9
-#define PROMLOG_ERROR_ARG	       -10
-#define PROMLOG_ERROR_UNUSED	       -11	  	
+#define PROMLOG_ERROR_PROM	       (-1)
+#define PROMLOG_ERROR_MAGIC	       (-2)
+#define PROMLOG_ERROR_CORRUPT	       (-3)
+#define PROMLOG_ERROR_BOL	       (-4)
+#define PROMLOG_ERROR_EOL	       (-5)
+#define PROMLOG_ERROR_POS	       (-6)
+#define PROMLOG_ERROR_REPLACE	       (-7)
+#define PROMLOG_ERROR_COMPACT	       (-8)
+#define PROMLOG_ERROR_FULL	       (-9)
+#define PROMLOG_ERROR_ARG	       (-10)
+#define PROMLOG_ERROR_UNUSED	       (-11)	  	
 
 #define PROMLOG_TYPE_UNUSED		0xf
 #define PROMLOG_TYPE_LOG		3
diff -u -r include-bak/asm-ia64/sn/vector.h include/asm-ia64/sn/vector.h
--- include-bak/asm-ia64/sn/vector.h	Thu Nov 15 16:10:18 2001
+++ include/asm-ia64/sn/vector.h	Thu Nov 15 16:59:22 2001
@@ -67,16 +67,16 @@
 #endif
 
 #define NET_ERROR_NONE          0       /* No error             */
-#define NET_ERROR_HARDWARE     -1       /* Hardware error       */
-#define NET_ERROR_OVERRUN      -2       /* Extra response(s)    */
-#define NET_ERROR_REPLY        -3       /* Reply parms mismatch */
-#define NET_ERROR_ADDRESS      -4       /* Addr error response  */
-#define NET_ERROR_COMMAND      -5       /* Cmd error response   */
-#define NET_ERROR_PROT         -6       /* Prot error response  */
-#define NET_ERROR_TIMEOUT      -7       /* Too many retries     */
-#define NET_ERROR_VECTOR       -8       /* Invalid vector/path  */
-#define NET_ERROR_ROUTERLOCK   -9       /* Timeout locking rtr  */
-#define NET_ERROR_INVAL	       -10	/* Invalid vector request */
+#define NET_ERROR_HARDWARE     (-1)     /* Hardware error       */
+#define NET_ERROR_OVERRUN      (-2)     /* Extra response(s)    */
+#define NET_ERROR_REPLY        (-3)     /* Reply parms mismatch */
+#define NET_ERROR_ADDRESS      (-4)     /* Addr error response  */
+#define NET_ERROR_COMMAND      (-5)     /* Cmd error response   */
+#define NET_ERROR_PROT         (-6)     /* Prot error response  */
+#define NET_ERROR_TIMEOUT      (-7)     /* Too many retries     */
+#define NET_ERROR_VECTOR       (-8)     /* Invalid vector/path  */
+#define NET_ERROR_ROUTERLOCK   (-9)     /* Timeout locking rtr  */
+#define NET_ERROR_INVAL	       (-10)	/* Invalid vector request */
 
 #if defined(_LANGUAGE_C) || defined(_LANGUAGE_C_PLUS_PLUS)
 typedef uint64_t              net_reg_t;
diff -u -r include-bak/asm-ia64/sn/xtalk/xtalk.h include/asm-ia64/sn/xtalk/xtalk.h
--- include-bak/asm-ia64/sn/xtalk/xtalk.h	Thu Nov 15 16:10:19 2001
+++ include/asm-ia64/sn/xtalk/xtalk.h	Thu Nov 15 17:12:49 2001
@@ -18,19 +18,19 @@
  */
 typedef char            xwidgetnum_t;	/* xtalk widget number  (0..15) */
 
-#define XWIDGET_NONE		-1
+#define XWIDGET_NONE		(-1)
 
 typedef int xwidget_part_num_t;	/* xtalk widget part number */
 
-#define XWIDGET_PART_NUM_NONE	-1
+#define XWIDGET_PART_NUM_NONE	(-1)
 
 typedef int             xwidget_rev_num_t;	/* xtalk widget revision number */
 
-#define XWIDGET_REV_NUM_NONE	-1
+#define XWIDGET_REV_NUM_NONE	(-1)
 
 typedef int xwidget_mfg_num_t;	/* xtalk widget manufacturing ID */
 
-#define XWIDGET_MFG_NUM_NONE	-1
+#define XWIDGET_MFG_NUM_NONE	(-1)
 
 typedef struct xtalk_piomap_s *xtalk_piomap_t;
 
diff -u -r include-bak/asm-m68k/bvme6000hw.h include/asm-m68k/bvme6000hw.h
--- include-bak/asm-m68k/bvme6000hw.h	Thu Nov 15 16:09:59 2001
+++ include/asm-m68k/bvme6000hw.h	Thu Nov 15 16:20:03 2001
@@ -138,13 +138,13 @@
 #define BVME_ACR_A24LBA		0xff460003
 #define BVME_ACR_ADDRCTL	0xff470003
 
-#define bvme_acr_a32vba		*(volatile unsigned char *)BVME_ACR_A32VBA
-#define bvme_acr_a32msk		*(volatile unsigned char *)BVME_ACR_A32MSK
-#define bvme_acr_a24vba		*(volatile unsigned char *)BVME_ACR_A24VBA
-#define bvme_acr_a24msk		*(volatile unsigned char *)BVME_ACR_A24MSK
-#define bvme_acr_a16vba		*(volatile unsigned char *)BVME_ACR_A16VBA
-#define bvme_acr_a32lba		*(volatile unsigned char *)BVME_ACR_A32LBA
-#define bvme_acr_a24lba		*(volatile unsigned char *)BVME_ACR_A24LBA
-#define bvme_acr_addrctl	*(volatile unsigned char *)BVME_ACR_ADDRCTL
+#define bvme_acr_a32vba		(*(volatile unsigned char *)BVME_ACR_A32VBA)
+#define bvme_acr_a32msk		(*(volatile unsigned char *)BVME_ACR_A32MSK)
+#define bvme_acr_a24vba		(*(volatile unsigned char *)BVME_ACR_A24VBA)
+#define bvme_acr_a24msk		(*(volatile unsigned char *)BVME_ACR_A24MSK)
+#define bvme_acr_a16vba		(*(volatile unsigned char *)BVME_ACR_A16VBA)
+#define bvme_acr_a32lba		(*(volatile unsigned char *)BVME_ACR_A32LBA)
+#define bvme_acr_a24lba		(*(volatile unsigned char *)BVME_ACR_A24LBA)
+#define bvme_acr_addrctl	(*(volatile unsigned char *)BVME_ACR_ADDRCTL)
 
 #endif
diff -u -r include-bak/asm-m68k/mc146818rtc.h include/asm-m68k/mc146818rtc.h
--- include-bak/asm-m68k/mc146818rtc.h	Thu Nov 15 16:09:59 2001
+++ include/asm-m68k/mc146818rtc.h	Thu Nov 15 16:21:01 2001
@@ -33,7 +33,7 @@
 /* On Atari, the year was stored with base 1970 in old TOS versions (before
  * 3.06). Later, Atari recognized that this broke leap year recognition, and
  * changed the base to 1968. Medusa and Hades always use the new version. */
-#define RTC_CENTURY_SWITCH	-1	/* no century switch */
+#define RTC_CENTURY_SWITCH	(-1)	/* no century switch */
 #define RTC_MINYEAR		epoch
 
 #define CMOS_READ(addr) ({ \
diff -u -r include-bak/asm-m68k/siginfo.h include/asm-m68k/siginfo.h
--- include-bak/asm-m68k/siginfo.h	Thu Nov 15 16:09:58 2001
+++ include/asm-m68k/siginfo.h	Thu Nov 15 16:21:33 2001
@@ -112,11 +112,11 @@
  */
 #define SI_USER		0		/* sent by kill, sigsend, raise */
 #define SI_KERNEL	0x80		/* sent by the kernel from somewhere */
-#define SI_QUEUE	-1		/* sent by sigqueue */
+#define SI_QUEUE	(-1)		/* sent by sigqueue */
 #define SI_TIMER __SI_CODE(__SI_TIMER,-2) /* sent by timer expiration */
-#define SI_MESGQ	-3		/* sent by real time mesq state change */
-#define SI_ASYNCIO	-4		/* sent by AIO completion */
-#define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_MESGQ	(-3)		/* sent by real time mesq state change */
+#define SI_ASYNCIO	(-4)		/* sent by AIO completion */
+#define SI_SIGIO	(-5)		/* sent by queued SIGIO */
 
 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
diff -u -r include-bak/asm-m68k/swim_iop.h include/asm-m68k/swim_iop.h
--- include-bak/asm-m68k/swim_iop.h	Thu Nov 15 16:09:59 2001
+++ include/asm-m68k/swim_iop.h	Thu Nov 15 16:22:28 2001
@@ -58,32 +58,32 @@
 
 /* Error codes: */
 
-#define	gcrOnMFMErr	-400	/* GCR (400/800K) on HD media */
-#define	verErr		-84	/* verify failed */
-#define	fmt2Err		-83	/* cant get enough sync during format */
-#define	fmt1Err		-82	/* can't find sector 0 after track format */
-#define	sectNFErr	-81	/* can't find sector */
-#define	seekErr		-80	/* drive error during seek */
-#define	spdAdjErr	-79	/* can't set drive speed */
-#define	twoSideErr	-78	/* drive is single-sided */
-#define	initIWMErr	-77	/* error during initialization */
-#define	tk0badErr	-76	/* track zero is bad */
-#define	cantStepErr	-75	/* drive error during step */
-#define	wrUnderrun	-74	/* write underrun occurred */
-#define	badDBtSlp	-73	/* bad data bitslip marks */
-#define	badDCksum	-72	/* bad data checksum */
-#define	noDtaMkErr	-71	/* can't find data mark */
-#define	badBtSlpErr	-70	/* bad address bitslip marks */
-#define	badCksmErr	-69	/* bad address-mark checksum */
-#define	dataVerErr	-68	/* read-verify failed */
-#define	noAdrMkErr	-67	/* can't find an address mark */
-#define	noNybErr	-66	/* no nybbles? disk is probably degaussed */
-#define	offLinErr	-65	/* no disk in drive */
-#define	noDriveErr	-64	/* drive isn't connected */
-#define	nsDrvErr	-56	/* no such drive */
-#define	paramErr	-50	/* bad positioning information */
-#define	wPrErr		-44	/* write protected */
-#define	openErr		-23	/* already initialized */
+#define	gcrOnMFMErr	(-400)	/* GCR (400/800K) on HD media */
+#define	verErr		(-84)	/* verify failed */
+#define	fmt2Err		(-83)	/* cant get enough sync during format */
+#define	fmt1Err		(-82)	/* can't find sector 0 after track format */
+#define	sectNFErr	(-81)	/* can't find sector */
+#define	seekErr		(-80)	/* drive error during seek */
+#define	spdAdjErr	(-79)	/* can't set drive speed */
+#define	twoSideErr	(-78)	/* drive is single-sided */
+#define	initIWMErr	(-77)	/* error during initialization */
+#define	tk0badErr	(-76)	/* track zero is bad */
+#define	cantStepErr	(-75)	/* drive error during step */
+#define	wrUnderrun	(-74)	/* write underrun occurred */
+#define	badDBtSlp	(-73)	/* bad data bitslip marks */
+#define	badDCksum	(-72)	/* bad data checksum */
+#define	noDtaMkErr	(-71)	/* can't find data mark */
+#define	badBtSlpErr	(-70)	/* bad address bitslip marks */
+#define	badCksmErr	(-69)	/* bad address-mark checksum */
+#define	dataVerErr	(-68)	/* read-verify failed */
+#define	noAdrMkErr	(-67)	/* can't find an address mark */
+#define	noNybErr	(-66)	/* no nybbles? disk is probably degaussed */
+#define	offLinErr	(-65)	/* no disk in drive */
+#define	noDriveErr	(-64)	/* drive isn't connected */
+#define	nsDrvErr	(-56)	/* no such drive */
+#define	paramErr	(-50)	/* bad positioning information */
+#define	wPrErr		(-44)	/* write protected */
+#define	openErr		(-23)	/* already initialized */
 
 #ifndef __ASSEMBLY__
 
diff -u -r include-bak/asm-mips/asm.h include/asm-mips/asm.h
--- include-bak/asm-mips/asm.h	Thu Nov 15 16:09:55 2001
+++ include/asm-mips/asm.h	Thu Nov 15 16:23:16 2001
@@ -206,12 +206,12 @@
 #if (_MIPS_ISA == _MIPS_ISA_MIPS1) || (_MIPS_ISA == _MIPS_ISA_MIPS2) || \
     (_MIPS_ISA == _MIPS_ISA_MIPS32)
 #define ALSZ	7
-#define ALMASK	~7
+#define ALMASK	(~7)
 #endif
 #if (_MIPS_ISA == _MIPS_ISA_MIPS3) || (_MIPS_ISA == _MIPS_ISA_MIPS4) || \
     (_MIPS_ISA == _MIPS_ISA_MIPS5) || (_MIPS_ISA == _MIPS_ISA_MIPS64)
 #define ALSZ	15
-#define ALMASK	~15
+#define ALMASK	(~15)
 #endif
 
 /*
diff -u -r include-bak/asm-mips/processor.h include/asm-mips/processor.h
--- include-bak/asm-mips/processor.h	Thu Nov 15 16:09:55 2001
+++ include/asm-mips/processor.h	Thu Nov 15 16:24:34 2001
@@ -51,7 +51,7 @@
 extern struct mips_cpuinfo cpu_data[];
 #define current_cpu_data cpu_data[smp_processor_id()]
 #else
-#define cpu_data &boot_cpu_data
+#define cpu_data (&boot_cpu_data)
 #define current_cpu_data boot_cpu_data
 #endif
 
diff -u -r include-bak/asm-mips/siginfo.h include/asm-mips/siginfo.h
--- include-bak/asm-mips/siginfo.h	Thu Nov 15 16:09:56 2001
+++ include/asm-mips/siginfo.h	Thu Nov 15 16:25:05 2001
@@ -122,11 +122,11 @@
  */
 #define SI_USER		0	/* sent by kill, sigsend, raise */
 #define SI_KERNEL	0x80	/* sent by the kernel from somewhere */
-#define SI_QUEUE	-1	/* sent by sigqueue */
-#define SI_ASYNCIO	-2	/* sent by AIO completion */
+#define SI_QUEUE	(-1)	/* sent by sigqueue */
+#define SI_ASYNCIO	(-2)	/* sent by AIO completion */
 #define SI_TIMER __SI_CODE(__SI_TIMER,-3) /* sent by timer expiration */
-#define SI_MESGQ	-4	/* sent by real time mesq state change */
-#define SI_SIGIO	-5	/* sent by queued SIGIO */
+#define SI_MESGQ	(-4)	/* sent by real time mesq state change */
+#define SI_SIGIO	(-5)	/* sent by queued SIGIO */
 
 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
diff -u -r include-bak/asm-mips64/asm.h include/asm-mips64/asm.h
--- include-bak/asm-mips64/asm.h	Thu Nov 15 16:10:19 2001
+++ include/asm-mips64/asm.h	Thu Nov 15 16:25:58 2001
@@ -187,12 +187,12 @@
 #if (_MIPS_ISA == _MIPS_ISA_MIPS1) || (_MIPS_ISA == _MIPS_ISA_MIPS2) || \
     (_MIPS_ISA == _MIPS_ISA_MIPS32)
 #define ALSZ	7
-#define ALMASK	~7
+#define ALMASK	(~7)
 #endif
 #if (_MIPS_ISA == _MIPS_ISA_MIPS3) || (_MIPS_ISA == _MIPS_ISA_MIPS4) || \
     (_MIPS_ISA == _MIPS_ISA_MIPS5) || (_MIPS_ISA == _MIPS_ISA_MIPS64)
 #define ALSZ	15
-#define ALMASK	~15
+#define ALMASK	(~15)
 #endif
 
 /*
diff -u -r include-bak/asm-mips64/siginfo.h include/asm-mips64/siginfo.h
--- include-bak/asm-mips64/siginfo.h	Thu Nov 15 16:10:20 2001
+++ include/asm-mips64/siginfo.h	Thu Nov 15 16:25:35 2001
@@ -122,11 +122,11 @@
  */
 #define SI_USER		0	/* sent by kill, sigsend, raise */
 #define SI_KERNEL	0x80	/* sent by the kernel from somewhere */
-#define SI_QUEUE	-1	/* sent by sigqueue */
-#define SI_ASYNCIO	-2	/* sent by AIO completion */
+#define SI_QUEUE	(-1)	/* sent by sigqueue */
+#define SI_ASYNCIO	(-2)	/* sent by AIO completion */
 #define SI_TIMER __SI_CODE(__SI_TIMER,-3) /* sent by timer expiration */
-#define SI_MESGQ	-4	/* sent by real time mesq state change */
-#define SI_SIGIO	-5	/* sent by queued SIGIO */
+#define SI_MESGQ	(-4)	/* sent by real time mesq state change */
+#define SI_SIGIO	(-5)	/* sent by queued SIGIO */
 
 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
diff -u -r include-bak/asm-mips64/sn/kldir.h include/asm-mips64/sn/kldir.h
--- include-bak/asm-mips64/sn/kldir.h	Thu Nov 15 16:10:20 2001
+++ include/asm-mips64/sn/kldir.h	Thu Nov 15 17:00:07 2001
@@ -180,7 +180,7 @@
 #define IP27_SYMMON_STK_STRIDE		0x7000
 
 #define IP27_FREEMEM_OFFSET		0x19000
-#define IP27_FREEMEM_SIZE		-1
+#define IP27_FREEMEM_SIZE		(-1)
 #define IP27_FREEMEM_COUNT		1
 #define IP27_FREEMEM_STRIDE		0
 
diff -u -r include-bak/asm-mips64/xtalk/xtalk.h include/asm-mips64/xtalk/xtalk.h
--- include-bak/asm-mips64/xtalk/xtalk.h	Thu Nov 15 16:10:20 2001
+++ include/asm-mips64/xtalk/xtalk.h	Thu Nov 15 17:00:44 2001
@@ -18,19 +18,19 @@
  */
 typedef char            xwidgetnum_t;	/* xtalk widget number  (0..15) */
 
-#define XWIDGET_NONE		-1
+#define XWIDGET_NONE		(-1)
 
 typedef int xwidget_part_num_t;	/* xtalk widget part number */
 
-#define XWIDGET_PART_NUM_NONE	-1
+#define XWIDGET_PART_NUM_NONE	(-1)
 
 typedef int             xwidget_rev_num_t;	/* xtalk widget revision number */
 
-#define XWIDGET_REV_NUM_NONE	-1
+#define XWIDGET_REV_NUM_NONE	(-1)
 
 typedef int xwidget_mfg_num_t;	/* xtalk widget manufacturing ID */
 
-#define XWIDGET_MFG_NUM_NONE	-1
+#define XWIDGET_MFG_NUM_NONE	(-1)
 
 typedef struct xtalk_piomap_s *xtalk_piomap_t;
 
diff -u -r include-bak/asm-parisc/pdc.h include/asm-parisc/pdc.h
--- include-bak/asm-parisc/pdc.h	Thu Nov 15 16:10:22 2001
+++ include/asm-parisc/pdc.h	Thu Nov 15 16:30:34 2001
@@ -58,9 +58,9 @@
 #define PDC_IODC_DINIT	  3       /* destructive init */
 #define PDC_IODC_MEMERR	 4       /* check for memory errors */
 #define PDC_IODC_INDEX_DATA     0       /* get first 16 bytes from mod IODC */
-#define PDC_IODC_BUS_ERROR      -4      /* bus error return value */
-#define PDC_IODC_INVALID_INDEX  -5      /* invalid index return value */
-#define PDC_IODC_COUNT	  -6      /* count is too small */
+#define PDC_IODC_BUS_ERROR	(-4)	/* bus error return value */
+#define PDC_IODC_INVALID_INDEX	(-5)	/* invalid index return value */
+#define PDC_IODC_COUNT		(-6)	/* count is too small */
 
 #define	PDC_TOD		9		/* time-of-day clock (TOD) */
 #define	PDC_TOD_READ		0	/* read TOD  */
@@ -112,23 +112,23 @@
 #define PDC_REQ_ERR_1       2  /* See above */
 #define PDC_REQ_ERR_0       1  /* Call would generate a requestor error */
 #define PDC_OK	      0  /* Call completed successfully */
-#define PDC_BAD_PROC	   -1  /* Called non-existant procedure */
-#define PDC_BAD_OPTION     -2  /* Called with non-existant option */
-#define PDC_ERROR	  -3  /* Call could not complete without an error */
-#define PDC_INVALID_ARG   -10  /* Called with an invalid argument */
-#define PDC_BUS_POW_WARN  -12  /* Call could not complete in allowed power budget */
+#define PDC_BAD_PROC	   (-1)  /* Called non-existant procedure */
+#define PDC_BAD_OPTION     (-2)  /* Called with non-existant option */
+#define PDC_ERROR	  (-3)  /* Call could not complete without an error */
+#define PDC_INVALID_ARG   (-10)  /* Called with an invalid argument */
+#define PDC_BUS_POW_WARN  (-12)  /* Exceeded power budget */
 
 
 /* The following are from the HPUX .h files, and are just for
 compatibility */
 
 #define PDC_RET_OK       0L	/* Call completed successfully */
-#define PDC_RET_NE_PROC -1L	/* Non-existent procedure */
-#define PDC_RET_NE_OPT  -2L	/* non-existant option - arg1 */
-#define PDC_RET_NE_MOD  -5L	/* Module not found */
-#define PDC_RET_NE_CELL_MOD -7L	/* Cell module not found */
-#define PDC_RET_INV_ARG	-10L	/* Invalid argument */
-#define PDC_RET_NOT_NARROW -17L /* Narrow mode not supported */
+#define PDC_RET_NE_PROC (-1L)	/* Non-existent procedure */
+#define PDC_RET_NE_OPT  (-2L)	/* non-existant option - arg1 */
+#define PDC_RET_NE_MOD  (-5L)	/* Module not found */
+#define PDC_RET_NE_CELL_MOD (-7L)	/* Cell module not found */
+#define PDC_RET_INV_ARG	(-10L)	/* Invalid argument */
+#define PDC_RET_NOT_NARROW (-17L) /* Narrow mode not supported */
 
 
 /* Error codes for PDC_ADD_VALID */
@@ -137,10 +137,10 @@
 #define PDC_ADD_VALID_REQ_ERR_1       2  /* See above */
 #define PDC_ADD_VALID_REQ_ERR_0       1  /* Call would generate a requestor error */
 #define PDC_ADD_VALID_OK	      0  /* Call completed successfully */
-#define PDC_ADD_VALID_BAD_OPTION     -2  /* Called with non-existant option */
-#define PDC_ADD_VALID_ERROR	  -3  /* Call could not complete without an error */
-#define PDC_ADD_VALID_INVALID_ARG   -10  /* Called with an invalid argument */
-#define PDC_ADD_VALID_BUS_POW_WARN  -12  /* Call could not complete in allowed power budget */
+#define PDC_ADD_VALID_BAD_OPTION     (-2)  /* Called with non-existant option */
+#define PDC_ADD_VALID_ERROR  (-3) /* Call could not complete without an error */
+#define PDC_ADD_VALID_INVALID_ARG   (-10)  /* Called with an invalid argument */
+#define PDC_ADD_VALID_BUS_POW_WARN  (-12)  /* Exceeded power budget */
 
 /* The PDC_MEM_MAP calls */
 
diff -u -r include-bak/asm-parisc/siginfo.h include/asm-parisc/siginfo.h
--- include-bak/asm-parisc/siginfo.h	Thu Nov 15 16:10:22 2001
+++ include/asm-parisc/siginfo.h	Thu Nov 15 16:30:56 2001
@@ -102,11 +102,11 @@
  */
 #define SI_USER		0		/* sent by kill, sigsend, raise */
 #define SI_KERNEL	0x80		/* sent by the kernel from somewhere */
-#define SI_QUEUE	-1		/* sent by sigqueue */
+#define SI_QUEUE	(-1)		/* sent by sigqueue */
 #define SI_TIMER __SI_CODE(__SI_TIMER,-2) /* sent by timer expiration */
-#define SI_MESGQ	-3		/* sent by real time mesq state change */
-#define SI_ASYNCIO	-4		/* sent by AIO completion */
-#define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_MESGQ	(-3)		/* sent by real time mesq state change */
+#define SI_ASYNCIO	(-4)		/* sent by AIO completion */
+#define SI_SIGIO	(-5)		/* sent by queued SIGIO */
 
 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
diff -u -r include-bak/asm-ppc/dma.h include/asm-ppc/dma.h
--- include-bak/asm-ppc/dma.h	Thu Nov 15 16:10:03 2001
+++ include/asm-ppc/dma.h	Thu Nov 15 16:31:36 2001
@@ -109,15 +109,15 @@
 #define SND_DMA1 ppc_cs4232_dma
 #define SND_DMA2 ppc_cs4232_dma2
 #else /* !CONFIG_ALL_PPC */
-#define SND_DMA1 -1
-#define SND_DMA2 -1
+#define SND_DMA1 (-1)
+#define SND_DMA2 (-1)
 #endif /* CONFIG_ALL_PPC */
 #elif defined(CONFIG_MSS)
 #define SND_DMA1 CONFIG_MSS_DMA
 #define SND_DMA2 CONFIG_MSS_DMA2
 #else
-#define SND_DMA1 -1
-#define SND_DMA2 -1
+#define SND_DMA1 (-1)
+#define SND_DMA2 (-1)
 #endif
 
 /* 8237 DMA controllers */
diff -u -r include-bak/asm-ppc/io.h include/asm-ppc/io.h
--- include-bak/asm-ppc/io.h	Thu Nov 15 16:10:03 2001
+++ include/asm-ppc/io.h	Thu Nov 15 16:31:48 2001
@@ -175,7 +175,7 @@
 #define outsl_ns(port, buf, nl)	_outsl_ns((u32 *)((port)+_IO_BASE), (buf), (nl))
 
 
-#define IO_SPACE_LIMIT ~0
+#define IO_SPACE_LIMIT (~0)
 
 #define memset_io(a,b,c)       memset((void *)(a),(b),(c))
 #define memcpy_fromio(a,b,c)   memcpy((a),(void *)(b),(c))
diff -u -r include-bak/asm-ppc/siginfo.h include/asm-ppc/siginfo.h
--- include-bak/asm-ppc/siginfo.h	Thu Nov 15 16:10:04 2001
+++ include/asm-ppc/siginfo.h	Thu Nov 15 16:32:20 2001
@@ -103,11 +103,11 @@
  */
 #define SI_USER		0		/* sent by kill, sigsend, raise */
 #define SI_KERNEL	0x80		/* sent by the kernel from somewhere */
-#define SI_QUEUE	-1		/* sent by sigqueue */
+#define SI_QUEUE	(-1)		/* sent by sigqueue */
 #define SI_TIMER __SI_CODE(__SI_TIMER,-2) /* sent by timer expiration */
-#define SI_MESGQ	-3		/* sent by real time mesq state change */
-#define SI_ASYNCIO	-4		/* sent by AIO completion */
-#define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_MESGQ	(-3)		/* sent by real time mesq state change */
+#define SI_ASYNCIO	(-4)		/* sent by AIO completion */
+#define SI_SIGIO	(-5)		/* sent by queued SIGIO */
 
 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
diff -u -r include-bak/asm-s390/debug.h include/asm-s390/debug.h
--- include-bak/asm-s390/debug.h	Thu Nov 15 16:10:22 2001
+++ include/asm-s390/debug.h	Thu Nov 15 16:33:59 2001
@@ -43,15 +43,15 @@
 #include <linux/proc_fs.h>
 
 #define DEBUG_MAX_LEVEL            6  /* debug levels range from 0 to 6 */
-#define DEBUG_OFF_LEVEL            -1 /* level where debug is switched off */
-#define DEBUG_FLUSH_ALL            -1 /* parameter to flush all areas */
+#define DEBUG_OFF_LEVEL            (-1) /* level where debug is switched off */
+#define DEBUG_FLUSH_ALL            (-1) /* parameter to flush all areas */
 #define DEBUG_MAX_VIEWS            10 /* max number of views in proc fs */
 #define DEBUG_MAX_PROCF_LEN        16 /* max length for a proc file name */
 #define DEBUG_DEFAULT_LEVEL        3  /* initial debug level */
 
 #define DEBUG_DIR_ROOT "s390dbf" /* name of debug root directory in proc fs */
 
-#define DEBUG_DATA(entry) (char*)(entry + 1) /* data is stored behind */
+#define DEBUG_DATA(entry) ((char*)(entry + 1)) /* data is stored behind */
                                              /* the entry information */
 
 #define STCK(x)	asm volatile ("STCK %0" : "=m" (x) : : "cc" )
diff -u -r include-bak/asm-s390/siginfo.h include/asm-s390/siginfo.h
--- include-bak/asm-s390/siginfo.h	Thu Nov 15 16:10:21 2001
+++ include/asm-s390/siginfo.h	Thu Nov 15 16:34:46 2001
@@ -110,11 +110,11 @@
  */
 #define SI_USER		0	/* sent by kill, sigsend, raise */
 #define SI_KERNEL	0x80	/* sent by the kernel from somewhere */
-#define SI_QUEUE	-1	/* sent by sigqueue */
-#define SI_TIMER	-2	/* sent by timer expiration */
-#define SI_MESGQ	-3	/* sent by real time mesq state change */
-#define SI_ASYNCIO	-4	/* sent by AIO completion */
-#define SI_SIGIO	-5	/* sent by queued SIGIO */
+#define SI_QUEUE	(-1)	/* sent by sigqueue */
+#define SI_TIMER	(-2)	/* sent by timer expiration */
+#define SI_MESGQ	(-3)	/* sent by real time mesq state change */
+#define SI_ASYNCIO	(-4)	/* sent by AIO completion */
+#define SI_SIGIO	(-5)	/* sent by queued SIGIO */
 
 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
diff -u -r include-bak/asm-sh/siginfo.h include/asm-sh/siginfo.h
--- include-bak/asm-sh/siginfo.h	Thu Nov 15 16:10:14 2001
+++ include/asm-sh/siginfo.h	Thu Nov 15 16:35:33 2001
@@ -102,11 +102,11 @@
  */
 #define SI_USER		0		/* sent by kill, sigsend, raise */
 #define SI_KERNEL	0x80		/* sent by the kernel from somewhere */
-#define SI_QUEUE	-1		/* sent by sigqueue */
+#define SI_QUEUE	(-1)		/* sent by sigqueue */
 #define SI_TIMER __SI_CODE(__SI_TIMER,-2) /* sent by timer expiration */
-#define SI_MESGQ	-3		/* sent by real time mesq state change */
-#define SI_ASYNCIO	-4		/* sent by AIO completion */
-#define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_MESGQ	(-3)		/* sent by real time mesq state change */
+#define SI_ASYNCIO	(-4)		/* sent by AIO completion */
+#define SI_SIGIO	(-5)		/* sent by queued SIGIO */
 
 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
diff -u -r include-bak/asm-sparc/fbio.h include/asm-sparc/fbio.h
--- include-bak/asm-sparc/fbio.h	Thu Nov 15 16:10:00 2001
+++ include/asm-sparc/fbio.h	Thu Nov 15 16:35:56 2001
@@ -5,7 +5,7 @@
 /* (C) 1996 Miguel de Icaza */
 
 /* Frame buffer types */
-#define FBTYPE_NOTYPE           -1
+#define FBTYPE_NOTYPE           (-1)
 #define FBTYPE_SUN1BW           0   /* mono */
 #define FBTYPE_SUN1COLOR        1 
 #define FBTYPE_SUN2BW           2 
diff -u -r include-bak/asm-sparc/pgtable.h include/asm-sparc/pgtable.h
--- include-bak/asm-sparc/pgtable.h	Thu Nov 15 16:10:00 2001
+++ include/asm-sparc/pgtable.h	Thu Nov 15 16:36:20 2001
@@ -391,7 +391,7 @@
 extern struct ctx_list ctx_free;        /* Head of free list */
 extern struct ctx_list ctx_used;        /* Head of used contexts list */
 
-#define NO_CONTEXT     -1
+#define NO_CONTEXT     (-1)
 
 extern __inline__ void remove_from_ctx_list(struct ctx_list *entry)
 {
diff -u -r include-bak/asm-sparc/siginfo.h include/asm-sparc/siginfo.h
--- include-bak/asm-sparc/siginfo.h	Thu Nov 15 16:10:01 2001
+++ include/asm-sparc/siginfo.h	Thu Nov 15 16:36:41 2001
@@ -107,11 +107,11 @@
 #define SI_NOINFO	32767		/* no information in siginfo_t */
 #define SI_USER		0		/* sent by kill, sigsend, raise */
 #define SI_KERNEL	0x80		/* sent by the kernel from somewhere */
-#define SI_QUEUE	-1		/* sent by sigqueue */
+#define SI_QUEUE	(-1)		/* sent by sigqueue */
 #define SI_TIMER __SI_CODE(__SI_TIMER,-2) /* sent by timer expiration */
-#define SI_MESGQ	-3		/* sent by real time mesq state change */
-#define SI_ASYNCIO	-4		/* sent by AIO completion */
-#define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_MESGQ	(-3)		/* sent by real time mesq state change */
+#define SI_ASYNCIO	(-4)		/* sent by AIO completion */
+#define SI_SIGIO	(-5)		/* sent by queued SIGIO */
 
 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
diff -u -r include-bak/asm-sparc64/fbio.h include/asm-sparc64/fbio.h
--- include-bak/asm-sparc64/fbio.h	Thu Nov 15 16:10:05 2001
+++ include/asm-sparc64/fbio.h	Thu Nov 15 16:37:34 2001
@@ -5,7 +5,7 @@
 /* (C) 1996 Miguel de Icaza */
 
 /* Frame buffer types */
-#define FBTYPE_NOTYPE           -1
+#define FBTYPE_NOTYPE           (-1)
 #define FBTYPE_SUN1BW           0   /* mono */
 #define FBTYPE_SUN1COLOR        1 
 #define FBTYPE_SUN2BW           2 
diff -u -r include-bak/asm-sparc64/siginfo.h include/asm-sparc64/siginfo.h
--- include-bak/asm-sparc64/siginfo.h	Thu Nov 15 16:10:06 2001
+++ include/asm-sparc64/siginfo.h	Thu Nov 15 16:37:18 2001
@@ -167,11 +167,11 @@
 #define SI_NOINFO	32767		/* no information in siginfo_t */
 #define SI_USER		0		/* sent by kill, sigsend, raise */
 #define SI_KERNEL	0x80		/* sent by the kernel from somewhere */
-#define SI_QUEUE	-1		/* sent by sigqueue */
+#define SI_QUEUE	(-1)		/* sent by sigqueue */
 #define SI_TIMER __SI_CODE(__SI_TIMER,-2) /* sent by timer expiration */
-#define SI_MESGQ	-3		/* sent by real time mesq state change */
-#define SI_ASYNCIO	-4		/* sent by AIO completion */
-#define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_MESGQ	(-3)		/* sent by real time mesq state change */
+#define SI_ASYNCIO	(-4)		/* sent by AIO completion */
+#define SI_SIGIO	(-5)		/* sent by queued SIGIO */
 
 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
diff -u -r include-bak/linux/amigaffs.h include/linux/amigaffs.h
--- include-bak/linux/amigaffs.h	Thu Nov 15 16:09:47 2001
+++ include/linux/amigaffs.h	Thu Nov 15 16:39:07 2001
@@ -147,8 +147,8 @@
 #define T_LIST		16
 #define T_DATA		8
 
-#define ST_LINKFILE	-4
-#define ST_FILE		-3
+#define ST_LINKFILE	(-4)
+#define ST_FILE		(-3)
 #define ST_ROOT		1
 #define ST_USERDIR	2
 #define ST_SOFTLINK	3
diff -u -r include-bak/linux/atm.h include/linux/atm.h
--- include-bak/linux/atm.h	Thu Nov 15 16:09:47 2001
+++ include/linux/atm.h	Thu Nov 15 16:39:40 2001
@@ -129,7 +129,7 @@
 #define ATM_ABR		4
 #define ATM_ANYCLASS	5		/* compatible with everything */
 
-#define ATM_MAX_PCR	-1		/* maximum available PCR */
+#define ATM_MAX_PCR	(-1)		/* maximum available PCR */
 
 struct atm_trafprm {
 	unsigned char	traffic_class;	/* traffic class (ATM_UBR, ...) */
@@ -164,11 +164,11 @@
 
 /* PVC addressing */
 
-#define ATM_ITF_ANY	-1		/* "magic" PVC address values */
-#define ATM_VPI_ANY	-1
-#define ATM_VCI_ANY	-1
-#define ATM_VPI_UNSPEC	-2
-#define ATM_VCI_UNSPEC	-2
+#define ATM_ITF_ANY	(-1)		/* "magic" PVC address values */
+#define ATM_VPI_ANY	(-1)
+#define ATM_VCI_ANY	(-1)
+#define ATM_VPI_UNSPEC	(-2)
+#define ATM_VCI_UNSPEC	(-2)
 
 
 struct sockaddr_atmpvc {
diff -u -r include-bak/linux/atmdev.h include/linux/atmdev.h
--- include-bak/linux/atmdev.h	Thu Nov 15 16:09:50 2001
+++ include/linux/atmdev.h	Thu Nov 15 16:39:52 2001
@@ -152,7 +152,7 @@
 
 /* for ATM_GETCIRANGE / ATM_SETCIRANGE */
 
-#define ATM_CI_MAX      -1              /* use maximum range of VPI/VCI */
+#define ATM_CI_MAX      (-1)              /* use maximum range of VPI/VCI */
  
 struct atm_cirange {
 	char	vpi_bits;		/* 1..8, ATM_CI_MAX (-1) for maximum */
diff -u -r include-bak/linux/cdk.h include/linux/cdk.h
--- include-bak/linux/cdk.h	Thu Nov 15 16:09:46 2001
+++ include/linux/cdk.h	Thu Nov 15 16:40:15 2001
@@ -200,8 +200,8 @@
 #define	FLUSHRX		0x1
 #define	FLUSHTX		0x2
 
-#define	BREAKON		-1
-#define	BREAKOFF	-2
+#define	BREAKON		(-1)
+#define	BREAKOFF	(-2)
 
 /*
  *	Define the port setting structure, and all those defines that go along
diff -u -r include-bak/linux/coda.h include/linux/coda.h
--- include-bak/linux/coda.h	Thu Nov 15 16:09:47 2001
+++ include/linux/coda.h	Thu Nov 15 16:40:59 2001
@@ -779,10 +779,10 @@
 
 #define	CODA_CONTROL		".CONTROL"
 #define CODA_CONTROLLEN           8
-#define	CTL_VOL			-1
-#define	CTL_VNO			-1
-#define	CTL_UNI			-1
-#define CTL_INO                 -1
+#define	CTL_VOL			(-1)
+#define	CTL_VNO			(-1)
+#define	CTL_UNI			(-1)
+#define CTL_INO                 (-1)
 #define	CTL_FILE		"/coda/.CONTROL"
 
 
diff -u -r include-bak/linux/compatmac.h include/linux/compatmac.h
--- include-bak/linux/compatmac.h	Thu Nov 15 16:09:51 2001
+++ include/linux/compatmac.h	Thu Nov 15 16:41:28 2001
@@ -114,8 +114,8 @@
 #define test_and_clear_bit(nr, addr) clear_bit(nr, addr)
 
 /* Not yet implemented on 2.0 */
-#define ASYNC_SPD_SHI  -1
-#define ASYNC_SPD_WARP -1
+#define ASYNC_SPD_SHI  (-1)
+#define ASYNC_SPD_WARP (-1)
 
 
 /* Ugly hack: the driver_name doesn't exist in 2.0.x . So we define it
diff -u -r include-bak/linux/ext2_fs.h include/linux/ext2_fs.h
--- include-bak/linux/ext2_fs.h	Thu Nov 15 16:09:46 2001
+++ include/linux/ext2_fs.h	Thu Nov 15 16:41:53 2001
@@ -471,8 +471,8 @@
 #define EXT2_FEATURE_RO_COMPAT_SUPP	(EXT2_FEATURE_RO_COMPAT_SPARSE_SUPER| \
 					 EXT2_FEATURE_RO_COMPAT_LARGE_FILE| \
 					 EXT2_FEATURE_RO_COMPAT_BTREE_DIR)
-#define EXT2_FEATURE_RO_COMPAT_UNSUPPORTED	~EXT2_FEATURE_RO_COMPAT_SUPP
-#define EXT2_FEATURE_INCOMPAT_UNSUPPORTED	~EXT2_FEATURE_INCOMPAT_SUPP
+#define EXT2_FEATURE_RO_COMPAT_UNSUPPORTED	(~EXT2_FEATURE_RO_COMPAT_SUPP)
+#define EXT2_FEATURE_INCOMPAT_UNSUPPORTED	(~EXT2_FEATURE_INCOMPAT_SUPP)
 
 /*
  * Default values for user and/or group using reserved blocks
diff -u -r include-bak/linux/ftape.h include/linux/ftape.h
--- include-bak/linux/ftape.h	Thu Nov 15 16:09:45 2001
+++ include/linux/ftape.h	Thu Nov 15 16:42:57 2001
@@ -84,7 +84,7 @@
 #define FT_RQM_DELAY    12
 #define FT_MILLISECOND  1
 #define FT_SECOND       1000
-#define FT_FOREVER      -1
+#define FT_FOREVER      (-1)
 #ifndef HZ
 #error "HZ undefined."
 #endif
diff -u -r include-bak/linux/i2o.h include/linux/i2o.h
--- include-bak/linux/i2o.h	Thu Nov 15 16:09:47 2001
+++ include/linux/i2o.h	Thu Nov 15 16:43:28 2001
@@ -588,7 +588,7 @@
 #define MSG_POOL_SIZE		16384
 
 #define I2O_POST_WAIT_OK	0
-#define I2O_POST_WAIT_TIMEOUT	-ETIMEDOUT
+#define I2O_POST_WAIT_TIMEOUT	(-ETIMEDOUT)
 
 #endif /* __KERNEL__ */
 #endif /* _I2O_H */
diff -u -r include-bak/linux/ipsec.h include/linux/ipsec.h
--- include-bak/linux/ipsec.h	Thu Nov 15 16:09:48 2001
+++ include/linux/ipsec.h	Thu Nov 15 16:43:52 2001
@@ -23,7 +23,7 @@
 /* These defines are compatible with NRL IPv6, however their semantics
    is different */
 
-#define IPSEC_LEVEL_NONE	-1	/* send plaintext, accept any */
+#define IPSEC_LEVEL_NONE	(-1)	/* send plaintext, accept any */
 #define IPSEC_LEVEL_DEFAULT	0	/* encrypt/authenticate if possible */
 					/* the default MUST be 0, because a */
 					/* socket is initialized with 0's */
diff -u -r include-bak/linux/lp.h include/linux/lp.h
--- include-bak/linux/lp.h	Thu Nov 15 16:09:45 2001
+++ include/linux/lp.h	Thu Nov 15 16:44:32 2001
@@ -99,10 +99,10 @@
 #ifdef __KERNEL__
 
 /* Magic numbers for defining port-device mappings */
-#define LP_PARPORT_UNSPEC -4
-#define LP_PARPORT_AUTO -3
-#define LP_PARPORT_OFF -2
-#define LP_PARPORT_NONE -1
+#define LP_PARPORT_UNSPEC (-4)
+#define LP_PARPORT_AUTO (-3)
+#define LP_PARPORT_OFF (-2)
+#define LP_PARPORT_NONE (-1)
 
 #define LP_F(minor)	lp_table[(minor)].flags		/* flags for busy, etc. */
 #define LP_CHAR(minor)	lp_table[(minor)].chars		/* busy timeout */
diff -u -r include-bak/linux/lvm.h include/linux/lvm.h
--- include-bak/linux/lvm.h	Thu Nov 15 16:09:51 2001
+++ include/linux/lvm.h	Thu Nov 15 16:44:59 2001
@@ -228,7 +228,7 @@
 #define	LVM_SNAPSHOT_DEF_CHUNK	64	/* 64  KB */
 #define	LVM_SNAPSHOT_MIN_CHUNK	(PAGE_SIZE/1024)	/* 4 or 8 KB */
 
-#define	UNDEF	-1
+#define	UNDEF	(-1)
 
 /*
  * ioctls
diff -u -r include-bak/linux/n_r3964.h include/linux/n_r3964.h
--- include-bak/linux/n_r3964.h	Thu Nov 15 16:09:50 2001
+++ include/linux/n_r3964.h	Thu Nov 15 16:45:30 2001
@@ -124,8 +124,8 @@
 
 /* error codes for client messages */
 #define R3964_OK 0        /* no error. */
-#define R3964_TX_FAIL -1  /* transmission error, block NOT sent */
-#define R3964_OVERFLOW -2 /* msg queue overflow */
+#define R3964_TX_FAIL (-1)  /* transmission error, block NOT sent */
+#define R3964_OVERFLOW (-2) /* msg queue overflow */
 
 /* the client gets this struct when calling read(fd,...): */
 struct r3964_client_message {
diff -u -r include-bak/linux/parport.h include/linux/parport.h
--- include-bak/linux/parport.h	Thu Nov 15 16:09:48 2001
+++ include/linux/parport.h	Thu Nov 15 16:45:58 2001
@@ -15,14 +15,14 @@
 #define PARPORT_MAX  16
 
 /* Magic numbers */
-#define PARPORT_IRQ_NONE  -1
-#define PARPORT_DMA_NONE  -1
-#define PARPORT_IRQ_AUTO  -2
-#define PARPORT_DMA_AUTO  -2
-#define PARPORT_DMA_NOFIFO -3
-#define PARPORT_DISABLE   -2
-#define PARPORT_IRQ_PROBEONLY -3
-#define PARPORT_IOHI_AUTO -1
+#define PARPORT_IRQ_NONE  (-1)
+#define PARPORT_DMA_NONE  (-1)
+#define PARPORT_IRQ_AUTO  (-2)
+#define PARPORT_DMA_AUTO  (-2)
+#define PARPORT_DMA_NOFIFO (-3)
+#define PARPORT_DISABLE   (-2)
+#define PARPORT_IRQ_PROBEONLY (-3)
+#define PARPORT_IOHI_AUTO (-1)
 
 #define PARPORT_CONTROL_STROBE    0x1
 #define PARPORT_CONTROL_AUTOFD    0x2
diff -u -r include-bak/linux/pci.h include/linux/pci.h
--- include-bak/linux/pci.h	Thu Nov 15 16:09:45 2001
+++ include/linux/pci.h	Thu Nov 15 16:46:25 2001
@@ -119,18 +119,18 @@
 #define  PCI_IO_RANGE_TYPE_MASK	0x0f	/* I/O bridging type */
 #define  PCI_IO_RANGE_TYPE_16	0x00
 #define  PCI_IO_RANGE_TYPE_32	0x01
-#define  PCI_IO_RANGE_MASK	~0x0f
+#define  PCI_IO_RANGE_MASK	(~0x0f)
 #define PCI_SEC_STATUS		0x1e	/* Secondary status register, only bit 14 used */
 #define PCI_MEMORY_BASE		0x20	/* Memory range behind */
 #define PCI_MEMORY_LIMIT	0x22
 #define  PCI_MEMORY_RANGE_TYPE_MASK 0x0f
-#define  PCI_MEMORY_RANGE_MASK	~0x0f
+#define  PCI_MEMORY_RANGE_MASK	(~0x0f)
 #define PCI_PREF_MEMORY_BASE	0x24	/* Prefetchable memory range behind */
 #define PCI_PREF_MEMORY_LIMIT	0x26
 #define  PCI_PREF_RANGE_TYPE_MASK 0x0f
 #define  PCI_PREF_RANGE_TYPE_32	0x00
 #define  PCI_PREF_RANGE_TYPE_64	0x01
-#define  PCI_PREF_RANGE_MASK	~0x0f
+#define  PCI_PREF_RANGE_MASK	(~0x0f)
 #define PCI_PREF_BASE_UPPER32	0x28	/* Upper half of prefetchable memory range */
 #define PCI_PREF_LIMIT_UPPER32	0x2c
 #define PCI_IO_BASE_UPPER16	0x30	/* Upper half of I/O addresses */
@@ -168,7 +168,7 @@
 #define PCI_CB_IO_BASE_1_HI	0x36
 #define PCI_CB_IO_LIMIT_1	0x38
 #define PCI_CB_IO_LIMIT_1_HI	0x3a
-#define  PCI_CB_IO_RANGE_MASK	~0x03
+#define  PCI_CB_IO_RANGE_MASK	(~0x03)
 /* 0x3c-0x3d are same as for htype 0 */
 #define PCI_CB_BRIDGE_CONTROL	0x3e
 #define  PCI_CB_BRIDGE_CTL_PARITY	0x01	/* Similar to standard bridge control register */
diff -u -r include-bak/linux/phonedev.h include/linux/phonedev.h
--- include-bak/linux/phonedev.h	Thu Nov 15 16:09:51 2001
+++ include/linux/phonedev.h	Thu Nov 15 16:46:54 2001
@@ -19,7 +19,7 @@
 extern int phonedev_init(void);
 #define PHONE_MAJOR	100
 extern int phone_register_device(struct phone_device *, int unit);
-#define PHONE_UNIT_ANY	-1
+#define PHONE_UNIT_ANY	(-1)
 extern void phone_unregister_device(struct phone_device *);
 
 #endif
diff -u -r include-bak/linux/pmu.h include/linux/pmu.h
--- include-bak/linux/pmu.h	Thu Nov 15 16:09:51 2001
+++ include/linux/pmu.h	Thu Nov 15 16:47:18 2001
@@ -164,7 +164,7 @@
 
 /* Result codes returned by the notifiers */
 #define PBOOK_SLEEP_OK		0
-#define PBOOK_SLEEP_REFUSE	-1
+#define PBOOK_SLEEP_REFUSE	(-1)
 
 /* priority levels in notifiers */
 #define SLEEP_LEVEL_VIDEO	100	/* Video driver (first wake) */
diff -u -r include-bak/linux/ppp-comp.h include/linux/ppp-comp.h
--- include-bak/linux/ppp-comp.h	Thu Nov 15 16:09:47 2001
+++ include/linux/ppp-comp.h	Thu Nov 15 16:47:41 2001
@@ -120,8 +120,8 @@
  * Don't you just lurve software patents.
  */
 
-#define DECOMP_ERROR		-1	/* error detected before decomp. */
-#define DECOMP_FATALERROR	-2	/* error detected after decomp. */
+#define DECOMP_ERROR		(-1)	/* error detected before decomp. */
+#define DECOMP_FATALERROR	(-2)	/* error detected after decomp. */
 
 /*
  * CCP codes.
diff -u -r include-bak/linux/ps2esdi.h include/linux/ps2esdi.h
--- include-bak/linux/ps2esdi.h	Thu Nov 15 16:09:48 2001
+++ include/linux/ps2esdi.h	Thu Nov 15 16:49:00 2001
@@ -86,7 +86,7 @@
 #define HDIO_GETGEO 0x0301
 
 #define FALSE 0
-#define TRUE !FALSE
+#define TRUE 1  /* these are stupid macros. */
 
 struct ps2esdi_geometry {
 	unsigned char heads;
diff -u -r include-bak/linux/reiserfs_fs.h include/linux/reiserfs_fs.h
--- include-bak/linux/reiserfs_fs.h	Thu Nov 15 16:09:52 2001
+++ include/linux/reiserfs_fs.h	Thu Nov 15 16:50:34 2001
@@ -166,9 +166,9 @@
 
 // reiserfs internal error code (used by search_by_key adn fix_nodes))
 #define CARRY_ON      0
-#define REPEAT_SEARCH -1
-#define IO_ERROR      -2
-#define NO_DISK_SPACE -3
+#define REPEAT_SEARCH (-1)
+#define IO_ERROR      (-2)
+#define NO_DISK_SPACE (-3)
 #define NO_BALANCING_NEEDED  (-4)
 #define NO_MORE_UNUSED_CONTIGUOUS_BLOCKS (-5)
 
@@ -357,7 +357,7 @@
 
 /* The result of the key compare */
 #define FIRST_GREATER 1
-#define SECOND_GREATER -1
+#define SECOND_GREATER (-1)
 #define KEYS_IDENTICAL 0
 #define KEY_FOUND 1
 #define KEY_NOT_FOUND 0
@@ -371,12 +371,12 @@
 #define ITEM_NOT_FOUND 0
 #define ENTRY_FOUND 1
 #define ENTRY_NOT_FOUND 0
-#define DIRECTORY_NOT_FOUND -1
-#define REGULAR_FILE_FOUND -2
-#define DIRECTORY_FOUND -3
+#define DIRECTORY_NOT_FOUND (-1)
+#define REGULAR_FILE_FOUND (-2)
+#define DIRECTORY_FOUND (-3)
 #define BYTE_FOUND 1
 #define BYTE_NOT_FOUND 0
-#define FILE_NOT_FOUND -1
+#define FILE_NOT_FOUND (-1)
 
 #define POSITION_FOUND 1
 #define POSITION_NOT_FOUND 0
diff -u -r include-bak/linux/sdla.h include/linux/sdla.h
--- include-bak/linux/sdla.h	Thu Nov 15 16:09:47 2001
+++ include/linux/sdla.h	Thu Nov 15 16:50:49 2001
@@ -31,7 +31,7 @@
 #define SDLA_S507			5070
 #define SDLA_S508			5080
 #define SDLA_S509			5090
-#define SDLA_UNKNOWN			-1
+#define SDLA_UNKNOWN			(-1)
 
 /* port selection flags for the S508 */
 #define SDLA_S508_PORT_V35		0x00
diff -u -r include-bak/linux/sysctl.h include/linux/sysctl.h
--- include-bak/linux/sysctl.h	Thu Nov 15 16:09:46 2001
+++ include/linux/sysctl.h	Thu Nov 15 16:51:08 2001
@@ -48,7 +48,7 @@
 
 /* For internal pattern-matching use only: */
 #ifdef __KERNEL__
-#define CTL_ANY		-1	/* Matches any name */
+#define CTL_ANY		(-1)	/* Matches any name */
 #define CTL_NONE	0
 #endif
 
diff -u -r include-bak/linux/ufs_fs.h include/linux/ufs_fs.h
--- include-bak/linux/ufs_fs.h	Thu Nov 15 16:09:45 2001
+++ include/linux/ufs_fs.h	Thu Nov 15 16:52:45 2001
@@ -129,7 +129,7 @@
 #define UFS_CG_SUN		0x00001000
 
 /* fs_inodefmt options */
-#define UFS_42INODEFMT	-1
+#define UFS_42INODEFMT	(-1)
 #define UFS_44INODEFMT	2
 
 /* mount options */
@@ -149,8 +149,8 @@
 #define UFS_MOUNT_UFSTYPE_SUNx86	0x00000400
 #define UFS_MOUNT_UFSTYPE_HP	        0x00000800
 
-#define ufs_clear_opt(o,opt)	o &= ~UFS_MOUNT_##opt
-#define ufs_set_opt(o,opt)	o |= UFS_MOUNT_##opt
+#define ufs_clear_opt(o,opt)	((o) &= ~UFS_MOUNT_##opt)
+#define ufs_set_opt(o,opt)	((o) |= UFS_MOUNT_##opt)
 #define ufs_test_opt(o,opt)	((o) & UFS_MOUNT_##opt)
 
 /*
@@ -401,7 +401,7 @@
 /*
  * Rotational layout table format types
  */
-#define UFS_42POSTBLFMT		-1	/* 4.2BSD rotational table format */
+#define UFS_42POSTBLFMT		(-1)	/* 4.2BSD rotational table format */
 #define UFS_DYNAMICPOSTBLFMT	1	/* dynamic rotational table format */
 
 /*
diff -u -r include-bak/linux/videodev.h include/linux/videodev.h
--- include-bak/linux/videodev.h	Thu Nov 15 16:09:49 2001
+++ include/linux/videodev.h	Thu Nov 15 16:53:14 2001
@@ -176,7 +176,7 @@
 	int	clipcount;
 #define VIDEO_WINDOW_INTERLACE	1
 #define VIDEO_WINDOW_CHROMAKEY	16	/* Overlay by chromakey */
-#define VIDEO_CLIP_BITMAP	-1
+#define VIDEO_CLIP_BITMAP	(-1)
 /* bitmap is 1024x625, a '1' bit represents a clipped pixel */
 #define VIDEO_CLIPMAP_SIZE	(128 * 625)
 };
diff -u -r include-bak/linux/watchdog.h include/linux/watchdog.h
--- include-bak/linux/watchdog.h	Thu Nov 15 16:09:48 2001
+++ include/linux/watchdog.h	Thu Nov 15 16:53:33 2001
@@ -27,8 +27,8 @@
 #define	WDIOC_KEEPALIVE		_IOR(WATCHDOG_IOCTL_BASE, 5, int)
 #define	WDIOC_SETTIMEOUT        _IOW(WATCHDOG_IOCTL_BASE, 6, int)
 
-#define	WDIOF_UNKNOWN		-1	/* Unknown flag error */
-#define	WDIOS_UNKNOWN		-1	/* Unknown status error */
+#define	WDIOF_UNKNOWN		(-1)	/* Unknown flag error */
+#define	WDIOS_UNKNOWN		(-1)	/* Unknown status error */
 
 #define	WDIOF_OVERHEAT		0x0001	/* Reset due to CPU overheat */
 #define	WDIOF_FANFAULT		0x0002	/* Fan failed */
diff -u -r include-bak/net/irda/irlap.h include/net/irda/irlap.h
--- include-bak/net/irda/irlap.h	Thu Nov 15 16:10:02 2001
+++ include/net/irda/irlap.h	Thu Nov 15 17:01:15 2001
@@ -55,11 +55,11 @@
 
 #define NR_EXPECTED     1
 #define NR_UNEXPECTED   0
-#define NR_INVALID     -1
+#define NR_INVALID     (-1)
 
 #define NS_EXPECTED     1
 #define NS_UNEXPECTED   0
-#define NS_INVALID     -1
+#define NS_INVALID     (-1)
 
 /* Main structure of IrLAP */
 struct irlap_cb {
diff -u -r include-bak/net/irda/nsc-ircc.h include/net/irda/nsc-ircc.h
--- include-bak/net/irda/nsc-ircc.h	Thu Nov 15 16:10:02 2001
+++ include/net/irda/nsc-ircc.h	Thu Nov 15 17:01:33 2001
@@ -101,7 +101,7 @@
 #define BANK7     	0xf4
 
 #define MCR		0x04 /* Mode Control Register */
-#define MCR_MODE_MASK	~(0xd0)
+#define MCR_MODE_MASK	(~0xd0)
 #define MCR_UART        0x00
 #define MCR_RESERVED  	0x20	
 #define MCR_SHARP_IR    0x40
diff -u -r include-bak/net/irda/w83977af_ir.h include/net/irda/w83977af_ir.h
--- include-bak/net/irda/w83977af_ir.h	Thu Nov 15 16:10:02 2001
+++ include/net/irda/w83977af_ir.h	Thu Nov 15 17:02:01 2001
@@ -78,7 +78,7 @@
 #define SET7	        0xF4
 
 #define HCR		0x04
-#define HCR_MODE_MASK	~(0xD0)
+#define HCR_MODE_MASK	(~0xD0)
 #define HCR_SIR         0x60
 #define HCR_MIR_576  	0x20	
 #define HCR_MIR_1152	0x80
diff -u -r include-bak/scsi/sg.h include/scsi/sg.h
--- include-bak/scsi/sg.h	Thu Nov 15 16:10:05 2001
+++ include/scsi/sg.h	Thu Nov 15 16:54:37 2001
@@ -120,14 +120,14 @@
 } sg_io_hdr_t;  /* 64 bytes long (on i386) */
 
 /* Use negative values to flag difference from original sg_header structure */
-#define SG_DXFER_NONE -1        /* e.g. a SCSI Test Unit Ready command */
-#define SG_DXFER_TO_DEV -2      /* e.g. a SCSI WRITE command */
-#define SG_DXFER_FROM_DEV -3    /* e.g. a SCSI READ command */
-#define SG_DXFER_TO_FROM_DEV -4 /* treated like SG_DXFER_FROM_DEV with the
-				   additional property than during indirect
-				   IO the user buffer is copied into the
-				   kernel buffers before the transfer */
-#define SG_DXFER_UNKNOWN -5     /* Unknown data direction */
+#define SG_DXFER_NONE (-1)        /* e.g. a SCSI Test Unit Ready command */
+#define SG_DXFER_TO_DEV (-2)      /* e.g. a SCSI WRITE command */
+#define SG_DXFER_FROM_DEV (-3)    /* e.g. a SCSI READ command */
+#define SG_DXFER_TO_FROM_DEV (-4) /* treated like SG_DXFER_FROM_DEV with the
+			 	     additional property than during indirect
+				     IO the user buffer is copied into the
+				     kernel buffers before the transfer */
+#define SG_DXFER_UNKNOWN (-5)     /* Unknown data direction */
 
 /* following flag values can be "or"-ed together */
 #define SG_FLAG_DIRECT_IO 1     /* default is indirect IO */
diff -u -r include-bak/video/macmodes.h include/video/macmodes.h
--- include-bak/video/macmodes.h	Thu Nov 15 16:10:14 2001
+++ include/video/macmodes.h	Thu Nov 15 16:55:05 2001
@@ -43,8 +43,8 @@
 #define VMODE_MAX		22
 #define VMODE_CHOOSE		99
 
-#define CMODE_NVRAM		-1
-#define CMODE_CHOOSE		-2
+#define CMODE_NVRAM		(-1)
+#define CMODE_CHOOSE		(-2)
 #define CMODE_8			0	/* 8 bits/pixel */
 #define CMODE_16		1	/* 16 (actually 15) bits/pixel */
 #define CMODE_32		2	/* 32 (actually 24) bits/pixel */
