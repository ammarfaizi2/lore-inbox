Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265265AbTLRTVn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 14:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265268AbTLRTVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 14:21:43 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:47529 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S265265AbTLRTVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 14:21:40 -0500
Date: Thu, 18 Dec 2003 11:21:32 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Ronny V. Vindenes" <s864@ii.uib.no>
Cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 2.4 Rmap] Add Inactive to /proc/meminfo was: Mem: and Swap: lines in /proc/meminfo
Message-ID: <20031218192132.GE6438@matchmail.com>
Mail-Followup-To: "Ronny V. Vindenes" <s864@ii.uib.no>,
	linux-kernel@vger.kernel.org, Rik van Riel <riel@redhat.com>
References: <11HNp-oH-19@gated-at.bofh.it> <11I6J-UO-15@gated-at.bofh.it> <13yZr-2nX-23@gated-at.bofh.it> <m3llpannhf.fsf@terminal124.gozu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3llpannhf.fsf@terminal124.gozu.lan>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 18, 2003 at 04:40:12PM +0100, Ronny V. Vindenes wrote:
> Mike Fedyk <mfedyk@matchmail.com> writes:
> > +		K(nr_inactive_dirty_pages()) + K(nr_inactive_dirty_pages())
>                               ^^^^^  
> Shouldn't that be nr_inactive_clean_pages() ? now it's 2*dirty + laundry
> 

Yes, good catch.  Thanks

> > +			+ K(nr_inactive_laundry_pages()),

How's this?

--- proc_misc.c.orig	2003-12-16 17:03:45.000000000 -0800
+++ proc_misc.c	2003-12-16 17:04:28.000000000 -0800
@@ -189,6 +189,7 @@
 		"Active:       %8u kB\n"
 		"ActiveAnon:   %8u kB\n"
 		"ActiveCache:  %8u kB\n"
+		"Inactive:     %8u kB\n"
 		"Inact_dirty:  %8u kB\n"
 		"Inact_laundry:%8u kB\n"
 		"Inact_clean:  %8u kB\n"
@@ -208,6 +209,8 @@
 		K(nr_active_anon_pages()) + K(nr_active_cache_pages()),
 		K(nr_active_anon_pages()),
 		K(nr_active_cache_pages()),
+		K(nr_inactive_dirty_pages()) + K(nr_inactive_laundry_pages())
+			+ K(nr_inactive_clean_pages()),
 		K(nr_inactive_dirty_pages()),
 		K(nr_inactive_laundry_pages()),
 		K(nr_inactive_clean_pages()),
