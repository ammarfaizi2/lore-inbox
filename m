Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWCMKnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWCMKnj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 05:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbWCMKni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 05:43:38 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19428 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751349AbWCMKni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 05:43:38 -0500
Date: Mon, 13 Mar 2006 11:43:15 +0100
From: Pavel Machek <pavel@suse.cz>
To: Con Kolivas <kernel@kolivas.org>
Cc: ck@vds.kolivas.org, Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Jun OKAJIMA <okajima@digitalinfra.co.jp>, linux-kernel@vger.kernel.org
Subject: Re: [ck] Re: Faster resuming of suspend technology.
Message-ID: <20060313104315.GH3495@elf.ucw.cz>
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <20060312213228.GA27693@rhlx01.fht-esslingen.de> <20060313100619.GA2136@elf.ucw.cz> <200603132136.00210.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603132136.00210.kernel@kolivas.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 13-03-06 21:35:59, Con Kolivas wrote:
> On Monday 13 March 2006 21:06, Pavel Machek wrote:
> > On Ne 12-03-06 22:32:28, Andreas Mohr wrote:
> > > And... well... this sounds to me exactly like a prime task
> > > for the newish swap prefetch work, no need for any other
> > > special solutions here, I think.
> > > We probably want a new flag for swap prefetch to let it know
> > > that we just resumed from software suspend and thus need
> > > prefetching to happen *much* faster than under normal
> > > conditions for a short while, though (most likely by
> > > enabling prefetching on a *non-idle* system for a minute).
> >
> > Yep, that would be nice. We are actually able to save up-to half of
> > pagecache, so situation is not as bad as it used to be.
> 
> I would be happy to extend swap prefetch's capabilities to improve
> resume. It 

That would be nice.

> wouldn't be too hard to add a special post_resume_swap_prefetch() which 
> aggressively prefetches for a while. Excuse my ignorance, though, as I know 
> little about swsusp. Are there pages still on swap space after a resume 
> cycle?

Yes, there are, most of the time. Let me explain:

swsusp needs half of memory free. So it shrinks caches (by emulating
memory pressure) so that half of memory if free (and optionaly shrinks
them some more). Pages are pushed into swap by this process.

Now, that works perfectly okay for me (with 1.5GB machine). I can
imagine that on 128MB machine, shrinking caches to 64MB could hurt a
bit. I guess we'll need to find someone interested with small memory
machine (if there are no such people, we can happily ignore the issue
:-).
								Pavel
-- 
61:        uint KeyID = BitConverter.ToUInt32( adKEY, 0 );
