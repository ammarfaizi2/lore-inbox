Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269299AbUHaXLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269299AbUHaXLa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 19:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269306AbUHaXLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 19:11:30 -0400
Received: from zero.aec.at ([193.170.194.10]:39940 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S269299AbUHaXKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 19:10:07 -0400
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
References: <2yQkS-6Zh-13@gated-at.bofh.it> <2zaCV-4FE-3@gated-at.bofh.it>
	<2zaWk-4Yj-9@gated-at.bofh.it> <2zmE8-4Zz-11@gated-at.bofh.it>
	<2zngP-5wD-9@gated-at.bofh.it> <2zngP-5wD-7@gated-at.bofh.it>
	<2znJS-5Pm-25@gated-at.bofh.it> <2znJS-5Pm-27@gated-at.bofh.it>
	<2znJS-5Pm-29@gated-at.bofh.it> <2znJS-5Pm-31@gated-at.bofh.it>
	<2znJS-5Pm-33@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 01 Sep 2004 01:10:04 +0200
In-Reply-To: <2znJS-5Pm-33@gated-at.bofh.it> (Ingo Molnar's message of "Wed,
 01 Sep 2004 00:00:20 +0200")
Message-ID: <m3hdqij44z.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Ingo Molnar <mingo@elte.hu> wrote:
>
>> 
>> * Lee Revell <rlrevell@joe-job.com> wrote:
>> 
>> > File under boot-time stuff, I guess.  This could be bad if X crashes,
>> > but I can't remember the last time this happened to me, and I use xorg
>> > CVS.
>> 
>> but the first wbinvd() within prepare_set() seems completely unnecessary
>> - we can flush the cache after disabling the cache just fine.
>
> the third wbinvd() in post_set() seems unnecessary too - what kind of
> cache do we expect to flush, we've disabled caching in the CPU ... But
> the Intel pseudocode does it too - this is a thinko i think.

The multiple steps are needed, otherwise there can be problems
with hyperthreading (the first x86-64 didn't do it in all cases,
and it causes occassional problens with Intel CPUs) 

Also repeated calls of this are relatively cheap because at the
second time there is not much to flush anymore.

I would suggest to not do this change, it could cause very
subtle problems.

-Andi

