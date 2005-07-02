Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVGBBrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVGBBrw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 21:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVGBBrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 21:47:52 -0400
Received: from unused.mind.net ([69.9.134.98]:8168 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S261173AbVGBBrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 21:47:49 -0400
Date: Fri, 1 Jul 2005 18:46:33 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
In-Reply-To: <20050701071850.GA18926@elte.hu>
Message-ID: <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org>
References: <200506281927.43959.annabellesgarden@yahoo.de>
 <200506301952.22022.annabellesgarden@yahoo.de> <20050630205029.GB1824@elte.hu>
 <200507010027.33079.annabellesgarden@yahoo.de> <20050701071850.GA18926@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jul 2005, Ingo Molnar wrote:

> oops - i had it in my tree (so all my tests passed), but it escaped the 
> -39 patch. I've uploaded -50-40 with this included too.

FWIW, I'm still seeing the SMT scheduling? meltdown issues with -50-42.  
Running two instances of 'dd if=/dev/zero of=/dev/null bs=65536' instead 
of 'burnP6' results in the same behavior.  Here's a quick recap:

- Start (or login to ) X.
- Start an X app that constantly updates the screen, like wmcube, or vlc.
- Run 'burnP6' or 'dd if=/dev/zero of=/dev/null bs=65536'.
- Run trace-it.  Trace completes without any troubles.
- Run another 'burnP6' or 'dd if=/dev/zero of=/dev/null bs=65536'.

At this point, most of the system is unresponsive:

- Most X apps are frozen (even top in its own xterm).
- Mouse lost synchro serio warnings show up on serial console.
- Serial console is otherwise unresponsive (no SysRq).
- X server quits responding to keyboard input.
- Kbd input makes mouse temporarily unresponsive (for .1 to >5 secs).
- Mouse immediately after kbd triggers more 'mouse lost synchro' messages.
- Networking is lost (box won't respond to pings).
- Any script automating starting burnP6 or dd and then trace-it hangs.

A few things are left working (but not enough to get the system back):

- Mouse pointer (movements are chunky) and window focus.
- Mouse scroll wheel can still scroll xterms and switch workspaces.
- SysRq-B

All of this behavior is 100% reproduceable on recent realtime SMP/SMT
kernels, and is _not_ seen with vanilla SMP/SMT, Fedora SMP, or realtime
UP kernels.  I'll be running realtime UP kernels on this Xeon/HT box for a
while unless someone gives me reason to enable SMT again.

You can tell me to shut up now.... at least until I decide to hunt down
another corner case ;-}


Best Regards,
--William Weston
