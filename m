Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262317AbVEYHL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262317AbVEYHL0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 03:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbVEYHKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 03:10:20 -0400
Received: from smtp816.mail.sc5.yahoo.com ([66.163.170.2]:19629 "HELO
	smtp816.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262326AbVEYHHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 03:07:09 -0400
Message-Id: <20050525064005.969605000.dtor_core@ameritech.net>
References: <20050525063738.864916000.dtor_core@ameritech.net>
Date: Wed, 25 May 2005 01:37:42 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: irda-users@lists.sourceforge.net
Cc: Jean Tourrilhes <jt@hpl.hp.com>, linux-kernel@vger.kernel.org
Subject: [patch 4/9] smsc-ircc2: remove typedefs
Content-Disposition: inline; filename=ircc2-remove-typedef.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IRDA: smsc-ircc2 - remove excessive typedefs.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 smsc-ircc2.c |   39 +++++++++++++--------------------------
 1 files changed, 13 insertions(+), 26 deletions(-)

Index: dtor/drivers/net/irda/smsc-ircc2.c
===================================================================
--- dtor.orig/drivers/net/irda/smsc-ircc2.c
+++ dtor/drivers/net/irda/smsc-ircc2.c
@@ -105,17 +105,6 @@ struct smsc_transceiver {
 	void (*set_for_speed)(int fir_base, u32 speed);
 	int  (*probe)(int fir_base);
 };
-typedef struct smsc_transceiver smsc_transceiver_t;
-
-#if 0
-struct smc_chip {
-	char *name;
-	u16 flags;
-	u8 devid;
-	u8 rev;
-};
-typedef struct smc_chip smc_chip_t;
-#endif
 
 struct smsc_chip {
 	char *name;
@@ -126,13 +115,11 @@ struct smsc_chip {
 	u8 devid;
 	u8 rev;
 };
-typedef struct smsc_chip smsc_chip_t;
 
 struct smsc_chip_address {
 	unsigned int cfg_base;
 	unsigned int type;
 };
-typedef struct smsc_chip_address smsc_chip_address_t;
 
 /* Private data for each instance */
 struct smsc_ircc_cb {
@@ -208,9 +195,9 @@ static void smsc_ircc_sir_wait_hw_transm
 
 /* Probing */
 static int __init smsc_ircc_look_for_chips(void);
-static const smsc_chip_t * __init smsc_ircc_probe(unsigned short cfg_base, u8 reg, const smsc_chip_t *chip, char *type);
-static int __init smsc_superio_flat(const smsc_chip_t *chips, unsigned short cfg_base, char *type);
-static int __init smsc_superio_paged(const smsc_chip_t *chips, unsigned short cfg_base, char *type);
+static const struct smsc_chip * __init smsc_ircc_probe(unsigned short cfg_base, u8 reg, const struct smsc_chip *chip, char *type);
+static int __init smsc_superio_flat(const struct smsc_chip *chips, unsigned short cfg_base, char *type);
+static int __init smsc_superio_paged(const struct smsc_chip *chips, unsigned short cfg_base, char *type);
 static int __init smsc_superio_fdc(unsigned short cfg_base);
 static int __init smsc_superio_lpc(unsigned short cfg_base);
 
@@ -232,7 +219,7 @@ static int smsc_ircc_pmproc(struct pm_de
 
 /* Transceivers for SMSC-ircc */
 
-static smsc_transceiver_t smsc_transceivers[] =
+static struct smsc_transceiver smsc_transceivers[] =
 {
 	{ "Toshiba Satellite 1800 (GP data pin select)", smsc_ircc_set_transceiver_toshiba_sat1800, smsc_ircc_probe_transceiver_toshiba_sat1800 },
 	{ "Fast pin select", smsc_ircc_set_transceiver_smsc_ircc_fast_pin_select, smsc_ircc_probe_transceiver_smsc_ircc_fast_pin_select },
@@ -250,7 +237,7 @@ static smsc_transceiver_t smsc_transceiv
 #define	FIR	4	/* SuperIO Chip has fast IRDA */
 #define	SERx4	8	/* SuperIO Chip supports 115,2 KBaud * 4=460,8 KBaud */
 
-static smsc_chip_t __initdata fdc_chips_flat[] =
+static struct smsc_chip __initdata fdc_chips_flat[] =
 {
 	/* Base address 0x3f0 or 0x370 */
 	{ "37C44",	KEY55_1|NoIRDA,		0x00, 0x00 }, /* This chip cannot be detected */
@@ -264,7 +251,7 @@ static smsc_chip_t __initdata fdc_chips_
 	{ NULL }
 };
 
-static smsc_chip_t __initdata fdc_chips_paged[] =
+static struct smsc_chip __initdata fdc_chips_paged[] =
 {
 	/* Base address 0x3f0 or 0x370 */
 	{ "37B72X",	KEY55_1|SIR|SERx4,	0x4c, 0x00 },
@@ -283,7 +270,7 @@ static smsc_chip_t __initdata fdc_chips_
 	{ NULL }
 };
 
-static smsc_chip_t __initdata lpc_chips_flat[] =
+static struct smsc_chip __initdata lpc_chips_flat[] =
 {
 	/* Base address 0x2E or 0x4E */
 	{ "47N227",	KEY55_1|FIR|SERx4,	0x5a, 0x00 },
@@ -291,7 +278,7 @@ static smsc_chip_t __initdata lpc_chips_
 	{ NULL }
 };
 
-static smsc_chip_t __initdata lpc_chips_paged[] =
+static struct smsc_chip __initdata lpc_chips_paged[] =
 {
 	/* Base address 0x2E or 0x4E */
 	{ "47B27X",	KEY55_1|SIR|SERx4,	0x51, 0x00 },
@@ -310,7 +297,7 @@ static smsc_chip_t __initdata lpc_chips_
 #define SMSCSIO_TYPE_FLAT	4
 #define SMSCSIO_TYPE_PAGED	8
 
-static smsc_chip_address_t __initdata possible_addresses[] =
+static struct smsc_chip_address __initdata possible_addresses[] =
 {
 	{ 0x3f0, SMSCSIO_TYPE_FDC|SMSCSIO_TYPE_FLAT|SMSCSIO_TYPE_PAGED },
 	{ 0x370, SMSCSIO_TYPE_FDC|SMSCSIO_TYPE_FLAT|SMSCSIO_TYPE_PAGED },
@@ -2012,7 +1999,7 @@ static void smsc_ircc_sir_wait_hw_transm
 
 static int __init smsc_ircc_look_for_chips(void)
 {
-	smsc_chip_address_t *address;
+	struct smsc_chip_address *address;
 	char *type;
 	unsigned int cfg_base, found;
 
@@ -2055,7 +2042,7 @@ static int __init smsc_ircc_look_for_chi
  *    Try to get configuration of a smc SuperIO chip with flat register model
  *
  */
-static int __init smsc_superio_flat(const smsc_chip_t *chips, unsigned short cfgbase, char *type)
+static int __init smsc_superio_flat(const struct smsc_chip *chips, unsigned short cfgbase, char *type)
 {
 	unsigned short firbase, sirbase;
 	u8 mode, dma, irq;
@@ -2106,7 +2093,7 @@ static int __init smsc_superio_flat(cons
  *    Try  to get configuration of a smc SuperIO chip with paged register model
  *
  */
-static int __init smsc_superio_paged(const smsc_chip_t *chips, unsigned short cfg_base, char *type)
+static int __init smsc_superio_paged(const struct smsc_chip *chips, unsigned short cfg_base, char *type)
 {
 	unsigned short fir_io, sir_io;
 	int ret = -ENODEV;
@@ -2151,7 +2138,7 @@ static int __init smsc_access(unsigned s
 	return inb(cfg_base) != reg ? -1 : 0;
 }
 
-static const smsc_chip_t * __init smsc_ircc_probe(unsigned short cfg_base, u8 reg, const smsc_chip_t *chip, char *type)
+static const struct smsc_chip * __init smsc_ircc_probe(unsigned short cfg_base, u8 reg, const struct smsc_chip *chip, char *type)
 {
 	u8 devid, xdevid, rev;
 

