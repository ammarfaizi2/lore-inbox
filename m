Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266470AbUBFEsu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 23:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266475AbUBFEst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 23:48:49 -0500
Received: from host62.ipowerweb.com ([66.235.195.162]:63147 "EHLO
	host62.ipowerweb.com") by vger.kernel.org with ESMTP
	id S266470AbUBFEsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 23:48:36 -0500
Message-ID: <40231BED.8060100@lyola.com>
Date: Fri, 06 Feb 2004 07:45:33 +0300
From: Nikolay Igotti <nike@lyola.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: memmove syscall
References: <Pine.LNX.4.44.0402052252130.5933-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0402052252130.5933-100000@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host62.ipowerweb.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - lyola.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>On Wed, 4 Feb 2004, Nikolay Igotti wrote:
>
>  
>
>>   Maybe this is kinda crazy (or known) idea, but why don't we create
>>syscall allowing large copies by just manipulating MMU page table, i.e.
>>    
>>
>
>  
>
>>   return mmu_remap_pages(src,  dst, size / PAGE_SIZE);
>>    
>>
>
>Did you look at mremap(2) ?
>  
>
 If I get it correctly:

       mremap expands (or shrinks) an  existing  memory  mapping,  
potentially
       moving  it  at  the same time (controlled by the flags argument 
and the
       available virtual address space).


And this syscall can be only used for realloc() kind of stuff, as you're 
not allowed to change
virtual address of some page to desired value, but whole point is to 
allow very fast page-aligned
memory moving (or to be exact - swapping, as I guess dst pages should be 
mapped where src ones was
mapped before, to keep things sane).

 Obvious applications for this syscall - Large Object Spaces in 
different memory management systems
-  if space is allocated in pages, defragmentation becomes very cheap.

 Also there could be other applications, like execution-time program 
obfuscators, just shuffling
program stack and data in fancy way :), or tools for improvment of 
interactive behavior of
KDE/Gnome by putting images (or other location-neutral(pointerless) 
data) into nearby virtual
memory locations (so they'll be swapped in and out together, as they 
should).

  If it can be achieved with existing syscalls, I'd be happy to know how 
to do that :).

    Thanks,
      Nikolay






 





 





