Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265677AbTFSGVj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 02:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265706AbTFSGVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 02:21:39 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:50377 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S265677AbTFSGVg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 02:21:36 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] 2.5.72 O(1) interactivity bugfix
Date: Thu, 19 Jun 2003 16:35:33 +1000
User-Agent: KMail/1.5.2
Cc: Andreas Boman <aboman@midgaard.us>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <1055983621.1753.23.camel@asgaard.midgaard.us> <5.2.0.9.2.20030619071327.00ce7ee8@pop.gmx.net>
In-Reply-To: <5.2.0.9.2.20030619071327.00ce7ee8@pop.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306191635.33965.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jun 2003 16:13, Mike Galbraith wrote:
> At 11:12 AM 6/19/2003 +1000, Con Kolivas wrote:
> >On Thu, 19 Jun 2003 10:47, Andreas Boman wrote:
> > > On Wed, 2003-06-18 at 19:38, Con Kolivas wrote:
> > > > I had another look at 2.5 and noticed the max sleep avg is set to 10
> > > > seconds instead of 2 seconds in 2.4. This could make a _big_
> > > > difference to new forked tasks if they all start out penalised as
> > > > most
> > > > non-interactive. It can take 5 times longer before they get the
> > > > balance right. Can you try with this set to 2 or even 1 second on
> > > > 2.5?
> > >
> > > Ahh, thanks Con, setting MAX_SLEEP_AVG to 2 *almost* removes all xmms
> > > skipping here, a song *may* skip during desktop switches sometime
> > > during the first 5 sec or so of playback IFF make -j20 is running. On a
> > > mostly idle box (well LoadAvg 3 or so is mostly idle isnt it? ;)
> > > desktop switching doesnt cause skips anymore 8)
> >
> >That's nice; a MAX_SLEEP_AVG of 1 second will shorten that 5 seconds to
> > half that as well. What you describe makes perfect sense given that
> > achieving a balance is an exponential function where the MSA is the time
> > constant.
>
> However, that will also send X and friends go off to the expired array
> _very_ quickly.  This will certainly destroy interactive feel under load
> because your desktop can/will go away for seconds at a time.  Try to drag a
> window while a make -j10 is running, and it'll get choppy as heck.  AFAIKT,
> anything that you do to increase concurrency in a global manner is _going_
> to have the side effect of damaging interactive feel to some extent.  The
> one and only source of desktop responsiveness is the large repository of
> cpu ticks a task is allowed to save up for a rainy day.

Indeed that's what I thought and found as well. I have a question though - do 
non interactive tasks have periods of inactivity where they collect sleep 
times or is it just interactive tasks that exhibit this? Why I'm asking is, 
what if the interactivity bonus is based on the best interactive setting that 
task has received, and make this one much slower at decaying than the 
sleep_avg. Say one second for max_sleep_avg and 60 seconds for 
max_interactive_bonus? So it can become interactive very quickly (and 
therefore also should start as non interactive) but becomes non-interactive 
slowly.

> Sigh, scheduling is a _bitch_.

Indeed

Con.

