Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbTEYMZp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 08:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbTEYMZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 08:25:45 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:48646 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262063AbTEYMZn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 08:25:43 -0400
Date: Sun, 25 May 2003 14:35:29 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Willy Tarreau <willy@w.ods.org>, gibbs@scsiguy.com,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: Undo aic7xxx changes
Message-ID: <20030525123529.GA931@pcw.home.local>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva> <2804790000.1052441142@aslan.scsiguy.com> <20030509120648.1e0af0c8.skraw@ithnet.com> <20030509120659.GA15754@alpha.home.local> <20030509150207.3ff9cd64.skraw@ithnet.com> <20030524111608.GA4599@alpha.home.local> <20030525125811.68430bda.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030525125811.68430bda.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

On Sun, May 25, 2003 at 12:58:11PM +0200, Stephan von Krawczynski wrote:
> it did not take really long for rc3+aic20030520 to freeze - exactly one day.

Well, in some ways, it will be easier to debug it than when it took 14 days, if
it's the same bug, of course.

> Though I used nmi_watchdog there are no presentable outputs. As I expected the
> screen simply is black and no messages are in any logfiles.
> Again it froze while tar-ing about 80 GB of data onto an aic-driven SDLT. Data
> is coming from IDE drive connected to a 3ware 7500-8 (though no raid
> configuration). 

OK, so there's a high probability that the problem is related to either SCSI or
IDE (or both), and less likely implies any other parts.

> Ah yes, one more thing: I can ping the box, but keyboard, mouse, display is
> dead and usually working processes stopped (like snmp).

that's surprizing, mine was completely dead IIRC. It's like it doesn't schedule
anymore but still processes interrupts. I don't know if a deadlock can cause
this behaviour.

> Willy: I am willing to try a serial console setup (as it does not interfere
> with X). I have tried this before with no luck. Can you provide some hints how
> you got that working (yes, I read Documentation/serial-console.txt, but I could
> not manage any output on the serial line).

I had to try several times, because the freeze was so sudden that I often 
caught only a few chars. Justin even didn't believe me. First, you have to
check that CONFIG_SERIAL_CONSOLE is enabled. After that, you'll need a remote
console which can work at high speeds (I could get interesting results at 38400
bps). Surprizingly, above I had mangled output. Perhaps my cable wasn't good
enough (flat cisco RJ45 console cable). I also disabled hard and soft flow
control. But as I already stated, in my case it was easier because it froze
every 2-3 boots, and when it didn't I only had to start a "make -j dep" to get
it. So if I got frozen with no messages, I simply hit the reset button and tried
again. It seems more complicated in your case (although your big tar may be
helping).

When your setup seems OK, you should test it to be sure. I often use "mdir"
with nothing in the drive, or AltGr-SysRq-P to get console messages. If you
don't see anything on your serial console, then your setup is not ready yet
for a test.

Oh and by the way, if you're using modules, you may find interesting to keep
copies of lsmod output, and /proc/ksyms to get a more accurate decoding with a
further ksymoops.

If you really cannot catch anything, I suggest one of these solutions :
  - apply the netconsole patch and have a linux box on the same lan with the
    netconsole server. You can find it in -aa kernels for example.
  - apply the kmsgdump patch, only if you have a floppy drive or a parallel
    printer. It will try to reset the system after a panic, and use bios calls
    to write the kernel messages buffer on the media. This usually works, but
    there are some corner cases where it doesn't. But it's easy to try with
    AltGr-SysRq-D. Download it from http://w.ods.org/tools/kmsgdump/

Good luck !
Willy

