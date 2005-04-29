Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262938AbVD2Uhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262938AbVD2Uhx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 16:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262940AbVD2UNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 16:13:07 -0400
Received: from mailfe08.swip.net ([212.247.154.225]:50592 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262939AbVD2UMA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 16:12:00 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: 2.6.11.7 kernel panic on boot on AMD64
From: Alexander Nyberg <alexn@telia.com>
To: Andi Kleen <ak@suse.de>
Cc: Ruben Puettmann <ruben@puettmann.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, rddunlap@osdl.org
In-Reply-To: <20050429144501.GH21080@wotan.suse.de>
References: <20050427140342.GG10685@puettmann.net>
	 <1114769162.874.4.camel@localhost.localdomain>
	 <20050429143215.GE21080@wotan.suse.de>
	 <20050429144103.GK18972@puettmann.net>
	 <20050429144501.GH21080@wotan.suse.de>
Content-Type: text/plain
Date: Fri, 29 Apr 2005 22:11:56 +0200
Message-Id: <1114805516.7659.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok. If you really had such a overlong command line it is ok.
> 
> We should probably check this condition better too and error out.
> 

How about something like this then (I was thinking making it a panic but
not sure). I think it's a good idea to give some kind of indication so
that there is at least some message when the user discovers that some
things specified on cmdline don't start/work.


Check if the user specified a too long kernel command line and warn
about it being truncated. 

Signed-off-by: Alexander Nyberg <alexn@telia.com>

Index: linux-2.6/init/main.c
===================================================================
--- linux-2.6.orig/init/main.c	2005-04-26 11:41:57.000000000 +0200
+++ linux-2.6/init/main.c	2005-04-29 20:28:44.000000000 +0200
@@ -456,6 +456,8 @@
 	build_all_zonelists();
 	page_alloc_init();
 	printk(KERN_NOTICE "Kernel command line: %s\n", saved_command_line);
+	if (strlen(saved_command_line) == COMMAND_LINE_SIZE-1)
+		printk(KERN_ALERT "WARNING: Too long command line! Truncated.\n");
 	parse_early_param();
 	parse_args("Booting kernel", command_line, __start___param,
 		   __stop___param - __start___param,




