Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbTDYWqO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 18:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbTDYWqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 18:46:14 -0400
Received: from zero.aec.at ([193.170.194.10]:14605 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264537AbTDYWqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 18:46:12 -0400
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TASK_UNMAPPED_BASE & stack location
From: Andi Kleen <ak@muc.de>
Date: Sat, 26 Apr 2003 00:58:17 +0200
In-Reply-To: <20030425225007$3fae@gated-at.bofh.it> ("Martin J. Bligh"'s
 message of "Sat, 26 Apr 2003 00:50:07 +0200")
Message-ID: <m3n0ie422e.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <20030425220018$6219@gated-at.bofh.it>
	<20030425220018$76b1@gated-at.bofh.it>
	<20030425225007$3fae@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

>>> Is there any good reason we can't remove TASK_UNMAPPED_BASE, and just
>>> shove libraries directly above the program text? Red Hat seems to have
>>> patches to dynamically tune it on a per-processes basis anyway ...
>> 
>> Yes. You won't get a continuous sbrk/brk heap then anymore. Not sure it
>> is a  big problem though.
>
> Me no understand. I think this *makes* it a contiguous space. The way I see
> it, we currently allocate from TASK_UNMAPPED_BASE up to the top, then start
> again above program text. Which seems a bit silly.

The space for brk is not completely continuous anymore, especially
when you use mmap() too.

Same with mmap.

Basically mmap() and brk/sbrk (=malloc) will fragment each other.

wli's suggestion of making it a personality makes sense.

> I've moved PAGE_OFFSET around a lot (which moves the stack, as you say). 
> Haven't seen it break anything yet ... IMHO it was broken anyway if this
> hurts it. Obviously not something one could do in a stable kernel series,
> but 2.5 seems like a perfect time for it to me ... unless I'm missing some
> glibc / linker thing, it seems like a simple change.

It at least broke Sun Java.

-Andi
