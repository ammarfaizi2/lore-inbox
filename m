Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262621AbVCWQHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262621AbVCWQHJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 11:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVCWQHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 11:07:09 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:59346 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S261650AbVCWQGy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 11:06:54 -0500
Date: Wed, 23 Mar 2005 11:06:52 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unable to handle paging request in worker_thread on apm resume
Message-ID: <20050323160652.GB19669@fieldses.org>
References: <20050322040657.GA28404@fieldses.org> <20050323023344.62ba883b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050323023344.62ba883b.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 02:33:44AM -0800, Andrew Morton wrote:
> Seems that there's a `struct work_struct' which is still registered but its
> memory has been freed.  It's likely that CONFIG_DEBUG_PAGEALLOC caught this.
> 
> Either that, or some module got unloaded without flushing its workqueue.
> 
> Are you using any modules which do schedule_work()?

No.

> Have you added any code which does schedule_work()?

Hm, I don't think so.  But of course I have some nfsv4 patches, and the
nfsv4 nfsd code does use schedule_delayed_work().  It's possible the
cleanup is wrong, and that bringing nfsd up and down could get nfsv4
into some bad state.  I'll take a look.  Would that explain this?

I'm not claiming this is a recent regression, by the way; apm resume has
always had intermittent problems on this laptop.  It's only recently
that I've actually tried to pay attention to those problems.  (Bad me!)

--b.
