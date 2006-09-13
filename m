Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbWIMJWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWIMJWT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 05:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWIMJWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 05:22:19 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:1739 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751005AbWIMJWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 05:22:19 -0400
Date: Wed, 13 Sep 2006 11:23:27 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: "Alon Bar-Lev" <alon.barlev@gmail.com>
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/26] Dynamic kernel command-line - avr32 (resend with
 signoff)
Message-ID: <20060913112327.0d832f8c@cad-250-152.norway.atmel.com>
In-Reply-To: <9e0cf0bf0609070921k7a96f9f7x1605a66745feef9f@mail.gmail.com>
References: <200609040115.22856.alon.barlev@gmail.com>
	<200609040118.06291.alon.barlev@gmail.com>
	<20060907093111.1bf57c61@cad-250-152.norway.atmel.com>
	<9e0cf0bf0609070921k7a96f9f7x1605a66745feef9f@mail.gmail.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.0-rc2 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2006 19:21:17 +0300
"Alon Bar-Lev" <alon.barlev@gmail.com> wrote:

> On 9/7/06, Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:
>
> > On Mon, 4 Sep 2006 01:18:04 +0300
> > Alon Bar-Lev <alon.barlev@gmail.com> wrote:
> >  
> > >
> > > 1. Rename saved_command_line into boot_command_line.
> > > 2. Set command_line as __initdata.  
> >
> > I should probably start using that parse_early_param() stuff,
> > though. I'll update this patch if I do.

The patch "AVR32: Use parse_early_param" does that. Here's an updated
version of your patch that goes on top of that one.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/kernel/setup.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.18-rc5-mm1/arch/avr32/kernel/setup.c
===================================================================
--- linux-2.6.18-rc5-mm1.orig/arch/avr32/kernel/setup.c	2006-09-07 10:05:07.000000000 +0200
+++ linux-2.6.18-rc5-mm1/arch/avr32/kernel/setup.c	2006-09-07 10:30:00.000000000 +0200
@@ -44,7 +44,7 @@ struct avr32_cpuinfo boot_cpu_data = {
 };
 EXPORT_SYMBOL(boot_cpu_data);
 
-static char command_line[COMMAND_LINE_SIZE];
+static char __initdata command_line[COMMAND_LINE_SIZE];
 
 /*
  * Should be more than enough, but if you have a _really_ complex
@@ -202,7 +202,7 @@ __tagtable(ATAG_MEM, parse_tag_mem);
 
 static int __init parse_tag_cmdline(struct tag *tag)
 {
-	strlcpy(saved_command_line, tag->u.cmdline.cmdline, COMMAND_LINE_SIZE);
+	strlcpy(boot_command_line, tag->u.cmdline.cmdline, COMMAND_LINE_SIZE);
 	return 0;
 }
 __tagtable(ATAG_CMDLINE, parse_tag_cmdline);
@@ -317,7 +317,7 @@ void __init setup_arch (char **cmdline_p
 	init_mm.end_data = (unsigned long) &_edata;
 	init_mm.brk = (unsigned long) &_end;
 
-	strlcpy(command_line, saved_command_line, COMMAND_LINE_SIZE);
+	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
 	parse_early_param();
 
