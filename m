Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266243AbTBKVFz>; Tue, 11 Feb 2003 16:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266308AbTBKVFv>; Tue, 11 Feb 2003 16:05:51 -0500
Received: from mail4.bluewin.ch ([195.186.4.74]:48840 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id <S266243AbTBKVFb>;
	Tue, 11 Feb 2003 16:05:31 -0500
Date: Tue, 11 Feb 2003 22:15:16 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Henrik Persson <nix@socialism.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: via rhine bug? (timeouts and resets)
Message-ID: <20030211211516.GA6140@k3.hellgate.ch>
Mail-Followup-To: Henrik Persson <nix@socialism.nu>,
	linux-kernel@vger.kernel.org
References: <200302111344.h1BDiMPY067070@sirius.nix.badanka.com> <20030211154449.GA2252@k3.hellgate.ch> <200302111652.h1BGq0PY067795@sirius.nix.badanka.com> <20030211171736.GA1359@k3.hellgate.ch> <200302111745.h1BHjdPY067992@sirius.nix.badanka.com> <20030211183943.GA2443@k3.hellgate.ch> <200302111855.h1BItiPY068299@sirius.nix.badanka.com> <20030211193126.GA3136@k3.hellgate.ch> <200302112031.h1BKVjPY068673@sirius.nix.badanka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302112031.h1BKVjPY068673@sirius.nix.badanka.com>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.60 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2003 21:31:10 +0100, Henrik Persson wrote:
> And look what came up when I stressed the net a bit.. Worked fine at
> first, though.. But I guess that depends on other things.. Sunset and
> all.. Heh ;)

It's pretty easy to trigger, actually. Just have some heavy traffic going
in _and_ out, e.g. netcat blowing iso images both ways. It will last a
couple of seconds at most.

> Well.. dmesg attached..

# eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
# eth0: Done via_rhine_open(), status 0c1a MII status: 782d.
# eth0: no IPv6 routers present
# eth0: Transmit error, Tx status 00008800.
# eth0: Transmitter underrun, Tx threshold now 40.
# eth0: Transmit error, Tx status 00008800.
# eth0: Transmitter underrun, Tx threshold now 60.
# eth0: Transmit error, Tx status 00008800.
# eth0: Transmitter underrun, Tx threshold now 80.
# Gotcha: 0x2 0x8 0x0
# Gotcha: 0x1 0x8 0x0
# Gotcha: 0x1 0x8 0x0
# NETDEV WATCHDOG: eth0: transmit timed out
# eth0: Transmit timed out, status 0000, PHY status 782d, resetting...
# eth0: Reset succeeded.

As expected. Now comes the punch line: I don't know how to fix this. I
locked my machine up solid a couple of times trying. It seems that
particular flag doesn't want to be cleared. Of course I could simply reset
the chip, but that's a) less than elegant and b) would make cleaning up the
force_media mess kind of urgent. And doing that properly is a rather
non-trivial change. Also, I need to investigate the implications for
Rhine-III and have somebody test Rhine-I.

Thanks for the logs, though; at least now I know that many more would hit
that problem if they weren't using a driver that breaks down way earlier.
If the problem bothers you I can send you a dirty hack. I need to whack
some registers before writing a proper fix, and I don't know when that will
happen.

Roger
