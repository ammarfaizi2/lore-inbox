Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVC0WeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVC0WeM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 17:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbVC0WeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 17:34:12 -0500
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:53772 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261605AbVC0WeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 17:34:05 -0500
Date: Mon, 28 Mar 2005 00:34:01 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Do not misuse Coverity please (Was: sound/oss/cs46xx.c: fix a
 check after use)
Message-Id: <20050328003401.7b3cf380.khali@linux-fr.org>
In-Reply-To: <20050327214323.GH4285@stusta.de>
References: <20050327205014.GD4285@stusta.de>
	<20050327232158.46146243.khali@linux-fr.org>
	<20050327214323.GH4285@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

> There are two cases:
> 1. NULL is impossible, the check is superfluous
> 2. this was an actual bug

Agreed.

> In the first case, my patch doesn't do any harm (a superfluous isn't
> a real bug).

The fact that it isn't a bug does not imply that the patch doesn't harm.
Tricking the reader into thinking that something can happen when it in
fact cannot does possibly harm in the long run.

> In the second case, it fixed a bug.
> It might be a bug not many people hit because it might be in some
> error path of some esoteric driver.

True, except that e.g. the sg_mmap() function of scsi/sg hardly falls
into this category. Same for fbcon_init() in video/console/fbcon. You
don't seem to treat core code any differently than esoteric drivers.

> If a maintainer of a well-maintained subsystem like i2c says
> "The check is superfluous." that's the perfect solution.
> 
> But in less maintained parts of the kernel, even a low possibility
> that it fixes a possible bug is IMHO worth making such a riskless
> patch.

This is where my opinion strongly differs.

The very fact that these "check after use" cases were not fixed yet
means that they are not hit frequently, if ever, regardless of how
popular the driver is. This means that we have (relatively) plenty of
time to fix them. At least Coverity or a similar tool will keep
reminding us to take a look and decide what must be done after we
carefully checked the code. Your approach will not let us do that.
Mass-posting these patches here is likely to make them end in Andrew's
tree soon and to Linus' right after that is nobody objects, right?

If you can make sure that none of these patches ever reaches Linus' tree
without their respective driver maintainer having confirmed that they
were the right thing to do, then fine with me, but it doesn't look like
the way things will go. I think that you'd be better just telling the
maintainers about the problem without providing an arbitrary patch, so
that they will actually look into the problem with their advanced
knowledge of the driver, rather than merely ack'ing that the patch looks
OK, which I think is what will happen with your method. (I'd love to be
proven wrong though.)

Thanks,
-- 
Jean Delvare
