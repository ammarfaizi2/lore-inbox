Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbTBKSaD>; Tue, 11 Feb 2003 13:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbTBKSaD>; Tue, 11 Feb 2003 13:30:03 -0500
Received: from mail5.bluewin.ch ([195.186.1.207]:39143 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id <S261353AbTBKSaC>;
	Tue, 11 Feb 2003 13:30:02 -0500
Date: Tue, 11 Feb 2003 19:39:43 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Henrik Persson <nix@socialism.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: via rhine bug? (timeouts and resets)
Message-ID: <20030211183943.GA2443@k3.hellgate.ch>
Mail-Followup-To: Henrik Persson <nix@socialism.nu>,
	linux-kernel@vger.kernel.org
References: <200302111344.h1BDiMPY067070@sirius.nix.badanka.com> <20030211154449.GA2252@k3.hellgate.ch> <200302111652.h1BGq0PY067795@sirius.nix.badanka.com> <20030211171736.GA1359@k3.hellgate.ch> <200302111745.h1BHjdPY067992@sirius.nix.badanka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302111745.h1BHjdPY067992@sirius.nix.badanka.com>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.60 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2003 18:44:59 +0100, Henrik Persson wrote:
> RL> _same_ errors my guess is you're still running the old driver. Check
> RL> the log at debug=3.
> 
> Darn. The same PROBLEMS, not the same errors. Indeed, the errors are not
> there. But the behaviour is still the same, i.e. slow speeds after a
> while.. :/

No errors at all? No "Transmitter underrun" (at debug>1)? I suspect you hit
two more bugs: If the driver resets the chip (e.g. watchdog timeout),
chances are the chip is programmed to go half-duplex -> performance breaks
down. No problem as long as we deal with errors properly, but the Rhine-II
can throw an error the mainline driver doesn't notice because the interrupt
status registers stay clean.

Can I see a complete log (at debug=3), starting with module insertion?
There's got to be some underrun and watchdog timeout.

> But it's not as bad as it got a few minutes ago when I tested the driver
> from scyld.com.. It totally trashed my NIC.. A shame though, since it ran

Define "trashed". How exactly did it misbehave, what did you have to do to
get it back working? Anything interesting in the log before it breaks?

FWIW, it is possible to get a Rhine into a state where physically removing
the PCI card from the computer and keeping both away from any power source
for an hour still results in the driver hanging on boot (after putting
everything back together, of course). I've gone through this twice so far.
Voodoo magic.

Roger
