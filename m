Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271724AbRHUPrV>; Tue, 21 Aug 2001 11:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271701AbRHUPrD>; Tue, 21 Aug 2001 11:47:03 -0400
Received: from galba.tp1.ruhr-uni-bochum.de ([134.147.240.75]:9482 "EHLO
	galba.tp1.ruhr-uni-bochum.de") by vger.kernel.org with ESMTP
	id <S271725AbRHUPqs>; Tue, 21 Aug 2001 11:46:48 -0400
Date: Tue, 21 Aug 2001 17:47:01 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
To: Mike Castle <dalgoda@ix.netcom.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.9 build fails on Mandrake 8.0 ( make modules_install
 'isdn')
In-Reply-To: <20010821075326.A8844@thune.mrc-home.com>
Message-ID: <Pine.LNX.4.33.0108211745440.14658-100000@chaos.tp1.ruhr-uni-bochum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2001, Mike Castle wrote:

> On Mon, Aug 20, 2001 at 12:19:49AM +0200, Kai Germaschewski wrote:
> > On Sun, 19 Aug 2001, Chris Oxenreider wrote:
> > 
> > > depmod: *** Unresolved symbols in
> > > /lib/modules/2.4.9/kernel/drivers/isdn/eicon/eicon.o
> > > depmod: 	vsnprintf
> > 
> > This patch should fix it:
> 
> Hmmm... with that patch, I get the following errors:

Well, I said should ;-) Maybe I should have tried...

Next try: (still untested)

--Kai

diff -ur linux-2.4.9/include/linux/kernel.h linux-2.4.9.work/include/linux/kernel.h
--- linux-2.4.9/include/linux/kernel.h	Fri Aug 17 09:57:10 2001
+++ linux-2.4.9.work/include/linux/kernel.h	Tue Aug 21 17:44:32 2001
@@ -61,6 +61,8 @@
 extern long long simple_strtoll(const char *,char **,unsigned int);
 extern int sprintf(char * buf, const char * fmt, ...);
 extern int vsprintf(char *buf, const char *, va_list);
+extern int snprintf(char * buf, size_t size, const char * fmt, ...);
+extern int vsnprintf(char *buf, size_t size, const char *, va_list);
 extern int get_option(char **str, int *pint);
 extern char *get_options(char *str, int nints, int *ints);
 extern unsigned long long memparse(char *ptr, char **retptr);
diff -ur linux-2.4.9/kernel/ksyms.c linux-2.4.9.work/kernel/ksyms.c
--- linux-2.4.9/kernel/ksyms.c	Fri Aug 17 09:57:12 2001
+++ linux-2.4.9.work/kernel/ksyms.c	Mon Aug 20 00:16:58 2001
@@ -458,6 +458,8 @@
 EXPORT_SYMBOL(printk);
 EXPORT_SYMBOL(sprintf);
 EXPORT_SYMBOL(vsprintf);
+EXPORT_SYMBOL(snprintf);
+EXPORT_SYMBOL(vsnprintf);
 EXPORT_SYMBOL(kdevname);
 EXPORT_SYMBOL(bdevname);
 EXPORT_SYMBOL(cdevname);

