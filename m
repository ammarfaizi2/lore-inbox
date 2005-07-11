Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbVGKOMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVGKOMS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 10:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVGKOKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 10:10:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62100 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261710AbVGKOJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 10:09:18 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Arjan van de Ven <arjan@infradead.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Lee Revell <rlrevell@joe-job.com>,
       Andrew Morton <akpm@osdl.org>, azarah@nosferatu.za.org, cw@f00f.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, christoph@lameter.org
In-Reply-To: <20050711140510.GB14529@thunk.org>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	 <20050708214908.GA31225@taniwha.stupidest.org>
	 <20050708145953.0b2d8030.akpm@osdl.org>
	 <1120928891.17184.10.camel@lycan.lan> <1120932991.6488.64.camel@mindpipe>
	 <1120933916.3176.57.camel@laptopd505.fenrus.org>
	 <1120934163.6488.72.camel@mindpipe> <20050709121212.7539a048.akpm@osdl.org>
	 <1120936561.6488.84.camel@mindpipe>
	 <1121088186.7407.61.camel@localhost.localdomain>
	 <20050711140510.GB14529@thunk.org>
Content-Type: text/plain
Date: Mon, 11 Jul 2005 16:08:59 +0200
Message-Id: <1121090939.3177.30.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The real answer here is for the tickless patches to cleaned up to the
> point where they can be merged, and then we won't waste battery power
> entering the timer interrupt in the first place.  :-)

one big step forward for that is to have a

mod_timer_relative() and add_timer_relative()

which 
1) take a relative delay as argument (and thus kill 99% of the jiffies
use in the kernel right there and then)
2) takes it in miliseconds, killing 99% of all the HZ conversions/uses
3) takes a "accuracy" argument

3) is tricky I guess, it's designed for cases that are like "I want a
timer 1 second from now, but it's ok to be also at 1.5 seconds if that
suits you better". Those cases are far less rare than you might think at
first, most watchdog kind things are of this type. This accuracy thing
will allow the kernel to save many wakeups by grouping them I suspect.

Alan: you worked on this before, where did you end up with ?

