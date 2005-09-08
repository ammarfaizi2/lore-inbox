Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbVIHTp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbVIHTp4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 15:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbVIHTp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 15:45:56 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7949 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964967AbVIHTpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 15:45:55 -0400
Date: Thu, 8 Sep 2005 20:45:50 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Kars de Jong <jongk@linux-m68k.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 8250_hp300: initialisation ordering bug
Message-ID: <20050908204550.N5661@flint.arm.linux.org.uk>
Mail-Followup-To: Kars de Jong <jongk@linux-m68k.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20050904111901.A30509@flint.arm.linux.org.uk> <1126124269.3968.5.camel@kars.perseus.home> <20050907213316.G19199@flint.arm.linux.org.uk> <1126208533.9535.8.camel@kars.perseus.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1126208533.9535.8.camel@kars.perseus.home>; from jongk@linux-m68k.org on Thu, Sep 08, 2005 at 09:42:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 09:42:12PM +0200, Kars de Jong wrote:
> However, that doesn't seem to be appropriate for the APCI devices which
> are on the motherboard. So I'll use the platform driver for those. Do
> you have any suggestion for the id value I should use in my platform
> device? I looked in the existing drivers and ids -1 and 1-5 are taken,
> any reason id 0 was not used?

You might be interested in this patch which sorts out the numeric
ID allocation.

