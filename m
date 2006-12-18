Return-Path: <linux-kernel-owner+w=401wt.eu-S1754705AbWLRWeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754705AbWLRWeT (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 17:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754706AbWLRWeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 17:34:19 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:27413 "EHLO
	vms040pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754705AbWLRWeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 17:34:18 -0500
Date: Mon, 18 Dec 2006 17:34:01 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.19 file content corruption on ext3
In-reply-to: <Pine.LNX.4.64.0612181230330.3479@woody.osdl.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrei Popa <andrei.popa@i-neo.ro>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Message-id: <200612181734.01809.gene.heskett@verizon.net>
Organization: Not detectable
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <1166314399.7018.6.camel@localhost>
 <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
 <Pine.LNX.4.64.0612181230330.3479@woody.osdl.org>
User-Agent: KMail/1.9.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 December 2006 15:41, Linus Torvalds wrote:
>On Mon, 18 Dec 2006, Linus Torvalds wrote:
>> But at the same time, it's interesting that it still happens when we
>> try to re-add the dirty bit. That would tell me that it's one of two
>> cases:
>
>Forget that. There's a third case, which is much more likely:
>
> - Andrew's patch had a ", 1" where it _should_ have had a ", 0".
>
>This should be fairly easy to test: just change every single ", 1" case
> in the patch to ", 0".
>
>The only case that _definitely_ would want ",1" is actually the case
> that already calls page_mkclean() directly: clear_page_dirty_for_io().
> So no other ", 1" is valid, and that one that needed it already avoided
> even calling the "test_clear_page_dirty()" function, because it did it
> all by hand.
>
What about the mm/rmap.c one liner, in or out?

Thanks.

>What happens for you in that case?
>
>		Linus
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
