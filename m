Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWI0Q6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWI0Q6l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 12:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWI0Q6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 12:58:41 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:45807 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751260AbWI0Q6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 12:58:38 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Victor <andrew@sanpeople.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       hskinnemoen@atmel.com
Subject: [PATCH 5/8] at91_serial -> atmel_serial: Public definitions
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Wed, 27 Sep 2006 18:58:02 +0200
Message-Id: <11593762851544-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.1.1
In-Reply-To: <11593762853931-git-send-email-hskinnemoen@atmel.com>
References: <1159376285670-git-send-email-hskinnemoen@atmel.com> <115937628584-git-send-email-hskinnemoen@atmel.com> <11593762852168-git-send-email-hskinnemoen@atmel.com> <11593762851735-git-send-email-hskinnemoen@atmel.com> <11593762853931-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the following public definitions:
  * AT91_NR_UART -> ATMEL_NR_UART
  * struct at91_uart_data -> struct atmel_uart_data
  * at91_default_console_device -> atmel_default_console_device

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/arm/mach-at91rm9200/devices.c         |   22 +++++++++++-----------
 arch/avr32/mach-at32ap/at32ap7000.c        |    4 ++--
 drivers/serial/atmel_serial.c              |   14 +++++++-------
 include/asm-arm/arch-at91rm9200/board.h    |    4 ++--
 include/asm-arm/arch-at91rm9200/hardware.h |    2 +-
 include/asm-avr32/arch-at32ap/board.h      |    4 ++--
 6 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-at91rm9200/devices.c b/arch/arm/mach-at91rm9200/devices.c
index 78d6a1a..ffc229f 100644
--- a/arch/arm/mach-at91rm9200/devices.c
+++ b/arch/arm/mach-at91rm9200/devices.c
@@ -558,7 +558,7 @@ static struct resource dbgu_resources[] 
 	},
 };
 
-static struct at91_uart_data dbgu_data = {
+static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
 };
@@ -593,7 +593,7 @@ static struct resource uart0_resources[]
 	},
 };
 
-static struct at91_uart_data uart0_data = {
+static struct atmel_uart_data uart0_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 };
@@ -635,7 +635,7 @@ static struct resource uart1_resources[]
 	},
 };
 
-static struct at91_uart_data uart1_data = {
+static struct atmel_uart_data uart1_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 };
@@ -676,7 +676,7 @@ static struct resource uart2_resources[]
 	},
 };
 
-static struct at91_uart_data uart2_data = {
+static struct atmel_uart_data uart2_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 };
@@ -711,7 +711,7 @@ static struct resource uart3_resources[]
 	},
 };
 
-static struct at91_uart_data uart3_data = {
+static struct atmel_uart_data uart3_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
 };
@@ -733,8 +733,8 @@ static inline void configure_usart3_pins
 	at91_set_B_periph(AT91_PIN_PA6, 0);		/* RXD3 */
 }
 
-struct platform_device *at91_uarts[AT91_NR_UART];	/* the UARTs to use */
-struct platform_device *at91_default_console_device;	/* the serial console device */
+struct platform_device *at91_uarts[ATMEL_NR_UART];	/* the UARTs to use */
+struct platform_device *atmel_default_console_device;	/* the serial console device */
 
 void __init at91_init_serial(struct at91_uart_config *config)
 {
@@ -775,9 +775,9 @@ void __init at91_init_serial(struct at91
 	}
 
 	/* Set serial console device */
-	if (config->console_tty < AT91_NR_UART)
-		at91_default_console_device = at91_uarts[config->console_tty];
-	if (!at91_default_console_device)
+	if (config->console_tty < ATMEL_NR_UART)
+		atmel_default_console_device = at91_uarts[config->console_tty];
+	if (!atmel_default_console_device)
 		printk(KERN_INFO "AT91: No default serial console defined.\n");
 }
 
@@ -785,7 +785,7 @@ void __init at91_add_device_serial(void)
 {
 	int i;
 
-	for (i = 0; i < AT91_NR_UART; i++) {
+	for (i = 0; i < ATMEL_NR_UART; i++) {
 		if (at91_uarts[i])
 			platform_device_register(at91_uarts[i]);
 	}
diff --git a/arch/avr32/mach-at32ap/at32ap7000.c b/arch/avr32/mach-at32ap/at32ap7000.c
index aca7890..536bc88 100644
--- a/arch/avr32/mach-at32ap/at32ap7000.c
+++ b/arch/avr32/mach-at32ap/at32ap7000.c
@@ -615,11 +615,11 @@ struct platform_device *__init at32_add_
 	return pdev;
 }
 
-struct platform_device *at91_default_console_device;
+struct platform_device *atmel_default_console_device;
 
 void __init at32_setup_serial_console(unsigned int usart_id)
 {
-	at91_default_console_device = setup_usart(usart_id);
+	atmel_default_console_device = setup_usart(usart_id);
 }
 
 /* --------------------------------------------------------------------
diff --git a/drivers/serial/atmel_serial.c b/drivers/serial/atmel_serial.c
index b5f9e31..55ca5df 100644
--- a/drivers/serial/atmel_serial.c
+++ b/drivers/serial/atmel_serial.c
@@ -113,7 +113,7 @@ struct at91_uart_port {
 	unsigned short		suspended;	/* is port suspended? */
 };
 
