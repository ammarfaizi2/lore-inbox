Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266157AbUGARFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266157AbUGARFb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 13:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266171AbUGARFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 13:05:31 -0400
Received: from waste.org ([209.173.204.2]:41378 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S266157AbUGARFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 13:05:19 -0400
Date: Thu, 1 Jul 2004 12:05:12 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: netconsole hangs w/ alt-sysrq-t
Message-ID: <20040701170512.GH25826@waste.org>
References: <16527.47765.286783.249944@segfault.boston.redhat.com> <20040428142753.GE28459@waste.org> <16527.63123.869014.733258@segfault.boston.redhat.com> <16604.18881.850162.785970@segfault.boston.redhat.com> <20040625232711.GE25826@waste.org> <16608.12233.39964.940020@segfault.boston.redhat.com> <20040628151954.GH25826@waste.org> <16608.20014.220537.339589@segfault.boston.redhat.com> <20040701165201.GF25826@waste.org> <16612.16858.959279.469244@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16612.16858.959279.469244@segfault.boston.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 12:54:50PM -0400, Jeff Moyer wrote:
> ==> Regarding Re: netconsole hangs w/ alt-sysrq-t; Matt Mackall <mpm@selenic.com> adds:
> 
> mpm> On Mon, Jun 28, 2004 at 12:58:22PM -0400, Jeff Moyer wrote:
> >> ==> Regarding Re: netconsole hangs w/ alt-sysrq-t; Matt Mackall
> >> <mpm@selenic.com> adds:
> mpm> No, I think we get to this on the non-NAPI route as well. The ->poll
> mpm> check keeps us from filtering twice.
> >> I'll have to take your word for it on this one, as I can't find a way
> >> into this code for the non-napi case.  Would anyone care to give an
> >> authoritative answer on this?
> 
> mpm> I could be mistaken, but that's my recollection from last summer.
> mpm> Hopefully I'll have some spare cycles for this next week.
>  
> >> One other thing we might consider is adding a call to
> >> touch_nmi_watchdog() to zap_completion_queue.
> 
> mpm> Not sure how I feel about that yet. If we can't get out of the guts of
> mpm> netpoll in a timely fashion, then perhaps that's an indication that
> mpm> the watchdog should indeed fire. Describe the scenario where you think
> mpm> we should do this, please.
> 
> Alt-Sysrq-t from the keyboard on a heavily-loaded UP system.

Is it because we're spinning for too long waiting for skbs or is it
just because sysrq-t takes that long to dump its guts? How does the
watchdog get tickled in the sysrq-t over slow serial console case?

In other words, would this better be done between dumps in the sysrq-t
loop where we actually know we're making forward progress?

-- 
Mathematics is the supreme nostalgia of our time.
