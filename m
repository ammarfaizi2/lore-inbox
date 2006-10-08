Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWJHVv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWJHVv0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 17:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWJHVv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 17:51:26 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37865 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751490AbWJHVvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 17:51:25 -0400
Date: Sun, 8 Oct 2006 23:51:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pm@osdl.org
Subject: Re: Funky "Blue screen" issue while rebooting from X with 2.6.18-git21
Message-ID: <20061008215110.GF4152@elf.ucw.cz>
References: <9a8748490610041316w3ad442a6rf8f5fc5189fd72ac@mail.gmail.com> <20061008174759.GF6755@stusta.de> <20061008183406.GA4496@ucw.cz> <9a8748490610081446y6103a9b1o491ce87250beabfb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490610081446y6103a9b1o491ce87250beabfb@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> > I have a strange "problem" with 2.6.18-git21 that I've never had with
> >> > any previous kernel. If I open up an xterm in X, su to root and
> >> > 'reboot' (or 'shutdown -r now') I instantly get a blue screen that
> >> > persists until the box actually reboots.
> >>
> >> Pavel, is this a known issue or should Jesper bisect?
> >
> >Jesper should show it is kernel problem and not userland race.
> >
> 
> Jesper will try to do that ;-)
> 
> 
> >If userspace does kill -15 -1; kill -9 -1, and X fails to shut down in
> >time, it is userland problem ('should wait for X to shut down').
> >
> 
> Well, I just checked my initscript that is run when going into
> runlevels 0 & 6, and it does this :
> 
> (...)
> 
> # Kill all processes.
> # INIT is supposed to handle this entirely now, but this didn't always
> # work correctly without this second pass at killing off the processes.
> # Since INIT already notified the user that processes were being killed,
> # we'll avoid echoing this info this time around.
> if [ ! "$1" = "fast" ]; then # shutdown did not already kill all processes
>  /sbin/killall5 -15
>  /bin/sleep 5
>  /sbin/killall5 -9
> fi

...so, if X takes more than five seconds to shut down, you kill it
with -9, resulting in blue screen. Too bad, and not an kernel problem.

Try inserting something like

	while ps -aux | grep myXserver;
		sleep 1;
	done

alternatively, remove/shorten the sleep and you should experience blue
screen in 2.6.17.

> kernels, but since somewhere in the 2.6.18-rc series I've experienced
> this "blue screen" problem once in a while and I've also had a problem
> with the screen going all white when switching from X to a plain tty
> and back (once it goes white it stays that way permanently until I
> reboot) - I *never* see those issues when running 2.6.17.x and
> earlier.

Maybe something got slower in 2.6.18?
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
