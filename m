Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbUDCDFu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 22:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUDCDFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 22:05:50 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:33695 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S261322AbUDCDFt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 22:05:49 -0500
Date: Fri, 2 Apr 2004 20:05:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6-mm] early_param console_setup clobbers commandline
Message-ID: <20040403030537.GF31152@smtp.west.cox.net>
References: <Pine.LNX.4.58.0404022026560.11690@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404022026560.11690@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 08:32:10PM -0500, Zwane Mwaikambo wrote:
> console_setup clobbers the argument it's passed, resulting in
> the commandline being chopped (it inserts a '\0'). A sample command line
> would be;
> 
> ro root=/dev/hda1 profile=2 debug console=tty0 console=ttyS0,38400 hugepages=20 nmi_watchdog=2
> 
> would end up like;
> 
> ro root=/dev/hda1 profile=2 debug console=tty0 console=ttyS0

This shouldn't be a problem 'tho, since we don't allow for spaces in
args, and we do find where the next space is, and ensure it's still a
space after the call (because console can splice up the command line,
but we'd skip over those bits anyhow).

> I believe this may be the only setup call which clobbers the argument, so
> how about we pass a copy (i wasn't sure about what would be a decent
> argument length so i just went with COMMAND_LINE_SIZE (ugly, yes)?
> Something like the following tested patch;

pci= will clobber as well, which is why I thought I asked Andrew to drop
that part of the i386 patch (but perhaps I forgot, and with Rusty's
patch, it becomes a non-issue again).

-- 
Tom Rini
http://gate.crashing.org/~trini/
