Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966586AbWK2J14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966586AbWK2J14 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 04:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966595AbWK2J14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 04:27:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:12828 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S966586AbWK2J1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 04:27:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LKpOf6aW5fJEd243tMCtQpu3M7D3TjSv6cw1lpBGo74O7n1RFCk0cvlxDHKctBsjeFLh0NKJXek3kQhkpbs/H4UIM6QmPH+OC6cGFToX45lFGuSLnDVgTg5kc9PqFF/tX0OycOTNjyL/khxTv7CeMiCZUIGEkyyaHadx8NwA4kc=
Message-ID: <6d6a94c50611290127u2b26976en1100217a69d651c0@mail.gmail.com>
Date: Wed, 29 Nov 2006 17:27:52 +0800
From: Aubrey <aubreylee@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: The VFS cache is not freed when there is not enough free memory to allocate
Cc: "Sonic Zhang" <sonic.adi@gmail.com>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, vapier.adi@gmail.com
In-Reply-To: <4e5ebad50611282317r55c22228qa5333306ccfff28e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6d6a94c50611212351if1701ecx7b89b3fe79371554@mail.gmail.com>
	 <1164185036.5968.179.camel@twins>
	 <6d6a94c50611220202t1d076b4cye70dcdcc19f56e55@mail.gmail.com>
	 <456A964D.2050004@yahoo.com.au>
	 <4e5ebad50611282317r55c22228qa5333306ccfff28e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/06, Sonic Zhang <sonic.adi@gmail.com> wrote:
> Forward to the mailing list.
>
> > On 11/27/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
>
> >> I haven't actually written any nommu userspace code, but it is obvious
> >> that you must try to keep malloc to <= PAGE_SIZE (although order 2 and
> >> even 3 allocations seem to be reasonable, from process context)... Then
> >> you would use something a bit more advanced than a linear array to store
> >> data (a pagetable-like radix tree would be a nice, easy idea).
> >>
> >
> > But, even we split the 8M memory into 2048 x 4k blocks, we still face
> > this failure. The key problem is that available memory is small than
> > 2048 x 4k, while there are still a lot of VFS cache. The VFS cache can
> > be freed, but kernel allocation function ignores it. See the new test
> > application.
>
>
> Which kernel allocation function? If you can provide more details I'd
> like to get to the bottom of this.

I posted it here, I think you missed it. So forwarded it to you.

>
> Because the anonymous memory allocation in mm/nommu.c is all allocated
> with GFP_KERNEL from process context, and in that case, the allocator
> should not fail but call into page reclaim which in turn will free VFS
> caches.
>
>
>
> > What's a better way to free the VFS cache in memory allocator?
>
>
> It should be freeing it for you, so I'm not quite sure what is going
> on. Can you send over the kernel messages you see when the allocation
> fails?

I don't think so. The kernel doesn't attempt to free it. The log is
included in the mail I forwarded to you.

>
> Also, do you happen to know of a reasonable toolchain + emulator setup
> that I could test the nommu kernel with?

A project named skyeye.
http://www.skyeye.org/index.shtml

-Aubrey
