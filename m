Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292555AbSCMHMR>; Wed, 13 Mar 2002 02:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292574AbSCMHMH>; Wed, 13 Mar 2002 02:12:07 -0500
Received: from lmail.actcom.co.il ([192.114.47.13]:44991 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S292555AbSCMHLz>; Wed, 13 Mar 2002 02:11:55 -0500
Date: Wed, 13 Mar 2002 09:11:47 +0200 (EET)
From: guy keren <choo@actcom.co.il>
To: Ben Israel <ben@genesis-one.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Write allocated mallocs
In-Reply-To: <010701c1ca27$dc05fdc0$60d53318@pbc.adelphia.net>
Message-ID: <Pine.GSU.4.30_heb2.09.0203130907340.602-100000@actcom.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 12 Mar 2002, Ben Israel wrote:

> I have noticed some unexpected behavior of my Linux 2.4.7 kernel. It appears
> that my user level task is only allowed 512 mallocs before each malloc
> starts getting physical memory. I want to malloc virtual address space and
> only get physical memory when I write to a page. Is this some compiled
> constant in the kernel? Are there any ways to get more? Where can I read
> about such architecture decisions, so other behavior won't be so unexpected?

i'm not sure i fully understand what you are seeing, but it _seems_ like
the physical memory is allocated in order for malloc to store its data
structures. for example, each time you malloc() a block, malloc has to
store the block size somewhere (probably just before that block in
memory). thus, after allocating enough blocks, new pages are required
to store malloc's data. could it be that this is what you're seeing?

the number 512 is especially curious - what size of blocks are you
allocating? assuming there's a need to use 4 bytes to store the size of
each allocated block, and that a memory page contains 4096 byets, then if
each block you allocate is 4 bytes long, you'll see that 512 mallocs will
exactly fill up a memory page
512 * (4 bytes for size + 4 bytes for block) = 4096.

--
guy

"For world domination - press 1,
 or dial 0, and please hold, for the creator." -- nob o. dy

