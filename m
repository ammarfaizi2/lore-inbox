Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282813AbRK0GRs>; Tue, 27 Nov 2001 01:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282814AbRK0GRh>; Tue, 27 Nov 2001 01:17:37 -0500
Received: from sj1-3-1-20.iserver.com ([128.121.122.117]:53777 "EHLO
	sj1-3-1-20.iserver.com") by vger.kernel.org with ESMTP
	id <S282800AbRK0GRP>; Tue, 27 Nov 2001 01:17:15 -0500
Date: Tue, 27 Nov 2001 06:17:14 +0000
From: Nathan Myers <ncm-nospam@cantrip.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC] [PATCH] omnibus header cleanup, certification
Message-ID: <20011127061714.A41881@cantrip.org>
Mail-Followup-To: Nathan Myers <ncm-nospam@cantrip.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is being sent to each person listed as a MAINTAINER
of a header file affected by it.

Weeks ago I [1]posted  patches ([2],[3]) to fix undisciplined macro 
definitions in 116 header files.  The patches still apply unchanged 
to kernels 2.5 and to 2.4.16.

I noted later[4] that...
> There are certainly dozens of more-subtle bug sources (e.g. [5],[6]) in 
> the kernel, and I would love to help smoke them out, but I can't afford 
> to do that if it's a hundred times as much work to get the resulting 
> patches accepted as to find and fix them in the first place.

Alan suggested I send the patches directly to all the MAINTAINERs 
affected and ask each of you to certify them.  I have attached the 
patches directly to this e-mail.

Please review at least the portion that you are responsible for,
and verify that the changes are safe and cannot change the semantics 
of otherwise-correct code that uses the affected macros.  (That will
be easy, they're all trivial parenthesizations.  It seems worth noting 
here that in the C grammar, "-1" is not a numeric literal, but a unary 
expression.)  Then, pass on your evaluation to Linus and Marcelo.  

Many of the affected files do not have a current maintainer.  Please 
consider certifying the changes to the orphaned files as well.

Note that there is no way I can afford to keep track of whether each 
of 116 separate patches were taken, and resubmit them, so I am asking 
that the patches be taken wholesale once a few maintainers have 
certified that the changes really are as benign as they (so obviously)
are.

Nathan Myers
ncm at cantrip dot org

