Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbTJAJYR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 05:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbTJAJYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 05:24:17 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:44731 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262006AbTJAJYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 05:24:16 -0400
Subject: Re: [BUG] 2.4.x RT signal leak with kupdated (and maybe others)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
In-Reply-To: <20030930182255.GX17274@velociraptor.random>
References: <1064939275.673.42.camel@gaston>
	 <20030930173651.GU17274@velociraptor.random>
	 <1064944028.5634.49.camel@gaston>
	 <20030930182255.GX17274@velociraptor.random>
Content-Type: text/plain
Message-Id: <1065000241.5636.53.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 01 Oct 2003 11:24:01 +0200
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That's because nobody else sends signals to the daemons I guess. And
> even if they do the daemon won't clear the pending bitflag, so there's
> no risk to queue more than 1 non-RT entry per signal per daemon like it
> happened with kupdate.

And any daemon can cause the same leak by sending it RT signals... I just
verified sending for example a bunch of 33's (SIGRTMIN) to khubd, that
increased the count permanently.

I agree this should not happen normally, and I suppose only root can do
that and we aren't here to prevent root from shooting itself in the
foot, are we ?

The question is should I spend some time adding some flush_signals() to
the loop of those various kernel daemons I can find or that isn't worth ?

Regarding kupated, dequeue_signal is a better option as we actually care
about the signal, I'm testing a patch it will be there in a few minutes.

Ben.
 

