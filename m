Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbUE1L43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbUE1L43 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 07:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbUE1L42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 07:56:28 -0400
Received: from mail.donpac.ru ([80.254.111.2]:33204 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S262020AbUE1Lz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 07:55:26 -0400
Subject: [PATCH 0/13] 2.6.7-rc1-mm1, Simplify DMI matching data
In-Reply-To: 
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 28 May 2004 15:55:22 +0400
Message-Id: <10857453222105@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

simplify DMI blacklist table by removing the need to fill
unused slots with NO_MATCH macro.

diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.7-rc1-mm1/arch/i386/kernel/dmi_scan.c
--- linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/dmi_scan.c	Wed Apr 28 22:56:08 2004
+++ linux-2.6.7-rc1-mm1/arch/i386/kernel/dmi_scan.c	Wed Apr 28 23:07:48 2004
@@ -142,6 +142,7 @@ static int __init dmi_iterate(void (*dec
 
 enum
 {
+	DMI_NONE,
 	DMI_BIOS_VENDOR,
 	DMI_BIOS_VERSION,
 	DMI_BIOS_DATE,
@@ -185,8 +186,6 @@ struct dmi_strmatch
 	char *substr;
 };
 
-#define NONE	255
-
 struct dmi_blacklist
 {
 	int (*callback)(struct dmi_blacklist *);
@@ -194,7 +193,6 @@ struct dmi_blacklist
 	struct dmi_strmatch matches[4];
 };
 
-#define NO_MATCH	{ NONE, NULL}
 #define MATCH(a,b)	{ a, b }
 
 /* 
@@ -590,12 +588,10 @@ static __initdata struct dmi_blacklist d
 	{ broken_ps2_resume, "Dell Latitude C600", {	/* Handle problems with APM on the C600 */
 			MATCH(DMI_SYS_VENDOR, "Dell"),
 			MATCH(DMI_PRODUCT_NAME, "Latitude C600"),
-			NO_MATCH, NO_MATCH
 			} },
 	{ set_apm_ints, "Dell Latitude", {  /* Allow interrupts during suspend on Dell Latitude laptops*/
 			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
 			MATCH(DMI_PRODUCT_NAME, "Latitude C510"),
-			NO_MATCH, NO_MATCH
 			} },
 	{ apm_is_horked, "Dell Inspiron 2500", { /* APM crashes */
 			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
@@ -606,17 +602,16 @@ static __initdata struct dmi_blacklist d
 	{ set_apm_ints, "Dell Inspiron", {	/* Allow interrupts during suspend on Dell Inspiron laptops*/
 			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
 			MATCH(DMI_PRODUCT_NAME, "Inspiron 4000"),
-			NO_MATCH, NO_MATCH
 			} },
 	{ broken_apm_power, "Dell Inspiron 5000e", {	/* Handle problems with APM on Inspiron 5000e */
 			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
 			MATCH(DMI_BIOS_VERSION, "A04"),
-			MATCH(DMI_BIOS_DATE, "08/24/2000"), NO_MATCH
+			MATCH(DMI_BIOS_DATE, "08/24/2000"),
 			} },
 	{ broken_apm_power, "Dell Inspiron 2500", {	/* Handle problems with APM on Inspiron 2500 */
 			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
 			MATCH(DMI_BIOS_VERSION, "A12"),
-			MATCH(DMI_BIOS_DATE, "02/04/2002"), NO_MATCH
+			MATCH(DMI_BIOS_DATE, "02/04/2002"),
 			} },
 	{ apm_is_horked, "Dell Dimension 4100", { /* APM crashes */
 			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
@@ -627,22 +622,19 @@ static __initdata struct dmi_blacklist d
 	{ set_realmode_power_off, "Award Software v4.60 PGMA", {	/* broken PM poweroff bios */
 			MATCH(DMI_BIOS_VENDOR, "Award Software International, Inc."),
 			MATCH(DMI_BIOS_VERSION, "4.60 PGMA"),
-			MATCH(DMI_BIOS_DATE, "134526184"), NO_MATCH
+			MATCH(DMI_BIOS_DATE, "134526184"),
 			} },
 	{ set_smp_bios_reboot, "Dell PowerEdge 1300", {	/* Handle problems with rebooting on Dell 1300's */
 			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
 			MATCH(DMI_PRODUCT_NAME, "PowerEdge 1300/"),
-			NO_MATCH, NO_MATCH
 			} },
 	{ set_bios_reboot, "Dell PowerEdge 300", {	/* Handle problems with rebooting on Dell 300's */
 			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
 			MATCH(DMI_PRODUCT_NAME, "PowerEdge 300/"),
-			NO_MATCH, NO_MATCH
 			} },
 	{ set_bios_reboot, "Dell PowerEdge 2400", {  /* Handle problems with rebooting on Dell 2400's */
 			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
 			MATCH(DMI_PRODUCT_NAME, "PowerEdge 2400"),
-			NO_MATCH, NO_MATCH
 			} },
 	{ set_apm_ints, "Compaq 12XL125", {	/* Allow interrupts during suspend on Compaq Laptops*/
 			MATCH(DMI_SYS_VENDOR, "Compaq"),
@@ -653,38 +645,31 @@ static __initdata struct dmi_blacklist d
 	{ set_apm_ints, "ASUSTeK", {   /* Allow interrupts during APM or the clock goes slow */
 			MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
 			MATCH(DMI_PRODUCT_NAME, "L8400K series Notebook PC"),
-			NO_MATCH, NO_MATCH
 			} },					
 	{ apm_is_horked, "ABIT KX7-333[R]", { /* APM blows on shutdown */
 			MATCH(DMI_BOARD_VENDOR, "ABIT"),
 			MATCH(DMI_BOARD_NAME, "VT8367-8233A (KX7-333[R])"),
-			NO_MATCH, NO_MATCH,
 			} },
 	{ apm_is_horked, "Trigem Delhi3", { /* APM crashes */
 			MATCH(DMI_SYS_VENDOR, "TriGem Computer, Inc"),
 			MATCH(DMI_PRODUCT_NAME, "Delhi3"),
-			NO_MATCH, NO_MATCH,
 			} },
 	{ apm_is_horked, "Fujitsu-Siemens", { /* APM crashes */
 			MATCH(DMI_BIOS_VENDOR, "hoenix/FUJITSU SIEMENS"),
 			MATCH(DMI_BIOS_VERSION, "Version1.01"),
-			NO_MATCH, NO_MATCH,
 			} },
 	{ apm_is_horked_d850md, "Intel D850MD", { /* APM crashes */
 			MATCH(DMI_BIOS_VENDOR, "Intel Corp."),
 			MATCH(DMI_BIOS_VERSION, "MV85010A.86A.0016.P07.0201251536"),
-			NO_MATCH, NO_MATCH,
 			} },
 	{ apm_is_horked, "Intel D810EMO", { /* APM crashes */
 			MATCH(DMI_BIOS_VENDOR, "Intel Corp."),
 			MATCH(DMI_BIOS_VERSION, "MO81010A.86A.0008.P04.0004170800"),
-			NO_MATCH, NO_MATCH,
 			} },
 	{ apm_is_horked, "Dell XPS-Z", { /* APM crashes */
 			MATCH(DMI_BIOS_VENDOR, "Intel Corp."),
 			MATCH(DMI_BIOS_VERSION, "A11"),
 			MATCH(DMI_PRODUCT_NAME, "XPS-Z"),
-			NO_MATCH,
 			} },
 	{ apm_is_horked, "Sharp PC-PJ/AX", { /* APM crashes */
 			MATCH(DMI_SYS_VENDOR, "SHARP"),
@@ -701,94 +686,91 @@ static __initdata struct dmi_blacklist d
 	{ apm_likes_to_melt, "Jabil AMD", { /* APM idle hangs */
 			MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
 			MATCH(DMI_BIOS_VERSION, "0AASNP06"),
-			NO_MATCH, NO_MATCH,
 			} },
 	{ apm_likes_to_melt, "AMI Bios", { /* APM idle hangs */
 			MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
 			MATCH(DMI_BIOS_VERSION, "0AASNP05"), 
-			NO_MATCH, NO_MATCH,
 			} },
 	{ sony_vaio_laptop, "Sony Vaio", { /* This is a Sony Vaio laptop */
 			MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
 			MATCH(DMI_PRODUCT_NAME, "PCG-"),
-			NO_MATCH, NO_MATCH,
 			} },
 	{ swab_apm_power_in_minutes, "Sony VAIO", { /* Handle problems with APM on Sony Vaio PCG-N505X(DE) */
 			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
 			MATCH(DMI_BIOS_VERSION, "R0206H"),
-			MATCH(DMI_BIOS_DATE, "08/23/99"), NO_MATCH
+			MATCH(DMI_BIOS_DATE, "08/23/99"),
 			} },
 
 	{ swab_apm_power_in_minutes, "Sony VAIO", { /* Handle problems with APM on Sony Vaio PCG-N505VX */
 			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
 			MATCH(DMI_BIOS_VERSION, "W2K06H0"),
-			MATCH(DMI_BIOS_DATE, "02/03/00"), NO_MATCH
+			MATCH(DMI_BIOS_DATE, "02/03/00"),
 			} },
 			
 	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-XG29 */
 			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
 			MATCH(DMI_BIOS_VERSION, "R0117A0"),
-			MATCH(DMI_BIOS_DATE, "04/25/00"), NO_MATCH
+			MATCH(DMI_BIOS_DATE, "04/25/00"),
 			} },
 
 	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-Z600NE */
 			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
 			MATCH(DMI_BIOS_VERSION, "R0121Z1"),
-			MATCH(DMI_BIOS_DATE, "05/11/00"), NO_MATCH
+			MATCH(DMI_BIOS_DATE, "05/11/00"),
 			} },
 
 	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-Z600NE */
 			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
 			MATCH(DMI_BIOS_VERSION, "WME01Z1"),
-			MATCH(DMI_BIOS_DATE, "08/11/00"), NO_MATCH
+			MATCH(DMI_BIOS_DATE, "08/11/00"),
 			} },
 
 	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-Z600LEK(DE) */
 			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
 			MATCH(DMI_BIOS_VERSION, "R0206Z3"),
-			MATCH(DMI_BIOS_DATE, "12/25/00"), NO_MATCH
+			MATCH(DMI_BIOS_DATE, "12/25/00"),
 			} },
 
 	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-Z505LS */
 			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
 			MATCH(DMI_BIOS_VERSION, "R0203D0"),
-			MATCH(DMI_BIOS_DATE, "05/12/00"), NO_MATCH
+			MATCH(DMI_BIOS_DATE, "05/12/00"),
 			} },
 
 	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-Z505LS */
 			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
 			MATCH(DMI_BIOS_VERSION, "R0203Z3"),
