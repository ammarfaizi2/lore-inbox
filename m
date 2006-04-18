Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWDRNIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWDRNIN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 09:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWDRNIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 09:08:13 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20618 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750797AbWDRNIM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 09:08:12 -0400
Date: Tue, 18 Apr 2006 15:07:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>
Subject: Re: [RFC][PATCH -mm] swsusp: use less memory during resume
Message-ID: <20060418130755.GB26668@elf.ucw.cz>
References: <200604181319.47400.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604181319.47400.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Currently during resume swsusp puts the image data in the page frames that
> don't conflict with the original locations of the data (ie. the locations the
> data will be put in when the saved system state is restored from the image).
> These page frames are considered as "safe" and the other page frames are
> treadet as "unsafe".
> 
> Of course we cannot force the memory allocator to allocate "safe" pages only,
> so if an "unsafe" page is allocated, swsusp treats it as an "eaten page" and
> attempts to allocate another page in the hope that it'll be "safe" etc.
> swsusp tries to allocate as many "safe" pages as necessary to store the
> image data, so it "eats" a considerable number of "unsafe" pages in the
> process.  Next, it reads the image and puts the data into the allocated "safe"
> pages.  Finally, the data are copied to their "original" locations.
> 
> This approach, although it works nicely, is quite inefficient from the memory
> utilization point of view and it also turns out to be unnecessary.  Namely,
> for each "unsafe" page frame returned by the memory allocator there's exactly
> one page in the image that finally should be placed in this page frame.
> Therefore we can put the right data into this page frame as soon as they're
> read from the image and we won't have to copy these data later on.  This way
> we'll only need to allocate as many pages as necessary to store the image
> data and we won't have to "eat" the "unsafe" pages.

Looks good to me. Clever hack, I'd say.
									Pavel
-- 
Thanks for all the (sleeping) penguins.
