Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319333AbSHQDpx>; Fri, 16 Aug 2002 23:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319335AbSHQDpw>; Fri, 16 Aug 2002 23:45:52 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:22442 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S319333AbSHQDpw>; Fri, 16 Aug 2002 23:45:52 -0400
Date: Fri, 16 Aug 2002 20:46:36 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Benjamin LaHaise <bcrl@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>
cc: Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)]
Message-ID: <2154752289.1029530794@[10.10.2.3]>
In-Reply-To: <20020815221647.M29874@redhat.com>
References: <20020815221647.M29874@redhat.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > A 4G/4G split flushes the TLB on every syscall.
>> 
>> This is just not going to happen. It will have to continue being a 3/1G 
>> split, and we'll just either find a way to move stuff to highmem and 
>> shrink the "struct page", or we'll just say "screw those 16GB+ machines on 
>> x86". 
> 
> I wish life were that simple.  Unfortunately, struct page isn't the only 
> problem with these abominations: the system can run out of kvm for 
> vm_area_struct, task_struct, files...  Personally, I *never* want to see 
> those data structures being kmap()'d as it would hurt kernel code quality 
> whereas a 4G/4G split is well confined, albeit sickening.

At least some of those you don't have to kmap ... at least not in
the traditional sense. This sort of thing is a good application
for the per-process (or per-task) kernel virtual address area.
you just map in the stuff you need for your own task, instead
of having to share the global space with everybody. Some things
have to be global (well, easier at least) like the task_struct,
but the kernel stacks could be moved out with a little work,
files, vm_area_structs, etc.

That sounds more appealing to me than either kmap or a 4G/4G split.

M.

