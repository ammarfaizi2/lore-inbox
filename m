Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262908AbSJATKK>; Tue, 1 Oct 2002 15:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262909AbSJATKK>; Tue, 1 Oct 2002 15:10:10 -0400
Received: from packet.digeo.com ([12.110.80.53]:21477 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262908AbSJATKI>;
	Tue, 1 Oct 2002 15:10:08 -0400
Message-ID: <3D99F44F.E82EBC36@digeo.com>
Date: Tue, 01 Oct 2002 12:15:27 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Shared memory shmat/dt not working well in
References: <35FD2132190@vcnet.vc.cvut.cz> <Pine.LNX.4.44.0210011804001.1783-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Oct 2002 19:15:28.0075 (UTC) FILETIME=[E6EAF9B0:01C2697E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> ...
> --- 2.5.40/mm/mprotect.c        Fri Sep 27 23:56:45 2002
> +++ linux/mm/mprotect.c Tue Oct  1 18:00:31 2002
> @@ -186,8 +186,10 @@
>                 /*
>                  * Try to merge with the previous vma.
>                  */
> -               if (mprotect_attempt_merge(vma, *pprev, end, newflags))
> +               if (mprotect_attempt_merge(vma, *pprev, end, newflags)) {
> +                       vma = *pprev;
>                         goto success;
> +               }
>         } else {
>                 error = split_vma(mm, vma, start, 1);
>                 if (error)

Got that, thanks.

I think that's enough "cleanups" for 2.5, guys.  Let's concentrate
on missing must-have functionality, bugs and tuning from now.
