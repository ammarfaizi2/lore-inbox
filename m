Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbWCUC7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWCUC7i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 21:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWCUC7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 21:59:37 -0500
Received: from mail.parknet.jp ([210.171.160.80]:47876 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1750976AbWCUC7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 21:59:37 -0500
X-AuthUser: hirofumi@parknet.jp
To: kernel@kolivas.org
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org,
       george@mvista.com
Subject: Re: gettimeofday order of magnitude slower with pmtimer, which is default
References: <20060320122449.GA29718@outpost.ds9a.nl>
	<20060320145047.GA12332@rhlx01.fht-esslingen.de>
	<200603210224.23540.kernel@kolivas.org>
	<87wteo37vr.fsf@duaron.myhome.or.jp>
	<1142901656.441f4b98472e5@vds.kolivas.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 21 Mar 2006 11:59:29 +0900
In-Reply-To: <1142901656.441f4b98472e5@vds.kolivas.org> (kernel@kolivas.org's message of "Tue, 21 Mar 2006 11:40:56 +1100")
Message-ID: <87acbk33la.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel@kolivas.org writes:

> Quoting OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>:
>
> What I mean is that I've seen profiles of the worst (from Andi) showing up to 5%
> cpu time on some workloads! That's a heck of a lot slower than when it's
> latched.

I see. Thanks.

>> +	if (unlikely(pmtmr_need_workaround)) {
>
> I would not put this in an unlikely because on the machines where
> pmtmr_need_workaround is true this will always be true.

Yes. However, if machines uses buggy chip, I guessed TSC/PIT would be
more proper as time source. But probably you are right, timer_pit.c
seems more slow usually (it uses many I/O port).

I'll remove unlikely(), and also will remove "Use other timer source"
from warning.

BTW, this patch is still quick hack.

At least, we would need to check the ICH4 which says in comment.
However, I couldn't find the PM-Timer Errata in ICH4 spec update.

Do you/anyone know about a ICH4 error?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
