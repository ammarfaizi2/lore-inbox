Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbUCBSFG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 13:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbUCBSFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 13:05:06 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27540 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261725AbUCBSE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 13:04:58 -0500
To: hpa@zytor.com (H. Peter Anvin)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] 2.6.4-rc1 remove x86 boot page tables
References: <m1vflp81kq.fsf@ebiederm.dsl.xmission.com>
	<c21amp$769$1@terminus.zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 02 Mar 2004 10:56:46 -0700
In-Reply-To: <c21amp$769$1@terminus.zytor.com>
Message-ID: <m1y8qj3zfl.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa@zytor.com (H. Peter Anvin) writes:

> Followup to:  <m1vflp81kq.fsf@ebiederm.dsl.xmission.com>
> By author:    ebiederm@xmission.com (Eric W. Biederman)
> In newsgroup: linux.dev.kernel
> > 
> > I think I have accounted for the sub architectures but I don't have
> > the hardware to test them.  For voyager and VISWS I actually changed
> > some code so I would appreciate a confirmation I didn't break
> > anything.  
> > 
> 
> For VISWS I think you actually need to turn paging off explicitly.

Hmm.  I will look at that.

> Also, you probably need to check that you didn't break 4G/4G,
> especially on SMP.

The patch will need a few tweaks but it should be fairly straight forward.

> I would also like to remove the magic %bx, which I did in the version
> of my patch sent to akpm and which is now in -mm (basically the SMP
> trampoline jumps to a different entrypoint instead.)  In that patch,
> %ebx is still used as a flag, but it's completely internal to head.S.

Ok I have not seen that one.  In this case there was enough common
code that it seemed reasonable to reuse it.  I managed to reduce
the code to two tests.  With just a bit of care I suspect I could
remove the tests completely.
 
> See ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/earlymem-7.diff
> 
> > Thanks to HPA who got the ball started :)
> 
> :)
> 
> I definitely agree that simply using no paging until we have page
> tables is by far the cleanest approach.  I felt that is was too high
> risk for 2.6, basically because I'm a chicken, but more realistically
> because I couldn't really see the effect on all subarchitectures, and
> I didn't feel 100% confident that there wasn't anything that relied on
> memory being dual mapped; however, I'm more than happy to be proven
> wrong :)

I will try.  So far except for early_printk I have not found anything.
And that was easy to fix.
 
> Oh yes, with this change you should probably just move swapper_pg_dir
> (and empty_zero_page?) into .bss like anything else that should be
> zero after boot.

Sounds like a good idea.

Eric
