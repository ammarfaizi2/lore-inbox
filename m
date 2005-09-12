Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbVILS5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbVILS5E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 14:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbVILS5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 14:57:04 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:11131 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S932148AbVILS5D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 14:57:03 -0400
Date: Mon, 12 Sep 2005 20:59:09 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: new asm-offsets.h patch problems
Message-ID: <20050912185909.GA13374@mars.ravnborg.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F045A9188@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F045A9188@scsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 09:00:06AM -0700, Luck, Tony wrote:
> So I still don't understand what is really happening here.
> 
> I left my build script running overnight ... working on a
> kernel at the 357d596bd... commit (where Linus merged in
> my tree last night).  This one has your "archprepare" patch
> already included.
> 
> Sometimes a build for a config succeeds, and sometimes it
> fails. (tiger_defconfig for the last six builds has had a
> GOOD, BAD, BAD, BAD, GOOD, GOOD sequence, while bigsur_defconfig
> went GOOD, BAD, BAD, BAD, BAD, BAD).  This non-determinism
> doesn't fit in well with your explanation of missing defines
> for PAGE_SIZE etc.

I have tried to reproduce it locally, but my gcc barfed out
in namei.c with an internal error :-(
I can explain why you see recompiles though.

asm-offsets.c has a dependency on asm-offsets.h
So in the cases where asm-offsets.c is build just before asm-offsets.h
then no recompile happens - at least not if they get same timestamp.
But in the cases where there is a command or two in betweem the two
the timestamps differ so next time you execute 'make' it will see that
asm-offsets.h is newe than asm-offsets.c and thus it will rebuild the
asm-offsets.h file.

But again this does not expalin why it sometimes goes bad, sometimes
goes well. I need some compile output for good and bad cases to dig more
into it.
There is no chance this is unrealted to the asm-offsets changes?

	Sam

> 
> -Tony
> 
