Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261300AbTC0T6e>; Thu, 27 Mar 2003 14:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261326AbTC0T6e>; Thu, 27 Mar 2003 14:58:34 -0500
Received: from [80.190.48.67] ([80.190.48.67]:60168 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id <S261300AbTC0T6c>; Thu, 27 Mar 2003 14:58:32 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: bunk@fs.tum.de, Corey Minyard <minyard@mvista.com>
Subject: Re: 2.4.21-pre6: IPMI unresolved symbols
Date: Thu, 27 Mar 2003 21:08:35 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
References: <20030327200401.GX24744@fs.tum.de>
In-Reply-To: <20030327200401.GX24744@fs.tum.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_BYBFMBASZOF0FJJYMKRB"
Message-Id: <200303272108.35214.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_BYBFMBASZOF0FJJYMKRB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday 27 March 2003 21:04, bunk@fs.tum.de wrote:

Hi Adrian,

> panic_notifier_list and panic_timeout are not EXPORT_SYMBOL'ed in
> kernel/panic.c resulting in the following unresolved symbol errors when
> building IPMI modular:
> <--  snip  -->
> ...
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.21-pre6/kernel/drivers/char/ipmi/ipmi_msghandler.o dep=
mod:
>         panic_notifier_list
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.21-pre6/kernel/drivers/char/ipmi/ipmi_watchdog.o depmo=
d: =20
>       panic_notifier_list
> depmod:         panic_timeout
> ...

patch attached.

ciao, Marc
--------------Boundary-00=_BYBFMBASZOF0FJJYMKRB
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="ipmi-exported-symbols-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ipmi-exported-symbols-fix.patch"

--- linux.orig/kernel/ksyms.c	Fri Dec  6 09:12:07 2002
+++ linux/kernel/ksyms.c	Fri Dec  6 09:13:01 2002
@@ -65,6 +65,8 @@
 extern int request_dma(unsigned int dmanr, char * deviceID);
 extern void free_dma(unsigned int dmanr);
 extern spinlock_t dma_spin_lock;
+extern int panic_timeout;
+
 
 #ifdef CONFIG_MODVERSIONS
 const struct module_symbol __export_Using_Versions
@@ -471,6 +471,8 @@
 
 /* misc */
 EXPORT_SYMBOL(panic);
+EXPORT_SYMBOL(panic_notifier_list);
+EXPORT_SYMBOL(panic_timeout);
 EXPORT_SYMBOL(__out_of_line_bug);
 EXPORT_SYMBOL(sprintf);
 EXPORT_SYMBOL(snprintf);

--------------Boundary-00=_BYBFMBASZOF0FJJYMKRB--