-			MATCH(DMI_BIOS_DATE, "08/25/00"), NO_MATCH
+			MATCH(DMI_BIOS_DATE, "08/25/00"),
 			} },
 	
 	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-Z505LS (with updated BIOS) */
 			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
 			MATCH(DMI_BIOS_VERSION, "R0209Z3"),
-			MATCH(DMI_BIOS_DATE, "05/12/01"), NO_MATCH
+			MATCH(DMI_BIOS_DATE, "05/12/01"),
 			} },
 
 	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-F104K */
 			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
 			MATCH(DMI_BIOS_VERSION, "R0204K2"),
-			MATCH(DMI_BIOS_DATE, "08/28/00"), NO_MATCH
+			MATCH(DMI_BIOS_DATE, "08/28/00"),
 			} },
 
 	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-C1VN/C1VE */
 			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
 			MATCH(DMI_BIOS_VERSION, "R0208P1"),
-			MATCH(DMI_BIOS_DATE, "11/09/00"), NO_MATCH
+			MATCH(DMI_BIOS_DATE, "11/09/00"),
 			} },
 
 	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-C1VE */
 			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
 			MATCH(DMI_BIOS_VERSION, "R0204P1"),
-			MATCH(DMI_BIOS_DATE, "09/12/00"), NO_MATCH
+			MATCH(DMI_BIOS_DATE, "09/12/00"),
 			} },
 
 	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-C1VE */
 			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
 			MATCH(DMI_BIOS_VERSION, "WXPO1Z3"),
