Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261296AbRE3PNZ>; Wed, 30 May 2001 11:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261297AbRE3PNP>; Wed, 30 May 2001 11:13:15 -0400
Received: from mtiwmhc22.worldnet.att.net ([204.127.131.47]:43516 "EHLO
	mtiwmhc22.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S261296AbRE3PNH> convert rfc822-to-8bit; Wed, 30 May 2001 11:13:07 -0400
From: William Waddington <csbwaddington@att.net>
To: linux-kernel@vger.kernel.org
Subject: Re: query regarding 'map_user_kiobuf'
Date: Wed, 30 May 2001 08:12:17 -0700
Message-ID: <593aht81ed3p199mr0l1m896d32bgr6qnv@4ax.com>
In-Reply-To: <fa.f4liqpv.6lq2r7@ifi.uio.no> <CA256A5B.00548719.00@d73mta01.au.ibm.com> <fa.e3ea6bv.t0ceia@ifi.uio.no>
In-Reply-To: <fa.e3ea6bv.t0ceia@ifi.uio.no>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2001 19:30:06 GMT, in fa.linux.kernel you wrote:

>
>mdaljeet@in.ibm.com said:
>> After using the 'map_user_kiobuf', I observed the followiing:
>> 
>> 1. 'kiobuf->maplist[0]->virtual' contains a different virtual address than
>> the user space buffer address
>> 2. But these two addresses are mapped as when i write something using the
>> address 'kiobuf->maplist[0]->virtual' inside the kernel, I see the same
>> data in the user space buffer in my application.
>> 3. I use the 'virt_to_phys' operation to the virtual address
>> 'kiobuf->maplist[0]->virtual' to get the physical address.
>> 4. I use this physical address for DMA operations.
>> 
>> Now, using this information I do a DMA from card to system memory. What I
>> have noticed is that DMA happens somewhere else in the system memory. I am
>> not able to execute most of the commands (ls, chmod, cat, clear etc) after
>> my user program exits.
>> 
>> Am I doing the steps 3 and 4 above right?
>
>After calling map_user_kiobuf(), I believe you should be locking the pages
>in memory by calling lock_kiovec(). Otherwise, nothing prevents them from 
>being paged out again.
>
>Also, the pages may be in high memory and not directly accessible. You should
>use kmap() before touching them from the kernel rather than just using 
>page->virtual, and obviously kunmap() afterwards.
>
>The PCI DMA interface is more complex than simply using virt_to_phys() too, 
>if you want to deal correctly with the highmem case. I'm sure others will 
>give you the details or pointers to the documentation.


David,

I have a couple of user DMA drivers up and running, but in light of your
comment, I am not so sure.

I see the following  w/map_user_kiobuf() in memory.c (2.4.4)

...

/*
 * Force in an entire range of pages from the current process's user VA,
 * and pin them in physical memory.  
 */
 
#define dprintk(x...)
 int map_user_kiobuf(int rw, struct kiobuf *iobuf, unsigned long va, size_t
len)

...

What is the difference between pinning and locking?  I had the impression
that locking had more to do with ownership.

Thanks,
Bill

---------------------------------------
Bill Waddington
Bainbridge Island, WA, USA
csbwaddington@att.net
ikoncorp@att.net
---------------------------------------
