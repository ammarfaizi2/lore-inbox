Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966874AbWKTWSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966874AbWKTWSj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 17:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966869AbWKTWSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 17:18:39 -0500
Received: from thunk.org ([69.25.196.29]:5343 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S966874AbWKTWSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 17:18:32 -0500
Date: Mon, 20 Nov 2006 17:17:56 -0500
From: Theodore Tso <tytso@mit.edu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] PM: suspend/resume debugging should depend on SOFTWARE_SUSPEND
Message-ID: <20061120221756.GA8708@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Linus Torvalds <torvalds@osdl.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <200611190320_MC3-1-D21B-111C@compuserve.com> <Pine.LNX.4.64.0611190930370.3692@woody.osdl.org> <200611191844.14354.rjw@sisk.pl> <Pine.LNX.4.64.0611191008310.3692@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611191008310.3692@woody.osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One reason why I've generally avoided using suspend-to-ram is that
after my laptop (IBM Thinkpad T60p) comes out of suspend-to-ram, it is
consuming 30W of power --- as opposed to before I hibernated, when my
laptop was consuming only 17W or 18W of power.  (And even without
doing things like unloading all of my USB modules, normally my laptop
will consume about 24W after a fresh reboot --- which makes the 30W
power consumption after a suspend-to-ram especially troubling,)

If I unload all of my USB modules, and shutdown the parallel port, the
wired ethernet port, etc., I get power savinges down to 17W --- and
once I was able to push it all the way down to 15W, although in
practice it's much more common that I can get the power consumption
down to 17W or 18W.  Unfortunately, after the laptop wakss up from a
suspend-to-ram, the laptop is apparently powering up all of the
devices in high power mode while I can get some of the power savings
back by manually loading and then unlodaing a whole bunch of device
drivers, in practice that only gets me from 30W to 24W or so.  This is
probably much more of a hardware bug than an OS bug, but because of
this fact, if I'm going to be running the laptop for any amount of
time after resume, I'm better off using suspend-to-disk.

If someone has a suggestion for how I can save the power state of all
of the various components in my laptop so that the laptop cna be
brought back to the 18W state after a suspend-to-ram, I'm all ears....

						- Ted
