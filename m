Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751536AbWCMLhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbWCMLhs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 06:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbWCMLhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 06:37:48 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45222 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751536AbWCMLhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 06:37:47 -0500
Date: Mon, 13 Mar 2006 12:36:31 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org,
       Jun OKAJIMA <okajima@digitalinfra.co.jp>, linux-kernel@vger.kernel.org
Subject: does swsusp suck aftre resume for you? [was Re: [ck] Re: Faster resuming of suspend technology.]
Message-ID: <20060313113631.GA1736@elf.ucw.cz>
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <20060312213228.GA27693@rhlx01.fht-esslingen.de> <20060313100619.GA2136@elf.ucw.cz> <200603132136.00210.kernel@kolivas.org> <20060313104315.GH3495@elf.ucw.cz> <20060313111326.GA29716@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060313111326.GA29716@rhlx01.fht-esslingen.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 13-03-06 12:13:26, Andreas Mohr wrote:
> Hi,
> 
> On Mon, Mar 13, 2006 at 11:43:15AM +0100, Pavel Machek wrote:
> > On Po 13-03-06 21:35:59, Con Kolivas wrote:
> > > wouldn't be too hard to add a special post_resume_swap_prefetch() which 
> > > aggressively prefetches for a while. Excuse my ignorance, though, as I know 
> > > little about swsusp. Are there pages still on swap space after a resume 
> > > cycle?
> > 
> > Yes, there are, most of the time. Let me explain:
> > 
> > swsusp needs half of memory free. So it shrinks caches (by emulating
> > memory pressure) so that half of memory if free (and optionaly shrinks
> > them some more). Pages are pushed into swap by this process.
> > 
> > Now, that works perfectly okay for me (with 1.5GB machine). I can
> > imagine that on 128MB machine, shrinking caches to 64MB could hurt a
> > bit. I guess we'll need to find someone interested with small memory
> > machine (if there are no such people, we can happily ignore the issue
> > :-).
> 
> Why not simply use the mem= boot parameter?
> Or is that impossible for some reason in this specific case?
> 
> I have a P3/450 256M machine where I could do some tests if really needed.

Yes, I can do mem=128M... but then, I'd prefer not to code workarounds
for machines noone uses any more.

So, I'm looking for a volunteer:

1) Does the swsusp work for you (no => bugzilla, but not interesting
here)

2) Does interactivity suck after resume (no => you are not the right
person)

3) Does it still suck after setting image_size to high value (no =>
good, we have simple fix)

[If there are no people that got here, I'll just assume problem is
solved or hits too little people to be interesting.]

4) Congratulations, you are right person to help. Could you test if
Con's patches help?
								Pavel
-- 
114:    }
