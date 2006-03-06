Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWCFNZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWCFNZy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 08:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWCFNZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 08:25:54 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:31368 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932176AbWCFNZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 08:25:54 -0500
Date: Mon, 6 Mar 2006 14:24:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: realtime-preempt patch-2.6.15-rt18 issues
Message-ID: <20060306132442.GA12359@elte.hu>
References: <45924.195.245.190.93.1141647094.squirrel@www.rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45924.195.245.190.93.1141647094.squirrel@www.rncbc.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4999]
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> Hi, Ingo,
> 
> I think I would let you know that I'm still on 2.6.15-rt16, which 
> works great for the most purposes, on all of my boxes.
> 
> My problem is that the current/latest of the realtime-preempt patch, 
> 2.6.15-rt18, has some showstoppers, at least for my day-to-day usage.
> 
> First one, and I think this is a return of an old buglet. Its the one 
> that occurs every time an usb-storage device is unplugged (e.g. a usb 
> flash stick). Once that happens, the usb subsystem gets seriously 
> crippled.
> 
> Here goes a sample dmesg output of this occurrence (the complete listing
> is attached, as is the corresponding kernel .config).
> 
> ...
> usb 2-1: USB disconnect, address 2
> slab error in kmem_cache_destroy(): cache `scsi_cmd_cache': Can't free all
> objects

hm, this implicates the SLAB code. I've uploaded -rt19, does it work any 
better [there i've included a newer version of the rt-SLAB code]? If you 
still get the same problem even under -rt19, do things improve if you 
enable CONFIG_EMBEDDED and CONFIG_SLOB?

(-rt19 also has the tasklet/ALSA fix, and some other fixlets)

	Ingo
