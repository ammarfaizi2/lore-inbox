Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267361AbUHSUVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267361AbUHSUVM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 16:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267365AbUHSUVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 16:21:12 -0400
Received: from server18.wavepath.com ([63.247.70.66]:11689 "EHLO
	server18.wavepath.com") by vger.kernel.org with ESMTP
	id S267361AbUHSUUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 16:20:53 -0400
Message-ID: <15724.12.172.68.51.1092946691.squirrel@server18.wavepath.com>
Date: Thu, 19 Aug 2004 16:18:11 -0400 (EDT)
Subject: Re: [PATCH] 2.4.27 - MTD cfi_cmdset_0002.c - Duplicate cleanup in error path
From: <bkgoodman@bradgoodman.com>
To: <marcelo.tosatti@cyclades.com>
In-Reply-To: <20040819155405.GC4396@logos.cnet>
References: <200407231947.i6NJlwo32224@bradgoodman.com>
        <87k6wtlvwk.fsf@farside.sncag.com>
        <20040819155405.GC4396@logos.cnet>
X-Priority: 3
Importance: Normal
Cc: <rainer.weikusat@sncag.com>, <bkgoodman@bradgoodman.com>,
       <alan@redhat.com>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed it in the 2.4.28-pre1 changelog.

I had concidered doing it has he described - I figured though as a
first-time submitter, the less I touched, the more comfortable people
would feel with it ;-)

Thanks,

-BKG

>
> Applied Rainer's patch, its equivalent and I his
> "consisteny with other algorithms" point is a good one.
>
> Thanks guys!
>
> On Sat, Jul 24, 2004 at 03:14:03PM +0800, Rainer Weikusat wrote:
>> "bradgoodman.com" <bkgoodman@bradgoodman.com> writes:
>> > Patch to 2.4.x: Corrects an obvious error where all of the cleanups
>> are done twice in the event of a chip programming error. This can
>> result in kernel BUG() getting called on subsequent programming
>> attempts.
> <snip>
>> That way, it is consistent with the other low-level chip access
>> functions. But the algorithm is per se buggy, anyway, because except
>> if DQ5 was raised before, the chip is not 'ready' (for reading array
>> data), but still in programming mode and will remain there until the
>> 'embedded programming algorithm' stops, because (according to the
>> docs) a reset command will not be accepted until DQ5 has been raised
>> and the opportunityto check for that is gone after the syscall
>> returned to the caller.



