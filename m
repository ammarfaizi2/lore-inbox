Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261354AbSK0UEb>; Wed, 27 Nov 2002 15:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263246AbSK0UEa>; Wed, 27 Nov 2002 15:04:30 -0500
Received: from packet.digeo.com ([12.110.80.53]:1977 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261354AbSK0UE3>;
	Wed, 27 Nov 2002 15:04:29 -0500
Message-ID: <3DE526FC.3D78DB54@digeo.com>
Date: Wed, 27 Nov 2002 12:11:40 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rasmus Andersen <rasmus@jaquet.dk>
CC: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: 2.5.49-mm2
References: <3DE48C4A.98979F0C@digeo.com> <20021127210153.A8411@jaquet.dk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Nov 2002 20:11:40.0784 (UTC) FILETIME=[32C14700:01C29651]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rasmus Andersen wrote:
> 
> On Wed, Nov 27, 2002 at 01:11:38AM -0800, Andrew Morton wrote:
> >
> > url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.49/2.5.49-mm2/
> 
> I'm fairly sure this is not specific to -mm2 since it looks
> at lot like my problem from plain 2.5.49
> (http://marc.theaimsgroup.com/?l=linux-kernel&m=103805691602076&w=2)
> but -mm2 gave me some usable debug output:
> 
> Debug: Sleeping function called from illegal context at include/
> linux/rwsem.h:66
> Call Trace: __might_sleep+0x54/0x58
>            sys_mprotect+0x97/0x22b
>            syscall_call+0x7/0xb

Oh that's cute.  Looks like we've accidentally disabled preemption
somewhere...

> Unable to handle kernel paging request at virtual address 4001360c

And once you do that, the pagefault handler won't handle pagefaults.
 
> (I did not copy the rest but can reproduce at will.)

Please do.  And tell how you're making it happen.

Is that .config still current?

Does it go away if you turn off preemption?
