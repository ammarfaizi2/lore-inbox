Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbVLNLxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbVLNLxs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 06:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbVLNLxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 06:53:48 -0500
Received: from tim.rpsys.net ([194.106.48.114]:52167 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932472AbVLNLxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 06:53:47 -0500
Subject: Re: [2.6 patch] defconfig's shouldn't set CONFIG_BROKEN=y
From: Richard Purdie <rpurdie@rpsys.net>
To: David Woodhouse <dwmw2@infradead.org>, Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>
In-Reply-To: <1134380295.10234.62.camel@localhost.localdomain>
References: <20051211185212.GQ23349@stusta.de>
	 <20051211192109.GA22537@flint.arm.linux.org.uk>
	 <20051211193118.GR23349@stusta.de>
	 <1134380295.10234.62.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 11:50:18 +0000
Message-Id: <1134561019.8092.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-12 at 10:38 +0100, David Woodhouse wrote:
> On Sun, 2005-12-11 at 20:31 +0100, Adrian Bunk wrote:
> > Either the depency of MTD_OBSOLETE_CHIPS on BROKEN is correct (in
> > which case CONFIG_MTD_OBSOLETE_CHIPS=y wouldn't bring you anything),
> > or the dependency on BROKEN is not correct and should be corrected.
> > 
> > David, can you comment on this issue?
> 
> I don't see any justification for MTD_OBSOLETE_CHIPS depending on
> BROKEN. That option covers a few of the obsolete chip drivers which
> people shouldn't be using any more -- and I'm perfectly willing to
> believe that one or two of those don't work any more, but if that's the
> case then those individual drivers ought to be marked BROKEN (or just
> removed). We shouldn't mark MTD_OBSOLETE_CHIPS broken.
> 
> I'd like to see the collie_defconfig updated to use the appropriate CFI
> driver back end.

As things stand, collie doesn't work with the unmodified mainline
obsolete chips driver but doesn't work with CFI either. Updating the
defconfig isn't really going to help one way or the other as both are
broken in some way.

A patch does exist to make the obsolete chip driver work on collie and
it could probably be made acceptable to mainline but I doubt David would
apply it as he (understandably) wants the "obsolete" driver to die.

I'm just a spectator in this as I don't have access to hardware to work
out what the problem with CFI is. I agree CFI is the way to go but until
it works, every real world configuration is going to use the patched
obsolete driver.

Adrian Bunk:
> The vast majority of drivers depending on BROKEN simply don't compile.

In this case the sharp driver didn't use to compile but does now since
my patch to fix it was applied. If broken means doesn't compile, the
driver does now and the broken status can be removed. It should work on
the platforms it originally worked on. It is still missing some code
that's needed to make it work specifically on collie but I guess that's
a separate issue.

Richard

