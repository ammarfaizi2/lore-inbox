Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265887AbUFOT3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265887AbUFOT3m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 15:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265889AbUFOT3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 15:29:42 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:2301 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S265887AbUFOT3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 15:29:37 -0400
To: Robin Holt <holt@sgi.com>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>, Dean Nelson <dcn@sgi.com>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: calling kthread_create() from interrupt thread
References: <40CF350B.mailxD2X1NPFBC@aqua.americas.sgi.com>
	<1087321777.2710.43.camel@laptop.fenrus.com>
	<20040615180525.GA17145@sgi.com>
	<Pine.LNX.4.53.0406151412350.2353@chaos>
	<20040615190114.GA6151@lnx-holt.americas.sgi.com>
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <roland@topspin.com>
Date: 15 Jun 2004 12:28:51 -0700
In-Reply-To: <20040615190114.GA6151@lnx-holt.americas.sgi.com>
Message-ID: <52u0xcwrgs.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 Jun 2004 19:28:51.0796 (UTC) FILETIME=[FD535140:01C4530E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Robin> The problem Dean is trying to address is as follows:

    Robin> We receive an interrupt.  The interrupt handler determines
    Robin> that some work needs to be done.  Part of that work to be
    Robin> done may result in the process needing to go to sleep
    Robin> waiting for a resource to become available.

    Robin> Currently, the interrupt handler wakes a thread sleeping on
    Robin> a wait_event_interruptible().  This wakeup is taking approx
    Robin> 35uSec.  Dean is looking for a lower latency means of doing
    Robin> the wakeup.

Could the interrupt handler attempt to do the work directly, and only
defer things if it determines it needs to sleep for the resource?  It
seems if your are sleeping waiting for something to free up, then
your latency is shot anyway.

 - Roland
