Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265230AbTLRPkw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 10:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265232AbTLRPkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 10:40:52 -0500
Received: from 213-145-178-72.dd.nextgentel.com ([213.145.178.72]:63786 "EHLO
	terminal124.gozu.lan") by vger.kernel.org with ESMTP
	id S265230AbTLRPks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 10:40:48 -0500
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4 Rmap] Add Inactive to /proc/meminfo was: Mem: and Swap: lines in /proc/meminfo
References: <11HNp-oH-19@gated-at.bofh.it> <11I6J-UO-15@gated-at.bofh.it>
	<13yZr-2nX-23@gated-at.bofh.it>
From: s864@ii.uib.no (Ronny V. Vindenes)
Date: 18 Dec 2003 16:40:12 +0100
In-Reply-To: <13yZr-2nX-23@gated-at.bofh.it>
Message-ID: <m3llpannhf.fsf@terminal124.gozu.lan>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> writes:

> On Thu, Dec 11, 2003 at 03:05:11PM -0800, Mike Fedyk wrote:
> > On Thu, Dec 11, 2003 at 05:42:46PM -0500, Rik van Riel wrote:
> > > On Thu, 11 Dec 2003, Mike Fedyk wrote:
> > > 
> > > > Inact_dirty:     21516 kB
> > > > Inact_laundry:   65612 kB
> > > > Inact_clean:     19812 kB
> > > > 
> > > > These three are seperate lists in rmap, and are equal to "Inactive:" in
> > > > the -aa vm.
> > > 
> > > I should add an Inactive: list to -rmap that sums up all
> > > 3, to make it a bit easier on programs parsing /proc.
> > > 
> > 
> > ISTR, asking for this a while ago ;)
> > 
> > Yes, please do add that Inactive: line to rmap. :)
> 
> How's this patch?
> 
> --- proc_misc.c.orig	2003-12-16 17:03:45.000000000 -0800
> +++ proc_misc.c	2003-12-16 17:04:28.000000000 -0800
> @@ -189,6 +189,7 @@
>  		"Active:       %8u kB\n"
>  		"ActiveAnon:   %8u kB\n"
>  		"ActiveCache:  %8u kB\n"
> +		"Inactive:     %8u kB\n"
>  		"Inact_dirty:  %8u kB\n"
>  		"Inact_laundry:%8u kB\n"
>  		"Inact_clean:  %8u kB\n"
> @@ -208,6 +209,8 @@
>  		K(nr_active_anon_pages()) + K(nr_active_cache_pages()),
>  		K(nr_active_anon_pages()),
>  		K(nr_active_cache_pages()),
> +		K(nr_inactive_dirty_pages()) + K(nr_inactive_dirty_pages())
                              ^^^^^  
Shouldn't that be nr_inactive_clean_pages() ? now it's 2*dirty + laundry

> +			+ K(nr_inactive_laundry_pages()),
>  		K(nr_inactive_dirty_pages()),
>  		K(nr_inactive_laundry_pages()),
>  		K(nr_inactive_clean_pages()),
> -

-- 
Ronny V. Vindenes <s864@ii.uib.no>
