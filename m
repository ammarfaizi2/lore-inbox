Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269329AbTCDI1o>; Tue, 4 Mar 2003 03:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269331AbTCDI1o>; Tue, 4 Mar 2003 03:27:44 -0500
Received: from buitenpost.surfnet.nl ([192.87.108.12]:49883 "EHLO
	buitenpost.surfnet.nl") by vger.kernel.org with ESMTP
	id <S269329AbTCDI1m>; Tue, 4 Mar 2003 03:27:42 -0500
Date: Mon, 3 Mar 2003 15:39:37 +0100
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IGMP problem with 2.5 kernels
Message-ID: <20030303143936.GA3068@pangsit>
References: <20030303134904.GA19636@pangsit> <Pine.LNX.3.95.1030303090132.22417A-100000@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1030303090132.22417A-100000@chaos>
X-Mailer: Mutt on Debian GNU/Linux sid
X-Editor: vim
X-Organisation: SURFnet bv
X-Address: Radboudburcht, P.O. Box 19035, 3501 DA Utrecht, NL
X-Phone: +31 302 305 305
X-Telefax: +31 302 305 329
User-Agent: Mutt/1.5.3i
From: Niels den Otter <otter@surfnet.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard,

On Monday,  3 March 2003, Richard B. Johnson wrote:
> Did you try to use bind() to bind your socket to a specific interface?
> Using `route` to obtain side-effects is not the correct way. The
> application needs to bind the socket to a specific interface if the
> applications requires a specific interface (which you seem to
> require). Otherwise, the first interface found will be used as the
> default. If you can't rebuild the programs, you might work- around the
> problem by modifying start-up so that your ethernet interfaces are
> started before loop-back.
> 
> You can expriment without rebooting...
> 
> Remove all routing entries first.
> route del -default xxx
> route del -net xxx, etc.
> 
> `ifconfig eth0 down`
> `ifconfig lo down`
> 
> Completely reconfigure eth0 first....
> Then configure lo.
> 
> If you don't remove all the routing entries first, you don't really
> end up with a new configuration. Something 'remembers' and the order
> of entries doesn't get changed.

I have tried both your method and also booting Linux without any
interfaces enabled, then enable eth0 and after that also lo.

When only eth0 was enabled, I got the following error from sdr:
 pangsit:~> sdr
 setsockopt - IP_ADD_MEMBERSHIP: No such device
 setsockopt - IP_ADD_MEMBERSHIP: No such device
 sd_listen: setsockopt IP_ADD_MEMBRSHIP err, addr: 224.2.127.254

I can send strace if this helps.

This is the same problem I see with other multicast applications. It
really doesn't want to bind to the ethernet interface.
  pangsit:~> ifconfig eth0
  eth0      Link encap:Ethernet  HWaddr 00:08:74:22:48:CF  
            inet addr:192.87.109.130  Bcast:192.87.109.255 Mask:255.255.255.0
            inet6 addr: 2001:610:508:109:208:74ff:fe22:48cf/64 Scope:Global
            inet6 addr: fe80::208:74ff:fe22:48cf/64 Scope:Link
            UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
            RX packets:32863 errors:0 dropped:0 overruns:1 frame:0
            TX packets:150 errors:0 dropped:0 overruns:0 carrier:1
            collisions:0 txqueuelen:100 
            RX bytes:16213097 (15.4 MiB)  TX bytes:16428 (16.0 KiB)
            Interrupt:11 Base address:0xec80 

After bringing up the loopback interface again the applications binds to
this interface.


-- Niels
