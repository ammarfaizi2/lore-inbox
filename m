Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277141AbRJQUFa>; Wed, 17 Oct 2001 16:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277143AbRJQUFV>; Wed, 17 Oct 2001 16:05:21 -0400
Received: from maties1.sun.ac.za ([146.232.128.1]:52676 "EHLO
	maties1.sun.ac.za") by vger.kernel.org with ESMTP
	id <S277141AbRJQUFE>; Wed, 17 Oct 2001 16:05:04 -0400
Date: Wed, 17 Oct 2001 22:05:19 +0200
From: Hugo van der Merwe <hugovdm@mail.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: ps/2 mouse, keyboard conflicts
Message-ID: <20011017220519.C14119@baboon.wilgenhof.sun.ac.za>
In-Reply-To: <20011017144158.A6534@baboon.wilgenhof.sun.ac.za> <Pine.LNX.4.10.10110171314400.29412-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10110171314400.29412-100000@coffee.psychology.mcmaster.ca>
User-Agent: Mutt/1.3.23i
X-Scanner: exiscan *15twwO-0005iE-00*czo8aXB1lPI* http://duncanthrax.net/exiscan/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Any ideas how I can debug this problem?
> 
> well, sanity-checking should happen first.  for instance,
> bios settings, whether you have the mouse plugged into the 
> mouse PS/2 port (they're often different), and what kinds
> of messages the kernel prints regarding these items...

OK, some lies ... it seems I have ps/2 support compiled in, not as a
module. If I start gpm with parameters that makes it read ps2 mouse, the
keyboard and the mouse stops working immediately. However, a while back,
when using ps/2 in X only, I could start X and use it for a while, only
after a few minutes does it all "lock up". Then killing X with the
serial mouse gave me my keyboard back.

I don't recall having changed anything in the BIOS since my 2.2 days,
when the mouse worked fine. (I cannot say for certain that it broke
during my 2.2->2.4 upgrade. Should I install a 2.2. kernel again and see
if it happens there?) What setting in the BIOS should I be playing with?

I don't find anything special in syslog or any other log file.
/var/log/dmesg has the one related line:

Detected PS/2 Mouse Port.

When gpm is "using" the mouse, I see the following line
in /proc/interrupts:

 12:          0          XT-PIC  PS/2 Mouse

That 0 probably means something? When gpm is not using the mouse, there
is no line for interrupt 12. (I do notice my sound card and one of my
two network cards is sharing interrupt 10. Is this something that might
have negative consequences?)

I sometimes notice the following in user.log:
Oct 17 21:54:45 baboon /usr/sbin/gpm[14687]: oops() invoked from gpn.c(204)
Oct 17 21:54:45 baboon /usr/sbin/gpm[14687]: /var/run/gpm.pid: No such file or directory
It doesn't happen very often though, and might be tied to the staring
and stopping of gpm, rather than with the functioning of the ps/2 port. 
I cannot reproduce this reliably.

What else might be involved? /proc/{iomem,ioports,dma} are the same with
gpm with ps/2 running and not running.

Thanks,
Hugo van der Merwe

ps, please CC me, thanks. How high is this list's traffic, and where is
its archive?
