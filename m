Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVAHUBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVAHUBg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 15:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVAHUBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 15:01:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56541 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261295AbVAHUBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 15:01:32 -0500
Date: Sat, 8 Jan 2005 15:00:47 -0500
From: Dave Jones <davej@redhat.com>
To: Chris Wright <chrisw@osdl.org>
Cc: clameter@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: panic on bootup due to __GFP_ZERO patch
Message-ID: <20050108200047.GC10190@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Chris Wright <chrisw@osdl.org>, clameter@sgi.com,
	linux-kernel@vger.kernel.org
References: <20050108010629.M469@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050108010629.M469@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 01:06:30AM -0800, Chris Wright wrote:
 > I'm getting a panic during pidmap_init with a backtrace that looks
 > something like:
 > 
 > buffered_rmqueue
 > __alloc_pages
 > get_zeroed_page
 > pidmap_init
 > start_kernel
 > 
 > Reverting the __GFP_ZERO patch fixes the issue, haven't drilled down
 > any deeper yet to see what in the patch is causing the problem.  This is
 > x86 w/out HIGHMEM (and no NUMA).

ACK, there has been a number of folks hit by this since I updated
the Fedora rawhide kernel to snapshots including this change.

https://bugzilla.redhat.com/beta/show_bug.cgi?id=144480

I've also hit in on my test box that has 256MB.
The pattern so far does seem to be 'no highmem', though
I've not actually tried a recent snapshot on my highmem box.

		Dave

