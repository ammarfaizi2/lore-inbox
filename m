Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265846AbRFYCTG>; Sun, 24 Jun 2001 22:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265845AbRFYCS4>; Sun, 24 Jun 2001 22:18:56 -0400
Received: from c109854-a.frmt1.sfba.home.com ([65.11.45.79]:49425 "HELO
	windriver.loc") by vger.kernel.org with SMTP id <S265846AbRFYCSn>;
	Sun, 24 Jun 2001 22:18:43 -0400
Date: Sun, 24 Jun 2001 19:18:41 -0700
From: Galen Hancock <galen@CSUA.Berkeley.EDU>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Message-ID: <20010624191841.X12235@c109854-a.frmt1.sfba.home.com>
Mail-Followup-To: "J . A . Magallon" <jamagallon@able.es>,
	"linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010625003002.A1767@werewolf.able.es>
User-Agent: Mutt/1.3.18i
X-URL: http://www.CSUA.Berkeley.EDU/~galen/gh.xhtml
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2001 at 12:30:02AM +0200, J . A . Magallon wrote:
> shell scripting, for example. Or multithreaded web servers. With the above
> test (fork() + immediate exec()), you just try to mesaure the speed of fork().

The benchmark that used lmbench that was posted tested fork follwed fork
by exit not follwed by exec.

Although you could have used vfork in that test, the point of the test
was to get some feel for how much overhead the fork and exit together
had. A real application could not use vfork, because it would do some
actual work before the exit.

> Say you have a fork'ing server. On each connection you fork and exec the
> real transfer program.

Most forking servers I know of don't exec programs to deal with accepted
connections. (The only exception I can think of is inetd and its
cousins, the performance of which is not important.)

>                        There time for fork matters. It can run very fast
> in Linux but suck in other systems. Just because the programmer chose fork()
> instead of vfork().

vfork is not portable. There are standards that specify what it does,
but the portable semantics are so useless that if you use it you will
almost certainly wind up with undefined behavior.

However, the original discussion was about threads. How to do fork+exec
(or vfork+exec if you insist on using that broken interface) quickly is
beside the point.

> >> The clean battle should be linux fork-exec vs vfork-exec in
> >> Solaris, because for in linux is really a vfork in solaris.

> >But the point of threading is it's a fork WITHOUT an exec.

> Not always, see above.

You appear to be saying that spawning child programs is an example of
threading. I don't think that's what most people mean by threading.

					Galen
