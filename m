Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263763AbUFBSeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263763AbUFBSeo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 14:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbUFBSeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 14:34:44 -0400
Received: from h001061b078fa.ne.client2.attbi.com ([24.91.86.110]:16266 "EHLO
	linuxfarms.com") by vger.kernel.org with ESMTP id S263763AbUFBSem
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 14:34:42 -0400
Date: Wed, 2 Jun 2004 14:35:33 -0400 (EDT)
From: Arthur Perry <kernel@linuxfarms.com>
X-X-Sender: kernel@tiamat.perryconsulting.net
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: GART Error 11
In-Reply-To: <m3vfi96drx.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.4.58.0406021421490.14423@tiamat.perryconsulting.net>
References: <22qyw-6e7-29@gated-at.bofh.it> <22ELe-oP-47@gated-at.bofh.it>
 <m3vfi96drx.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andi!
I did not realize there were quirks associated with reading this right from pci config space.

Perhaps someone can tell me this:
Does anybody know if there is any documented information about the differences between agp driver version 0.99 and 0.100?
I know I can just read the source, but there must be list of known bugs and what has been addressed by the newer version, right?

The reason why I ask is that both RedHat and SuSE are using 0.99 agp driver still..
RedHat Enterprise 3.0 's 2.4.21-9.0.1EL kernel and SuSE's 2.4.19 kernel have this in common, and I am seeing such gart errors only with their kernels.
The mainline kernel 2.4.27-pre4 using gart 0.100 does not produce this failure condition.

Please let me know if I am going in the wrong direction, but I am going to patch RedHat's kernel with the agp 0.100 driver and see if the problem does indeed go away.
I'll do the same with SuSE.
If this is the case, then I have found root cause of this particular problem, and I can then address it to the specific distributors.

Thanks!
Best Regards,
Arthur Perry


On Wed, 2 Jun 2004, Andi Kleen wrote:

> Arthur Perry <kernel@linuxfarms.com> writes:
>
> > Hello,
> >
> > Oops. Sorry I have made a mistake in all of my statements below.
> > It was after 5pm yesterday, and it was a long day...
> > It's not offset 0x44 that we are interested in.
> > My listings were at offset 0x48, which is MCA NB Status Low Register.
> > Sorry, did not mean to confuse anybody.
>
> I would recommend to just read the MC* MSRs via /dev/msr.
> Accessing the northbridge directly for MCE information has various
> quirks and i removed that completely in the 2.6 driver.
> They contain the same information.
>
> -Andi
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
