Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270732AbRHKH04>; Sat, 11 Aug 2001 03:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270733AbRHKH0q>; Sat, 11 Aug 2001 03:26:46 -0400
Received: from pD9516138.dip.t-dialin.net ([217.81.97.56]:3322 "EHLO
	bonzo.nirvana") by vger.kernel.org with ESMTP id <S270732AbRHKH0i>;
	Sat, 11 Aug 2001 03:26:38 -0400
Date: Sat, 11 Aug 2001 09:26:23 +0200
From: Axel Thimm <Axel.Thimm@physik.fu-berlin.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Remotely rebooting a machine with state 'D' processes, how?
Message-ID: <20010811092623.A4877@bonzo.nirvana>
In-Reply-To: <20010810231906.A21435@bonzo.nirvana> <200108102159.f7ALxb908284@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200108102159.f7ALxb908284@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Aug 10, 2001 at 02:59:37PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2001 at 02:59:37PM -0700, Linus Torvalds wrote:
> In article <20010810231906.A21435@bonzo.nirvana> you write:
> > How can I reboot a stuck machine remotely, when there are uninterruptable
> > processes arround? shutdown -r, reboot [-n] [-f], telinit 6 do not give
> > the intended results. Localy I can use Alt-SysRq-S/U/B, but what if I
> > still have a remote ssh connection and don't want to have to get to the
> > machines location?
> >
> > Of course the real problem are the processes themselves, but being able to
> > revive a machine is also nice ;)
> You have to use the reboot() system call directly as root, with the proper
> arguments to make it avoid doing even any sync. See man 2 reboot for
> details.

Would there be a way to also simulate the effects of Alt-SysRq-S and
Alt-SysRq-U? A simple sync falls also into D-state, Alt-SysRq-S does not, as
far as I have had to use it.

Would an `emergency-reboot' binary that calls these three kernel calls be
possible and also good-to-have if it's not a too bad idea?

Is there a way to have this automated in some kind of a kernel software
watchdog? Given certain conditions (like processes in D-state for longer than
a specified time) the kernel might first try to call a userland-reboot and
this timing out the kernel might use the sync;umount;reboot procedure of
Alt-SysRq-S/U/B.

But even when I write this I realize the security hole potentials. If someone
could simulate the watchdog conditions for a reboot, he might be able to have
this machine reboot all the time.
-- 
Axel.Thimm@physik.fu-berlin.de
