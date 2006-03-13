Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWCMKGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWCMKGh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 05:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWCMKGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 05:06:36 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47023 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932217AbWCMKGg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 05:06:36 -0500
Date: Mon, 13 Mar 2006 11:06:19 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Jun OKAJIMA <okajima@digitalinfra.co.jp>, linux-kernel@vger.kernel.org,
       ck@vds.kolivas.org
Subject: Re: Faster resuming of suspend technology.
Message-ID: <20060313100619.GA2136@elf.ucw.cz>
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <20060312213228.GA27693@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060312213228.GA27693@rhlx01.fht-esslingen.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ne 12-03-06 22:32:28, Andreas Mohr wrote:
> Hi,
> 
> [CC'd -ck list]
> 
> On Sat, Mar 11, 2006 at 02:04:10AM +0900, Jun OKAJIMA wrote:
> > 
> > 
> > As you might know, one of the key technology of fast booting is suspending.
> > actually, using suspending does fast booting. And very good point is
> > not only can do booting desktop and daemons, but apps at once.
> > but one big fault --- it is slow for a while after booted because of HDD thrashing.
> > (I mention a term suspend as generic one, not refering only to Nigel Cunningham's one)
> I think that is the case since swsusp AFAIR forces as many pages
> as possible into swap and then appends some non-pageable parts
> before shutting down.
> Thus the system will resume with all processes fully residing
> in swap space and the apps getting back to main memory
> on demand only.

Actually... not any more, see /sys/power/image_size.

> And... well... this sounds to me exactly like a prime task
> for the newish swap prefetch work, no need for any other
> special solutions here, I think.
> We probably want a new flag for swap prefetch to let it know
> that we just resumed from software suspend and thus need
> prefetching to happen *much* faster than under normal
> conditions for a short while, though (most likely by
> enabling prefetching on a *non-idle* system for a minute).

Yep, that would be nice. We are actually able to save up-to half of
pagecache, so situation is not as bad as it used to be.
							Pavel
-- 
159:
