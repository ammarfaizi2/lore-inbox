Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161338AbWJ3Ry6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161338AbWJ3Ry6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 12:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161337AbWJ3Ry6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 12:54:58 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:2450 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S1161331AbWJ3Ry4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 12:54:56 -0500
Date: Mon, 30 Oct 2006 19:54:49 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Cc: Martin Lorenz <martin@lorenz.eu.org>, Pavel Machek <pavel@suse.cz>,
       Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       len.brown@intel.com, linux-acpi@vger.kernel.org, linux-pm@osdl.org,
       "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: 2.6.19-rc3: known unfixed regressions (v3)
Message-ID: <20061030175449.GP1941@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <4546345E.3050706@ce.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4546345E.3050706@ce.jp.nec.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Jun'ichi Nomura <j-nomura@ce.jp.nec.com>:
> Subject: Re: 2.6.19-rc3: known unfixed regressions (v3)
> 
> Hi Michael,
> 
> Michael S. Tsirkin wrote:
> >> The code is related to bd_claim_by_disk which is called when
> >> device-mapper or md tries to mark the underlying devices
> >> for exclusive use and creates symlinks from/to the devices
> >> in sysfs. The patch added error handlings which weren't in
> >> the original code.
> >>
> >> I have no idea how it affects ACPI event handling.
> > 
> > It's a mystery. Probably exposes a bug somewhere?
> > 
> >> Are you using dm and/or md on your machine?
> > 
> > The .config is attached to bugzilla.
> 
> OK, I found you disabled CONFIG_MD, which means neither
> dm.ko nor md.ko was built.
> Do you have any out-of-tree kernel modules which call either
> bd_claim_by_kobject or bd_claim_by_disk?

No, I don't have any out-of-tree modules.

> If you aren't using either of them, I'm afraid reverting
> the patch doesn't really solve your problem because the patched
> code is called only from them.

I agree this could be just papering over some issue.
The test results (of both git-bisect and reverting the patch) seem to be pretty
consistent so far though. Keep me posted if you rework the patch.

> >> Have you seen any unusual kernel messages or symptoms regarding
> >> dm/md before the ACPI problem occurs?
> > 
> > I haven't.
> 
> Thanks,

-- 
MST
