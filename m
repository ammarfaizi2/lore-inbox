Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272755AbTG1Irb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 04:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272757AbTG1Ira
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 04:47:30 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:52237 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S272755AbTG1IrZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 04:47:25 -0400
Date: Mon, 28 Jul 2003 11:02:26 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, <torvalds@osdl.org>, Andi Kleen <ak@suse.de>
Subject: Re: PATCH: console on by default if not embedded (save mucho pain)
In-Reply-To: <200307272002.h6RK215U029586@hraefn.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0307281056400.717-100000@serv>
References: <200307272002.h6RK215U029586@hraefn.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 27 Jul 2003, Alan Cox wrote:

> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/char/Kconfig linux-2.6.0-test2-ac1/drivers/char/Kconfig
> --- linux-2.6.0-test2/drivers/char/Kconfig	2003-07-10 21:04:38.000000000 +0100
> +++ linux-2.6.0-test2-ac1/drivers/char/Kconfig	2003-07-16 18:39:32.000000000 +0100
> @@ -5,8 +5,9 @@
>  menu "Character devices"
>  
>  config VT
> -	bool "Virtual terminal"
> +	bool "Virtual terminal" if EMBEDDED
>  	requires INPUT=y
> +	default y
>  	---help---
>  	  If you say Y here, you will get support for terminal devices with
>  	  display and keyboard devices. These are called "virtual" because you

The patch below is better and this is one actually fixes most of the 
upgrade pain, as the other options have reasonable defaults.
I'm not sure we should hide that much behind EMBEDDED, for people who just 
want to load an old config and expect something workable the patch below 
is enough, other people have to search for all the options hidden behind 
EMBEDDED.

bye, Roman

Index: drivers/char/Kconfig
===================================================================
RCS file: /home/other/cvs/linux/linux-2.6/drivers/char/Kconfig,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 Kconfig
--- drivers/char/Kconfig	14 Jul 2003 09:22:00 -0000	1.1.1.1
+++ drivers/char/Kconfig	22 Jul 2003 08:08:26 -0000
@@ -6,7 +6,7 @@ menu "Character devices"
 
 config VT
 	bool "Virtual terminal"
-	requires INPUT=y
+	select INPUT
 	---help---
 	  If you say Y here, you will get support for terminal devices with
 	  display and keyboard devices. These are called "virtual" because you

