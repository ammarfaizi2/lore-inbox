Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319336AbSHQEfQ>; Sat, 17 Aug 2002 00:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319337AbSHQEfQ>; Sat, 17 Aug 2002 00:35:16 -0400
Received: from holomorphy.com ([66.224.33.161]:3778 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S319336AbSHQEfP>;
	Sat, 17 Aug 2002 00:35:15 -0400
Date: Fri, 16 Aug 2002 21:36:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Benjamin LaHaise <bcrl@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)]
Message-ID: <20020817043631.GG18350@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Benjamin LaHaise <bcrl@redhat.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Chris Friesen <cfriesen@nortelnetworks.com>,
	Pavel Machek <pavel@elf.ucw.cz>, linux-kernel@vger.kernel.org,
	linux-aio@kvack.org
References: <2154752289.1029530794@[10.10.2.3]> <Pine.LNX.4.44.0208162056250.2305-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208162056250.2305-100000@home.transmeta.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2002 at 09:00:52PM -0700, Linus Torvalds wrote:
> Careful.
> The VM space is shared _separately_ from other data structures, which
> means that you can _not_ user per-VM virtual address areas and expect them 
> to scale with load. And than some VM happens to have thousands of threads, 
> and you're dead.

This is a clear and present danger, and the strategies to deal with them,
although they're not ready for presentation, are in development.


At some point in the past, Martin Bligh wrote:
>> Some things have to be global (well, easier at least) like the
>> task_struct, but the kernel stacks could be moved out with a little
>> work, files, vm_area_structs, etc.

On Fri, Aug 16, 2002 at 09:00:52PM -0700, Linus Torvalds wrote:
> Kernel stacks most certainly can't do this easily, since you'll just hit 
> the scalability problem somewhere else (ie many threads, same VM). 
> And files, for example, can not only be many files for one VM, you can 
> have the reverse too, ie many VM's, one file table.

Stacks are probably not the foremost priority here. First and foremost
come the bugs that stop smaller workloads cold. But as you've said,
scalability problems can and will arise in stacks and still other
things mapped in similar ways by the traditional UNIX architecture.
The demands 32-bit machines can make of a generic kernel are limited,
and this is understood. The intention of our developers is not to
corrupt the generic kernel with hacks that will not extend beyond 32
bits, but to exploit the hardware to which we have access to to expose
the largest number of scalability issues possible and address them. And
to the best of our abilities we will do the work necessary to address
them ourselves as opposed to presenting burdens on others. And ideally
we will also benefit common users with the same patches.

Please understand we are absolutely not interested in working against
your intentions but only working with them and taking on labor
ourselves to advance the state of the Linux kernel for all workloads,
both large and small. And that means swapping (which TPC/H does not do)
and IDE. Yes, I'm making promises that I myself cannot keep. But I am
confident that the support is present to such a degree that I am
absolutely certain the contributions and contributors to make them
happen will be funded, with or without my participation.


Cheers,
Bill
