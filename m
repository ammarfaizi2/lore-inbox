Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbTLQBpi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 20:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263221AbTLQBpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 20:45:38 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:62693 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S263178AbTLQBpg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 20:45:36 -0500
Date: Tue, 16 Dec 2003 17:12:14 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4 Rmap] Add Inactive to /proc/meminfo was: Mem: and Swap: lines in /proc/meminfo
Message-ID: <20031217011214.GE1402@matchmail.com>
Mail-Followup-To: Rik van Riel <riel@redhat.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0312111741150.15419-100000@chimarrao.boston.redhat.com> <20031211230511.GI15401@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031211230511.GI15401@matchmail.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 03:05:11PM -0800, Mike Fedyk wrote:
> On Thu, Dec 11, 2003 at 05:42:46PM -0500, Rik van Riel wrote:
> > On Thu, 11 Dec 2003, Mike Fedyk wrote:
> > 
> > > Inact_dirty:     21516 kB
> > > Inact_laundry:   65612 kB
> > > Inact_clean:     19812 kB
> > > 
> > > These three are seperate lists in rmap, and are equal to "Inactive:" in
> > > the -aa vm.
> > 
> > I should add an Inactive: list to -rmap that sums up all
> > 3, to make it a bit easier on programs parsing /proc.
> > 
> 
> ISTR, asking for this a while ago ;)
> 
> Yes, please do add that Inactive: line to rmap. :)

How's this patch?

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
+		K(nr_inactive_dirty_pages()) + K(nr_inactive_dirty_pages())
+			+ K(nr_inactive_laundry_pages()),
 		K(nr_inactive_dirty_pages()),
 		K(nr_inactive_laundry_pages()),
 		K(nr_inactive_clean_pages()),
