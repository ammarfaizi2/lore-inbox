Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319274AbSHQD4h>; Fri, 16 Aug 2002 23:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319335AbSHQD4h>; Fri, 16 Aug 2002 23:56:37 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11538 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319274AbSHQD4g>; Fri, 16 Aug 2002 23:56:36 -0400
Date: Fri, 16 Aug 2002 21:00:52 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: Benjamin LaHaise <bcrl@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re:
 async-io API registration for 2.5.29)]
In-Reply-To: <2154752289.1029530794@[10.10.2.3]>
Message-ID: <Pine.LNX.4.44.0208162056250.2305-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Aug 2002, Martin J. Bligh wrote:
> 
> At least some of those you don't have to kmap ... at least not in
> the traditional sense. This sort of thing is a good application
> for the per-process (or per-task) kernel virtual address area.
> you just map in the stuff you need for your own task, instead
> of having to share the global space with everybody.

Careful.

The VM space is shared _separately_ from other data structures, which
means that you can _not_ user per-VM virtual address areas and expect them 
to scale with load. And than some VM happens to have thousands of threads, 
and you're dead.

>					 Some things
> have to be global (well, easier at least) like the task_struct,
> but the kernel stacks could be moved out with a little work,
> files, vm_area_structs, etc.

Kernel stacks most certainly can't do this easily, since you'll just hit 
the scalability problem somewhere else (ie many threads, same VM). 

And files, for example, can not only be many files for one VM, you can 
have the reverse too, ie many VM's, one file table.

		Linus

