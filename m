Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264960AbUGGITJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264960AbUGGITJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 04:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbUGGITJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 04:19:09 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:37554 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S264960AbUGGITF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 04:19:05 -0400
Date: Wed, 7 Jul 2004 10:19:04 +0200
From: bert hubert <ahu@ds9a.nl>
To: Redeeman <lkml@metanurb.dk>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: quite big breakthrough in the BAD network performance, which mm6 did not fix
Message-ID: <20040707081904.GA21398@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Redeeman <lkml@metanurb.dk>,
	LKML Mailinglist <linux-kernel@vger.kernel.org>,
	Horst von Brand <vonbrand@inf.utfsm.cl>
References: <200407061930.i66JUpqI009671@eeyore.valparaiso.cl> <1089160973.903.1.camel@localhost> <200407061812.24526.lkml@lpbproductions.com> <1089179186.10677.8.camel@localhost> <20040707063100.GA18382@outpost.ds9a.nl> <1089182265.10687.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089182265.10687.4.camel@localhost>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 08:37:44AM +0200, Redeeman wrote:

> its 1 as default, using the tcp patch from another thread fixes so that i can connect to sites. (packages.gentoo.org etc)
> where before that patch came, i echo'ed 0 into it, and it worked aswell,
> however i didnt get more than 50kb/s either :|

Redeeman, from your trace to outpost.ds9a.nl:10000 I note that something in
your path removes the wscale option, or that you have turned off window
scaling entirely. Can you check /proc/sys/net/ipv4/tcp_window_scaling ?

43.909623 redeeman.33083 > 213.244.168.210.10000: S 4031970603:4031970603(0) 
	win 5840 <mss 1322,sackOK,timestamp 23502 0>
43.909678 213.244.168.210.10000 > redeeman.33083: S 634167324:634167324(0) 
	ack 4031970604 win 5792 <mss 1460,sackOK,timestamp 2136531455 23502> (DF)
43.951129 redeeman.33083 > 213.244.168.210.10000: . 
	ack 1 win 5840 <nop,nop,timestamp 23543 2136531455>

I also note that you most probably have tcp_default_win_scale set to 0.

Can you confirm for me that with 2.6.7-mm6 (and exactly that version)
	- you have no TCP connectivity to packages.gentoo.org by default

	- you can access packages.gentoo.org with /proc/sys/net/ipv4/tcp_default_win_scale
	  at both 1 and 0

	- that speed, even with tcp_default_win_scale set to 0, is
	  significantly lower than with stock 2.6.7, that is, if you
	  download some big files, and measure that, and then reboot
	  immediately to 2.6.7, things get lots faster

Alternatively, can you reboot to a kernel with the problem ("can't connect
to packages.gentoo.org") and try to connect to http://outpost.ds9a.nl:10000
and tcpdump that and send me the dump (if it does in fact not work).

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
