Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317868AbSFSMZV>; Wed, 19 Jun 2002 08:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317869AbSFSMZV>; Wed, 19 Jun 2002 08:25:21 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:47889 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317868AbSFSMZT>; Wed, 19 Jun 2002 08:25:19 -0400
Date: Wed, 19 Jun 2002 09:25:06 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Abhishek Nayani <abhi@kernelnewbies.org>
cc: linux-mm@kvack.org, <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] in do_mmap_pgoff() (2.4.19-preX)
In-Reply-To: <20020616191606.GA1888@SandStorm.net>
Message-ID: <Pine.LNX.4.44L.0206190923500.2598-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2002, Abhishek Nayani wrote:

> 	While documenting the do_mmap_pgoff() function, i found this
> snippet of code very suspicious:
>
>         /* Private writable mapping? Check memory availability.. */
> 	        if ((vm_flags & (VM_SHARED | VM_WRITE)) == VM_WRITE &&
>                                            !(flags & MAP_NORESERVE) &&
> 			          !vm_enough_memory(len >> PAGE_SHIFT))
> 			return -ENOMEM;
>
> 	Here we need to quit if *any* one of the condition is true. So I
> think it should be "||" instead of "&&". As according to the present
> code, it quits only if all the 3 conditions is true, which is wrong.

No, the code is correct.

The only case where we end up allocating new pages for
this mapping is when the mapping is both writable and
private.

Read-only mappings and shared mappings always have backing
store, the file from which the mapping comes and empty_zero_page.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

