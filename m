Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136396AbRA1Pr6>; Sun, 28 Jan 2001 10:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136590AbRA1Pri>; Sun, 28 Jan 2001 10:47:38 -0500
Received: from alcove.wittsend.com ([130.205.0.20]:48395 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S132290AbRA1Prg>; Sun, 28 Jan 2001 10:47:36 -0500
Date: Sun, 28 Jan 2001 10:45:27 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Dominik Kubla <dominik.kubla@uni-mainz.de>,
        Gregory Maxwell <greg@linuxpower.cx>,
        James Sutherland <jas88@cam.ac.uk>,
        David Schwartz <davids@webmaster.com>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: hotmail not dealing with ECN
Message-ID: <20010128104527.B23716@alcove.wittsend.com>
Mail-Followup-To: Dominik Kubla <dominik.kubla@uni-mainz.de>,
	Gregory Maxwell <greg@linuxpower.cx>,
	James Sutherland <jas88@cam.ac.uk>,
	David Schwartz <davids@webmaster.com>,
	Jamie Lokier <lk@tantalophile.demon.co.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKCECMNFAA.davids@webmaster.com> <Pine.SOL.4.21.0101272308030.701-100000@green.csi.cam.ac.uk> <20010127191159.B7467@xi.linuxpower.cx> <20010128021025.D800@uni-mainz.de> <20010127233543.D7467@xi.linuxpower.cx> <20010128135753.A2766@uni-mainz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <20010128135753.A2766@uni-mainz.de>; from dominik.kubla@uni-mainz.de on Sun, Jan 28, 2001 at 01:57:53PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28, 2001 at 01:57:53PM +0100, Dominik Kubla wrote:
> On Sat, Jan 27, 2001 at 11:35:43PM -0500, Gregory Maxwell wrote:
> ...
> > An attack against an Xray system is much more likely to come from inside the
> > companies network.
> ...

> We are not talking about attacks here, we are talking about undefined
> behaviour when (perhaps poorly designed) systems encounter network
> packages that use new or experimental features: I have seen MRI scanners
> panic when they received SNMP queries and SNMP has been around for ages!

	Couple of years ago I did a security advisory on OS/9 (the
Microware OS that was originally designed for 6809 processors).  It
had become quite popular for embedded controllers.  I think at the time
it was ranked one of the top three embedded controller operating systems
and was used in a large number of Allen Bradley controllers.  Read that
last statement as saying that it was in a GOD AWFULL number of HVAC
controllers and factory automation controllers around the entire world.

	We stumbled onto a flaw in the protocol stacks in OS/9 and it
couldn't handle being hit with an ICMP redirect.  The incoming stack
didn't properly recognize it and created some weird state in the outgoing
stack.  The next time the controller tried to transmit something, the
controller hung leaving whatever it was controlling in what ever position
it was in, no matter what the consequences.  This was "discovered" the
hard way at a site where the network people had not even realized that
all of these controllers were connected to the main corporate network.
Envision hundreds of controllers suddenly freezing and an entire plant
rapidly grinding to a complete halt.

	My contact at Microware told me that they never anticipated having
those controllers hooked up to a general purpose network and OS/9 was
designed for such a small footprint (Hey, I had a multitasking, multiuser,
dial-in system running on a RadioShack CoCo with 64K of memory running OS/9)
that they had no room for handling ICMP redirects so they hadn't coded
it into the stack.  Multiple mistakes and assumptions resulted in a
security advisory warning about potential threats to human health and
safety.  They were having a bad day...  Especially when CNN called them.  :-/
(They had been notified over 6 months prior to the publication of the
advisory, BTW...)

	That advisory concluded to isolate all embedded controllers to
insulated subnets and configure all routers to refuse to pass ICMP
redirect packets.  Anyone want to take bets if it's been done to
any great extent?  It will take some factory being knocked on it's
ass and making CNN, and even then most people won't take action because
most of the admins don't know what's on their networks in those
environments.

	Upgrading a lot of these old controllers also meant physically
removing and replacing EPROMS. (One claim to fame for OS/9 is that it
was totally PIC and could be copied straight into EPROM and run
equally well from EPROM or RAM at arbitrary addresses.)  That's even
assuming you knew where all your controllers were and how to get to them!

	So...  Yeah...  I can understand what can happen when unknown
packets reach devices that were not designed to handle them.  Bad Juju...
And embedded controllers are a hell of a lot more plentyful than X-Ray
machines.

> Yours,
>   Dominik Kubla
> -- 
>           A lovely thing to see:                   Kobayashi Issa
>      through the paper window's holes               (1763-1828)
>                 the galaxy.               [taken from: David Brin - Sundiver]

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
