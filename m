Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbUCBGsD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 01:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbUCBGsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 01:48:03 -0500
Received: from hera.kernel.org ([63.209.29.2]:11142 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261495AbUCBGsA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 01:48:00 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [CFT][PATCH] 2.6.4-rc1 remove x86 boot page tables
Date: Tue, 2 Mar 2004 06:47:53 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c21amp$769$1@terminus.zytor.com>
References: <m1vflp81kq.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1078210073 7370 63.209.29.3 (2 Mar 2004 06:47:53 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 2 Mar 2004 06:47:53 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <m1vflp81kq.fsf@ebiederm.dsl.xmission.com>
By author:    ebiederm@xmission.com (Eric W. Biederman)
In newsgroup: linux.dev.kernel
> 
> I think I have accounted for the sub architectures but I don't have
> the hardware to test them.  For voyager and VISWS I actually changed
> some code so I would appreciate a confirmation I didn't break
> anything.  
> 

For VISWS I think you actually need to turn paging off explicitly.
Also, you probably need to check that you didn't break 4G/4G,
especially on SMP.

I would also like to remove the magic %bx, which I did in the version
of my patch sent to akpm and which is now in -mm (basically the SMP
trampoline jumps to a different entrypoint instead.)  In that patch,
%ebx is still used as a flag, but it's completely internal to head.S.

See ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/earlymem-7.diff

> Thanks to HPA who got the ball started :)

:)

I definitely agree that simply using no paging until we have page
tables is by far the cleanest approach.  I felt that is was too high
risk for 2.6, basically because I'm a chicken, but more realistically
because I couldn't really see the effect on all subarchitectures, and
I didn't feel 100% confident that there wasn't anything that relied on
memory being dual mapped; however, I'm more than happy to be proven
wrong :)

Oh yes, with this change you should probably just move swapper_pg_dir
(and empty_zero_page?) into .bss like anything else that should be
zero after boot.

	-hpa
