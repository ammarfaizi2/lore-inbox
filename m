Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262237AbVD2KGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbVD2KGS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 06:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbVD2KGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 06:06:17 -0400
Received: from mailfe05.swip.net ([212.247.154.129]:27023 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262237AbVD2KGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 06:06:08 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: 2.6.11.7 kernel panic on boot on AMD64
From: Alexander Nyberg <alexn@telia.com>
To: Ruben Puettmann <ruben@puettmann.net>, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, rddunlap@osdl.org, ak@suse.de
In-Reply-To: <20050427140342.GG10685@puettmann.net>
References: <20050427140342.GG10685@puettmann.net>
Content-Type: text/plain
Date: Fri, 29 Apr 2005 12:06:02 +0200
Message-Id: <1114769162.874.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>                                                                                                            
> I'm trying to install linux on an HP DL385 but directly on boot I got                                           
> this kernel panic:
> 
>         http://www.puettmann.net/temp/panic.jpg


This is bogus appending stuff to the saved_command_line and at the same
time in Rubens case it touches the late_time_init() which breakes havoc.

Signed-off-by: Alexander Nyberg <alexn@telia.com>

Index: linux-2.6/arch/x86_64/kernel/head64.c
===================================================================
--- linux-2.6.orig/arch/x86_64/kernel/head64.c	2005-04-26 11:41:43.000000000 +0200
+++ linux-2.6/arch/x86_64/kernel/head64.c	2005-04-29 11:57:46.000000000 +0200
@@ -93,9 +93,6 @@
 #ifdef CONFIG_SMP
 	cpu_set(0, cpu_online_map);
 #endif
-	/* default console: */
-	if (!strstr(saved_command_line, "console="))
-		strcat(saved_command_line, " console=tty0"); 
 	s = strstr(saved_command_line, "earlyprintk=");
 	if (s != NULL)
 		setup_early_printk(s);


