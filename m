Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWFYWeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWFYWeW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 18:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWFYWeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 18:34:22 -0400
Received: from 1wt.eu ([62.212.114.60]:19209 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1750766AbWFYWeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 18:34:21 -0400
Date: Mon, 26 Jun 2006 00:22:43 +0200
From: Willy Tarreau <w@1wt.eu>
To: Andi Kleen <ak@suse.de>
Cc: Jesper Dangaard Brouer <hawk@diku.dk>,
       Harry Edmon <harry@atmos.washington.edu>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
Message-ID: <20060625222243.GJ13255@w.ods.org>
References: <4492D5D3.4000303@atmos.washington.edu> <44948EF6.1060201@atmos.washington.edu> <Pine.LNX.4.61.0606191638550.23553@ask.diku.dk> <200606191724.31305.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606191724.31305.ak@suse.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

On Mon, Jun 19, 2006 at 05:24:31PM +0200, Andi Kleen wrote:
> 
> > If you use "pmtmr" try to reboot with kernel option "clock=tsc".
> 
> That's dangerous advice - when the system choses not to use
> TSC it often has a reason.
> 
> > 
> > On my Opteron AMD system i normally can route 400 kpps, but with 
> > timesource "pmtmr" i could only route around 83 kpps.  (I found the timer 
> > to be the issue by using oprofile).
> 
> Unless you're using packet sniffing or any other application
> that requests time stamps on a socket then the timer shouldn't 
> make much difference. Incoming packets are only time stamped
> when someone asks for the timestamps.

I encountered the same problem on a dual core opteron equipped with a
broadcom NIC (tg3) under 2.4. It could receive 1 Mpps when using TSC
as the clock source, but the time jumped back and forth, so I changed
it to 'notsc', then the performance dropped dramatically to around the
same value as above with one CPU saturated. I suspect that the clock
precision is needed by the tg3 driver to correctly decide to switch to
polling mode, but unfortunately, the performance drop rendered the
solution so much unusable that I finally decided to use it only in
uniprocessor with TSC enabled.

> -Andi

Regards,
Willy

