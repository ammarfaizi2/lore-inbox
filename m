Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751989AbWCBVZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989AbWCBVZg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 16:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbWCBVZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 16:25:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9376 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751634AbWCBVZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 16:25:35 -0500
Date: Thu, 2 Mar 2006 13:25:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Douglas Gilbert <dougg@torque.net>
cc: Kai Makisara <Kai.Makisara@kolumbus.fi>,
       Matthias Andree <matthias.andree@gmx.de>, Mark Rustad <mrustad@mac.com>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sg regression in 2.6.16-rc5
In-Reply-To: <44074CA1.3000007@torque.net>
Message-ID: <Pine.LNX.4.64.0603021317520.22647@g5.osdl.org>
References: <E94491DE-8378-41DC-9C01-E8C1C91B6B4E@mac.com> <4404AA2A.5010703@torque.net>
 <20060301083824.GA9871@merlin.emma.line.org> <Pine.LNX.4.64.0603011027400.22647@g5.osdl.org>
 <4405F6F1.9040106@torque.net> <Pine.LNX.4.63.0603012239440.5789@kai.makisara.local>
 <44074CA1.3000007@torque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Mar 2006, Douglas Gilbert wrote:
> 
> As more information has come to light, the worst case
> "big transfer" of a single SCSI command through sg (and
> st I suspect) is 512 KB **. With full coalescing that figure
> goes up to 4 MB **. I am also aware that some users
> increase SG_SCATTER_SZ in the sg driver to get larger
> "big transfer"s than sg's current limit of (8MB - 32KB) **.
> That facility has now gone (i.e. upping SG_SCATTER_SZ will
> have no effect) with no replacement mechanism.
> 
> So I'll add my vote to "revert this change before lk 2.6.16"
> with a view to applying it after some solution to the "big
> transfer" problem is found.

Considering that the old code was apparently known-broken due to not 
honoring the use_clustering flag, I would say that the more likely thing 
is that very few people use sg in the first place, and we should wait and 
see what the reaction is to actually fixing a real bug.

Doing more than page-sized transfers can be hard/impossible in virtualized 
environments, for example.

In contrast, upping the limits should be fairly easy, I assume. Same goes 
for if some driver disables clustering even though it shouldn't. No?

		Linus
