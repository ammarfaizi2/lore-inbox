Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbVDEUq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVDEUq5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 16:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbVDEUpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 16:45:00 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2258 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261910AbVDEUlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 16:41:24 -0400
Date: Tue, 5 Apr 2005 22:41:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Norbert Preining <preining@logic.at>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: It's getting worse: 2.6.12-rc2-mm1 and suspend2ram
Message-ID: <20050405204107.GD1380@elf.ucw.cz>
References: <20050405181628.GB6879@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405181628.GB6879@gamma.logic.tuwien.ac.at>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Dear Andrew, dear Pavel, dear developers!
> 
> WIth 2.6.12-rc2-mm1 I cannot resume, and the laptop not even freezes, it
> immediately goes into reboot when resuming (suspend did work, well it
> looks like).
> 
> I booted into single user mode, stopped all programs (I could), unloaded
> all modules (I could), and then suspended, with the same result. In this
> single user mode my lsmod looked like this:
> 
> Module                  Size  Used by
> yenta_socket           18952  1 
> rsrc_nonstatic         11264  1 yenta_socket
> pcmcia_core            34704  2 yenta_socket,rsrc_nonstatic
> intel_agp              18844  1 
> agpgart                28488  1 intel_agp
> 
> and my ps -ax:
>   PID TTY      STAT   TIME COMMAND
>     1 ?        S      0:00 init [S]          
>     2 ?        SN     0:00 [ksoftirqd/0]
>     3 ?        S      0:00 [watchdog/0]
>     4 ?        S<     0:00 [events/0]
>     5 ?        S<     0:00 [khelper]
>     6 ?        S<     0:00 [kthread]
>     8 ?        S<     0:00 [kacpid]
>    98 ?        S<     0:00 [kblockd/0]
>   153 ?        S      0:00 [pdflush]
>   154 ?        S      0:00 [pdflush]
>   156 ?        S<     0:00 [aio/0]
>   155 ?        S      0:00 [kswapd0]
>   231 ?        S      0:00 [kseriod]
>   301 ?        S      0:00 [kjournald]
>   379 ?        S<s    0:00 udevd
>  2623 ?        S      0:00 [pccardd]
>  2634 ?        S      0:00 [pccardd]
>  3511 tty1     Ss     0:00 init [S]          
>  3516 tty1     S      0:00 bash
>  4417 tty1     R+     0:00 ps ax
> 
> It is interesting that I cannot unload the agp stuff, although to my
> eyes there is nothing which really is using the agp stuff (or is it
> udevd?). For the yenta/pcmcia I couldn't stop pccardd.
> 
> I though about trying to weed out my config, but I don't know where to
> start. I attach my config file, please comment on what I should leave
> out of the kernel for further testing.

I do not know why you can't unload them, but what about simply not
loading them at all? :-).

Or just rm -f them, it is hard to load module that is not there
;^))). Or init=/bin/bash....
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