diff --git a/arch/arm/mach-clps7500/core.c b/arch/arm/mach-clps7500/core.c
--- a/arch/arm/mach-clps7500/core.c
+++ b/arch/arm/mach-clps7500/core.c
@@ -354,7 +354,7 @@ static struct plat_serial8250_port seria
 
 static struct platform_device serial_device = {
 	.name			= "serial8250",
-	.id			= 0,
+	.id			= PLAT8250_DEV_PLATFORM,
 	.dev			= {
 		.platform_data	= serial_platform_data,
 	},
diff --git a/arch/arm/mach-ebsa110/core.c b/arch/arm/mach-ebsa110/core.c
--- a/arch/arm/mach-ebsa110/core.c
+++ b/arch/arm/mach-ebsa110/core.c
@@ -219,7 +219,7 @@ static struct plat_serial8250_port seria
 
 static struct platform_device serial_device = {
 	.name			= "serial8250",
-	.id			= 0,
+	.id			= PLAT8250_DEV_PLATFORM,
 	.dev			= {
 		.platform_data	= serial_platform_data,
 	},
diff --git a/arch/arm/mach-epxa10db/arch.c b/arch/arm/mach-epxa10db/arch.c
--- a/arch/arm/mach-epxa10db/arch.c
+++ b/arch/arm/mach-epxa10db/arch.c
@@ -52,7 +52,7 @@ static struct plat_serial8250_port seria
 
 static struct platform_device serial_device = {
 	.name			= "serial8250",
-	.id			= 0,
+	.id			= PLAT8250_DEV_PLATFORM,
 	.dev			= {
 		.platform_data	= serial_platform_data,
 	},
diff --git a/arch/arm/mach-footbridge/isa.c b/arch/arm/mach-footbridge/isa.c
--- a/arch/arm/mach-footbridge/isa.c
+++ b/arch/arm/mach-footbridge/isa.c
@@ -34,7 +34,7 @@ static struct plat_serial8250_port seria
 
 static struct platform_device serial_device = {
 	.name			= "serial8250",
-	.id			= 0,
+	.id			= PLAT8250_DEV_PLATFORM,
 	.dev			= {
 		.platform_data	= serial_platform_data,
 	},
diff --git a/arch/arm/mach-h720x/cpu-h7202.c b/arch/arm/mach-h720x/cpu-h7202.c
--- a/arch/arm/mach-h720x/cpu-h7202.c
+++ b/arch/arm/mach-h720x/cpu-h7202.c
@@ -90,7 +90,7 @@ static struct plat_serial8250_port seria
 
 static struct platform_device serial_device = {
 	.name			= "serial8250",
-	.id			= 0,
+	.id			= PLAT8250_DEV_PLATFORM,
 	.dev			= {
 		.platform_data	= serial_platform_data,
 	},
diff --git a/arch/arm/mach-ixp2000/core.c b/arch/arm/mach-ixp2000/core.c
--- a/arch/arm/mach-ixp2000/core.c
+++ b/arch/arm/mach-ixp2000/core.c
@@ -174,7 +174,7 @@ static struct resource ixp2000_uart_reso
 
 static struct platform_device ixp2000_serial_device = {
 	.name		= "serial8250",
-	.id		= 0,
+	.id		= PLAT8250_DEV_PLATFORM,
 	.dev		= {
 		.platform_data		= ixp2000_serial_port,
 	},
diff --git a/arch/arm/mach-ixp4xx/coyote-setup.c b/arch/arm/mach-ixp4xx/coyote-setup.c
--- a/arch/arm/mach-ixp4xx/coyote-setup.c
+++ b/arch/arm/mach-ixp4xx/coyote-setup.c
@@ -66,7 +66,7 @@ static struct plat_serial8250_port coyot
 
 static struct platform_device coyote_uart = {
 	.name		= "serial8250",
-	.id		= 0,
+	.id		= PLAT8250_DEV_PLATFORM,
 	.dev			= {
 		.platform_data	= coyote_uart_data,
 	},
diff --git a/arch/arm/mach-ixp4xx/gtwx5715-setup.c b/arch/arm/mach-ixp4xx/gtwx5715-setup.c
--- a/arch/arm/mach-ixp4xx/gtwx5715-setup.c
+++ b/arch/arm/mach-ixp4xx/gtwx5715-setup.c
@@ -93,7 +93,7 @@ static struct plat_serial8250_port gtwx5
 
 static struct platform_device gtwx5715_uart_device = {
 	.name		= "serial8250",
-	.id		= 0,
+	.id		= PLAT8250_DEV_PLATFORM,
 	.dev			= {
 		.platform_data	= gtwx5715_uart_platform_data,
 	},
diff --git a/arch/arm/mach-ixp4xx/ixdp425-setup.c b/arch/arm/mach-ixp4xx/ixdp425-setup.c
--- a/arch/arm/mach-ixp4xx/ixdp425-setup.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-setup.c
@@ -96,7 +96,7 @@ static struct plat_serial8250_port ixdp4
 
 static struct platform_device ixdp425_uart = {
 	.name			= "serial8250",
-	.id			= 0,
+	.id			= PLAT8250_DEV_PLATFORM,
 	.dev.platform_data	= ixdp425_uart_data,
 	.num_resources		= 2,
 	.resource		= ixdp425_uart_resources
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -74,7 +74,7 @@ static struct plat_serial8250_port voice
 
 static struct platform_device serial_device = {
 	.name			= "serial8250",
-	.id			= 1,
+	.id			= PLAT8250_DEV_PLATFORM1,
 	.dev			= {
 		.platform_data	= voiceblue_ports,
 	},
diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -94,7 +94,7 @@ static struct plat_serial8250_port seria
 
 static struct platform_device serial_device = {
 	.name			= "serial8250",
-	.id			= 0,
+	.id			= PLAT8250_DEV_PLATFORM,
 	.dev			= {
 		.platform_data	= serial_platform_data,
 	},
diff --git a/arch/arm/mach-rpc/riscpc.c b/arch/arm/mach-rpc/riscpc.c
--- a/arch/arm/mach-rpc/riscpc.c
+++ b/arch/arm/mach-rpc/riscpc.c
@@ -140,7 +140,7 @@ static struct plat_serial8250_port seria
 
 static struct platform_device serial_device = {
 	.name			= "serial8250",
-	.id			= 0,
+	.id			= PLAT8250_DEV_PLATFORM,
 	.dev			= {
 		.platform_data	= serial_platform_data,
 	},
diff --git a/arch/arm/mach-s3c2410/mach-bast.c b/arch/arm/mach-s3c2410/mach-bast.c
--- a/arch/arm/mach-s3c2410/mach-bast.c
+++ b/arch/arm/mach-s3c2410/mach-bast.c
@@ -381,7 +381,7 @@ static struct plat_serial8250_port bast_
 
 static struct platform_device bast_sio = {
 	.name			= "serial8250",
-	.id			= 0,
+	.id			= PLAT8250_DEV_PLATFORM,
 	.dev			= {
 		.platform_data	= &bast_sio_data,
 	},
diff --git a/arch/arm/mach-s3c2410/mach-vr1000.c b/arch/arm/mach-s3c2410/mach-vr1000.c
--- a/arch/arm/mach-s3c2410/mach-vr1000.c
+++ b/arch/arm/mach-s3c2410/mach-vr1000.c
@@ -221,7 +221,7 @@ static struct plat_serial8250_port seria
 
 static struct platform_device serial_device = {
 	.name			= "serial8250",
-	.id			= 0,
+	.id			= PLAT8250_DEV_PLATFORM,
 	.dev			= {
 		.platform_data	= serial_platform_data,
 	},
diff --git a/arch/arm/mach-shark/core.c b/arch/arm/mach-shark/core.c
--- a/arch/arm/mach-shark/core.c
+++ b/arch/arm/mach-shark/core.c
@@ -41,7 +41,7 @@ static struct plat_serial8250_port seria
 
 static struct platform_device serial_device = {
 	.name			= "serial8250",
-	.id			= 0,
+	.id			= PLAT8250_DEV_PLATFORM,
 	.dev			= {
 		.platform_data	= serial_platform_data,
 	},
diff --git a/arch/ppc/syslib/mpc10x_common.c b/arch/ppc/syslib/mpc10x_common.c
--- a/arch/ppc/syslib/mpc10x_common.c
+++ b/arch/ppc/syslib/mpc10x_common.c
@@ -140,12 +140,12 @@ struct platform_device ppc_sys_platform_
 	},
 	[MPC10X_UART0] = {
 		.name = "serial8250",
-		.id	= 0,
+		.id	= PLAT8250_DEV_PLATFORM,
 		.dev.platform_data = serial_plat_uart0,
 	},
 	[MPC10X_UART1] = {
 		.name = "serial8250",
-		.id	= 1,
+		.id	= PLAT8250_DEV_PLATFORM1,
 		.dev.platform_data = serial_plat_uart1,
 	},
 
diff --git a/arch/ppc/syslib/mpc83xx_devices.c b/arch/ppc/syslib/mpc83xx_devices.c
--- a/arch/ppc/syslib/mpc83xx_devices.c
+++ b/arch/ppc/syslib/mpc83xx_devices.c
@@ -165,7 +165,7 @@ struct platform_device ppc_sys_platform_
 	},
 	[MPC83xx_DUART] = {
 		.name = "serial8250",
-		.id	= 0,
+		.id	= PLAT8250_DEV_PLATFORM,
 		.dev.platform_data = serial_platform_data,
 	},
 	[MPC83xx_SEC2] = {
diff --git a/arch/ppc/syslib/mpc85xx_devices.c b/arch/ppc/syslib/mpc85xx_devices.c
--- a/arch/ppc/syslib/mpc85xx_devices.c
+++ b/arch/ppc/syslib/mpc85xx_devices.c
@@ -282,7 +282,7 @@ struct platform_device ppc_sys_platform_
 	},
 	[MPC85xx_DUART] = {
 		.name = "serial8250",
-		.id	= 0,
+		.id	= PLAT8250_DEV_PLATFORM,
 		.dev.platform_data = serial_platform_data,
 	},
 	[MPC85xx_PERFMON] = {
diff --git a/arch/ppc64/kernel/setup.c b/arch/ppc64/kernel/setup.c
--- a/arch/ppc64/kernel/setup.c
+++ b/arch/ppc64/kernel/setup.c
@@ -1283,7 +1283,7 @@ void __init generic_find_legacy_serial_p
 
 static struct platform_device serial_device = {
 	.name	= "serial8250",
-	.id	= 0,
+	.id	= PLAT8250_DEV_PLATFORM,
 	.dev	= {
 		.platform_data = serial_ports,
 	},
diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2536,7 +2536,7 @@ static int __init serial8250_init(void)
 		goto out;
 
 	serial8250_isa_devs = platform_device_register_simple("serial8250",
-							      -1, NULL, 0);
+					 PLAT8250_DEV_LEGACY, NULL, 0);
 	if (IS_ERR(serial8250_isa_devs)) {
 		ret = PTR_ERR(serial8250_isa_devs);
 		goto unreg;
diff --git a/drivers/serial/8250_accent.c b/drivers/serial/8250_accent.c
--- a/drivers/serial/8250_accent.c
+++ b/drivers/serial/8250_accent.c
@@ -29,7 +29,7 @@ static struct plat_serial8250_port accen
 
 static struct platform_device accent_device = {
 	.name			= "serial8250",
-	.id			= 2,
+	.id			= PLAT8250_DEV_ACCENT,
 	.dev			= {
 		.platform_data	= accent_data,
 	},
diff --git a/drivers/serial/8250_boca.c b/drivers/serial/8250_boca.c
--- a/drivers/serial/8250_boca.c
+++ b/drivers/serial/8250_boca.c
@@ -43,7 +43,7 @@ static struct plat_serial8250_port boca_
 
 static struct platform_device boca_device = {
 	.name			= "serial8250",
-	.id			= 3,
+	.id			= PLAT8250_DEV_BOCA,
 	.dev			= {
 		.platform_data	= boca_data,
 	},
diff --git a/drivers/serial/8250_fourport.c b/drivers/serial/8250_fourport.c
--- a/drivers/serial/8250_fourport.c
+++ b/drivers/serial/8250_fourport.c
@@ -35,7 +35,7 @@ static struct plat_serial8250_port fourp
 
 static struct platform_device fourport_device = {
 	.name			= "serial8250",
-	.id			= 1,
+	.id			= PLAT8250_DEV_FOURPORT,
 	.dev			= {
 		.platform_data	= fourport_data,
 	},
diff --git a/drivers/serial/8250_hub6.c b/drivers/serial/8250_hub6.c
--- a/drivers/serial/8250_hub6.c
+++ b/drivers/serial/8250_hub6.c
@@ -40,7 +40,7 @@ static struct plat_serial8250_port hub6_
 
 static struct platform_device hub6_device = {
 	.name			= "serial8250",
-	.id			= 4,
+	.id			= PLAT8250_DEV_HUB6,
 	.dev			= {
 		.platform_data	= hub6_data,
 	},
diff --git a/drivers/serial/8250_mca.c b/drivers/serial/8250_mca.c
--- a/drivers/serial/8250_mca.c
+++ b/drivers/serial/8250_mca.c
@@ -44,7 +44,7 @@ static struct plat_serial8250_port mca_d
 
 static struct platform_device mca_device = {
 	.name			= "serial8250",
-	.id			= 5,
+	.id			= PLAT8250_DEV_MCA,
 	.dev			= {
 		.platform_data	= mca_data,
 	},
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -30,6 +30,21 @@ struct plat_serial8250_port {
 };
 
 /*
+ * Allocate 8250 platform device IDs.  Nothing is implied by
+ * the numbering here, except for the legacy entry being -1.
+ */
+enum {
+	PLAT8250_DEV_LEGACY = -1,
+	PLAT8250_DEV_PLATFORM,
+	PLAT8250_DEV_PLATFORM1,
+	PLAT8250_DEV_FOURPORT,
+	PLAT8250_DEV_ACCENT,
+	PLAT8250_DEV_BOCA,
+	PLAT8250_DEV_HUB6,
+	PLAT8250_DEV_MCA,
+};
+
+/*
  * This should be used by drivers which want to register
  * their own 8250 ports without registering their own
  * platform device.  Using these will make your driver


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
