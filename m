Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311160AbSCHVyJ>; Fri, 8 Mar 2002 16:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311168AbSCHVyA>; Fri, 8 Mar 2002 16:54:00 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:59825 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S311167AbSCHVx5>; Fri, 8 Mar 2002 16:53:57 -0500
Date: Fri, 08 Mar 2002 13:50:49 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Samuel Ortiz <sortiz@dbear.engr.sgi.com>
cc: Andrea Arcangeli <andrea@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] stop null ptr deference in __alloc_pages
Message-ID: <37610000.1015624249@flay>
In-Reply-To: <Pine.LNX.4.33.0203081325560.18968-100000@dbear.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.33.0203081325560.18968-100000@dbear.engr.sgi.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I should have also mentioned that:
>> 
>> 1) I shouldn't need the SGI patch, though it might help performance.
>
> Why shouldn't you need it ? It is NUMA generic, and totally arch
> independent.

I just mean the kernel shouldn't panic if I don't have it.

> And it actually helps performance. I also allows the kernel to have a
> single memory allocation path. I think it is cleaner than calling _alloc_pages()
> from numa.c
> 
>> 2) The kernel panics without my fix, and runs fine with it.
> I hope so  :-)
> But your fix is at the same time useless and harmless for UMA machines.

Yup, though I suppose we could shave off a couple of nanoseconds by 
surrounding my little check with #ifdef CONFIG_NUMA.

> OTOH, the SGI patch doesn't modify __alloc_pages(). I think I'm a little
> too picky here...

With the #ifdef, I won't really do this either (at least for the code generated).

The SGI patch is probably a good thing, and I'll pick it up and try it 
sometime soon. The only real problem is that it's not in the mainline
already. Until such time as it gets there, the fix I posted is trivial,
and easily seen to be correct (well, I'm biased ;-) ), and should get
shoved into the mainline much easier.

M.

