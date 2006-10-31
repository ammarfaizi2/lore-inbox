Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423788AbWJaSqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423788AbWJaSqT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 13:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423784AbWJaSqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 13:46:18 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:54109 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1423786AbWJaSqQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 13:46:16 -0500
Message-ID: <454799F3.1020609@tls.msk.ru>
Date: Tue, 31 Oct 2006 21:46:11 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: Peter Hicks <peter.hicks@poggs.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Thousands of interfaces
References: <20061031092550.GA8201@tufnell.london.poggs.net>
In-Reply-To: <20061031092550.GA8201@tufnell.london.poggs.net>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Hicks wrote:
> All,
> 
> I have a dual 3GHz Xeon machine with a 2.4.21 kernel and thousands (15k+) of
> ipip tunnel interfaces.  These are being used to tunnel traffic from remote
> routers, over a private network, and handed off to a third party.
[]
> Is there a userspace program which would handle this application better than
> using interfaces?

Not that it may be suitable for your case because of various reasons (including
but not limited to your use of specific - IPIP - type of tunnels, interoperability
issues), but take a look at the tinc principles -- http://www.tinc-vpn.org/ .  They
use single interface (based on tun driver) and a single select-loop-based userspace
program.  Initially you configure routing to route ALL your peer's traffic to this
interface, and next tincd takes care of {dis,re}appearing peers, shortest pathes,
{un}reachability of certain networks and so on.

I don't know whenever their implementation scales up to 15K+ peers any better than
current in-kernel implementation, but I think it's easier to deal with this stuff
in userspace anyway.  And the principles which are in the base of tinc are very..
interesting and are unique (as far as I know) to it, making this solution ideal for
certain setups.

/mjt
