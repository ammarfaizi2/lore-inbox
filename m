Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292473AbSBUPyO>; Thu, 21 Feb 2002 10:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292467AbSBUPyF>; Thu, 21 Feb 2002 10:54:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37387 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292473AbSBUPxz>;
	Thu, 21 Feb 2002 10:53:55 -0500
Date: Thu, 21 Feb 2002 15:53:48 +0000
From: Joel Becker <jlbec@evilplan.org>
To: Christer Weinigel <wingel@acolyte.hack.org>
Cc: jgarzik@mandrakesoft.com, zwane@linux.realnet.co.sz, roy@karlsbakk.net,
        alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [DRIVER][RFC] SC1200 Watchdog driver
Message-ID: <20020221155348.V2092@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	Christer Weinigel <wingel@acolyte.hack.org>,
	jgarzik@mandrakesoft.com, zwane@linux.realnet.co.sz,
	roy@karlsbakk.net, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0202211134080.7649-100000@netfinity.realnet.co.sz> <3C74C8C7.25D7BCD@mandrakesoft.com> <20020221111910.57235F5B@acolyte.hack.org> <20020221115916.9FD5AF5B@acolyte.hack.org> <3C74E698.D3A0BFEB@mandrakesoft.com> <20020221125743.10F0BF5B@acolyte.hack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020221125743.10F0BF5B@acolyte.hack.org>; from wingel@acolyte.hack.org on Thu, Feb 21, 2002 at 01:57:43PM +0100
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2002 at 01:57:43PM +0100, Christer Weinigel wrote:
> I'm not even sure if single-open sematics are neccesary at all, but I
> copied most of the interface from wdt285.c so I copied this too.  The
> watchdog API seems to be a rather ad hoc thing.  For example I just
> noticed that the WDIOC_SETTIMEOUT call probably takes a parameter
> which seems to be minutes, not seconds.  "Someone (tm)" ought to write
> a more formal API specification.

	WDIOC_SETTIMEOUT is defined as being in seconds.  This is
commented in linux/watchdog.h against the WDIOF_SETTIMOUT flag.  Where
you see funky math against the passed parameter is where a watchdog card
takes strange values on its hardware and the driver is computing the
proper strange value for the given amount of seconds.
	Also note that WDIOC_SETTIMEOUT rounds up to the nearest second
interval the watchdog can handle if the watchdog cannot support the
passed interval.  For this reason, it always returns the actual timeout
set in the passed int*.  This is usually done with the fall-through to
the WDIOC_GETTIMEOUT code.
	You don't see WDIOC_SETTIMEOUT in 2.4.17 because it was added in
2.4.18pre.

Joel

-- 

"To fall in love is to create a religion that has a fallible god."
        -Jorge Luis Borges

			http://www.jlbec.org/
			jlbec@evilplan.org
