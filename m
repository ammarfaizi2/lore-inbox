Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264474AbTIIU0T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 16:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264369AbTIIUXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 16:23:04 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:32652 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264378AbTIIUUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 16:20:02 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jens Axboe <axboe@suse.de>
Cc: Pavel Machek <pavel@ucw.cz>, Patrick Mochel <mochel@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030902174126.GB14209@suse.de>
References: <20030823114738.B25729@flint.arm.linux.org.uk>
	 <Pine.LNX.4.44.0308250840360.1157-100000@cherise>
	 <20030825172737.E16790@flint.arm.linux.org.uk>
	 <20030901120208.GC1358@openzaurus.ucw.cz>  <20030902174126.GB14209@suse.de>
Message-Id: <1063138756.642.48.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 09 Sep 2003 22:19:17 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: [PM] Patrick: which part of "maintainer" and "peer review"
	needs explaining to you?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ide-cd should have a flush write cache as well, for mtr, dvd-ram, cd-rw
> with packet writing, etc.

This is currently not done by the ide-cd suspend state machine, I did
the infrastructure and ide-disk implementation, but I'm leaving things
like ide-cd to you :)

Patrick: As we discussed on IRC, the actual PM state constants you
defined don't match the old "S" levels, thus this code in ide-disk
suspend notifier:

                if (rq->pm->pm_state == 4)
 
to avoid stopping the platter on  suspend-to-disk will not work.

Should I fix the above to use a PM_* constant or will you fix the
constants ?

Ben.


