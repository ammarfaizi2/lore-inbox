Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130349AbQLTTJe>; Wed, 20 Dec 2000 14:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130355AbQLTTJZ>; Wed, 20 Dec 2000 14:09:25 -0500
Received: from alcove.wittsend.com ([130.205.0.20]:23056 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S130349AbQLTTJT>; Wed, 20 Dec 2000 14:09:19 -0500
Date: Wed, 20 Dec 2000 13:38:45 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Michael Rothwell <rothwell@holly-springs.nc.us>,
        David Lang <david.lang@digitalinsight.com>,
        linux-kernel@vger.kernel.org
Subject: Re: iptables: "stateful inspection?"
Message-ID: <20001220133845.H10408@alcove.wittsend.com>
Mail-Followup-To: Michael Rothwell <rothwell@holly-springs.nc.us>,
	David Lang <david.lang@digitalinsight.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3A40DE97.96228B5E@holly-springs.nc.us> <Pine.LNX.4.31.0012200848430.180-100000@dlang.diginsite.com> <20001220121351.D10408@alcove.wittsend.com> <3A40F1DB.84D53F7F@holly-springs.nc.us> <20001220130807.F10408@alcove.wittsend.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <20001220130807.F10408@alcove.wittsend.com>; from mhw@wittsend.com on Wed, Dec 20, 2000 at 01:08:07PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all!

On Wed, Dec 20, 2000 at 01:08:07PM -0500, Michael H. Warfield wrote:
> On Wed, Dec 20, 2000 at 12:52:27PM -0500, Michael Rothwell wrote:
> > "Michael H. Warfield" wrote:

> > >         You can use spf to add some stateful inspection for PORT mode
> > > ftp.  Personally, I like the masquerading option better, though.

> > Can you give an example of using MASQ selectively? I have real addresses
> > on both sides of the firewall, but want things like FTP to work
> > correctly. I think the IPChains HOWTOs are just a little terse. :)

	Michael Rothwell kindly pointed out to me in private mail that
I SCREWED UP (he didn't say that, I did) the copy-and-past on one of
the command lines and left out a "little detail"...

> 	modprobe ip_masq_ftp
> 	ipchains -A forward -p tcp -s {Source Addresses} -d 0/0 21

	This should have been:

	modprobe ip_masq_ftp
	ipchains -A forward -p tcp -s {Source Addresses} -d 0/0 21 -j MASQ

	DOH!  Sorry!

> 	Seems to work for me (mine includes a "tag" and a policy route
> rule to send it out my cable modem that I've left off here)...

> 	If you don't load the ip_masq_ftp module, you WILL get illegal
> port errors on the PORT commands.

> > Thanks!

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
