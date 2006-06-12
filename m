Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWFLRNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWFLRNF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWFLRNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:13:05 -0400
Received: from hera.kernel.org ([140.211.167.34]:17887 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751076AbWFLRND (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:13:03 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86 built-in command line
Date: Mon, 12 Jun 2006 10:12:52 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e6k7ak$gpd$1@terminus.zytor.com>
References: <20060611215530.GH24227@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1150132372 17198 127.0.0.1 (12 Jun 2006 17:12:52 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 12 Jun 2006 17:12:52 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20060611215530.GH24227@waste.org>
By author:    Matt Mackall <mpm@selenic.com>
In newsgroup: linux.dev.kernel
>
> This patch allows building in a kernel command line on x86 as is
> possible on several other arches.
> 
> Index: linux/arch/i386/kernel/setup.c
> ===================================================================
> --- linux.orig/arch/i386/kernel/setup.c	2006-05-26 16:18:13.000000000 -0500
> +++ linux/arch/i386/kernel/setup.c	2006-06-11 16:23:51.000000000 -0500
> @@ -713,6 +713,10 @@ static void __init parse_cmdline_early (
>  	int len = 0;
>  	int userdef = 0;
>  
> +#ifdef CONFIG_CMDLINE_BOOL
> +	strlcpy(saved_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> +#endif
> +
>  	/* Save unparsed command line copy for /proc/cmdline */
>  	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
>  

NAK.

a. Please make the patch available for x86-64 as well as x86.  The two
are coupled enough that they need to agree.

b. This patch will override a user-provided command line if one
exists.  This is the wrong behaviour; instead, the builtin command
line should only apply if no user-specified command line is present.

	-hpa

