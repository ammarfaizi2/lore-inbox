Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbVBJXdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVBJXdk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 18:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbVBJXdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 18:33:40 -0500
Received: from gate.crashing.org ([63.228.1.57]:15552 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261949AbVBJXdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 18:33:07 -0500
Subject: Re: 2.6.11-rc3-mm2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050210150208.315e9a76.akpm@osdl.org>
References: <20050210023508.3583cf87.akpm@osdl.org>
	 <1108075340.7687.212.camel@gaston>  <20050210150208.315e9a76.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 11 Feb 2005 10:31:48 +1100
Message-Id: <1108078309.7733.217.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Without the aty128fb and radeonfb updates, current 2.6.11 is a
> > regression on pmac as it breaks sleep support on previously working
> > laptops.
> 
> Is that worse than the risk of the large patch?

Well, it used to work upstream fine for some time now... The large patch
isn't risky imho, at least in the latest version I sent you. The bulk of
the changes are just code to re-initialize new chip that isn't executed
at all on earlier models. The main radeonfb code changes very little. I
haven't had a failure report with the latest patch yet.

> > If you don't intend to get at least
> > try_to_acquire_console_sem() and aty128fb fix in, in which case i can
> > send you a minimal radeonfb patch, then I'll have to make another patch
> > for 2.6.11 that reverts some of the arch changes to re-enable sleep on
> > those machines.
> 
> Ho hum.  PM and fbdev are regularly broken anyway.  Please always identify
> the patches by name - it helps avoid mistakes.

Ahem ... not that badly broken on releases, I've been careful enough
that at least, powerbook sleep worked fine for some time now.
 
> These?
> 
> add-try_acquire_console_sem.patch
> update-aty128fb-sleep-wakeup-code-for-new-powermac-changes.patch

Those 2 first at least yes

> radeonfb-update.patch
> radeonfb-build-fix.patch

And either the above, or I can do a minimal patch on radeonfb just
restoring sleep on earlier models (adding the pmac_feature call to
notify the arch code that we can wakeup the chip) if you don't want to
merge the bigger update.

Ben.


