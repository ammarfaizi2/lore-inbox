Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313416AbSDGVos>; Sun, 7 Apr 2002 17:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313419AbSDGVor>; Sun, 7 Apr 2002 17:44:47 -0400
Received: from pasky.ji.cz ([62.44.12.54]:34300 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S313416AbSDGVor>;
	Sun, 7 Apr 2002 17:44:47 -0400
Date: Sun, 7 Apr 2002 23:44:45 +0200
From: Petr Baudis <pasky@pasky.ji.cz>
To: Jiri Mencak <j.mencak@hud.ac.uk>
Cc: gpm@lists.linux.it, linux-kernel@vger.kernel.org
Subject: Re: gpmselection
Message-ID: <20020407214445.GD3218@pasky.ji.cz>
Mail-Followup-To: Jiri Mencak <j.mencak@hud.ac.uk>, gpm@lists.linux.it,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020407205703.GB30641@mencak.homeip.net> <20020407214024.GC3218@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, this time with the correct Cc: stuff, sorry :).

Dear diary, on Sun, Apr 07, 2002 at 10:57:03PM CEST, I got a letter,
where Jiri Mencak <j.mencak@hud.ac.uk> told me, that...
> Do you know any program or even better a gpm feature via which I could 
> access GPM selection? Say I wanted to select text `Hello World!' on 
> a text console using GPM and then this program (let's call it 
> `gpmselection') would output to stdout:
> 
> % gpmselection
> Hello World!
> 
> It would be nice to write to gpm selection as well. Say by writing:
> % echo "Hello World!" | gpmselection
> 
> it would be possible to paste `Hello World!' on a console.
> 
> What I am aiming at is an echange of data between X and a console. I 
> have a program `xsel' which does the same thing with X-Window selection.

This is a problem. Been there, wanted to do that. However, you cry on the wrong
grave. GPM doesn't itself handle this stuff, kernel does. Yes, it's
fundamentally bad design, no, you can't directly access kernel's selection
buffer. Yes, this change would be probably welcomed in 2.5.x. I wanted to do
it, but I've too little time for that these days :(.

The stuff you want to rewrite is at /usr/src/linux/drivers/char/selection.c,
maybe random bits at /usr/src/linux/drivers/char/vt.c. And, obviously GPM, as
you want to move this functionality there. You probably want to completely
remove concept of selections from kernel, make GPM to read content of
/dev/vcc/X when grabbing a selection and output proper escape sequences for
inverting the appropriate stuff (this may be tricky; maybe you want to keep
such mechanism in the kernel.. you'll see), add write handler for /dev/vcc/X to
the kernel so that you can simulate keyboard input on the terminal and finally
make some generic API inside GPM for manipulation with the selection buffer.

Have fun ;),

-- 
 
				Petr "Pasky" Baudis
 
* ELinks maintainer                * IPv6 guy (XS26 co-coordinator)
* IRCnet operator                  * FreeCiv AI hacker
.
Teamwork is essential -- it allows you to blame someone else.
.
Public PGP key && geekcode && homepage: http://pasky.ji.cz/~pasky/
