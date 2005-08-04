Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262695AbVHDVJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbVHDVJt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 17:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbVHDVGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 17:06:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26545 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262695AbVHDVGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 17:06:09 -0400
Date: Thu, 4 Aug 2005 23:04:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Marc Ballarin <Ballarin.Marc@gmx.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Calling suspend() in halt/restart/shutdown -> not a good idea
Message-ID: <20050804210419.GB1780@elf.ucw.cz>
References: <1122908972.18835.153.camel@gaston> <20050801203728.2012f058.Ballarin.Marc@gmx.de> <1122926885.30257.4.camel@gaston> <20050802095401.GB1442@elf.ucw.cz> <1123069255.30257.27.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123069255.30257.27.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'd like to get rid of shutdown callback. Having two copies of code
> > (one in callback, one in suspend) is ugly.
> 
> Well, it's obviously not a good time for this. First, suspend and
> shutdown don't necessarily do the same thing, then it just doesn't work
> in practice. So either do it right completely or not at all, but 2.6.13
> isn't the place for an half-assed hack that looks like a solution to
> you.

Well, if that "hack" broke something, it was broken
w.r.t. suspend-to-disk already, but... it caused enough problems that
it is not good idea for 2.6.13, agreed.

> I do agree that there are enough similarities between the suspend and
> shutdown process that we could use the same callback, but then, please,
> at least with a different argument and with drivers beeing fixed to
> handle it. Most drivers should probably just "ignore" shutdown
> anyway.

Yes, we should have different argument, but code should be really
similar in suspend-to-disk-powerdown and normal powerdown, so I'd like
to use same callback. This is post-2.6.13 material (but I'd like patch
to stay in -mm, so that drivers keep getting tested).

> BTW. I suppose we still have the same constant for PMSG_FREEZE and
> PMSG_SUSPEND ? That could have been fixed ages ago and is more important
> imho....

That one is fixed in -mm already. But I guess it will not make it into
2.6.13.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
