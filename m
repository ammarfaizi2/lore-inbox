Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbTJ2Lbp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 06:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbTJ2Lbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 06:31:45 -0500
Received: from ltgp.iram.es ([150.214.224.138]:134 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S261982AbTJ2Lbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 06:31:43 -0500
From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 29 Oct 2003 12:28:24 +0100
To: Pavel Machek <pavel@suse.cz>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Patrick Mochel <mochel@osdl.org>, George Anzinger <george@mvista.com>,
       John stultz <johnstul@us.ibm.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix time after suspend-to-*
Message-ID: <20031029112824.GA7789@iram.es>
References: <Pine.LNX.4.44.0310271535160.13116-100000@cherise> <1067329994.861.3.camel@teapot.felipe-alfaro.com> <20031028093233.GA1253@elf.ucw.cz> <1067351431.1358.11.camel@teapot.felipe-alfaro.com> <20031028172818.GB2307@elf.ucw.cz> <1067372182.864.11.camel@teapot.felipe-alfaro.com> <20031029093802.GA757@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031029093802.GA757@elf.ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 29, 2003 at 10:38:03AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > You are not asking userspace whether to reboot or not, and you should
> > > not ask them about suspend, either.
> > 
> > OK, so how should the system behave when a real-time-like process is
> > running? I talked about the CD burning example. Should the kernel simply
> > ignore the process and suspend?
> 
> Yes.
> 
> > > > 1. Network connections must be reestablished. A userspace program can't
> > > > try to automatically reestablish a broken TCP connection for no apparent
> > > > reason. A broken TCP connection could be the cause of an overloaded or
> > > > broken server/service. If we do not inform userspace processes that the
> > > > system is going to sleep (or that the system has been brought up from
> > > > standby), they will blindly try to restore TCP connections back, even
> > > > when the remote server is broken, generating a lot of unnecesary
> > > > traffic.
> > > 
> > > gettimeofday(), if I slept for too long, oops, something strange
> > > happened (maybe there was heavy io load and I was swapped out? or
> > > suspend? Did machine sleep for 20 minutes in cli?) try to reconnect.
> > 
> > Does "gettimeofday()" have into account the effect of adjusting the time
> > twice a year, once to make time roll forward one hour and another one to
> > roll it back?
> 
> Not sure how it is supposed to work, but here I just have ntpd
> step-setting by one hour...

Well, gettimeofday() is supposed to return UT. It does not care at all
about local time, which would be a 100% userspace problem if it were
not for broken filesystems which store timestamps in local time.

Going off-topic: on a typical distribution the files used for UT to 
localtime conversion are in/usr/share/zoneinfo. Also ntp exclusively
transmits UT, and is certainly not responsible for these hour steps.

	Gabriel.
