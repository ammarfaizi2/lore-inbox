Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280898AbRKPEw4>; Thu, 15 Nov 2001 23:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280909AbRKPEwp>; Thu, 15 Nov 2001 23:52:45 -0500
Received: from shell7.ba.best.com ([206.184.139.138]:57606 "EHLO
	shell7.ba.best.com") by vger.kernel.org with ESMTP
	id <S280898AbRKPEwX>; Thu, 15 Nov 2001 23:52:23 -0500
Date: Thu, 15 Nov 2001 20:51:34 -0800
From: Nathan Myers <ncm@nospam.cantrip.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, alan@redhat.com
Subject: [PATCH] omnibus NON-include/ cleanup (less big)
Message-ID: <20011115205134.A22464@shell7.ba.best.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall thought my previous posting was useful,
so this is the other half.  This is a followup to 

  http://marc.theaimsgroup.com/?l=linux-kernel&m=100587948705950&w=2

which patched up #defines under linux/include/.  

Attached below is a patch to fix the rest of the headers not under 
linux/include/.  It applies to linux-2.4.15-pre4.

Nathan Myers
ncm at cantrip dot org

---------------------
diff -u -r linux-bak/arch/alpha/math-emu/sfp-util.h linux/arch/alpha/math-emu/sfp-util.h
--- linux-bak/arch/alpha/math-emu/sfp-util.h	Fri Sep 22 13:54:09 2000
+++ linux/arch/alpha/math-emu/sfp-util.h	Thu Nov 15 20:12:51 2001
@@ -30,6 +30,6 @@
 #define abort()			goto bad_insn
 
 #ifndef __LITTLE_ENDIAN
-#define __LITTLE_ENDIAN -1
+#define __LITTLE_ENDIAN (-1)
 #endif
 #define __BYTE_ORDER __LITTLE_ENDIAN
diff -u -r linux-bak/arch/arm/nwfpe/fpsr.h linux/arch/arm/nwfpe/fpsr.h
--- linux-bak/arch/arm/nwfpe/fpsr.h	Sun Feb 13 10:47:01 2000
+++ linux/arch/arm/nwfpe/fpsr.h	Thu Nov 15 20:12:51 2001
@@ -103,6 +103,6 @@
 #define MASK_ALU	0x9cfff2ff	/* only ALU can write these bits */
 #define MASK_RESET	0x00000d00	/* bits set on reset, all others cleared */
 #define MASK_WFC	MASK_RESET
-#define MASK_RFC	~MASK_RESET
+#define MASK_RFC	(~MASK_RESET)
 
 #endif
diff -u -r linux-bak/arch/cris/drivers/usb-host.h linux/arch/cris/drivers/usb-host.h
--- linux-bak/arch/cris/drivers/usb-host.h	Thu Aug 16 22:15:56 2001
+++ linux/arch/cris/drivers/usb-host.h	Thu Nov 15 20:12:51 2001
@@ -143,7 +143,7 @@
 
 
 #define RH_ACK                     0x01
-#define RH_REQ_ERR                 -1
+#define RH_REQ_ERR                 (-1)
 #define RH_NACK                    0x00
 
 /* Field definitions for */
diff -u -r linux-bak/drivers/acpi/include/acinterp.h linux/drivers/acpi/include/acinterp.h
--- linux-bak/drivers/acpi/include/acinterp.h	Wed Nov  7 20:02:42 2001
+++ linux/drivers/acpi/include/acinterp.h	Thu Nov 15 20:12:54 2001
@@ -27,12 +27,12 @@
 #define __ACINTERP_H__
 
 
-#define WALK_OPERANDS       &(walk_state->operands [walk_state->num_operands -1])
+#define WALK_OPERANDS	(walk_state->operands + walk_state->num_operands - 1)
 
 
 /* Interpreter constants */
 
-#define AML_END_OF_BLOCK            -1
+#define AML_END_OF_BLOCK            (-1)
 #define PUSH_PKG_LENGTH             1
 #define DO_NOT_PUSH_PKG_LENGTH      0
 
diff -u -r linux-bak/drivers/cdrom/aztcd.h linux/drivers/cdrom/aztcd.h
--- linux-bak/drivers/cdrom/aztcd.h	Wed Dec  3 04:29:41 1997
+++ linux/drivers/cdrom/aztcd.h	Thu Nov 15 20:12:53 2001
@@ -25,7 +25,7 @@
 
 /* *** change this to set the I/O port address of your CD-ROM drive,
        set to '-1', if you want autoprobing */
-#define AZT_BASE_ADDR		-1
+#define AZT_BASE_ADDR		(-1)
 
 /* list of autoprobing addresses (not more than 15), last value must be 0x000
    Note: Autoprobing is only enabled, if AZT_BASE_ADDR is set to '-1' ! */
diff -u -r linux-bak/drivers/char/rio/cmd.h linux/drivers/char/rio/cmd.h
--- linux-bak/drivers/char/rio/cmd.h	Wed May 10 16:56:43 2000
+++ linux/drivers/char/rio/cmd.h	Thu Nov 15 20:12:53 2001
@@ -48,7 +48,7 @@
 
 
 #define PRE_EMPTIVE_CMD         0x80
-#define INLINE_CMD              ~PRE_EMPTIVE_CMD
+#define INLINE_CMD              (~PRE_EMPTIVE_CMD)
 
 #define CMD_IGNORE_PKT          ( (ushort) 0)
 #define CMD_STATUS_REQ          ( (ushort) 1)
diff -u -r linux-bak/drivers/char/rio/daemon.h linux/drivers/char/rio/daemon.h
--- linux-bak/drivers/char/rio/daemon.h	Wed May 10 16:56:43 2000
+++ linux/drivers/char/rio/daemon.h	Thu Nov 15 20:12:53 2001
@@ -329,6 +329,6 @@
 
 #define RIO_GET_SIVIEW	  ((('s')<<8) | 106)	/* backwards compatible with SI */
 
-#define	RIO_IOCTL_UNKNOWN	-2
+#define	RIO_IOCTL_UNKNOWN	(-2)
 
 #endif
diff -u -r linux-bak/drivers/char/rio/rio.h linux/drivers/char/rio/rio.h
--- linux-bak/drivers/char/rio/rio.h	Thu Aug 16 22:15:58 2001
+++ linux/drivers/char/rio/rio.h	Thu Nov 15 20:12:53 2001
@@ -101,9 +101,9 @@
 /*
 **	Flag values returned by functions
 */
-#define	RIO_FAIL	-1
+#define	RIO_FAIL	(-1)
 #define	RIO_SUCCESS	0
-#define	COPYFAIL	-1	/* copy[in|out] failed */
+#define	COPYFAIL	(-1)	/* copy[in|out] failed */
 
 /*
 ** SysPort value for something that hasn't any ports
@@ -275,7 +275,7 @@
 #define	RIO_MIPS_R3230	31
 #define	RIO_MIPS_R4030	32
 
-#define	RIO_IO_UNKNOWN	-2
+#define	RIO_IO_UNKNOWN	(-2)
 
 #undef	MODERN
 #define	ERROR( E )	do { u.u_error = E; return OPENFAIL } while ( 0 )
diff -u -r linux-bak/drivers/char/rocket_int.h linux/drivers/char/rocket_int.h
--- linux-bak/drivers/char/rocket_int.h	Mon Dec 11 12:51:57 2000
+++ linux/drivers/char/rocket_int.h	Thu Nov 15 20:12:53 2001
@@ -78,18 +78,18 @@
 #define	isMC	2
 
 /* Controller ID numbers */
-#define CTLID_NULL  -1              /* no controller exists */
+#define CTLID_NULL  (-1)              /* no controller exists */
 #define CTLID_0001  0x0001          /* controller release 1 */
 
 /* AIOP ID numbers, identifies AIOP type implementing channel */
-#define AIOPID_NULL -1              /* no AIOP or channel exists */
+#define AIOPID_NULL (-1)              /* no AIOP or channel exists */
 #define AIOPID_0001 0x0001          /* AIOP release 1 */
 
-#define NULLDEV -1                  /* identifies non-existant device */
-#define NULLCTL -1                  /* identifies non-existant controller */
+#define NULLDEV (-1)                  /* identifies non-existant device */
+#define NULLCTL (-1)                  /* identifies non-existant controller */
 #define NULLCTLPTR (CONTROLLER_T *)0 /* identifies non-existant controller */
-#define NULLAIOP -1                 /* identifies non-existant AIOP */
-#define NULLCHAN -1                 /* identifies non-existant channel */
+#define NULLAIOP (-1)                 /* identifies non-existant AIOP */
+#define NULLCHAN (-1)                 /* identifies non-existant channel */
 
 /************************************************************************
  Global Register Offsets - Direct Access - Fixed values
diff -u -r linux-bak/drivers/char/ser_a2232.h linux/drivers/char/ser_a2232.h
--- linux-bak/drivers/char/ser_a2232.h	Fri Jul 20 22:03:05 2001
+++ linux/drivers/char/ser_a2232.h	Thu Nov 15 20:12:53 2001
@@ -175,7 +175,7 @@
 
 
 /* Standard speeds tables, -1 means unavailable, -2 means 0 baud: switch off line */
-#define A2232_BAUD_TABLE_NOAVAIL -1
+#define A2232_BAUD_TABLE_NOAVAIL (-1)
 #define A2232_BAUD_TABLE_NUM_RATES (18)
 static int a2232_baud_table[A2232_BAUD_TABLE_NUM_RATES*3] = {
 	//Baud	//Normal			//Turbo
diff -u -r linux-bak/drivers/fc4/fcp_impl.h linux/drivers/fc4/fcp_impl.h
--- linux-bak/drivers/fc4/fcp_impl.h	Thu Jan 27 08:58:15 2000
+++ linux/drivers/fc4/fcp_impl.h	Thu Nov 15 20:12:54 2001
@@ -138,8 +138,8 @@
 #define FC_STATUS_ALLOC_FAIL		0x27
 #define FC_STATUS_BAD_SID		0x28
 #define FC_STATUS_NO_SEQ_INIT		0x29
-#define FC_STATUS_TIMED_OUT		-1
-#define FC_STATUS_BAD_RSP		-2
+#define FC_STATUS_TIMED_OUT		(-1)
+#define FC_STATUS_BAD_RSP		(-2)
 
 void fcp_queue_empty(fc_channel *);
 int fcp_init(fc_channel *);
diff -u -r linux-bak/drivers/ieee1394/ieee1394.h linux/drivers/ieee1394/ieee1394.h
--- linux-bak/drivers/ieee1394/ieee1394.h	Wed Oct 24 08:01:26 2001
+++ linux/drivers/ieee1394/ieee1394.h	Thu Nov 15 20:12:54 2001
@@ -39,10 +39,10 @@
 #define ACK_TYPE_ERROR           0xe 
 
 /* Non-standard "ACK codes" for internal use */
-#define ACKX_NONE                -1
-#define ACKX_SEND_ERROR          -2
-#define ACKX_ABORTED             -3
-#define ACKX_TIMEOUT             -4
+#define ACKX_NONE                (-1)
+#define ACKX_SEND_ERROR          (-2)
+#define ACKX_ABORTED             (-3)
+#define ACKX_TIMEOUT             (-4)
 
 
 #define SPEED_100                0x0
diff -u -r linux-bak/drivers/isdn/avmb1/capidrv.h linux/drivers/isdn/avmb1/capidrv.h
--- linux-bak/drivers/isdn/avmb1/capidrv.h	Tue Oct  9 17:54:41 2001
+++ linux/drivers/isdn/avmb1/capidrv.h	Thu Nov 15 20:12:53 2001
@@ -110,7 +110,7 @@
 /*
  * per ncci state machine
  */
-#define ST_NCCI_PREVIOUS			-1
+#define ST_NCCI_PREVIOUS			(-1)
 #define ST_NCCI_NONE				0	/* N-0 */
 #define ST_NCCI_OUTGOING			1	/* N-0.1 */
 #define ST_NCCI_INCOMING			2	/* N-1 */
diff -u -r linux-bak/drivers/isdn/hisax/l3dss1.h linux/drivers/isdn/hisax/l3dss1.h
--- linux-bak/drivers/isdn/hisax/l3dss1.h	Tue Oct  9 17:54:43 2001
+++ linux/drivers/isdn/hisax/l3dss1.h	Thu Nov 15 20:12:53 2001
@@ -99,9 +99,9 @@
 #define IE_MANDATORY_1	0x0200
 
 #define ERR_IE_COMPREHENSION	 1
-#define ERR_IE_UNRECOGNIZED	-1
-#define ERR_IE_LENGTH		-2
-#define ERR_IE_SEQUENCE		-3
+#define ERR_IE_UNRECOGNIZED	(-1)
+#define ERR_IE_LENGTH		(-2)
+#define ERR_IE_SEQUENCE		(-3)
 
 #else /* only l3dss1_process */
 
diff -u -r linux-bak/drivers/isdn/hisax/l3ni1.h linux/drivers/isdn/hisax/l3ni1.h
--- linux-bak/drivers/isdn/hisax/l3ni1.h	Tue Oct  9 17:54:43 2001
+++ linux/drivers/isdn/hisax/l3ni1.h	Thu Nov 15 20:12:54 2001
@@ -111,9 +111,9 @@
 #define IE_MANDATORY_1	0x0200
 
 #define ERR_IE_COMPREHENSION	 1
-#define ERR_IE_UNRECOGNIZED	-1
-#define ERR_IE_LENGTH		-2
-#define ERR_IE_SEQUENCE		-3
+#define ERR_IE_UNRECOGNIZED	(-1)
+#define ERR_IE_LENGTH		(-2)
+#define ERR_IE_SEQUENCE		(-3)
 
 #else /* only l3ni1_process */
 
diff -u -r linux-bak/drivers/net/aironet4500.h linux/drivers/net/aironet4500.h
--- linux-bak/drivers/net/aironet4500.h	Thu Oct 11 02:01:22 2001
+++ linux/drivers/net/aironet4500.h	Thu Nov 15 20:12:52 2001
@@ -49,7 +49,7 @@
 #include <linux/spinlock.h>
 
 
-#define AWC_ERROR	-1
+#define AWC_ERROR	(-1)
 #define AWC_SUCCESS	0
 
 struct awc_cis {
diff -u -r linux-bak/drivers/net/arlan.h linux/drivers/net/arlan.h
--- linux-bak/drivers/net/arlan.h	Sat Mar 31 11:14:33 2001
+++ linux/drivers/net/arlan.h	Thu Nov 15 20:12:52 2001
@@ -54,8 +54,8 @@
 extern const char* arlan_version;
 extern int     arlan_command(struct net_device * dev, int command);
  
-#define SIDUNKNOWN -1
-#define radioNodeIdUNKNOWN -1
+#define SIDUNKNOWN (-1)
+#define radioNodeIdUNKNOWN (-1)
 #define encryptionKeyUNKNOWN '\0';
 #define irqUNKNOWN 0
 #define memUNKNOWN 0
@@ -66,8 +66,8 @@
 #define spreadingCodeUNKNOWN 0
 #define channelNumberUNKNOWN 0
 #define channelSetUNKNOWN 0
-#define systemIdUNKNOWN -1
-#define registrationModeUNKNOWN -1
+#define systemIdUNKNOWN (-1)
+#define registrationModeUNKNOWN (-1)
 #define siteNameUNKNOWN "LinuxSite"
 
 
diff -u -r linux-bak/drivers/net/de4x5.h linux/drivers/net/de4x5.h
--- linux-bak/drivers/net/de4x5.h	Sat Mar 31 11:14:33 2001
+++ linux/drivers/net/de4x5.h	Thu Nov 15 20:28:41 2001
@@ -13,57 +13,57 @@
 /*
 ** DC21040 CSR<1..15> Register Address Map
 */
-#define DE4X5_BMR    iobase+(0x000 << lp->bus)  /* Bus Mode Register */
-#define DE4X5_TPD    iobase+(0x008 << lp->bus)  /* Transmit Poll Demand Reg */
-#define DE4X5_RPD    iobase+(0x010 << lp->bus)  /* Receive Poll Demand Reg */
-#define DE4X5_RRBA   iobase+(0x018 << lp->bus)  /* RX Ring Base Address Reg */
-#define DE4X5_TRBA   iobase+(0x020 << lp->bus)  /* TX Ring Base Address Reg */
-#define DE4X5_STS    iobase+(0x028 << lp->bus)  /* Status Register */
-#define DE4X5_OMR    iobase+(0x030 << lp->bus)  /* Operation Mode Register */
-#define DE4X5_IMR    iobase+(0x038 << lp->bus)  /* Interrupt Mask Register */
-#define DE4X5_MFC    iobase+(0x040 << lp->bus)  /* Missed Frame Counter */
-#define DE4X5_APROM  iobase+(0x048 << lp->bus)  /* Ethernet Address PROM */
-#define DE4X5_BROM   iobase+(0x048 << lp->bus)  /* Boot ROM Register */
-#define DE4X5_SROM   iobase+(0x048 << lp->bus)  /* Serial ROM Register */
-#define DE4X5_MII    iobase+(0x048 << lp->bus)  /* MII Interface Register */
-#define DE4X5_DDR    iobase+(0x050 << lp->bus)  /* Data Diagnostic Register */
-#define DE4X5_FDR    iobase+(0x058 << lp->bus)  /* Full Duplex Register */
-#define DE4X5_GPT    iobase+(0x058 << lp->bus)  /* General Purpose Timer Reg.*/
-#define DE4X5_GEP    iobase+(0x060 << lp->bus)  /* General Purpose Register */
-#define DE4X5_SISR   iobase+(0x060 << lp->bus)  /* SIA Status Register */
-#define DE4X5_SICR   iobase+(0x068 << lp->bus)  /* SIA Connectivity Register */
-#define DE4X5_STRR   iobase+(0x070 << lp->bus)  /* SIA TX/RX Register */
-#define DE4X5_SIGR   iobase+(0x078 << lp->bus)  /* SIA General Register */
+#define DE4X5_BMR    (iobase+(0x000 << lp->bus)) /* Bus Mode Register */
+#define DE4X5_TPD    (iobase+(0x008 << lp->bus)) /* Transmit Poll Demand Reg */
+#define DE4X5_RPD    (iobase+(0x010 << lp->bus)) /* Receive Poll Demand Reg */
+#define DE4X5_RRBA   (iobase+(0x018 << lp->bus)) /* RX Ring Base Address Reg */
+#define DE4X5_TRBA   (iobase+(0x020 << lp->bus)) /* TX Ring Base Address Reg */
+#define DE4X5_STS    (iobase+(0x028 << lp->bus)) /* Status Register */
+#define DE4X5_OMR    (iobase+(0x030 << lp->bus)) /* Operation Mode Register */
+#define DE4X5_IMR    (iobase+(0x038 << lp->bus)) /* Interrupt Mask Register */
+#define DE4X5_MFC    (iobase+(0x040 << lp->bus)) /* Missed Frame Counter */
+#define DE4X5_APROM  (iobase+(0x048 << lp->bus)) /* Ethernet Address PROM */
+#define DE4X5_BROM   (iobase+(0x048 << lp->bus)) /* Boot ROM Register */
+#define DE4X5_SROM   (iobase+(0x048 << lp->bus)) /* Serial ROM Register */
+#define DE4X5_MII    ((iobase+(0x048 << lp->bus)) /* MII Interface Register */
+#define DE4X5_DDR    (iobase+(0x050 << lp->bus)) /* Data Diagnostic Register */
+#define DE4X5_FDR    (iobase+(0x058 << lp->bus)) /* Full Duplex Register */
+#define DE4X5_GPT    (iobase+(0x058 << lp->bus)) /* General Purpose Timer Reg.*/
+#define DE4X5_GEP    (iobase+(0x060 << lp->bus)) /* General Purpose Register */
+#define DE4X5_SISR   (iobase+(0x060 << lp->bus)) /* SIA Status Register */
+#define DE4X5_SICR   (iobase+(0x068 << lp->bus)) /* SIA Connectivity Register */
+#define DE4X5_STRR   (iobase+(0x070 << lp->bus)) /* SIA TX/RX Register */
+#define DE4X5_SIGR   (iobase+(0x078 << lp->bus))   /* SIA General Register */
 
 /*
 ** EISA Register Address Map
 */
-#define EISA_ID      iobase+0x0c80   /* EISA ID Registers */ 
-#define EISA_ID0     iobase+0x0c80   /* EISA ID Register 0 */ 
-#define EISA_ID1     iobase+0x0c81   /* EISA ID Register 1 */ 
-#define EISA_ID2     iobase+0x0c82   /* EISA ID Register 2 */ 
-#define EISA_ID3     iobase+0x0c83   /* EISA ID Register 3 */ 
-#define EISA_CR      iobase+0x0c84   /* EISA Control Register */
-#define EISA_REG0    iobase+0x0c88   /* EISA Configuration Register 0 */
-#define EISA_REG1    iobase+0x0c89   /* EISA Configuration Register 1 */
-#define EISA_REG2    iobase+0x0c8a   /* EISA Configuration Register 2 */
-#define EISA_REG3    iobase+0x0c8f   /* EISA Configuration Register 3 */
-#define EISA_APROM   iobase+0x0c90   /* Ethernet Address PROM */
+#define EISA_ID      (iobase+0x0c80)   /* EISA ID Registers */ 
+#define EISA_ID0     (iobase+0x0c80)   /* EISA ID Register 0 */ 
+#define EISA_ID1     (iobase+0x0c81)   /* EISA ID Register 1 */ 
+#define EISA_ID2     (iobase+0x0c82)   /* EISA ID Register 2 */ 
+#define EISA_ID3     (iobase+0x0c83)   /* EISA ID Register 3 */ 
+#define EISA_CR      (iobase+0x0c84)   /* EISA Control Register */
+#define EISA_REG0    (iobase+0x0c88)   /* EISA Configuration Register 0 */
+#define EISA_REG1    (iobase+0x0c89)   /* EISA Configuration Register 1 */
+#define EISA_REG2    (iobase+0x0c8a)   /* EISA Configuration Register 2 */
+#define EISA_REG3    (iobase+0x0c8f)   /* EISA Configuration Register 3 */
+#define EISA_APROM   (iobase+0x0c90)   /* Ethernet Address PROM */
 
 /*
 ** PCI/EISA Configuration Registers Address Map
 */
-#define PCI_CFID     iobase+0x0008   /* PCI Configuration ID Register */
-#define PCI_CFCS     iobase+0x000c   /* PCI Command/Status Register */
-#define PCI_CFRV     iobase+0x0018   /* PCI Revision Register */
-#define PCI_CFLT     iobase+0x001c   /* PCI Latency Timer Register */
-#define PCI_CBIO     iobase+0x0028   /* PCI Base I/O Register */
-#define PCI_CBMA     iobase+0x002c   /* PCI Base Memory Address Register */
-#define PCI_CBER     iobase+0x0030   /* PCI Expansion ROM Base Address Reg. */
-#define PCI_CFIT     iobase+0x003c   /* PCI Configuration Interrupt Register */
-#define PCI_CFDA     iobase+0x0040   /* PCI Driver Area Register */
-#define PCI_CFDD     iobase+0x0041   /* PCI Driver Dependent Area Register */
-#define PCI_CFPM     iobase+0x0043   /* PCI Power Management Area Register */
+#define PCI_CFID     (iobase+0x0008)  /* PCI Configuration ID Register */
+#define PCI_CFCS     (iobase+0x000c)  /* PCI Command/Status Register */
+#define PCI_CFRV     (iobase+0x0018)  /* PCI Revision Register */
+#define PCI_CFLT     (iobase+0x001c)  /* PCI Latency Timer Register */
+#define PCI_CBIO     (iobase+0x0028)  /* PCI Base I/O Register */
+#define PCI_CBMA     (iobase+0x002c)  /* PCI Base Memory Address Register */
+#define PCI_CBER     (iobase+0x0030)  /* PCI Expansion ROM Base Address Reg. */
+#define PCI_CFIT     (iobase+0x003c)  /* PCI Configuration Interrupt Register */
+#define PCI_CFDA     (iobase+0x0040)  /* PCI Driver Area Register */
+#define PCI_CFDD     (iobase+0x0041)  /* PCI Driver Dependent Area Register */
+#define PCI_CFPM     (iobase+0x0043)  /* PCI Power Management Area Register */
 
 /*
 ** EISA Configuration Register 0 bit definitions
@@ -898,8 +898,8 @@
 #define NO                   0
 #define FALSE                0
 
-#define YES                  ~0
-#define TRUE                 ~0
+#define YES                  (~0)	/* these are very stupid macros */
+#define TRUE                 (~0)
 
 /*
 ** Adapter state
diff -u -r linux-bak/drivers/net/dgrs_bcomm.h linux/drivers/net/dgrs_bcomm.h
--- linux-bak/drivers/net/dgrs_bcomm.h	Sat Dec 21 07:23:20 1996
+++ linux/drivers/net/dgrs_bcomm.h	Thu Nov 15 20:12:52 2001
@@ -129,7 +129,7 @@
 /*
  *	bc_host values
  */
-#define	BC_DIAGS	-1
+#define	BC_DIAGS	(-1)
 #define BC_SASWITCH	0
 #define	BC_SWITCH	1
 #define	BC_MULTINIC	2
@@ -142,7 +142,7 @@
 /*
  *	filter commands
  */
-#define	BC_FILTER_ERR	-1
+#define	BC_FILTER_ERR	(-1)
 #define	BC_FILTER_OK	0
 #define	BC_FILTER_SET	1
 #define	BC_FILTER_CLR	2
diff -u -r linux-bak/drivers/net/gt96100eth.h linux/drivers/net/gt96100eth.h
--- linux-bak/drivers/net/gt96100eth.h	Sun Sep 23 14:55:52 2001
+++ linux/drivers/net/gt96100eth.h	Thu Nov 15 20:12:52 2001
@@ -48,8 +48,8 @@
 #define GT96100_ETHER0_IRQ 4
 #define GT96100_ETHER1_IRQ 4
 #else
-#define GT96100_ETHER0_IRQ -1
-#define GT96100_ETHER1_IRQ -1
+#define GT96100_ETHER0_IRQ (-1)
+#define GT96100_ETHER1_IRQ (-1)
 #endif
 
 #define GT96100ETH_READ(gp, offset) \
diff -u -r linux-bak/drivers/net/hamradio/soundmodem/sm_tbl_afsk1200.h linux/drivers/net/hamradio/soundmodem/sm_tbl_afsk1200.h
--- linux-bak/drivers/net/hamradio/soundmodem/sm_tbl_afsk1200.h	Sat Mar 31 11:17:47 2001
+++ linux/drivers/net/hamradio/soundmodem/sm_tbl_afsk1200.h	Thu Nov 15 20:12:52 2001
@@ -63,7 +63,7 @@
 static const int afsk12_tx_hi_i[] = {
 	  127,   16, -122,  -48,  109,   77,  -89, -100 
 };
-#define SUM_AFSK12_TX_HI_I -30
+#define SUM_AFSK12_TX_HI_I (-30)
 
 static const int afsk12_tx_hi_q[] = {
 	    0,  125,   32, -117,  -63,  100,   89,  -77 
diff -u -r linux-bak/drivers/net/hamradio/soundmodem/sm_tbl_afsk2400_7.h linux/drivers/net/hamradio/soundmodem/sm_tbl_afsk2400_7.h
--- linux-bak/drivers/net/hamradio/soundmodem/sm_tbl_afsk2400_7.h	Sat Mar 31 11:17:47 2001
+++ linux/drivers/net/hamradio/soundmodem/sm_tbl_afsk2400_7.h	Thu Nov 15 20:12:52 2001
@@ -58,7 +58,7 @@
 static const int afsk24_tx_lo_q[] = {
 	    0,   11,   35,   43,    0,  -78, -125,  -89,   -1,   62,   61,   25,    0,   -7 
 };
-#define SUM_AFSK24_TX_LO_Q -63
+#define SUM_AFSK24_TX_LO_Q (-63)
 
 static const int afsk24_tx_hi_i[] = {
 	   10,    2,  -34,  -24,   76,   69,  -86, -101,   53,   83,  -14,  -35,    0,   10 
diff -u -r linux-bak/drivers/net/hamradio/soundmodem/sm_tbl_afsk2400_8.h linux/drivers/net/hamradio/soundmodem/sm_tbl_afsk2400_8.h
--- linux-bak/drivers/net/hamradio/soundmodem/sm_tbl_afsk2400_8.h	Sat Mar 31 11:17:47 2001
+++ linux/drivers/net/hamradio/soundmodem/sm_tbl_afsk2400_8.h	Thu Nov 15 20:12:52 2001
@@ -58,7 +58,7 @@
 static const int afsk24_tx_lo_q[] = {
 	    0,   12,   35,   34,  -22, -100, -115,  -40,   55,   87,   48,    2,  -11,  -10 
 };
-#define SUM_AFSK24_TX_LO_Q -25
+#define SUM_AFSK24_TX_LO_Q (-25)
 
 static const int afsk24_tx_hi_i[] = {
 	   10,    0,  -35,   -2,   89,    6, -124,  -10,  111,    9,  -61,   -4,   16,    1 
diff -u -r linux-bak/drivers/net/hamradio/soundmodem/sm_tbl_afsk2666.h linux/drivers/net/hamradio/soundmodem/sm_tbl_afsk2666.h
--- linux-bak/drivers/net/hamradio/soundmodem/sm_tbl_afsk2666.h	Sat Mar 31 11:17:47 2001
+++ linux/drivers/net/hamradio/soundmodem/sm_tbl_afsk2666.h	Thu Nov 15 20:12:52 2001
@@ -58,18 +58,18 @@
 	{
 		{{      1,      7,    -18,    -73,   -100,    -47,     47,    100,     73,     18,     -7,     -1 }, {      0,     17,     43,     30,    -41,   -115,   -115,    -41,     30,     43,     17,      0 }},
 #define AFSK26_DEM_SUM_I_0_0 0
-#define AFSK26_DEM_SUM_Q_0_0 -132
+#define AFSK26_DEM_SUM_Q_0_0 (-132)
 		{{      1,     -7,    -46,    -10,    100,     76,    -75,   -100,     10,     46,      7,     -1 }, {      1,     17,     -6,    -79,    -41,     99,     99,    -41,    -79,     -6,     17,      1 }}
 #define AFSK26_DEM_SUM_I_0_1 1
-#define AFSK26_DEM_SUM_Q_0_1 -18
+#define AFSK26_DEM_SUM_Q_0_1 (-18)
 	},
 	{
 		{{      8,     22,      0,    -67,   -118,    -89,      0,     67,     63,     22,      0,      0 }, {      0,     22,     63,     67,      0,    -89,   -118,    -67,      0,     22,      8,      0 }},
-#define AFSK26_DEM_SUM_I_1_0 -92
-#define AFSK26_DEM_SUM_Q_1_0 -92
+#define AFSK26_DEM_SUM_I_1_0 (-92)
+#define AFSK26_DEM_SUM_Q_1_0 (-92)
 		{{      8,      8,    -54,    -67,     59,    122,      0,    -91,    -31,     22,      7,      0 }, {      0,     30,     31,    -67,   -102,     32,    118,     24,    -54,    -22,      4,      0 }}
-#define AFSK26_DEM_SUM_I_1_1 -17
-#define AFSK26_DEM_SUM_Q_1_1 -6
+#define AFSK26_DEM_SUM_I_1_1 (-17)
+#define AFSK26_DEM_SUM_Q_1_1 (-6)
 	}
 };
 
diff -u -r linux-bak/drivers/net/sk98lin/h/skgepnm2.h linux/drivers/net/sk98lin/h/skgepnm2.h
--- linux-bak/drivers/net/sk98lin/h/skgepnm2.h	Fri Jul 20 22:03:09 2001
+++ linux/drivers/net/sk98lin/h/skgepnm2.h	Thu Nov 15 20:25:13 2001
@@ -145,7 +145,7 @@
 #endif
 
 #ifndef TRUE
-#define	TRUE			!(FALSE)
+#define	TRUE			1	/* this is a stupid macro */
 #endif
 
 /*
diff -u -r linux-bak/drivers/net/wan/lmc/lmc_ioctl.h linux/drivers/net/wan/lmc/lmc_ioctl.h
--- linux-bak/drivers/net/wan/lmc/lmc_ioctl.h	Wed Feb 21 21:07:43 2001
+++ linux/drivers/net/wan/lmc/lmc_ioctl.h	Thu Nov 15 20:24:09 2001
@@ -16,20 +16,20 @@
   * of the GNU General Public License version 2, incorporated herein by reference.
   */
 
-#define LMCIOCGINFO             SIOCDEVPRIVATE+3 /* get current state */
-#define LMCIOCSINFO             SIOCDEVPRIVATE+4 /* set state to user values */
-#define LMCIOCGETLMCSTATS       SIOCDEVPRIVATE+5
-#define LMCIOCCLEARLMCSTATS     SIOCDEVPRIVATE+6
-#define LMCIOCDUMPEVENTLOG      SIOCDEVPRIVATE+7
-#define LMCIOCGETXINFO          SIOCDEVPRIVATE+8
-#define LMCIOCSETCIRCUIT        SIOCDEVPRIVATE+9
-#define LMCIOCUNUSEDATM         SIOCDEVPRIVATE+10
-#define LMCIOCRESET             SIOCDEVPRIVATE+11
-#define LMCIOCT1CONTROL         SIOCDEVPRIVATE+12
-#define LMCIOCIFTYPE            SIOCDEVPRIVATE+13
-#define LMCIOCXILINX            SIOCDEVPRIVATE+14
+#define LMCIOCGINFO           (SIOCDEVPRIVATE+3) /* get current state */
+#define LMCIOCSINFO           (SIOCDEVPRIVATE+4) /* set state to user values */
+#define LMCIOCGETLMCSTATS       (SIOCDEVPRIVATE+5)
+#define LMCIOCCLEARLMCSTATS     (SIOCDEVPRIVATE+6)
+#define LMCIOCDUMPEVENTLOG      (SIOCDEVPRIVATE+7)
+#define LMCIOCGETXINFO          (SIOCDEVPRIVATE+8)
+#define LMCIOCSETCIRCUIT        (SIOCDEVPRIVATE+9)
+#define LMCIOCUNUSEDATM         (SIOCDEVPRIVATE+10)
+#define LMCIOCRESET             (SIOCDEVPRIVATE+11)
+#define LMCIOCT1CONTROL         (SIOCDEVPRIVATE+12)
+#define LMCIOCIFTYPE            (SIOCDEVPRIVATE+13)
+#define LMCIOCXILINX            (SIOCDEVPRIVATE+14)
 
-#define LMC_CARDTYPE_UNKNOWN            -1
+#define LMC_CARDTYPE_UNKNOWN            (-1)
 #define LMC_CARDTYPE_HSSI               1       /* probed card is a HSSI card */
 #define LMC_CARDTYPE_DS3                2       /* probed card is a DS3 card */
 #define LMC_CARDTYPE_SSI                3       /* probed card is a SSI card */
diff -u -r linux-bak/drivers/net/wan/sbni.h linux/drivers/net/wan/sbni.h
--- linux-bak/drivers/net/wan/sbni.h	Thu Aug 16 22:16:06 2001
+++ linux/drivers/net/wan/sbni.h	Thu Nov 15 20:12:51 2001
@@ -80,7 +80,7 @@
 	DEFAULT_FRAME_LEN = 1012
 };
 
-#define DEF_RXL_DELTA	-1
+#define DEF_RXL_DELTA	(-1)
 #define DEF_RXL		0xf
 
 #define SBNI_SIG 0x5a
diff -u -r linux-bak/drivers/s390/block/dasd_int.h linux/drivers/s390/block/dasd_int.h
--- linux-bak/drivers/s390/block/dasd_int.h	Tue Oct  9 17:54:55 2001
+++ linux/drivers/s390/block/dasd_int.h	Thu Nov 15 20:12:54 2001
@@ -28,7 +28,7 @@
 #define DASD_FORMAT_INTENS_WRITE_RECZERO 0x01
 #define DASD_FORMAT_INTENS_WRITE_HOMEADR 0x02
 
-#define DASD_STATE_DEL   -1
+#define DASD_STATE_DEL   (-1)
 #define DASD_STATE_NEW    0
 #define DASD_STATE_KNOWN  1
 #define DASD_STATE_ACCEPT 2
diff -u -r linux-bak/drivers/sbus/audio/cs4231.h linux/drivers/sbus/audio/cs4231.h
--- linux-bak/drivers/sbus/audio/cs4231.h	Mon Dec 20 22:06:42 1999
+++ linux/drivers/sbus/audio/cs4231.h	Thu Nov 15 20:12:54 2001
@@ -105,7 +105,7 @@
 #define IAR_AUTOCAL_BEGIN       0x40    /* MCE */
 #define IAR_NOT_READY           0x80    /* INIT */
 
-#define IAR_AUTOCAL_END         ~(IAR_AUTOCAL_BEGIN) /* MCD */
+#define IAR_AUTOCAL_END         (~(IAR_AUTOCAL_BEGIN)) /* MCD */
 
 /* Registers 1-15 modes 1 and 2. Registers 16-31 mode 2 only */
 /* Registers assumed to be same in both modes unless noted */
@@ -126,7 +126,7 @@
 /* 6 - Left Output Control */
 /* 7 - Right Output Control */
 #define OUTCR_MUTE              0x80
-#define OUTCR_UNMUTE            ~0x80
+#define OUTCR_UNMUTE            (~0x80)
 
 /* 8 - Playback Data Format (Mode 2) */
 #define CHANGE_DFR(var, val)            ((var & ~(0xF)) | val)
diff -u -r linux-bak/drivers/scsi/NCR5380.h linux/drivers/scsi/NCR5380.h
--- linux-bak/drivers/scsi/NCR5380.h	Wed Feb 21 21:07:47 2001
+++ linux/drivers/scsi/NCR5380.h	Thu Nov 15 20:12:53 2001
@@ -220,8 +220,8 @@
  * These are "special" values for the tag parameter passed to NCR5380_select.
  */
 
-#define TAG_NEXT	-1 	/* Use next free tag */
-#define TAG_NONE	-2	/* 
+#define TAG_NEXT	(-1) 	/* Use next free tag */
+#define TAG_NONE	(-2)	/* 
 				 * Establish I_T_L nexus instead of I_T_L_Q
 				 * even on SCSI-II devices.
 				 */
diff -u -r linux-bak/drivers/scsi/dpt/dpti_i2o.h linux/drivers/scsi/dpt/dpti_i2o.h
--- linux-bak/drivers/scsi/dpt/dpti_i2o.h	Sun Sep 23 14:56:04 2001
+++ linux/drivers/scsi/dpt/dpti_i2o.h	Thu Nov 15 20:12:53 2001
@@ -456,7 +456,7 @@
 #define MSG_POOL_SIZE		16384
 
 #define I2O_POST_WAIT_OK	0
-#define I2O_POST_WAIT_TIMEOUT	-ETIMEDOUT
+#define I2O_POST_WAIT_TIMEOUT	(-ETIMEDOUT)
 
 
 #endif /* __KERNEL__ */
diff -u -r linux-bak/drivers/scsi/gdth.h linux/drivers/scsi/gdth.h
--- linux-bak/drivers/scsi/gdth.h	Sun Sep 23 14:56:04 2001
+++ linux/drivers/scsi/gdth.h	Thu Nov 15 20:12:53 2001
@@ -178,7 +178,7 @@
 #define SCREENSERVICE   11
 
 /* screenservice defines */
-#define MSG_INV_HANDLE  -1                      /* special message handle */
+#define MSG_INV_HANDLE  (-1)                      /* special message handle */
 #define MSGLEN          16                      /* size of message text */
 #define MSG_SIZE        34                      /* size of message structure */
 #define MSG_REQUEST     0                       /* async. event: message */
diff -u -r linux-bak/drivers/scsi/sym53c8xx_comm.h linux/drivers/scsi/sym53c8xx_comm.h
--- linux-bak/drivers/scsi/sym53c8xx_comm.h	Wed Oct 24 08:02:01 2001
+++ linux/drivers/scsi/sym53c8xx_comm.h	Thu Nov 15 20:12:53 2001
@@ -2015,10 +2015,10 @@
 **===================================================================
 */
 #define DEF_DEPTH	(driver_setup.default_tags)
-#define ALL_TARGETS	-2
-#define NO_TARGET	-1
-#define ALL_LUNS	-2
-#define NO_LUN		-1
+#define ALL_TARGETS	(-2)
+#define NO_TARGET	(-1)
+#define ALL_LUNS	(-2)
+#define NO_LUN		(-1)
 
 static int device_queue_depth(int unit, int target, int lun)
 {
diff -u -r linux-bak/drivers/sound/ac97.h linux/drivers/sound/ac97.h
--- linux-bak/drivers/sound/ac97.h	Sun Sep 23 14:56:08 2001
+++ linux/drivers/sound/ac97.h	Thu Nov 15 20:12:53 2001
@@ -160,8 +160,8 @@
 };
 
 /* Values stored in the register cache.  */
-#define AC97_REGVAL_UNKNOWN -1
-#define AC97_REG_UNSUPPORTED -2
+#define AC97_REGVAL_UNKNOWN (-1)
+#define AC97_REG_UNSUPPORTED (-2)
 
 struct ac97_mixer_value_list
 {
diff -u -r linux-bak/drivers/usb/hpusbscsi.h linux/drivers/usb/hpusbscsi.h
--- linux-bak/drivers/usb/hpusbscsi.h	Tue Oct  9 17:55:11 2001
+++ linux/drivers/usb/hpusbscsi.h	Thu Nov 15 20:12:54 2001
@@ -36,7 +36,7 @@
         u8 scsi_state_byte;
 };
 
-#define SCSI_ERR_MASK ~0x3fu
+#define SCSI_ERR_MASK (~0x3fu)
 
 static const unsigned char scsi_command_direction[256/8] = {
 	0x28, 0x81, 0x14, 0x14, 0x20, 0x01, 0x90, 0x77,
diff -u -r linux-bak/drivers/usb/microtek.h linux/drivers/usb/microtek.h
--- linux-bak/drivers/usb/microtek.h	Sat Mar 31 11:14:50 2001
+++ linux/drivers/usb/microtek.h	Thu Nov 15 20:12:54 2001
@@ -56,5 +56,5 @@
 #define MTS_EP_IMAGE	0x3
 #define MTS_EP_TOTAL	0x3
 
-#define MTS_SCSI_ERR_MASK ~0x3fu
+#define MTS_SCSI_ERR_MASK (~0x3fu)
 
diff -u -r linux-bak/drivers/usb/uhci.h linux/drivers/usb/uhci.h
--- linux-bak/drivers/usb/uhci.h	Thu Nov 15 00:22:19 2001
+++ linux/drivers/usb/uhci.h	Thu Nov 15 20:12:54 2001
@@ -403,7 +403,7 @@
 #define RH_REMOVE_EP		0x00
 
 #define RH_ACK			0x01
-#define RH_REQ_ERR		-1
+#define RH_REQ_ERR		(-1)
 #define RH_NACK			0x00
 
 #endif
diff -u -r linux-bak/drivers/usb/usb-ohci.h linux/drivers/usb/usb-ohci.h
--- linux-bak/drivers/usb/usb-ohci.h	Wed Nov  7 20:02:45 2001
+++ linux/drivers/usb/usb-ohci.h	Thu Nov 15 20:12:54 2001
@@ -288,7 +288,7 @@
 #define RH_ENDPOINT_STALL          0x01
 
 #define RH_ACK                     0x01
-#define RH_REQ_ERR                 -1
+#define RH_REQ_ERR                 (-1)
 #define RH_NACK                    0x00
 
 
diff -u -r linux-bak/drivers/usb/usb-uhci.h linux/drivers/usb/usb-uhci.h
--- linux-bak/drivers/usb/usb-uhci.h	Sun Sep 23 14:56:19 2001
+++ linux/drivers/usb/usb-uhci.h	Thu Nov 15 20:12:54 2001
@@ -302,7 +302,7 @@
 
 
 #define RH_ACK                     0x01
-#define RH_REQ_ERR                 -1
+#define RH_REQ_ERR                 (-1)
 #define RH_NACK                    0x00
 
 #endif