-			MATCH(DMI_BIOS_DATE, "10/26/01"), NO_MATCH
+			MATCH(DMI_BIOS_DATE, "10/26/01"),
 			} },
 			
 	{ exploding_pnp_bios, "Higraded P14H", {	/* PnPBIOS GPF on boot */
@@ -807,52 +789,43 @@ static __initdata struct dmi_blacklist d
 	{ local_apic_kills_bios, "Dell Inspiron", {
 			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
 			MATCH(DMI_PRODUCT_NAME, "Inspiron"),
-			NO_MATCH, NO_MATCH
 			} },
 
 	{ local_apic_kills_bios, "Dell Latitude", {
 			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
 			MATCH(DMI_PRODUCT_NAME, "Latitude"),
-			NO_MATCH, NO_MATCH
 			} },
 
 	{ local_apic_kills_bios, "IBM Thinkpad T20", {
 			MATCH(DMI_BOARD_VENDOR, "IBM"),
 			MATCH(DMI_BOARD_NAME, "264741U"),
-			NO_MATCH, NO_MATCH
 			} },
 
 	{ local_apic_kills_bios, "ASUS L3C", {
 			MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
 			MATCH(DMI_BOARD_NAME, "P4_L3C"),
-			NO_MATCH, NO_MATCH
 			} },
 
 	{ broken_acpi_Sx, "ASUS K7V-RM", {		/* Bad ACPI Sx table */
 			MATCH(DMI_BIOS_VERSION,"ASUS K7V-RM ACPI BIOS Revision 1003A"),
 			MATCH(DMI_BOARD_NAME, "<K7V-RM>"),
-			NO_MATCH, NO_MATCH
 			} },
 
 	{ broken_toshiba_keyboard, "Toshiba Satellite 4030cdt", { /* Keyboard generates spurious repeats */
 			MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),
-			NO_MATCH, NO_MATCH, NO_MATCH
 			} },
 	{ init_ints_after_s1, "Toshiba Satellite 4030cdt", { /* Reinitialization of 8259 is needed after S1 resume */
 			MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),
-			NO_MATCH, NO_MATCH, NO_MATCH
 			} },
 #ifdef CONFIG_ACPI_SLEEP
 	{ reset_videomode_after_s3, "Toshiba Satellite 4030cdt", { /* Reset video mode after returning from ACPI S3 sleep */
 			MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),
-			NO_MATCH, NO_MATCH, NO_MATCH
 			} },
 #endif
 
 	{ print_if_true, KERN_WARNING "IBM T23 - BIOS 1.03b+ and controller firmware 1.02+ may be needed for Linux APM.", {
 			MATCH(DMI_SYS_VENDOR, "IBM"),
 			MATCH(DMI_BIOS_VERSION, "1AET38WW (1.01b)"),
-			NO_MATCH, NO_MATCH
 			} },
 	 
 	{ fix_broken_hp_bios_irq9, "HP Pavilion N5400 Series Laptop", {
@@ -869,7 +842,6 @@ static __initdata struct dmi_blacklist d
 	 
 	{ set_apm_ints, "IBM", {	/* Allow interrupts during suspend on IBM laptops */
 			MATCH(DMI_SYS_VENDOR, "IBM"),
-			NO_MATCH, NO_MATCH, NO_MATCH
 			} },
 
 	/*
@@ -878,7 +850,6 @@ static __initdata struct dmi_blacklist d
 	 
 	{ disable_smbus, "IBM", {
 			MATCH(DMI_SYS_VENDOR, "IBM"),
-			NO_MATCH, NO_MATCH, NO_MATCH
 			} },
 
 	/*
@@ -889,7 +860,6 @@ static __initdata struct dmi_blacklist d
 	{ acer_cpufreq_pst, "Acer Aspire", {
 			MATCH(DMI_SYS_VENDOR, "Insyde Software"),
 			MATCH(DMI_BIOS_VERSION, "3A71"),
-			NO_MATCH, NO_MATCH,
 			} },
 
 #ifdef	CONFIG_ACPI_BOOT
@@ -905,7 +875,7 @@ static __initdata struct dmi_blacklist d
 	{ dmi_disable_acpi, "IBM Thinkpad", {
 			MATCH(DMI_BOARD_VENDOR, "IBM"),
 			MATCH(DMI_BOARD_NAME, "2629H1G"),
-			NO_MATCH, NO_MATCH }},
+			} },
 
 	/*
 	 *	Boxes that need acpi=ht 
@@ -914,85 +884,85 @@ static __initdata struct dmi_blacklist d
 	{ force_acpi_ht, "FSC Primergy T850", {
 			MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
 			MATCH(DMI_PRODUCT_NAME, "PRIMERGY T850"),
-			NO_MATCH, NO_MATCH }},
+			}},
 
 	{ force_acpi_ht, "DELL GX240", {
 			MATCH(DMI_BOARD_VENDOR, "Dell Computer Corporation"),
 			MATCH(DMI_BOARD_NAME, "OptiPlex GX240"),
-			NO_MATCH, NO_MATCH }},
+			}},
 
 	{ force_acpi_ht, "HP VISUALIZE NT Workstation", {
 			MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
 			MATCH(DMI_PRODUCT_NAME, "HP VISUALIZE NT Workstation"),
-			NO_MATCH, NO_MATCH }},
+			}},
 
 	{ force_acpi_ht, "Compaq ProLiant DL380 G2", {
 			MATCH(DMI_SYS_VENDOR, "Compaq"),
 			MATCH(DMI_PRODUCT_NAME, "ProLiant DL380 G2"),
-			NO_MATCH, NO_MATCH }},
+			}},
 
 	{ force_acpi_ht, "Compaq ProLiant ML530 G2", {
 			MATCH(DMI_SYS_VENDOR, "Compaq"),
 			MATCH(DMI_PRODUCT_NAME, "ProLiant ML530 G2"),
-			NO_MATCH, NO_MATCH }},
+			}},
 
 	{ force_acpi_ht, "Compaq ProLiant ML350 G3", {
 			MATCH(DMI_SYS_VENDOR, "Compaq"),
 			MATCH(DMI_PRODUCT_NAME, "ProLiant ML350 G3"),
-			NO_MATCH, NO_MATCH }},
+			}},
 
 #ifdef CONFIG_SERIO_I8042
 	{ set_8042_nomux, "Compaq Proliant 8500", {
 			MATCH(DMI_SYS_VENDOR, "Compaq"),
 			MATCH(DMI_PRODUCT_NAME , "ProLiant"),
 			MATCH(DMI_PRODUCT_VERSION, "8500"),
-			NO_MATCH }},
+			}},
 #endif
 
 	{ force_acpi_ht, "Compaq Workstation W8000", {
 			MATCH(DMI_SYS_VENDOR, "Compaq"),
 			MATCH(DMI_PRODUCT_NAME, "Workstation W8000"),
-			NO_MATCH, NO_MATCH }},
+			}},
 
 	{ force_acpi_ht, "ASUS P4B266", {
 			MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
 			MATCH(DMI_BOARD_NAME, "P4B266"),
-			NO_MATCH, NO_MATCH }},
+			}},
 
 	{ force_acpi_ht, "ASUS P2B-DS", {
 			MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
 			MATCH(DMI_BOARD_NAME, "P2B-DS"),
-			NO_MATCH, NO_MATCH }},
+			}},
 
 	{ force_acpi_ht, "ASUS CUR-DLS", {
 			MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
 			MATCH(DMI_BOARD_NAME, "CUR-DLS"),
-			NO_MATCH, NO_MATCH }},
+			}},
 
 	{ force_acpi_ht, "ABIT i440BX-W83977", {
 			MATCH(DMI_BOARD_VENDOR, "ABIT <http://www.abit.com>"),
 			MATCH(DMI_BOARD_NAME, "i440BX-W83977 (BP6)"),
-			NO_MATCH, NO_MATCH }},
+			}},
 
 	{ force_acpi_ht, "IBM Bladecenter", {
 			MATCH(DMI_BOARD_VENDOR, "IBM"),
 			MATCH(DMI_BOARD_NAME, "IBM eServer BladeCenter HS20"),
-			NO_MATCH, NO_MATCH }},
+			}},
 
 	{ force_acpi_ht, "IBM eServer xSeries 360", {
 			MATCH(DMI_BOARD_VENDOR, "IBM"),
 			MATCH(DMI_BOARD_NAME, "eServer xSeries 360"),
-			NO_MATCH, NO_MATCH }},
+			}},
 
 	{ force_acpi_ht, "IBM eserver xSeries 330", {
 			MATCH(DMI_BOARD_VENDOR, "IBM"),
 			MATCH(DMI_BOARD_NAME, "eserver xSeries 330"),
-			NO_MATCH, NO_MATCH }},
+			}},
 
 	{ force_acpi_ht, "IBM eserver xSeries 440", {
 			MATCH(DMI_BOARD_VENDOR, "IBM"),
 			MATCH(DMI_PRODUCT_NAME, "eserver xSeries 440"),
-			NO_MATCH, NO_MATCH }},
+			}},
 
 	/*
 	 * Systems with nForce2 BIOS timer override bug
@@ -1048,7 +1018,7 @@ static __initdata struct dmi_blacklist d
 			MATCH(DMI_BOARD_NAME, "<A7V>"),
 			/* newer BIOS, Revision 1011, does work */
 			MATCH(DMI_BIOS_VERSION, "ASUS A7V ACPI BIOS Revision 1007"),
-			NO_MATCH }},
+			}},
 
 	/*
 	 *	Boxes that need ACPI PCI IRQ routing and PCI scan disabled
@@ -1103,7 +1073,7 @@ static __init void dmi_check_blacklist(v
 		for(i=0;i<4;i++)
 		{
 			int s = d->matches[i].slot;
-			if(s==NONE)
+			if(s==DMI_NONE)
 				continue;
 			if(dmi_ident[s] && strstr(dmi_ident[s], d->matches[i].substr))
 				continue;

