Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265039AbSKESsi>; Tue, 5 Nov 2002 13:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265054AbSKESsi>; Tue, 5 Nov 2002 13:48:38 -0500
Received: from pasky.ji.cz ([62.44.12.54]:11764 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S265039AbSKESsh>;
	Tue, 5 Nov 2002 13:48:37 -0500
Date: Tue, 5 Nov 2002 19:55:11 +0100
From: Petr Baudis <pasky@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jens Axboe <axboe@suse.de>, Arjan van de Ven <arjanv@redhat.com>,
       Jeff Garzik <jgarzik@pobox.com>, zippel@linux-m68k.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Allow 'n' as a symbol value in the .config file.
Message-ID: <20021105185511.GR2502@pasky.ji.cz>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jens Axboe <axboe@suse.de>, Arjan van de Ven <arjanv@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>, zippel@linux-m68k.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021105165024.GJ13587@suse.de> <3DC7FB11.10209@pobox.com> <20021105171409.GA1137@suse.de> <1036517201.5601.0.camel@localhost.localdomain> <20021105172617.GC1830@suse.de> <1036520436.4791.114.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036520436.4791.114.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  this patch (against 2.5.46) enabled recognition of 'n' tristate/boolean
symbol value in the .config file. This allows more convenient manual editing of
the .config file. Please apply.

 confdata.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

  Kind regards,
				Petr Baudis

--- linux/scripts/kconfig/confdata.c	Fri Nov  1 22:22:07 2002
+++ linux+pasky/scripts/kconfig/confdata.c	Tue Nov  5 19:54:12 2002
@@ -1,6 +1,9 @@
 /*
  * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
  * Released under the terms of the GNU GPL v2.0.
+ *
+ * Allow 'n' as a symbol value.
+ * 2002-11-05 Petr Baudis <pasky@ucw.cz>
  */
 
 #include <ctype.h>
@@ -146,13 +149,13 @@
 				break;
 			}
 			switch (sym->type) {
-			case S_BOOLEAN:
-				sym->def = symbol_yes.curr;
-				sym->flags &= ~SYMBOL_NEW;
-				break;
 			case S_TRISTATE:
 				if (p[0] == 'm')
 					sym->def = symbol_mod.curr;
+				else
+			case S_BOOLEAN:
+				if (p[0] == 'n')
+					sym->def = symbol_no.curr;
 				else
 					sym->def = symbol_yes.curr;
 				sym->flags &= ~SYMBOL_NEW;