-static struct at91_uart_port at91_ports[AT91_NR_UART];
+static struct at91_uart_port at91_ports[ATMEL_NR_UART];
 
 #ifdef SUPPORT_SYSRQ
 static struct console at91_console;
@@ -682,7 +682,7 @@ static struct uart_ops at91_pops = {
 static void __devinit at91_init_port(struct at91_uart_port *at91_port, struct platform_device *pdev)
 {
 	struct uart_port *port = &at91_port->uart;
-	struct at91_uart_data *data = pdev->dev.platform_data;
+	struct atmel_uart_data *data = pdev->dev.platform_data;
 
 	port->iotype	= UPIO_MEM;
 	port->flags     = UPF_BOOT_AUTOCONF;
@@ -834,9 +834,9 @@ #define AT91_CONSOLE_DEVICE	&at91_consol
  */
 static int __init at91_console_init(void)
 {
-	if (at91_default_console_device) {
-		add_preferred_console(AT91_DEVICENAME, at91_default_console_device->id, NULL);
-		at91_init_port(&(at91_ports[at91_default_console_device->id]), at91_default_console_device);
+	if (atmel_default_console_device) {
+		add_preferred_console(AT91_DEVICENAME, atmel_default_console_device->id, NULL);
+		at91_init_port(&(at91_ports[atmel_default_console_device->id]), atmel_default_console_device);
 		register_console(&at91_console);
 	}
 
@@ -849,7 +849,7 @@ console_initcall(at91_console_init);
  */
 static int __init at91_late_console_init(void)
 {
-	if (at91_default_console_device && !(at91_console.flags & CON_ENABLED))
+	if (atmel_default_console_device && !(at91_console.flags & CON_ENABLED))
 		register_console(&at91_console);
 
 	return 0;
@@ -866,7 +866,7 @@ static struct uart_driver at91_uart = {
 	.dev_name		= AT91_DEVICENAME,
 	.major			= SERIAL_AT91_MAJOR,
 	.minor			= MINOR_START,
-	.nr			= AT91_NR_UART,
+	.nr			= ATMEL_NR_UART,
 	.cons			= AT91_CONSOLE_DEVICE,
 };
 
diff --git a/include/asm-arm/arch-at91rm9200/board.h b/include/asm-arm/arch-at91rm9200/board.h
index c1ca9a4..d565270 100644
--- a/include/asm-arm/arch-at91rm9200/board.h
+++ b/include/asm-arm/arch-at91rm9200/board.h
@@ -97,10 +97,10 @@ struct at91_uart_config {
 	unsigned short	nr_tty;		/* number of serial tty's */
 	short		tty_map[];	/* map UART to tty number */
 };
-extern struct platform_device *at91_default_console_device;
+extern struct platform_device *atmel_default_console_device;
 extern void __init at91_init_serial(struct at91_uart_config *config);
 
-struct at91_uart_data {
+struct atmel_uart_data {
 	short		use_dma_tx;	/* use transmit DMA? */
 	short		use_dma_rx;	/* use receive DMA? */
 };
diff --git a/include/asm-arm/arch-at91rm9200/hardware.h b/include/asm-arm/arch-at91rm9200/hardware.h
index 235d39d..16d6056 100644
--- a/include/asm-arm/arch-at91rm9200/hardware.h
+++ b/include/asm-arm/arch-at91rm9200/hardware.h
@@ -57,7 +57,7 @@ #define AT91_SRAM_SIZE		0x00004000	/* In
 #define AT91_SRAM_VIRT_BASE	(AT91_IO_VIRT_BASE - AT91_SRAM_SIZE)
 
 /* Serial ports */
-#define AT91_NR_UART		5		/* 4 USART3's and one DBGU port */
+#define ATMEL_NR_UART		5		/* 4 USART3's and one DBGU port */
 
 /* FLASH */
 #define AT91_FLASH_BASE		0x10000000	/* NCS0: Flash physical base address */
diff --git a/include/asm-avr32/arch-at32ap/board.h b/include/asm-avr32/arch-at32ap/board.h
index 39368e1..7e0790b 100644
--- a/include/asm-avr32/arch-at32ap/board.h
+++ b/include/asm-avr32/arch-at32ap/board.h
@@ -9,8 +9,8 @@ #include <linux/types.h>
 /* Add basic devices: system manager, interrupt controller, portmuxes, etc. */
 void at32_add_system_devices(void);
 
-#define AT91_NR_UART	4
-extern struct platform_device *at91_default_console_device;
+#define ATMEL_NR_UART	4
+extern struct platform_device *atmel_default_console_device;
 
 struct platform_device *at32_add_device_usart(unsigned int id);
 
-- 
1.4.1.1

