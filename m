Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751951AbWCNMdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbWCNMdh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 07:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbWCNMdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 07:33:37 -0500
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:34251 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751951AbWCNMdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 07:33:36 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: does swsusp suck after resume for you? [was Re: Faster resuming of suspend technology.]
Date: Tue, 14 Mar 2006 23:33:12 +1100
User-Agent: KMail/1.9.1
Cc: ck@vds.kolivas.org, Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Jun OKAJIMA <okajima@digitalinfra.co.jp>, linux-kernel@vger.kernel.org
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <200603141613.10915.kernel@kolivas.org> <20060314115145.GL10870@elf.ucw.cz>
In-Reply-To: <20060314115145.GL10870@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603142333.12988.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 March 2006 22:51, Pavel Machek wrote:
> > Since my warning probably scared anyone from actually trying this patch
> > I've given it a thorough working over on my own laptop, booting with
> > mem=128M. The patch works fine and basically with the patch after
> > resuming from disk I have 25MB more memory in use with pages prefetched
> > from swap. This makes a noticeable difference to me. That's a pretty
> > artificial workload, so if someone who actually has lousy wakeup after
> > resume could test the patch it would be appreciated.
>
> Thanks for the patch...
>
> BTW.. if you want this maximally useful, it would be nice to have
> userspace interface for this.

What sort of interface is suitable? There's a swap_prefetch tunable that is a 
boolean but I could make that to be off=0, on=1, aggressive_prefetch=2 or 
something. Or did you have something else in mind?

> swsusp is done from userspace these days 
> (-mm kernel), and I guess it would be useful for "we have just
> finished big&ugly memory trashing job, can we get our interactivity
> back"? Like I'd probably cron-scheduled it just after updatedb, and
> added it to scripts after particular lingvistic experiments...

It may not be immediately obvious, but free ram is required for swap prefetch 
to do anything so as to not have any negative effects on normal vm function. 
After updatedb runs ram is full thus swap prefetch does nothing 
unfortunately. You could certainly do some pointless "ram touching" to free 
up the cached ram in an updatedb script though, but that could evict 
something useful so I wouldn't recommend it.

Cheers,
Con
