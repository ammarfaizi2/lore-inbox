Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbUCDTJg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 14:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbUCDTJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 14:09:36 -0500
Received: from waste.org ([209.173.204.2]:44458 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262005AbUCDTJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 14:09:34 -0500
Date: Thu, 4 Mar 2004 13:09:27 -0600
From: Matt Mackall <mpm@selenic.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: Re: [ANNOUNCE] kpatchup 0.02 kernel patching script
Message-ID: <20040304190927.GQ3883@waste.org>
References: <20040303022444.GA3883@waste.org> <1078420922.19701.1362.camel@nighthawk> <20040304183516.GN3883@waste.org> <1078426209.19701.1382.camel@nighthawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078426209.19701.1382.camel@nighthawk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 10:50:10AM -0800, Dave Hansen wrote:
> On Thu, 2004-03-04 at 10:35, Matt Mackall wrote:
> > I skimmed latest-kernel-version, is it doing something my -s option
> > doesn't do yet?
> 
> $ ./kpatchup-0.03 -s 2.6-bk
> 2.6.4-rc1-bk4

This is actually broken at the moment as it won't know how to fetch
stuff from old/ when it's given a non-current bk version. I have a
design assumption that I can go from a version name to a URL without
any lookups, which the snapshot dir purging breaks.

ISTR Jeff maintains the snapshot scripts. Jeff, could you possibly
have it put a copy of the each snapshot in old/ at creation time
rather than moving stuff there at a later point? This will make URLs
pointing to old/ for -bk patches stable but shouldn't break anything
else.

> $ ./kpatchup-0.03 -s 2.6
> 2.6.3
> $ ./kpatchup-0.03 -s 2.6-pre
> 2.6.4-rc2
> $ latest-kernel-version --probe
> 2.6.4-rc2
> 
> I might be misunderstanding the options, but 'kpatchup -s' I think is
> limited to giving the latest version of a single tree, while
> 'latest-kernel-version' will look at several different trees.  This is a
> tiny problem for kpatchup because it treats 2.6, 2.6-bk, and 2.6-pre as
> separate trees.  For my use, I just want the latest snapshot, whether
> it's a bk snapshot, or one of the real point releases.  

I suppose I could add a 2.6-tip, which will return the greatest of
2.6, 2.6-pre, and 2.6-bk. Like this:

$ kpatchup -s 2.6-tip
2.6.4-rc2
$ kpatchup -u 2.6-tip
http://www.kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.4-rc2.bz2

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