[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=100587948705950&w=2
[2] http://cantrip.org/omnibus-linux.diff
[3] http://cantrip.org/omnibus-includes.diff
[4] http://marc.theaimsgroup.com/?l=linux-kernel&m=100646558917525&w=2
[5] http://marc.theaimsgroup.com/?l=linux-kernel&m=100591078621276&w=2
[6] http://marc.theaimsgroup.com/?l=linux-kernel&m=100633930427682&w=2

---------------------- cut ------------------

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
+#define DE4X5_MII    (iobase+(0x048 << lp->bus)) /* MII Interface Register */
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
diff -u -r linux-bak/include/asm-alpha/gentrap.h linux/include/asm-alpha/gentrap.h
--- linux-bak/include/asm-alpha/gentrap.h	Thu Nov 15 16:09:57 2001
+++ linux/include/asm-alpha/gentrap.h	Thu Nov 15 16:15:06 2001
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
 
diff -u -r linux-bak/include/asm-alpha/siginfo.h linux/include/asm-alpha/siginfo.h
--- linux-bak/include/asm-alpha/siginfo.h	Thu Nov 15 16:09:58 2001
+++ linux/include/asm-alpha/siginfo.h	Thu Nov 15 16:16:02 2001
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
diff -u -r linux-bak/include/asm-arm/arch-l7200/aux_reg.h linux/include/asm-arm/arch-l7200/aux_reg.h
--- linux-bak/include/asm-arm/arch-l7200/aux_reg.h	Thu Nov 15 16:10:12 2001
+++ linux/include/asm-arm/arch-l7200/aux_reg.h	Thu Nov 15 16:56:01 2001
@@ -11,7 +11,7 @@
 
 #include <asm/arch/hardware.h>
 
-#define l7200aux_reg	*((volatile unsigned int *) (AUX_BASE))
+#define l7200aux_reg	(*((volatile unsigned int *) (AUX_BASE)))
 
 /*
  * Auxillary register values
diff -u -r linux-bak/include/asm-arm/arch-sa1100/assabet.h linux/include/asm-arm/arch-sa1100/assabet.h
--- linux-bak/include/asm-arm/arch-sa1100/assabet.h	Thu Nov 15 16:10:08 2001
+++ linux/include/asm-arm/arch-sa1100/assabet.h	Thu Nov 15 16:55:38 2001
@@ -21,7 +21,7 @@
 #define ASSABET_SCR_GFX		(1<<8)	/* Graphics Accelerator (0 = present) */
 #define ASSABET_SCR_SA1111	(1<<9)	/* Neponset (0 = present) */
 
-#define ASSABET_SCR_INIT	-1
+#define ASSABET_SCR_INIT	(-1)
 
 
 /* Board Control Register */
diff -u -r linux-bak/include/asm-arm/siginfo.h linux/include/asm-arm/siginfo.h
--- linux-bak/include/asm-arm/siginfo.h	Thu Nov 15 16:10:11 2001
+++ linux/include/asm-arm/siginfo.h	Thu Nov 15 16:16:59 2001
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
diff -u -r linux-bak/include/asm-cris/siginfo.h linux/include/asm-cris/siginfo.h
--- linux-bak/include/asm-cris/siginfo.h	Thu Nov 15 16:10:34 2001
+++ linux/include/asm-cris/siginfo.h	Thu Nov 15 16:17:33 2001
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
diff -u -r linux-bak/include/asm-i386/siginfo.h linux/include/asm-i386/siginfo.h
--- linux-bak/include/asm-i386/siginfo.h	Thu Nov 15 16:09:54 2001
+++ linux/include/asm-i386/siginfo.h	Thu Nov 15 16:18:00 2001
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
diff -u -r linux-bak/include/asm-ia64/pal.h linux/include/asm-ia64/pal.h
--- linux-bak/include/asm-ia64/pal.h	Thu Nov 15 16:10:16 2001
+++ linux/include/asm-ia64/pal.h	Thu Nov 15 16:18:50 2001
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
diff -u -r linux-bak/include/asm-ia64/siginfo.h linux/include/asm-ia64/siginfo.h
--- linux-bak/include/asm-ia64/siginfo.h	Thu Nov 15 16:10:17 2001
+++ linux/include/asm-ia64/siginfo.h	Thu Nov 15 16:19:26 2001
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
diff -u -r linux-bak/include/asm-ia64/sn/alenlist.h linux/include/asm-ia64/sn/alenlist.h
--- linux-bak/include/asm-ia64/sn/alenlist.h	Thu Nov 15 16:10:17 2001
+++ linux/include/asm-ia64/sn/alenlist.h	Thu Nov 15 16:56:22 2001
@@ -51,7 +51,7 @@
 
 
 /* Return codes from alenlist routines.  */
-#define ALENLIST_FAILURE -1
+#define ALENLIST_FAILURE (-1)
 #define ALENLIST_SUCCESS 0
 
 
diff -u -r linux-bak/include/asm-ia64/sn/clksupport.h linux/include/asm-ia64/sn/clksupport.h
--- linux-bak/include/asm-ia64/sn/clksupport.h	Thu Nov 15 16:10:17 2001
+++ linux/include/asm-ia64/sn/clksupport.h	Thu Nov 15 16:57:18 2001
@@ -50,7 +50,7 @@
 typedef heartreg_t clkreg_t;
 #define NSEC_PER_CYCLE		80
 #define CYCLE_PER_SEC		(NSEC_PER_SEC/NSEC_PER_CYCLE)
-#define GET_LOCAL_RTC	*((volatile clkreg_t *)PHYS_TO_COMPATK1(HEART_COUNT))
+#define GET_LOCAL_RTC  (*((volatile clkreg_t *)PHYS_TO_COMPATK1(HEART_COUNT)))
 #define DISABLE_TMO_INTR()
 #define CLK_CYCLE_ADDRESS_FOR_USER PHYS_TO_K1(HEART_COUNT)
 #define CLK_FCLOCK_SLOW_FREQ (CYCLE_PER_SEC / HZ)
diff -u -r linux-bak/include/asm-ia64/sn/intr.h linux/include/asm-ia64/sn/intr.h
--- linux-bak/include/asm-ia64/sn/intr.h	Thu Nov 15 16:10:17 2001
+++ linux/include/asm-ia64/sn/intr.h	Thu Nov 15 16:57:47 2001
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
diff -u -r linux-bak/include/asm-ia64/sn/ksys/elsc.h linux/include/asm-ia64/sn/ksys/elsc.h
--- linux-bak/include/asm-ia64/sn/ksys/elsc.h	Thu Nov 15 16:10:17 2001
+++ linux/include/asm-ia64/sn/ksys/elsc.h	Thu Nov 15 17:08:54 2001
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
diff -u -r linux-bak/include/asm-ia64/sn/ksys/i2c.h linux/include/asm-ia64/sn/ksys/i2c.h
--- linux-bak/include/asm-ia64/sn/ksys/i2c.h	Thu Nov 15 16:10:17 2001
+++ linux/include/asm-ia64/sn/ksys/i2c.h	Thu Nov 15 17:09:43 2001
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
diff -u -r linux-bak/include/asm-ia64/sn/labelcl.h linux/include/asm-ia64/sn/labelcl.h
--- linux-bak/include/asm-ia64/sn/labelcl.h	Thu Nov 15 16:10:17 2001
+++ linux/include/asm-ia64/sn/labelcl.h	Thu Nov 15 16:58:05 2001
@@ -12,7 +12,7 @@
 
 #define LABELCL_MAGIC 0x4857434c	/* 'HWLC' */
 #define LABEL_LENGTH_MAX 256		/* Includes NULL char */
-#define INFO_DESC_PRIVATE -1      	/* default */
+#define INFO_DESC_PRIVATE (-1)      	/* default */
 #define INFO_DESC_EXPORT  0       	/* export info itself */
 
 /*
diff -u -r linux-bak/include/asm-ia64/sn/pci/pciio.h linux/include/asm-ia64/sn/pci/pciio.h
--- linux-bak/include/asm-ia64/sn/pci/pciio.h	Thu Nov 15 16:10:17 2001
+++ linux/include/asm-ia64/sn/pci/pciio.h	Thu Nov 15 17:10:27 2001
@@ -29,11 +29,11 @@
 
 typedef int pciio_vendor_id_t;
 
-#define PCIIO_VENDOR_ID_NONE	-1
+#define PCIIO_VENDOR_ID_NONE	(-1)
 
 typedef int pciio_device_id_t;
 
-#define PCIIO_DEVICE_ID_NONE	-1
+#define PCIIO_DEVICE_ID_NONE	(-1)
 
 typedef uint8_t pciio_bus_t;       /* PCI bus number (0..255) */
 typedef uint8_t pciio_slot_t;      /* PCI slot number (0..31, 255) */
diff -u -r linux-bak/include/asm-ia64/sn/pio.h linux/include/asm-ia64/sn/pio.h
--- linux-bak/include/asm-ia64/sn/pio.h	Thu Nov 15 16:10:17 2001
+++ linux/include/asm-ia64/sn/pio.h	Thu Nov 15 16:58:26 2001
@@ -143,7 +143,7 @@
 #define LAN_RAM         2
 #define LAN_IO          3
 
-#define PIOREG_NULL	-1
+#define PIOREG_NULL	(-1)
 
 /* standard flags values for pio_map routines,
  * including {xtalk,pciio}_piomap calls.
diff -u -r linux-bak/include/asm-ia64/sn/prio.h linux/include/asm-ia64/sn/prio.h
--- linux-bak/include/asm-ia64/sn/prio.h	Thu Nov 15 16:10:18 2001
+++ linux/include/asm-ia64/sn/prio.h	Thu Nov 15 16:58:40 2001
@@ -33,6 +33,6 @@
 
 /* Error returns */
 #define PRIO_SUCCESS     0
-#define PRIO_FAIL       -1 
+#define PRIO_FAIL       (-1)
 
 #endif /* _ASM_SN_PRIO_H */
diff -u -r linux-bak/include/asm-ia64/sn/sn1/ip27config.h linux/include/asm-ia64/sn/sn1/ip27config.h
--- linux-bak/include/asm-ia64/sn/sn1/ip27config.h	Thu Nov 15 16:10:18 2001
+++ linux/include/asm-ia64/sn/sn1/ip27config.h	Thu Nov 15 17:11:03 2001
@@ -258,7 +258,7 @@
  */
 
 /* these numbers are as the are ordered in the table below */
-#define	IP27_CONFIG_UNKNOWN -1
+#define	IP27_CONFIG_UNKNOWN (-1)
 #define IP27_CONFIG_SN1_1MB_200_400_200_TABLE 0
 #define IP27_CONFIG_SN00_4MB_100_200_133_TABLE 1
 #define IP27_CONFIG_SN1_4MB_200_400_267_TABLE 2
diff -u -r linux-bak/include/asm-ia64/sn/sn1/kldir.h linux/include/asm-ia64/sn/sn1/kldir.h
--- linux-bak/include/asm-ia64/sn/sn1/kldir.h	Thu Nov 15 16:10:18 2001
+++ linux/include/asm-ia64/sn/sn1/kldir.h	Thu Nov 15 17:11:26 2001
@@ -193,7 +193,7 @@
 #define IP27_SYMMON_STK_STRIDE		0x8000
 
 #define IP27_FREEMEM_OFFSET		0x40000
-#define IP27_FREEMEM_SIZE		-1
+#define IP27_FREEMEM_SIZE		(-1)
 #define IP27_FREEMEM_COUNT		1
 #define IP27_FREEMEM_STRIDE		0
 
diff -u -r linux-bak/include/asm-ia64/sn/sn1/promlog.h linux/include/asm-ia64/sn/sn1/promlog.h
--- linux-bak/include/asm-ia64/sn/sn1/promlog.h	Thu Nov 15 16:10:18 2001
+++ linux/include/asm-ia64/sn/sn1/promlog.h	Thu Nov 15 17:12:18 2001
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
diff -u -r linux-bak/include/asm-ia64/sn/vector.h linux/include/asm-ia64/sn/vector.h
--- linux-bak/include/asm-ia64/sn/vector.h	Thu Nov 15 16:10:18 2001
+++ linux/include/asm-ia64/sn/vector.h	Thu Nov 15 16:59:22 2001
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
diff -u -r linux-bak/include/asm-ia64/sn/xtalk/xtalk.h linux/include/asm-ia64/sn/xtalk/xtalk.h
--- linux-bak/include/asm-ia64/sn/xtalk/xtalk.h	Thu Nov 15 16:10:19 2001
+++ linux/include/asm-ia64/sn/xtalk/xtalk.h	Thu Nov 15 17:12:49 2001
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
 
diff -u -r linux-bak/include/asm-m68k/bvme6000hw.h linux/include/asm-m68k/bvme6000hw.h
--- linux-bak/include/asm-m68k/bvme6000hw.h	Thu Nov 15 16:09:59 2001
+++ linux/include/asm-m68k/bvme6000hw.h	Thu Nov 15 16:20:03 2001
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
diff -u -r linux-bak/include/asm-m68k/mc146818rtc.h linux/include/asm-m68k/mc146818rtc.h
--- linux-bak/include/asm-m68k/mc146818rtc.h	Thu Nov 15 16:09:59 2001
+++ linux/include/asm-m68k/mc146818rtc.h	Thu Nov 15 16:21:01 2001
@@ -33,7 +33,7 @@
 /* On Atari, the year was stored with base 1970 in old TOS versions (before
  * 3.06). Later, Atari recognized that this broke leap year recognition, and
  * changed the base to 1968. Medusa and Hades always use the new version. */
-#define RTC_CENTURY_SWITCH	-1	/* no century switch */
+#define RTC_CENTURY_SWITCH	(-1)	/* no century switch */
 #define RTC_MINYEAR		epoch
 
 #define CMOS_READ(addr) ({ \
diff -u -r linux-bak/include/asm-m68k/siginfo.h linux/include/asm-m68k/siginfo.h
--- linux-bak/include/asm-m68k/siginfo.h	Thu Nov 15 16:09:58 2001
+++ linux/include/asm-m68k/siginfo.h	Thu Nov 15 16:21:33 2001
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
diff -u -r linux-bak/include/asm-m68k/swim_iop.h linux/include/asm-m68k/swim_iop.h
--- linux-bak/include/asm-m68k/swim_iop.h	Thu Nov 15 16:09:59 2001
+++ linux/include/asm-m68k/swim_iop.h	Thu Nov 15 16:22:28 2001
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
 
diff -u -r linux-bak/include/asm-mips/asm.h linux/include/asm-mips/asm.h
--- linux-bak/include/asm-mips/asm.h	Thu Nov 15 16:09:55 2001
+++ linux/include/asm-mips/asm.h	Thu Nov 15 16:23:16 2001
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
diff -u -r linux-bak/include/asm-mips/processor.h linux/include/asm-mips/processor.h
--- linux-bak/include/asm-mips/processor.h	Thu Nov 15 16:09:55 2001
+++ linux/include/asm-mips/processor.h	Thu Nov 15 16:24:34 2001
@@ -51,7 +51,7 @@
 extern struct mips_cpuinfo cpu_data[];
 #define current_cpu_data cpu_data[smp_processor_id()]
 #else
-#define cpu_data &boot_cpu_data
+#define cpu_data (&boot_cpu_data)
 #define current_cpu_data boot_cpu_data
 #endif
 
diff -u -r linux-bak/include/asm-mips/siginfo.h linux/include/asm-mips/siginfo.h
--- linux-bak/include/asm-mips/siginfo.h	Thu Nov 15 16:09:56 2001
+++ linux/include/asm-mips/siginfo.h	Thu Nov 15 16:25:05 2001
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
diff -u -r linux-bak/include/asm-mips64/asm.h linux/include/asm-mips64/asm.h
--- linux-bak/include/asm-mips64/asm.h	Thu Nov 15 16:10:19 2001
+++ linux/include/asm-mips64/asm.h	Thu Nov 15 16:25:58 2001
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
diff -u -r linux-bak/include/asm-mips64/siginfo.h linux/include/asm-mips64/siginfo.h
--- linux-bak/include/asm-mips64/siginfo.h	Thu Nov 15 16:10:20 2001
+++ linux/include/asm-mips64/siginfo.h	Thu Nov 15 16:25:35 2001
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
diff -u -r linux-bak/include/asm-mips64/sn/kldir.h linux/include/asm-mips64/sn/kldir.h
--- linux-bak/include/asm-mips64/sn/kldir.h	Thu Nov 15 16:10:20 2001
+++ linux/include/asm-mips64/sn/kldir.h	Thu Nov 15 17:00:07 2001
@@ -180,7 +180,7 @@
 #define IP27_SYMMON_STK_STRIDE		0x7000
 
 #define IP27_FREEMEM_OFFSET		0x19000
-#define IP27_FREEMEM_SIZE		-1
+#define IP27_FREEMEM_SIZE		(-1)
 #define IP27_FREEMEM_COUNT		1
 #define IP27_FREEMEM_STRIDE		0
 
diff -u -r linux-bak/include/asm-mips64/xtalk/xtalk.h linux/include/asm-mips64/xtalk/xtalk.h
--- linux-bak/include/asm-mips64/xtalk/xtalk.h	Thu Nov 15 16:10:20 2001
+++ linux/include/asm-mips64/xtalk/xtalk.h	Thu Nov 15 17:00:44 2001
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
 
diff -u -r linux-bak/include/asm-parisc/pdc.h linux/include/asm-parisc/pdc.h
--- linux-bak/include/asm-parisc/pdc.h	Thu Nov 15 16:10:22 2001
+++ linux/include/asm-parisc/pdc.h	Thu Nov 15 16:30:34 2001
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
 
diff -u -r linux-bak/include/asm-parisc/siginfo.h linux/include/asm-parisc/siginfo.h
--- linux-bak/include/asm-parisc/siginfo.h	Thu Nov 15 16:10:22 2001
+++ linux/include/asm-parisc/siginfo.h	Thu Nov 15 16:30:56 2001
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
diff -u -r linux-bak/include/asm-ppc/dma.h linux/include/asm-ppc/dma.h
--- linux-bak/include/asm-ppc/dma.h	Thu Nov 15 16:10:03 2001
+++ linux/include/asm-ppc/dma.h	Thu Nov 15 16:31:36 2001
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
diff -u -r linux-bak/include/asm-ppc/io.h linux/include/asm-ppc/io.h
--- linux-bak/include/asm-ppc/io.h	Thu Nov 15 16:10:03 2001
+++ linux/include/asm-ppc/io.h	Thu Nov 15 16:31:48 2001
@@ -175,7 +175,7 @@
 #define outsl_ns(port, buf, nl)	_outsl_ns((u32 *)((port)+_IO_BASE), (buf), (nl))
 
 
-#define IO_SPACE_LIMIT ~0
+#define IO_SPACE_LIMIT (~0)
 
 #define memset_io(a,b,c)       memset((void *)(a),(b),(c))
 #define memcpy_fromio(a,b,c)   memcpy((a),(void *)(b),(c))
diff -u -r linux-bak/include/asm-ppc/siginfo.h linux/include/asm-ppc/siginfo.h
--- linux-bak/include/asm-ppc/siginfo.h	Thu Nov 15 16:10:04 2001
+++ linux/include/asm-ppc/siginfo.h	Thu Nov 15 16:32:20 2001
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
diff -u -r linux-bak/include/asm-s390/debug.h linux/include/asm-s390/debug.h
--- linux-bak/include/asm-s390/debug.h	Thu Nov 15 16:10:22 2001
+++ linux/include/asm-s390/debug.h	Thu Nov 15 16:33:59 2001
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
diff -u -r linux-bak/include/asm-s390/siginfo.h linux/include/asm-s390/siginfo.h
--- linux-bak/include/asm-s390/siginfo.h	Thu Nov 15 16:10:21 2001
+++ linux/include/asm-s390/siginfo.h	Thu Nov 15 16:34:46 2001
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
diff -u -r linux-bak/include/asm-sh/siginfo.h linux/include/asm-sh/siginfo.h
--- linux-bak/include/asm-sh/siginfo.h	Thu Nov 15 16:10:14 2001
+++ linux/include/asm-sh/siginfo.h	Thu Nov 15 16:35:33 2001
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
diff -u -r linux-bak/include/asm-sparc/fbio.h linux/include/asm-sparc/fbio.h
--- linux-bak/include/asm-sparc/fbio.h	Thu Nov 15 16:10:00 2001
+++ linux/include/asm-sparc/fbio.h	Thu Nov 15 16:35:56 2001
@@ -5,7 +5,7 @@
 /* (C) 1996 Miguel de Icaza */
 
 /* Frame buffer types */
-#define FBTYPE_NOTYPE           -1
+#define FBTYPE_NOTYPE           (-1)
 #define FBTYPE_SUN1BW           0   /* mono */
 #define FBTYPE_SUN1COLOR        1 
 #define FBTYPE_SUN2BW           2 
diff -u -r linux-bak/include/asm-sparc/pgtable.h linux/include/asm-sparc/pgtable.h
--- linux-bak/include/asm-sparc/pgtable.h	Thu Nov 15 16:10:00 2001
+++ linux/include/asm-sparc/pgtable.h	Thu Nov 15 16:36:20 2001
@@ -392,7 +392,7 @@
 extern struct ctx_list ctx_free;        /* Head of free list */
 extern struct ctx_list ctx_used;        /* Head of used contexts list */
 
-#define NO_CONTEXT     -1
+#define NO_CONTEXT     (-1)
 
 extern __inline__ void remove_from_ctx_list(struct ctx_list *entry)
 {
diff -u -r linux-bak/include/asm-sparc/siginfo.h linux/include/asm-sparc/siginfo.h
--- linux-bak/include/asm-sparc/siginfo.h	Thu Nov 15 16:10:01 2001
+++ linux/include/asm-sparc/siginfo.h	Thu Nov 15 16:36:41 2001
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
diff -u -r linux-bak/include/asm-sparc64/fbio.h linux/include/asm-sparc64/fbio.h
--- linux-bak/include/asm-sparc64/fbio.h	Thu Nov 15 16:10:05 2001
+++ linux/include/asm-sparc64/fbio.h	Thu Nov 15 16:37:34 2001
@@ -5,7 +5,7 @@
 /* (C) 1996 Miguel de Icaza */
 
 /* Frame buffer types */
-#define FBTYPE_NOTYPE           -1
+#define FBTYPE_NOTYPE           (-1)
 #define FBTYPE_SUN1BW           0   /* mono */
 #define FBTYPE_SUN1COLOR        1 
 #define FBTYPE_SUN2BW           2 
diff -u -r linux-bak/include/asm-sparc64/siginfo.h linux/include/asm-sparc64/siginfo.h
--- linux-bak/include/asm-sparc64/siginfo.h	Thu Nov 15 16:10:06 2001
+++ linux/include/asm-sparc64/siginfo.h	Thu Nov 15 16:37:18 2001
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
diff -u -r linux-bak/include/linux/amigaffs.h linux/include/linux/amigaffs.h
--- linux-bak/include/linux/amigaffs.h	Thu Nov 15 16:09:47 2001
+++ linux/include/linux/amigaffs.h	Thu Nov 15 16:39:07 2001
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
diff -u -r linux-bak/include/linux/atm.h linux/include/linux/atm.h
--- linux-bak/include/linux/atm.h	Thu Nov 15 16:09:47 2001
+++ linux/include/linux/atm.h	Thu Nov 15 16:39:40 2001
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
diff -u -r linux-bak/include/linux/atmdev.h linux/include/linux/atmdev.h
--- linux-bak/include/linux/atmdev.h	Thu Nov 15 16:09:50 2001
+++ linux/include/linux/atmdev.h	Thu Nov 15 16:39:52 2001
@@ -152,7 +152,7 @@
 
 /* for ATM_GETCIRANGE / ATM_SETCIRANGE */
 
-#define ATM_CI_MAX      -1              /* use maximum range of VPI/VCI */
+#define ATM_CI_MAX      (-1)              /* use maximum range of VPI/VCI */
  
 struct atm_cirange {
 	char	vpi_bits;		/* 1..8, ATM_CI_MAX (-1) for maximum */
diff -u -r linux-bak/include/linux/cdk.h linux/include/linux/cdk.h
--- linux-bak/include/linux/cdk.h	Thu Nov 15 16:09:46 2001
+++ linux/include/linux/cdk.h	Thu Nov 15 16:40:15 2001
@@ -200,8 +200,8 @@
 #define	FLUSHRX		0x1
 #define	FLUSHTX		0x2
 
-#define	BREAKON		-1
-#define	BREAKOFF	-2
+#define	BREAKON		(-1)
+#define	BREAKOFF	(-2)
 
 /*
  *	Define the port setting structure, and all those defines that go along
diff -u -r linux-bak/include/linux/coda.h linux/include/linux/coda.h
--- linux-bak/include/linux/coda.h	Thu Nov 15 16:09:47 2001
+++ linux/include/linux/coda.h	Thu Nov 15 16:40:59 2001
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
 
 
diff -u -r linux-bak/include/linux/compatmac.h linux/include/linux/compatmac.h
--- linux-bak/include/linux/compatmac.h	Thu Nov 15 16:09:51 2001
+++ linux/include/linux/compatmac.h	Thu Nov 15 16:41:28 2001
@@ -114,8 +114,8 @@
 #define test_and_clear_bit(nr, addr) clear_bit(nr, addr)
 
 /* Not yet implemented on 2.0 */
-#define ASYNC_SPD_SHI  -1
-#define ASYNC_SPD_WARP -1
+#define ASYNC_SPD_SHI  (-1)
+#define ASYNC_SPD_WARP (-1)
 
 
 /* Ugly hack: the driver_name doesn't exist in 2.0.x . So we define it
diff -u -r linux-bak/include/linux/ext2_fs.h linux/include/linux/ext2_fs.h
--- linux-bak/include/linux/ext2_fs.h	Thu Nov 15 16:09:46 2001
+++ linux/include/linux/ext2_fs.h	Thu Nov 15 16:41:53 2001
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
diff -u -r linux-bak/include/linux/ftape.h linux/include/linux/ftape.h
--- linux-bak/include/linux/ftape.h	Thu Nov 15 16:09:45 2001
+++ linux/include/linux/ftape.h	Thu Nov 15 16:42:57 2001
@@ -84,7 +84,7 @@
 #define FT_RQM_DELAY    12
 #define FT_MILLISECOND  1
 #define FT_SECOND       1000
-#define FT_FOREVER      -1
+#define FT_FOREVER      (-1)
 #ifndef HZ
 #error "HZ undefined."
 #endif
diff -u -r linux-bak/include/linux/i2o.h linux/include/linux/i2o.h
--- linux-bak/include/linux/i2o.h	Thu Nov 15 16:09:47 2001
+++ linux/include/linux/i2o.h	Thu Nov 15 16:43:28 2001
@@ -588,7 +588,7 @@
 #define MSG_POOL_SIZE		16384
 
 #define I2O_POST_WAIT_OK	0
-#define I2O_POST_WAIT_TIMEOUT	-ETIMEDOUT
+#define I2O_POST_WAIT_TIMEOUT	(-ETIMEDOUT)
 
 #endif /* __KERNEL__ */
 #endif /* _I2O_H */
diff -u -r linux-bak/include/linux/ipsec.h linux/include/linux/ipsec.h
--- linux-bak/include/linux/ipsec.h	Thu Nov 15 16:09:48 2001
+++ linux/include/linux/ipsec.h	Thu Nov 15 16:43:52 2001
@@ -23,7 +23,7 @@
 /* These defines are compatible with NRL IPv6, however their semantics
    is different */
 
-#define IPSEC_LEVEL_NONE	-1	/* send plaintext, accept any */
+#define IPSEC_LEVEL_NONE	(-1)	/* send plaintext, accept any */
 #define IPSEC_LEVEL_DEFAULT	0	/* encrypt/authenticate if possible */
 					/* the default MUST be 0, because a */
 					/* socket is initialized with 0's */
diff -u -r linux-bak/include/linux/lp.h linux/include/linux/lp.h
--- linux-bak/include/linux/lp.h	Thu Nov 15 16:09:45 2001
+++ linux/include/linux/lp.h	Thu Nov 15 16:44:32 2001
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
diff -u -r linux-bak/include/linux/lvm.h linux/include/linux/lvm.h
--- linux-bak/include/linux/lvm.h	Thu Nov 15 16:09:51 2001
+++ linux/include/linux/lvm.h	Thu Nov 15 16:44:59 2001
@@ -228,7 +228,7 @@
 #define	LVM_SNAPSHOT_DEF_CHUNK	64	/* 64  KB */
 #define	LVM_SNAPSHOT_MIN_CHUNK	(PAGE_SIZE/1024)	/* 4 or 8 KB */
 
-#define	UNDEF	-1
+#define	UNDEF	(-1)
 
 /*
  * ioctls
diff -u -r linux-bak/include/linux/n_r3964.h linux/include/linux/n_r3964.h
--- linux-bak/include/linux/n_r3964.h	Thu Nov 15 16:09:50 2001
+++ linux/include/linux/n_r3964.h	Thu Nov 15 16:45:30 2001
@@ -124,8 +124,8 @@
 
 /* error codes for client messages */
 #define R3964_OK 0        /* no error. */
-#define R3964_TX_FAIL -1  /* transmission error, block NOT sent */
-#define R3964_OVERFLOW -2 /* msg queue overflow */
+#define R3964_TX_FAIL (-1)  /* transmission error, block NOT sent */
+#define R3964_OVERFLOW (-2) /* msg queue overflow */
 
 /* the client gets this struct when calling read(fd,...): */
 struct r3964_client_message {
diff -u -r linux-bak/include/linux/parport.h linux/include/linux/parport.h
--- linux-bak/include/linux/parport.h	Thu Nov 15 16:09:48 2001
+++ linux/include/linux/parport.h	Thu Nov 15 16:45:58 2001
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
diff -u -r linux-bak/include/linux/phonedev.h linux/include/linux/phonedev.h
--- linux-bak/include/linux/phonedev.h	Thu Nov 15 16:09:51 2001
+++ linux/include/linux/phonedev.h	Thu Nov 15 16:46:54 2001
@@ -19,7 +19,7 @@
 extern int phonedev_init(void);
 #define PHONE_MAJOR	100
 extern int phone_register_device(struct phone_device *, int unit);
-#define PHONE_UNIT_ANY	-1
+#define PHONE_UNIT_ANY	(-1)
 extern void phone_unregister_device(struct phone_device *);
 
 #endif
diff -u -r linux-bak/include/linux/pmu.h linux/include/linux/pmu.h
--- linux-bak/include/linux/pmu.h	Thu Nov 15 16:09:51 2001
+++ linux/include/linux/pmu.h	Thu Nov 15 16:47:18 2001
@@ -164,7 +164,7 @@
 
 /* Result codes returned by the notifiers */
 #define PBOOK_SLEEP_OK		0
-#define PBOOK_SLEEP_REFUSE	-1
+#define PBOOK_SLEEP_REFUSE	(-1)
 
 /* priority levels in notifiers */
 #define SLEEP_LEVEL_VIDEO	100	/* Video driver (first wake) */
diff -u -r linux-bak/include/linux/ppp-comp.h linux/include/linux/ppp-comp.h
--- linux-bak/include/linux/ppp-comp.h	Thu Nov 15 16:09:47 2001
+++ linux/include/linux/ppp-comp.h	Thu Nov 15 16:47:41 2001
@@ -120,8 +120,8 @@
  * Don't you just lurve software patents.
  */
 
-#define DECOMP_ERROR		-1	/* error detected before decomp. */
-#define DECOMP_FATALERROR	-2	/* error detected after decomp. */
+#define DECOMP_ERROR		(-1)	/* error detected before decomp. */
+#define DECOMP_FATALERROR	(-2)	/* error detected after decomp. */
 
 /*
  * CCP codes.
diff -u -r linux-bak/include/linux/ps2esdi.h linux/include/linux/ps2esdi.h
--- linux-bak/include/linux/ps2esdi.h	Thu Nov 15 16:09:48 2001
+++ linux/include/linux/ps2esdi.h	Thu Nov 15 16:49:00 2001
@@ -86,7 +86,7 @@
 #define HDIO_GETGEO 0x0301
 
 #define FALSE 0
-#define TRUE !FALSE
+#define TRUE 1  /* these are stupid macros. */
 
 struct ps2esdi_geometry {
 	unsigned char heads;
diff -u -r linux-bak/include/linux/reiserfs_fs.h linux/include/linux/reiserfs_fs.h
--- linux-bak/include/linux/reiserfs_fs.h	Thu Nov 15 16:09:52 2001
+++ linux/include/linux/reiserfs_fs.h	Thu Nov 15 16:50:34 2001
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
diff -u -r linux-bak/include/linux/sdla.h linux/include/linux/sdla.h
--- linux-bak/include/linux/sdla.h	Thu Nov 15 16:09:47 2001
+++ linux/include/linux/sdla.h	Thu Nov 15 16:50:49 2001
@@ -31,7 +31,7 @@
 #define SDLA_S507			5070
 #define SDLA_S508			5080
 #define SDLA_S509			5090
-#define SDLA_UNKNOWN			-1
+#define SDLA_UNKNOWN			(-1)
 
 /* port selection flags for the S508 */
 #define SDLA_S508_PORT_V35		0x00
diff -u -r linux-bak/include/linux/sysctl.h linux/include/linux/sysctl.h
--- linux-bak/include/linux/sysctl.h	Thu Nov 15 16:09:46 2001
+++ linux/include/linux/sysctl.h	Thu Nov 15 16:51:08 2001
@@ -48,7 +48,7 @@
 
 /* For internal pattern-matching use only: */
 #ifdef __KERNEL__
-#define CTL_ANY		-1	/* Matches any name */
+#define CTL_ANY		(-1)	/* Matches any name */
 #define CTL_NONE	0
 #endif
 
diff -u -r linux-bak/include/linux/ufs_fs.h linux/include/linux/ufs_fs.h
--- linux-bak/include/linux/ufs_fs.h	Thu Nov 15 16:09:45 2001
+++ linux/include/linux/ufs_fs.h	Thu Nov 15 16:52:45 2001
@@ -118,7 +118,7 @@
 #define UFS_CG_SUN		0x00001000
 
 /* fs_inodefmt options */
-#define UFS_42INODEFMT	-1
+#define UFS_42INODEFMT	(-1)
 #define UFS_44INODEFMT	2
 
 /* mount options */
@@ -138,8 +138,8 @@
 #define UFS_MOUNT_UFSTYPE_SUNx86	0x00000400
 #define UFS_MOUNT_UFSTYPE_HP	        0x00000800
 
-#define ufs_clear_opt(o,opt)	o &= ~UFS_MOUNT_##opt
-#define ufs_set_opt(o,opt)	o |= UFS_MOUNT_##opt
+#define ufs_clear_opt(o,opt)	((o) &= ~UFS_MOUNT_##opt)
+#define ufs_set_opt(o,opt)	((o) |= UFS_MOUNT_##opt)
 #define ufs_test_opt(o,opt)	((o) & UFS_MOUNT_##opt)
 
 /*
@@ -390,7 +390,7 @@
 /*
  * Rotational layout table format types
  */
-#define UFS_42POSTBLFMT		-1	/* 4.2BSD rotational table format */
+#define UFS_42POSTBLFMT		(-1)	/* 4.2BSD rotational table format */
 #define UFS_DYNAMICPOSTBLFMT	1	/* dynamic rotational table format */
 
 /*
diff -u -r linux-bak/include/linux/videodev.h linux/include/linux/videodev.h
--- linux-bak/include/linux/videodev.h	Thu Nov 15 16:09:49 2001
+++ linux/include/linux/videodev.h	Thu Nov 15 16:53:14 2001
@@ -176,7 +176,7 @@
 	int	clipcount;
 #define VIDEO_WINDOW_INTERLACE	1
 #define VIDEO_WINDOW_CHROMAKEY	16	/* Overlay by chromakey */
-#define VIDEO_CLIP_BITMAP	-1
+#define VIDEO_CLIP_BITMAP	(-1)
 /* bitmap is 1024x625, a '1' bit represents a clipped pixel */
 #define VIDEO_CLIPMAP_SIZE	(128 * 625)
 };
diff -u -r linux-bak/include/linux/watchdog.h linux/include/linux/watchdog.h
--- linux-bak/include/linux/watchdog.h	Thu Nov 15 16:09:48 2001
+++ linux/include/linux/watchdog.h	Thu Nov 15 16:53:33 2001
@@ -27,8 +27,8 @@
 #define	WDIOC_KEEPALIVE		_IOR(WATCHDOG_IOCTL_BASE, 5, int)
 #define	WDIOC_SETTIMEOUT        _IOW(WATCHDOG_IOCTL_BASE, 6, int)
 
-#define	WDIOF_UNKNOWN		-1	/* Unknown flag error */
-#define	WDIOS_UNKNOWN		-1	/* Unknown status error */
+#define	WDIOF_UNKNOWN		(-1)	/* Unknown flag error */
+#define	WDIOS_UNKNOWN		(-1)	/* Unknown status error */
 
 #define	WDIOF_OVERHEAT		0x0001	/* Reset due to CPU overheat */
 #define	WDIOF_FANFAULT		0x0002	/* Fan failed */
diff -u -r linux-bak/include/net/irda/irlap.h linux/include/net/irda/irlap.h
--- linux-bak/include/net/irda/irlap.h	Thu Nov 15 16:10:02 2001
+++ linux/include/net/irda/irlap.h	Thu Nov 15 17:01:15 2001
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
diff -u -r linux-bak/include/net/irda/nsc-ircc.h linux/include/net/irda/nsc-ircc.h
--- linux-bak/include/net/irda/nsc-ircc.h	Thu Nov 15 16:10:02 2001
+++ linux/include/net/irda/nsc-ircc.h	Thu Nov 15 17:01:33 2001
@@ -101,7 +101,7 @@
 #define BANK7     	0xf4
 
 #define MCR		0x04 /* Mode Control Register */
-#define MCR_MODE_MASK	~(0xd0)
+#define MCR_MODE_MASK	(~0xd0)
 #define MCR_UART        0x00
 #define MCR_RESERVED  	0x20	
 #define MCR_SHARP_IR    0x40
diff -u -r linux-bak/include/net/irda/w83977af_ir.h linux/include/net/irda/w83977af_ir.h
--- linux-bak/include/net/irda/w83977af_ir.h	Thu Nov 15 16:10:02 2001
+++ linux/include/net/irda/w83977af_ir.h	Thu Nov 15 17:02:01 2001
@@ -78,7 +78,7 @@
 #define SET7	        0xF4
 
 #define HCR		0x04
-#define HCR_MODE_MASK	~(0xD0)
+#define HCR_MODE_MASK	(~0xD0)
 #define HCR_SIR         0x60
 #define HCR_MIR_576  	0x20	
 #define HCR_MIR_1152	0x80
diff -u -r linux-bak/include/scsi/sg.h linux/include/scsi/sg.h
--- linux-bak/include/scsi/sg.h	Thu Nov 15 16:10:05 2001
+++ linux/include/scsi/sg.h	Thu Nov 15 16:54:37 2001
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
diff -u -r linux-bak/include/video/macmodes.h linux/include/video/macmodes.h
--- linux-bak/include/video/macmodes.h	Thu Nov 15 16:10:14 2001
+++ linux/include/video/macmodes.h	Thu Nov 15 16:55:05 2001
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
