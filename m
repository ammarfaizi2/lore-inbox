Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWBZWfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWBZWfG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 17:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWBZWfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 17:35:06 -0500
Received: from hell.org.pl ([62.233.239.4]:58891 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S1751399AbWBZWfF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 17:35:05 -0500
Date: Sun, 26 Feb 2006 23:34:48 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: linux-kernel@vger.kernel.org
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Convert serial_core oopses to BUG_ON
Message-ID: <20060226223448.GA27562@hell.org.pl>
References: <5Kr1a-6MF-15@gated-at.bofh.it> <5KraE-6XP-15@gated-at.bofh.it> <5KyFv-RL-15@gated-at.bofh.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <5KyFv-RL-15@gated-at.bofh.it>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Russell King:
> > > Calling serial functions to flush buffers, or try to send more data
> > >  after the port has been closed or hung up is a bug in the code doing
> > >  the calling, not in the serial_core driver.
> > > 
> > >  Make this explicitly obvious by adding BUG_ON()'s.
> > 
> > If we make it
> > 
> >       if (!info) {
> >               WARN_ON(1);
> >               return;
> >       }
> > 
> > will that allow people's kernels to limp along until it gets fixed?
> "until" - I think you mean "if anyone ever bothers" so no I don't agree.

Russel, I agree this should be clearly marked and an oops seems okay here,
but we're talking dead systems here (dead as in all interrupts masked type
of dead). Most users won't even be aware an oops occured, let alone be able
to read the messages on the console. 

I was just lucky because after the first one I got (#5958, a regular oops)
I tried to nail it down in text mode, with the console loglevel upped a
bit, so I was able to see what the panic (#6131) was all about.

I think we really need those *_ON()s at least in uart_write().

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
