Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbTJAJrr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 05:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbTJAJrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 05:47:47 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:6126 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S261345AbTJAJrp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 05:47:45 -0400
Date: Wed, 01 Oct 2003 21:32:43 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [BUG] 2.4.x RT signal leak with kupdated (and maybe others)
In-reply-to: <1065000241.5636.53.camel@gaston>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Message-id: <1065000763.12924.15.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1064939275.673.42.camel@gaston>
 <20030930173651.GU17274@velociraptor.random> <1064944028.5634.49.camel@gaston>
 <20030930182255.GX17274@velociraptor.random> <1065000241.5636.53.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

For what it's worth, Software Suspend sends signals to daemons, but it
uses flush_signals() to ensure they don't have any other effect than
getting the process stopped during the cycle.

Nigel

On Wed, 2003-10-01 at 21:24, Benjamin Herrenschmidt wrote:
> > That's because nobody else sends signals to the daemons I guess. And
> > even if they do the daemon won't clear the pending bitflag, so there's
> > no risk to queue more than 1 non-RT entry per signal per daemon like it
> > happened with kupdate.
> 
> And any daemon can cause the same leak by sending it RT signals... I just
> verified sending for example a bunch of 33's (SIGRTMIN) to khubd, that
> increased the count permanently.
> 
> I agree this should not happen normally, and I suppose only root can do
> that and we aren't here to prevent root from shooting itself in the
> foot, are we ?
> 
> The question is should I spend some time adding some flush_signals() to
> the loop of those various kernel daemons I can find or that isn't worth ?
> 
> Regarding kupated, dequeue_signal is a better option as we actually care
> about the signal, I'm testing a patch it will be there in a few minutes.
> 
> Ben.
>  
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

