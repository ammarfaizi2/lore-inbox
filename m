Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbVBOBQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVBOBQW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 20:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVBOBQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 20:16:16 -0500
Received: from oracle.bridgewayconsulting.com.au ([203.56.14.38]:48613 "EHLO
	oracle.bridgewayconsulting.com.au") by vger.kernel.org with ESMTP
	id S261596AbVBOBNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 20:13:52 -0500
Date: Tue, 15 Feb 2005 09:13:26 +0800
From: Bernard Blackham <bernard@blackham.com.au>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Address lots of pending pm_message_t changes
Message-ID: <20050215011326.GP10786@blackham.com.au>
References: <1108359808.12611.37.camel@desktop.cunningham.myip.net.au> <20050214213400.GF12235@elf.ucw.cz> <20050214134658.324076c9.akpm@osdl.org> <1108418226.12611.75.camel@desktop.cunningham.myip.net.au> <20050214220459.GM12235@elf.ucw.cz> <1108418990.12611.86.camel@desktop.cunningham.myip.net.au> <20050214234151.GA2134@elf.ucw.cz> <1108426556.3666.1.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108426556.3666.1.camel@desktop.cunningham.myip.net.au>
Organization: Dagobah Systems
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Trimmed Cc]

On Tue, Feb 15, 2005 at 11:15:56AM +1100, Nigel Cunningham wrote:
> > Well, yes, if you switch pm_message_t into struct. But we are not yet
> > ready to do that... it is going to be typedefed to u32 for 2.6.11...
> 
> Ah. So I haven't realised that Bernard took your patches wholesale,
> which is why we're fixing the compile errors too :>
> 
> Okay then, I guess the whole thing isn't urgent then?

I was taking the whole shebang in order to differentiate between
PMSG_FREEZE and PMSG_SUSPEND - they're currently typedef'd to the
same thing (3), so drivers such as ide-disk can't decide whether or
not they need to spin down for the atomic copy or for powering off.
(Otherwise you'll find the HDD spinning down and up mid-suspend).

I believe vanilla swsusp passed "3" as the power state hence the HDD
spun down and up anyway, so there were no regressions there, just
bugs. Software Suspend 2 passed "4" as the power state which
ide-disk.c treated as "flush caches, but don't spin down". This is
what broke when the new typedefs went in, but would be fixed when
they're complete (whole shebang).

Bernard.

-- 
 Bernard Blackham <bernard at blackham dot com dot au>
