Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbUDCUPG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 15:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbUDCUPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 15:15:06 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:716 "EHLO fed1mtao02.cox.net")
	by vger.kernel.org with ESMTP id S261918AbUDCUPB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 15:15:01 -0500
Date: Sat, 3 Apr 2004 13:14:50 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6-mm] early_param console_setup clobbers commandline
Message-ID: <20040403201450.GG31152@smtp.west.cox.net>
References: <Pine.LNX.4.58.0404022026560.11690@montezuma.fsmlabs.com> <20040403030537.GF31152@smtp.west.cox.net> <Pine.LNX.4.58.0404031028090.11690@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404031028090.11690@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 03, 2004 at 10:40:01AM -0500, Zwane Mwaikambo wrote:

> On Fri, 2 Apr 2004, Tom Rini wrote:
> 
> > This shouldn't be a problem 'tho, since we don't allow for spaces in
> > args, and we do find where the next space is, and ensure it's still a
> > space after the call (because console can splice up the command line,
> > but we'd skip over those bits anyhow).
> 
> Another new thing is that all setup functions get called with their
> parameter and any other trailing arguments. So console_setup sees;
> 
> tty0 console=ttyS0,38400 hugepages=20 nmi_watchdog=2
> 
> That's different enough to cause potential problems in future.

I _thought_ I had put in bits to make it only pass along the argument,
but perhaps that got lost in my testing/retesting.

> > pci= will clobber as well, which is why I thought I asked Andrew to drop
> > that part of the i386 patch (but perhaps I forgot, and with Rusty's
> > patch, it becomes a non-issue again).
> 
> What is the patch name for Rusty's patch?

I don't know, since I think once he got it working he forgot to CC lkml.
But I certainly hope it's in the next -mm since it replaced the
parse_early_options parsing code with parse_args, so all of the stupid
things my re-implementation got wrong, it doesn't.

-- 
Tom Rini
http://gate.crashing.org/~trini/
