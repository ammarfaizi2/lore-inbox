Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129704AbQLTRoo>; Wed, 20 Dec 2000 12:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129775AbQLTRoe>; Wed, 20 Dec 2000 12:44:34 -0500
Received: from alcove.wittsend.com ([130.205.0.20]:34831 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S129704AbQLTRoW>; Wed, 20 Dec 2000 12:44:22 -0500
Date: Wed, 20 Dec 2000 12:13:51 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: David Lang <david.lang@digitalinsight.com>
Cc: Michael Rothwell <rothwell@holly-springs.nc.us>,
        "Michael H. Warfield" <mhw@wittsend.com>, linux-kernel@vger.kernel.org
Subject: Re: iptables: "stateful inspection?"
Message-ID: <20001220121351.D10408@alcove.wittsend.com>
Mail-Followup-To: David Lang <david.lang@digitalinsight.com>,
	Michael Rothwell <rothwell@holly-springs.nc.us>,
	"Michael H. Warfield" <mhw@wittsend.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3A40DE97.96228B5E@holly-springs.nc.us> <Pine.LNX.4.31.0012200848430.180-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <Pine.LNX.4.31.0012200848430.180-100000@dlang.diginsite.com>; from david.lang@digitalinsight.com on Wed, Dec 20, 2000 at 08:51:34AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2000 at 08:51:34AM -0800, David Lang wrote:
> On Wed, 20 Dec 2000, Michael Rothwell wrote:

> > Date: Wed, 20 Dec 2000 11:30:15 -0500
> > From: Michael Rothwell <rothwell@holly-springs.nc.us>
> > To: Michael H. Warfield <mhw@wittsend.com>
> > Cc: linux-kernel@vger.kernel.org
> > Subject: Re: iptables: "stateful inspection?"

> > "Michael H. Warfield" wrote:
> > >         I think that's more than a little overstatement on your
> > > part.  It depends entirely on the application you intend to put
> > > it to.

> > Fine. How do I make FTP work through it? How can I allow all outgoing
> > TCP connections without opening the network to inbound connections on
> > the ports of desired services?
> >

> for the issue of outbound TCP connections you can set ipchains filters
> based on the Syn flag to prevent inbound connections.

> for FTP I don't know off the top of my head how to do it when not
> masquerading, when NAT is turned on load the FTP masq helper module and it
> will allow you to do ftp out with no problems.

	You can use spf to add some stateful inspection for PORT mode
ftp.  Personally, I like the masquerading option better, though.

> the real point that you need the stateful filtering is on UDP ports. for
> that again I don't know any way when not doing NAT, but when NAT is
> enabled it does do basic stateful filtering (but watch out for timeouts)

	Stateful filter also helps block FIN scans and other stealth
scans, as well as some other esoteric attacks (fragmentation attacks,
Ping'O Death, etc...).  There are other ways to deal with those attacks
as well, but stateful filtering helps.  You also need it if you want to
take advantage of some ICMP as well.

	Big thing for me about NetFilter over IPChains, in addition to
statefull inspection, is the fact that we finally have an IPv6 aware
firewall now.  I've been chomping at the bit to get on IPv6 but
couldn't till I had working firewall code for that.

> David Lang

> > >         Yes it does.  It's clearly stated in all the documentation
> > > on netfilter and in it's design.  Read the fine manual (or web site)
> > > and you would have uncovered this (or been run over by it) for yourself.
> > >
> > >         http://netfilter.filewatcher.org/
> >
> > Thanks.
> >
> > -M

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
