Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbUDACYM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 21:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbUDACYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 21:24:12 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:63454 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S261988AbUDACYI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 21:24:08 -0500
Date: Wed, 31 Mar 2004 19:24:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 1/22] Add __early_param for all arches
Message-ID: <20040401022406.GC21709@smtp.west.cox.net>
References: <20040324235722.QDLK23486.fed1mtao04.cox.net@localhost.localdomain> <1080706985.29195.12.camel@bach> <20040331161305.GK13819@smtp.west.cox.net> <1080784297.1999.89.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080784297.1999.89.camel@bach>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 11:51:41AM +1000, Rusty Russell wrote:
> On Thu, 2004-04-01 at 02:13, Tom Rini wrote:
> > My first concern is can parse_args & co really be run so very early on ?
> 
> If you can run normal C code, yes.  It doesn't require any
> initialization.

No malloc'ing, etc?  OK.  Then yes, please create some sort of merged
patchset (I don't know how Andrew wants to handle it, maybe just replace
the core patch?)

> > Also:
> > > +/* Arch code calls this early on. */
> > > +void __init parse_early_options(const char *saved_command_line)
> > > +{
> > > +	static char __initdata command_line[COMMAND_LINE_SIZE];
> > > +	strcpy(command_line, saved_command_line);
> > 
> > Really should be:
> > /* i386 goes right to saved_command_line */
> > if (*cmdline_p != saved_command_line)
> > 	memcpy(saved_command_line, *cmdline_p, COMMAND_LINE_SIZE);
> > /* ensure NUL terminated. */
> > saved_command_line[COMMAND_LINE_SIZE - 1] = '\0';
> 
> Why?  Other than the nul term (which I agree with), I didn't understand
> that code.  
> 
> Get the archs to pass some command line in.  eg. i386 can do:
> 
> -	parse_cmdline_early(cmdline_p);
> +	parse_early_options(*cmdline_p);
> 
> I feel that anyone destroying command lines should do their own
> saving, and we should head that way...

memcpy(src, src, size) isn't good, is it?  On i386 we start out with the
commandline in saved_command_line.  Everyone else I believe has a local
var we point cmdline_p at, which gets copied into saved_command_line.

-- 
Tom Rini
http://gate.crashing.org/~trini/
