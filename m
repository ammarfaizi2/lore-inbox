Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263730AbUCYXAr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 18:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUCYXAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 18:00:42 -0500
Received: from gprs214-160.eurotel.cz ([160.218.214.160]:21633 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263730AbUCYXAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:00:08 -0500
Date: Thu, 25 Mar 2004 23:59:46 +0100
From: Pavel Machek <pavel@suse.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp with highmem, testing wanted
Message-ID: <20040325225946.GI2179@elf.ucw.cz>
References: <20040324235702.GA497@elf.ucw.cz> <1080185300.1147.62.camel@gaston> <20040325120250.GC300@elf.ucw.cz> <1080254461.1195.40.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080254461.1195.40.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'd need to do atomic copy. (Unless someone can guarantee that during
> > writing to disk, no highmem page is going to be changed...)
> > 
> > "copy back" during resume is done in assembly, and I'd rather not
> > dealed with highmem there.
> 
> Can you make that an option ? The PPC version runs in real mode and
> can perfectly copy highmem pages (with small tweaks maybe)

What is real mode on PPC? I do not have PPC here, I guess you'd have
to do that.

> > OTOH, if it possible to guarantee that highmem pages do not change
> > during reads/writes to disk, I might be able to get away without this
> > copy.
> 
> I also think we free too much memory btw (and spend too much time
> trying to free memory). Have you looked at some of Nigel stuffs in
> swsusp2 ? There may be good ideas to borrow... 

Yes, swsusp2 is faster. It is also 10x more code. We could probably
stop freeing as soon as half of memory is free; OTOH if memory is
disk cache, it might be faster to drop it than write to swap, then
read back [swsusp2 shows its not usually the case, through].
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
