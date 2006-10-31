Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946012AbWJaVPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946012AbWJaVPp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 16:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946011AbWJaVPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 16:15:45 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:48274 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S1946005AbWJaVPo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 16:15:44 -0500
Date: Tue, 31 Oct 2006 23:15:38 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>,
       Martin Lorenz <martin@lorenz.eu.org>, Pavel Machek <pavel@suse.cz>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       len.brown@intel.com, linux-acpi@vger.kernel.org, linux-pm@osdl.org,
       "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: 2.6.19-rc3: known unfixed regressions (v3)
Message-ID: <20061031211538.GC6866@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <Pine.LNX.4.64.0610300953150.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610300953150.25218@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Linus Torvalds <torvalds@osdl.org>:
> Subject: Re: 2.6.19-rc3: known unfixed regressions (v3)
> 
> 
> 
> On Mon, 30 Oct 2006, Jun'ichi Nomura wrote:
> > 
> > Please revert the patch. I'll fix the wrong error handling.
> > 
> > I'm not sure reverting the patch solves the ACPI problem
> > because Michael's kernel seems not having any user of
> > bd_claim_by_kobject.
> 
> Yeah, doing a grep does seem to imply that there is no way that those 
> changes could matter.
> 
> Michael, can you double-check? I think Jun'ichi is right - in your kernel, 
> according to the config posted on bugzilla, I don't think there should be 
> a single caller of bd_claim_by_disk, since CONFIG_MD is disabled.

I double-checked, and of course you are right - the issues resurfaced after some
more use, even with the patch reverted.  I've written some scripts that do some
compiles from scratch, and suspend/resume several times.  Plan to try bi-secting
with that and see what that will come up with.

OTOH, from the discussion it seems just randomly pointing a finger at a patch
has uncovered some bugs - so maybe we should do this a bit more :)


-- 
MST
