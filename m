Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290017AbSBFEkc>; Tue, 5 Feb 2002 23:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290020AbSBFEkW>; Tue, 5 Feb 2002 23:40:22 -0500
Received: from alcove.wittsend.com ([130.205.0.10]:50115 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S290017AbSBFEkL>; Tue, 5 Feb 2002 23:40:11 -0500
Date: Tue, 5 Feb 2002 23:40:09 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18-pre8 - Good news and bad news...
Message-ID: <20020205234009.A6268@alcove.wittsend.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

	I've been trying to work around a problem since 2.4.16 where
the kernel would Oops on my gateway system with the EIP = 0010:5a5a5a5a.

	Several people had excellent suggestions, most of which had
no effect beyond eliminating the innocent (which is what I would hope
for anyways).  My thanks to all.

	One person asked if I was using DevFS.  I was, since I also work
on and test the Computone Multiport drivers and need to have that working
with DevFS.  They suggested disabling DevFS which I did and which had
absolutely no effect on the 5a5a5a5a problem.

	After seeing a post from Alan Cox about 2.4.18-pre7, I compiled
that up and started the gateway on it.  After it ran for a day (which
previous versions had NOT done) I left it to run for the week I was
in New York for LinuxWorld Expo.  OK, So I'm a DAMN IDIOT who likes to
live dangerously.  My SO knew how to reboot the gateway in case it went
tits up, which it did almost a week later.  It was set up to reboot to
a safe kernel (2.2.20) till I could get back and autopsy the corpse.
No problem...  :-)

	The good news...  The 5a5a5a5a Oops seems to be gone.  The Oops
in 2.4.18-pre7 was different and took a LOT longer to blow.  I didn't
try to reproduce it, since 2.4.18-pre8 was out.

	Now for the bad news...

	I build a new kernel with 2.4.18-pre8 and the latest FreeS/WAN
(1.95).  The only reason I mention FreeS/WAN is that this is the only
kernel mod from the stock tree and patches.  I also turned DevFS back
on, so I could test that.  I discovered that 2.4.18-pre8 would only
come up about (actually exactly) 50% of the time.  If it was a clean
reboot, I would get an Oops in the scheduler pretty early during
initialization.  The EIP in the Oops seemed different every time.
If it had to fsck the file systems, it wouldn't generate an Oops and
would boot, but I had trouble with a site which was logging into my
gateway over PPP and the Computone board.  There seem to be no traffic
after the initial "CONNECT" (which occurs with CF unaccerted).  Problems
just seemed to be bizzare and unpredicatable beyond the "every other boot"
weirdness.

	A little more investigation indicated that the every-other boot
Oops was occuring EXACTLY when the system was mounting "other filesystems"
which, in this case, meant DevFS and usbdevfs.  That's when I remembered
re-enabling DevFS in the build.  I re-disabled DevFS, rebuilt the kernel,
and then the system booted and my remote site managed to log in successfully,
first time, no problem.  This was after MULTIPLE failures with DevFS enabled.
(Hours of time shot.)

	Sooo...

	Good news...  My reported 5a5a5a5a Oops appears to have evaporated
with the changes that went in around 2.4.18-pre7.  Congrats and thanks!

	Bad news...  DevFS SEEMS to have problems.  Since I disabled it
early in the 2.4.18-pre series and could never get 2.4.17 stable, I have
no idea where the problem was introduced.  I did NOT see this in 2.4.16.

	I'm not looking for suggestions this time around, just reporting
observations.  My gateway is now running 2.4.18-pre8 and I'll report any
Oops if and when it occurs and deal with that then.  I may see if the
DevFS problem exists on my other systems, but my high traffic gateway
has been the only system to exhibit some of these problems to date.

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  /\/\|=mhw=|\/\/       |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!
