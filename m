Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272381AbTHBJm5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 05:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272404AbTHBJm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 05:42:57 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:40598 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id S272381AbTHBJmz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 05:42:55 -0400
Subject: Re: Linux 2.4.22-pre10
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Willy Tarreau <willy@w.ods.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <20030801224753.GA912@alpha.home.local>
References: <Pine.LNX.4.44.0308011316490.3656-100000@logos.cnet>
	 <20030801224753.GA912@alpha.home.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059817370.1868.5.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 02 Aug 2003 11:42:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-08-02 at 00:47, Willy Tarreau wrote:

> This is the _first_ vanilla 2.4 kernel which I can run _unpatched_ on my
> customer's firewalls. This one was stressed all the day at 4000 hits/s.
> Subsystems and drivers include aic7xxx, cpqarray, bonding, tulip, eepro100,
> sunhme, PIII / PPro SMP, netfilter. Everything looks fine and smooth even at a
> sustained write rate of 900 kB/s (logs). I only loose and corrupt significant
> number of firewall logs above 3000 lines/s if I don't extend the log buffer
> size. I've been using the fairly simple attached patch for a few months now
> with success (no loss up to 5600 lines/s). I believe Randy Dunlap has already
> got nearly the same one included in 2.5/2.6, so may want to include it too
> since it's not really intrusive, although my customer can survive with one
> patch :-)

Have you tried using the ULOG target and the ulogd userspace daemon?
It uses netlink and can batch several entries together before it sends
them to userspace. Works a lot better than syslog.

Are you using ip_conntrack on that machine? if you are, be aware that
ip_conntrack doesn't scale well at all on SMP. It's beeing worked on.

-- 
/Martin
