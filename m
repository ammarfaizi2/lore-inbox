Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbUDABvy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 20:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUDABvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 20:51:54 -0500
Received: from ozlabs.org ([203.10.76.45]:35221 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261787AbUDABvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 20:51:52 -0500
Subject: Re: [patch 1/22] Add __early_param for all arches
From: Rusty Russell <rusty@rustcorp.com.au>
To: Tom Rini <trini@kernel.crashing.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040331161305.GK13819@smtp.west.cox.net>
References: <20040324235722.QDLK23486.fed1mtao04.cox.net@localhost.localdomain>
	 <1080706985.29195.12.camel@bach> <20040331161305.GK13819@smtp.west.cox.net>
Content-Type: text/plain
Message-Id: <1080784297.1999.89.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 01 Apr 2004 11:51:41 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-01 at 02:13, Tom Rini wrote:
> My first concern is can parse_args & co really be run so very early on ?

If you can run normal C code, yes.  It doesn't require any
initialization.

> Also:

> > +/* Arch code calls this early on. */
> > +void __init parse_early_options(const char *saved_command_line)
> > +{
> > +	static char __initdata command_line[COMMAND_LINE_SIZE];
> > +	strcpy(command_line, saved_command_line);
> 
> Really should be:
> /* i386 goes right to saved_command_line */
> if (*cmdline_p != saved_command_line)
> 	memcpy(saved_command_line, *cmdline_p, COMMAND_LINE_SIZE);
> /* ensure NUL terminated. */
> saved_command_line[COMMAND_LINE_SIZE - 1] = '\0';

Why?  Other than the nul term (which I agree with), I didn't understand
that code.  

Get the archs to pass some command line in.  eg. i386 can do:

-	parse_cmdline_early(cmdline_p);
+	parse_early_options(*cmdline_p);

I feel that anyone destroying command lines should do their own
saving, and we should head that way...

Thanks,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

