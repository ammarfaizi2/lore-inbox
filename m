Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261609AbSJANYJ>; Tue, 1 Oct 2002 09:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261614AbSJANYJ>; Tue, 1 Oct 2002 09:24:09 -0400
Received: from inet-mail1.oracle.com ([148.87.2.201]:23782 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S261609AbSJANYI>; Tue, 1 Oct 2002 09:24:08 -0400
Message-ID: <3D99A2F2.70102@oracle.com>
Date: Tue, 01 Oct 2002 15:28:18 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Consulting Premium Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020918
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Zlatko Calusic <zlatko.calusic@iskon.hr>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Shared memory shmat/dt not working well in 2.5.x
References: <Pine.LNX.4.44.0210011401360.991-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Tue, 1 Oct 2002, Zlatko Calusic wrote:
> 
>>Still having problems with Oracle on 2.5.x (it can't even be started),
>>I devoted some time trying to pinpoint where the problem is. Reading
>>many traces of Oracle, and rebooting a dozen times, I finally found
>>that the culprit is weird behaviour of shmat/shmdt functions in 2.5,
>>when combined with mprotect() calls. I wrote a simple test app
>>(attached) and I'm also appending output of it below (running on
>>2.4.19 & 2.5.39 kernels, see the difference).
> 
> 
> Exemplary bug report!  Many thanks for taking so much trouble to
> reproduce the problem.  Patch below (against 2.5.39) should fix it:
> I'll send Linus and Andrew when I can get hold of a 2.5.40 tree.
> 
> Hugh
> 
> --- 2.5.39/mm/mmap.c	Fri Sep 20 17:57:49 2002
> +++ linux/mm/mmap.c	Tue Oct  1 13:59:54 2002
> @@ -1055,7 +1055,7 @@ int split_vma(struct mm_struct * mm, str
>  	if (new_below) {
>  		new->vm_end = addr;
>  		vma->vm_start = addr;
> -		vma->vm_pgoff += ((addr - vma->vm_start) >> PAGE_SHIFT);
> +		vma->vm_pgoff += ((addr - new->vm_start) >> PAGE_SHIFT);
>  	} else {
>  		vma->vm_end = addr;
>  		new->vm_start = addr;

I'm glad to report that Oracle 9.2 is now able to start once again
  on 2.5.x series :)

Thanks, cool work as always !

--alessandro

  "everything dies, baby that's a fact
    but maybe everything that dies someday comes back"
        (Bruce Springsteen, "Atlantic City")

