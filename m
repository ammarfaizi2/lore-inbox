Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVAaMjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVAaMjH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 07:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVAaMjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 07:39:07 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:29703 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261170AbVAaMjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 07:39:00 -0500
Date: Mon, 31 Jan 2005 13:38:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/mxser.c cleanups
Message-ID: <20050131123858.GD18316@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make two needlessly global structs static
- remove the unused global function SDS_PORT8_DTR

@Alan:
SDS_PORT8_DTR was introduced by your "Bring Moxa serial back into being" 
patch last month but was completely unused.
Is it correct to remove this function or should there have been a usage 
of this function?

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/mxser.c |   21 ++-------------------
 1 files changed, 2 insertions(+), 19 deletions(-)

--- linux-2.6.11-rc2-mm2-full/drivers/char/mxser.c.old	2005-01-31 13:20:44.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/mxser.c	2005-01-31 13:22:07.000000000 +0100
@@ -179,7 +179,7 @@
 
 #define UART_TYPE_NUM	2
 
-unsigned int Gmoxa_uart_id[UART_TYPE_NUM] = {
+static unsigned int Gmoxa_uart_id[UART_TYPE_NUM] = {
 	MOXA_MUST_MU150_HWID,
 	MOXA_MUST_MU860_HWID
 };
@@ -197,7 +197,7 @@
 	long max_baud;
 };
 
-struct mxpciuart_info Gpci_uart_info[UART_INFO_NUM] = {
+static struct mxpciuart_info Gpci_uart_info[UART_INFO_NUM] = {
 	{MOXA_OTHER_UART, 16, 16, 16, 14, 14, 1, 921600L},
 	{MOXA_MUST_MU150_HWID, 64, 64, 64, 48, 48, 16, 230400L},
 	{MOXA_MUST_MU860_HWID, 128, 128, 128, 96, 96, 32, 921600L}
@@ -3174,22 +3174,5 @@
 	outb(0x00, port + 4);
 }
 
-// added by James 03-05-2004.
-// for secure device server:
-// stat = 1, the port8 DTR is set to ON.
-// stat = 0, the port8 DTR is set to OFF.
-void SDS_PORT8_DTR(int stat)
-{
-	int _sds_oldmcr;
-	_sds_oldmcr = inb(mxvar_table[7].base + UART_MCR);	// get old MCR
-	if (stat == 1) {
-		outb(_sds_oldmcr | 0x01, mxvar_table[7].base + UART_MCR);	// set DTR ON
-	}
-	if (stat == 0) {
-		outb(_sds_oldmcr & 0xfe, mxvar_table[7].base + UART_MCR);	// set DTR OFF
-	}
-	return;
-}
-
 module_init(mxser_module_init);
 module_exit(mxser_module_exit);

