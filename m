Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129776AbQLTRjK>; Wed, 20 Dec 2000 12:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129704AbQLTRjA>; Wed, 20 Dec 2000 12:39:00 -0500
Received: from alcove.wittsend.com ([130.205.0.20]:32015 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S129485AbQLTRiq>; Wed, 20 Dec 2000 12:38:46 -0500
Date: Wed, 20 Dec 2000 12:08:16 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Cc: "Michael H. Warfield" <mhw@wittsend.com>, linux-kernel@vger.kernel.org
Subject: Re: iptables: "stateful inspection?"
Message-ID: <20001220120816.C10408@alcove.wittsend.com>
Mail-Followup-To: Michael Rothwell <rothwell@holly-springs.nc.us>,
	"Michael H. Warfield" <mhw@wittsend.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3A40DBC2.AEC6B3CA@holly-springs.nc.us> <20001220112502.A10406@alcove.wittsend.com> <3A40DE97.96228B5E@holly-springs.nc.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <3A40DE97.96228B5E@holly-springs.nc.us>; from rothwell@holly-springs.nc.us on Wed, Dec 20, 2000 at 11:30:15AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2000 at 11:30:15AM -0500, Michael Rothwell wrote:
> "Michael H. Warfield" wrote:
> >         I think that's more than a little overstatement on your
> > part.  It depends entirely on the application you intend to put
> > it to.  

> Fine. How do I make FTP work through it? How can I allow all outgoing
> TCP connections without opening the network to inbound connections on
> the ports of desired services?

	Passive mode ftp works great for me.  You can also tack spf on
top of IPChains and get port mode working if that's really part of your
requirements.  If you really want to get sexy, you can use the MASQ
code to masquarade and handle the FTP for you.  Personally, I like
the MASQ trick better than using spf and enabling PORT mode.

	Policy routing helps out there as well where you want
to masquarade some services and let others pass untampered.  (Actually
you only REALLY need policy routing if you are also playing tricks
with the routing when you masquarade.)  I use policy routing anyways,
so I can route outbound ftp and http out a big fat unreliable broadband
pipe while protecting my static addresses through my nice reliable
ISDN channels.

	Your second question doesn't even seem to make sense to me.
Doesn't make sense as in either I don't understand your question or
the answer is so obvious if I do.  You allow outbound "SYN" packets
and block all (or only allow appropriate) inbound "SYN" packets (-y
option on the ipchains rules).  Or did I misunderstand your question?
In my case, inappropriate inbound SYN packets get portforwarded up to
Abacus PortSentry on the firewall to deal with port scanners.

	Yes, that setup still does allow people to do "FIN" scans and
other stealthy scans, but with Abacus PortSentry running in front of
everything and shutting down rogue sites that try to scan me that's
not a real great threat.  The IDS behind the firewall also fires off
if anyone tricky enough tries to stealth scan me WITHOUT an initial
SYN half scan or full scan (which would cut them off).

	Snort, behind the firewall, deals with the next layer of ankle
bitters that are just a little cut above the common riff raff that
try to port scan me.  Snort makes for yet another good adjunct to
both IPChains or NetFilter and PortSentry.  The combination is awesome
for frontend filtering and detection.  Anyone getting through that
without tripping an alarm is NOT an amateur and is worthy of my full,
undivided, PERSONAL attention (and I have custom detectors and surprises
for that level of "talent" as well).  :-)=)

	BTW...  Before anyone raises the customary remark about "What
about denial of service attacks by spoofing Abacus PortSentry"...
No one has documented an effective DoS attack against PortSentry
in the field.  It's just too difficult to do and too easy to protect
against.  My "evil twin" David LeBlanc (when he was still working with
me at Internet Security Systems a couple of years ago) tried it against
my PortSentry protected workstation.  He failed.  He knew everything
I had on that system including the PortSentry configuration and never
once managed to spoof so much as a single DoS attack that was effective.
If he couldn't do it with his level of talent and his knowledge of my
systems, it's going to take a world class talent who already knows my
entire setup to make that happen.  At that point, I have bigger problems
than worrying about PortSentry (and it's also a tip-off from PortSentry
that I need to be worried).  It would take a lot of effort and a lot of
incentive and a lot of access to make a real one happen.  If you have
all three of those, there are easier DoS attacks than attacking
PortSentry.  Lots of them that are LOTS easier.

> >         Yes it does.  It's clearly stated in all the documentation
> > on netfilter and in it's design.  Read the fine manual (or web site)
> > and you would have uncovered this (or been run over by it) for yourself.

> >         http://netfilter.filewatcher.org/

> Thanks.

	No problem.

> -M

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
