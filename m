Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWHQTPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWHQTPh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 15:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWHQTPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 15:15:37 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:10931 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932267AbWHQTPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 15:15:37 -0400
Subject: Re: Linux time code
From: john stultz <johnstul@us.ibm.com>
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Cc: linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>,
       Udo van den Heuvel <udovdh@xs4all.nl>
In-Reply-To: <44E434E4.3276.FC937A2@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
References: <44E32B23.16949.BBB1EC4@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
	 <44E434E4.3276.FC937A2@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 12:15:31 -0700
Message-Id: <1155842132.31755.64.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 09:20 +0200, Ulrich Windl wrote:
> On 16 Aug 2006 at 12:53, john stultz wrote:
> > As you know, myself and others are working on this. Its taken quite a
> > bit of time to get some of the groundwork in, and cleanups are still
> > needed, but I think we're on the right track. However, criticism is
> > welcome, and I'd appreciate your input (I did try to keep you CC'ed on
> > most of the early discussions, but forgive me as I left you out on some
> > of the more recent discussions)
> 
> No problem, I was on holiday anyway. The code I tried had a problem with my ADM 
> Athlon X2 (Dual core): Both cores run with different frequency, a feature of power 
> management, thus making hi-res timing instable. I haven't investigated in-depth, 
> but I thought the hpet timer was used.

Hmmm.. The dualcore AMD TSC usage issue should be resolved now, so
please let me know if you can provide any further info on what you saw
(dmesg, config).


> > > For example there is a POSIX-like sys_clock_gettime() intended to 
> > > server the end-user directly, but there's no counterpart do_clock_gettime() to 
> > > server any in-kernel needs. 
> > 
> > Hmmm.. ktime_get(), ktime_get_ts() and ktime_get_real(), provide this
> > info. Is there something missing here?
> 
> From memory: Are those exported from posix_timer? I think I saw those, but wasn't 
> sure whether they are for general cross-arch use.

They should be cross-arch safe. Exported from ktime.h
 
> > The NTP PPS code was dropped because there were no in-kernel users of
> > that interface. But as I've always said, I'd be very happy to see your
> > PPS work get merged. I know there are a few out-of-tree patches
> > currently floating around (Udo mailed me awhile back with some links,
> > but I can't find them at the moment), and I'm sure due to the high level
> > of activity in this area makes it difficult to keep out of tree patches
> > up to date. Is there any reason these patches aren't being pushed into
> > mainline?
> 
> I'm only waiting for a "pusher" ;-) No actually I have my own quality check, and 
> currently the code fails those. It's named "alpha" by myself. Unless it's "beta" I 
> won't ask anybody for inclusion.

Even so, if I recall, your earlier PPS kit patch had both cleanups and
new features. Breaking that up and pushing just the cleanups might be an
easy way to reduce the patch size you have to maintain until its beta.

> I don't like the idea of a loadable module, because most of the code accesses 
> several timing variables that are (or can be) private now. A module would make 
> them public (for misuse). The time machinery should be a sealed black box IMHO.

Agreed, although interfaces can be added if necessary, so let me know if
you find anything specific that is lacking.


thanks
-john

