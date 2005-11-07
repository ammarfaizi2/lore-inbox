Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbVKGOdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbVKGOdA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 09:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbVKGOdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 09:33:00 -0500
Received: from hera.kernel.org ([140.211.167.34]:63705 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S964831AbVKGOdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 09:33:00 -0500
Date: Mon, 7 Nov 2005 07:32:09 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Roberto Nibali <ratz@drugphish.ch>, linux-kernel@vger.kernel.org,
       Grant Coady <gcoady@gmail.com>
Subject: Re: Linux-2.4.31-hf8
Message-ID: <20051107093209.GA15453@logos.cnet>
References: <20051104231815.GA26093@alpha.home.local> <436C5895.3040409@drugphish.ch> <20051105075915.GD11266@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105075915.GD11266@alpha.home.local>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 08:59:15AM +0100, Willy Tarreau wrote:
> Hi Roberto, Hi Marcelo,
> 
> On Sat, Nov 05, 2005 at 08:00:37AM +0100, Roberto Nibali wrote:
> > Well, to be honest, Horms just found another IPVS "issue" :). It seems
> > we are getting into reviewing 2.4.x IPVS a bit more closely. The problem
> > is that if you have setups where the persistency timeout is below the
> > IPVS state machine related FIN_WAIT (not TCP state) timeout (currently
> > 2*60*HZ) persistent templates will not be invalidated and the timer gets
> > re-set if a we still have a valid connection entry hashed. I've first
> > noted this somewhat aberrant behaviour in 2.2.x kernels but never got
> > around looking at it too closely because in 2.2.x we had a timer mess.
> > 
> > This issue however is absolutely minor since this buglet has been there
> > for ages already and we never received such a bug report. In fact, it
> > would be quite unusual to set a persistency timeout below fin_wait in a
> > LVS_DR setup for productive environments. And I didn't see it because I
> > set the FIN_WAIT to 10*HZ to relax sockets lingering. We can/will queue
> > it up, together with a small refcnt change for -hf9 and post 2.4.32.
> 
> I have a feeling that we will have a lot of network related fixes post
> 2.4.32 (IPVS, IPv6, mcast...). Marcelo, perhaps it would be a good idea
> to merge them in early 2.4.33-pre1 so that competent users have enough
> time to test them ? 

Definately. Please queue them up Willy, I will apply Roberto's fix and
release another -rc.

Thanks guys
