Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264073AbTEWNZy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 09:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264075AbTEWNZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 09:25:54 -0400
Received: from CPE-203-51-32-18.nsw.bigpond.net.au ([203.51.32.18]:28657 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP id S264073AbTEWNZw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 09:25:52 -0400
Message-ID: <3ECE246D.E3B27BCB@eyal.emu.id.au>
Date: Fri, 23 May 2003 23:38:53 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.21-rc2-e2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc3 - ipmi unresolved
References: <Pine.LNX.4.55L.0305221915450.1975@freak.distro.conectiva>
Content-Type: multipart/mixed;
 boundary="------------2F59CA615A8413B80914A7D8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2F59CA615A8413B80914A7D8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Marcelo Tosatti wrote:
> 
> Hi,
> 
> Here goes the third release candidate of 2.4.21.
> 
> Summary of changes from v2.4.21-rc2 to v2.4.21-rc3
> ============================================
[trim]
> Alan Cox <alan@lxorguk.ukuu.org.uk>:
>   o fix ipmi screwup

The exports in ksyms are still necessary, and missing:

depmod: *** Unresolved symbols in
/lib/modules/2.4.21-rc3/kernel/drivers/char/ipmi/ipmi_msghandler.o
depmod:         panic_notifier_list
depmod: *** Unresolved symbols in
/lib/modules/2.4.21-rc3/kernel/drivers/char/ipmi/ipmi_watchdog.o
depmod:         panic_notifier_list
depmod:         panic_timeout

The attached snippet was part of the earlier, larger patch.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
--------------2F59CA615A8413B80914A7D8
Content-Type: text/plain; charset=us-ascii;
 name="2.4.21-rc3-ipmi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.21-rc3-ipmi.patch"

--- linux/kernel/ksyms.c.orig	Fri May 23 22:17:07 2003
+++ linux/kernel/ksyms.c	Fri May 23 22:16:38 2003
@@ -65,6 +65,7 @@
 extern int request_dma(unsigned int dmanr, char * deviceID);
 extern void free_dma(unsigned int dmanr);
 extern spinlock_t dma_spin_lock;
+extern int panic_timeout;
 
 #ifdef CONFIG_MODVERSIONS
 const struct module_symbol __export_Using_Versions
@@ -471,6 +472,8 @@
 
 /* misc */
 EXPORT_SYMBOL(panic);
+EXPORT_SYMBOL(panic_notifier_list);
+EXPORT_SYMBOL(panic_timeout);
 EXPORT_SYMBOL(__out_of_line_bug);
 EXPORT_SYMBOL(sprintf);
 EXPORT_SYMBOL(snprintf);

--------------2F59CA615A8413B80914A7D8--

