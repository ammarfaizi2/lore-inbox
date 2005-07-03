Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVGCOEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVGCOEp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 10:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVGCOEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 10:04:45 -0400
Received: from mx2.elte.hu ([157.181.151.9]:9705 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261444AbVGCOEk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 10:04:40 -0400
Date: Sun, 3 Jul 2005 16:04:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Weston <weston@sysex.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
Message-ID: <20050703140432.GA19074@elte.hu>
References: <200506281927.43959.annabellesgarden@yahoo.de> <200506301952.22022.annabellesgarden@yahoo.de> <20050630205029.GB1824@elte.hu> <200507010027.33079.annabellesgarden@yahoo.de> <20050701071850.GA18926@elte.hu> <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* William Weston <weston@sysex.net> wrote:

> FWIW, I'm still seeing the SMT scheduling? meltdown issues with 
> -50-42.  Running two instances of 'dd if=/dev/zero of=/dev/null 
> bs=65536' instead of 'burnP6' results in the same behavior.  Here's a 
> quick recap:
> 
> - Start (or login to ) X.
> - Start an X app that constantly updates the screen, like wmcube, or vlc.
> - Run 'burnP6' or 'dd if=/dev/zero of=/dev/null bs=65536'.
> - Run trace-it.  Trace completes without any troubles.
> - Run another 'burnP6' or 'dd if=/dev/zero of=/dev/null bs=65536'.
> 
> At this point, most of the system is unresponsive:
> 
> - Most X apps are frozen (even top in its own xterm).
> - Mouse lost synchro serio warnings show up on serial console.
> - Serial console is otherwise unresponsive (no SysRq).
> - X server quits responding to keyboard input.
> - Kbd input makes mouse temporarily unresponsive (for .1 to >5 secs).
> - Mouse immediately after kbd triggers more 'mouse lost synchro' messages.
> - Networking is lost (box won't respond to pings).
> - Any script automating starting burnP6 or dd and then trace-it hangs.
> 
> A few things are left working (but not enough to get the system back):
> 
> - Mouse pointer (movements are chunky) and window focus.
> - Mouse scroll wheel can still scroll xterms and switch workspaces.
> - SysRq-B

hm, i can reproduce a variant of this, by starting enough 'dd' tasks.  
(it needed more than two on a 2-way/4-way HT testbox though) Indeed 
everything seems to be starved, but SysRq still worked so i was able to 
SysRq-kIll all tasks and thus the system recovered.

i'm debugging this now.

	Ingo
