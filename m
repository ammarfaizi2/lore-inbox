Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264892AbSKJOs2>; Sun, 10 Nov 2002 09:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264894AbSKJOs1>; Sun, 10 Nov 2002 09:48:27 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:55563 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S264892AbSKJOsZ>; Sun, 10 Nov 2002 09:48:25 -0500
Date: Sun, 10 Nov 2002 15:55:08 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Romain Lievin <rlievin@free.fr>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kconfig (gconf): GTK tool released, please test...
In-Reply-To: <20021110132750.GB6256@free.fr>
Message-ID: <Pine.LNX.4.44.0211101502460.2113-100000@serv>
References: <20021110132750.GB6256@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 10 Nov 2002, Romain Lievin wrote:

> I worked on a kernel configuration tool similar to Qconf but written with 
> GTK+... You will find it at <http://tilp.info/perso/gconfig.html>.

I needed the patch below to get it working at all. sym_get_choice_value() 
might return a NULL pointer. The choice value is only updated if the 
choice symbol is yes and even then it can be NULL, if no choice value is 
visible.
I couldn't select 'Adaptec AIC7xxx support'. Choice symbols are special 
tristate symbols, beside having the tristate value it also points to a 
choice value.
The autoexpand mode is very annoying, even after changing a single symbol 
everything is expanded again. Keyboard support is basically nonexistent.

Anyway, it looks interesting, but still needs quite some work. :)

bye, Roman

--- src/callbacks.c.org	2002-11-10 15:12:12.000000000 +0100
+++ src/callbacks.c	2002-11-10 15:11:59.000000000 +0100
@@ -648,7 +648,8 @@
 				def_menu = child;
 		}
 		
-		row[5] = g_strdup(menu_get_prompt(def_menu));
+		if (def_menu)
+			row[5] = g_strdup(menu_get_prompt(def_menu));
 	}
 		
 	type = sym_get_type(sym);

