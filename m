Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262791AbVBYWtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbVBYWtX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 17:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262795AbVBYWtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 17:49:22 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:8715 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262793AbVBYWso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 17:48:44 -0500
Date: Fri, 25 Feb 2005 23:48:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: [2.6 patch] drivers/char/mxser.c cleanups
Message-ID: <20050225224839.GH3311@stusta.de>
References: <20050224233842.GU8651@stusta.de> <200502251043.14792.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502251043.14792.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2005 at 10:43:14AM +0200, Denis Vlasenko wrote:
> On Friday 25 February 2005 01:38, Adrian Bunk wrote:
> >...
> > -unsigned int Gmoxa_uart_id[UART_TYPE_NUM] = {
> > +static unsigned int Gmoxa_uart_id[UART_TYPE_NUM] = {
> >  	MOXA_MUST_MU150_HWID,
> >  	MOXA_MUST_MU860_HWID
> >  };
> 
> You can add 'const' too.


Thanks for this suggestion.

Updated patch:


<--  snip  -->


This patch contains the following cleanups:
- make two needlessly global structs static const
- remove the unused global function SDS_PORT8_DTR

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/mxser.c |   21 ++-------------------
 1 files changed, 2 insertions(+), 19 deletions(-)

--- linux-2.6.11-rc2-mm2-full/drivers/char/mxser.c.old	2005-01-31 13:20:44.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/mxser.c	2005-01-31 13:22:07.000000000 +0100
@@ -179,7 +179,7 @@
 
 #define UART_TYPE_NUM	2
 
-unsigned int Gmoxa_uart_id[UART_TYPE_NUM] = {
+static const unsigned int Gmoxa_uart_id[UART_TYPE_NUM] = {
 	MOXA_MUST_MU150_HWID,
 	MOXA_MUST_MU860_HWID
 };
@@ -197,7 +197,7 @@
 	long max_baud;
 };
 
-struct mxpciuart_info Gpci_uart_info[UART_INFO_NUM] = {
+static const struct mxpciuart_info Gpci_uart_info[UART_INFO_NUM] = {
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


