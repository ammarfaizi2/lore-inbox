Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265368AbSJRWnC>; Fri, 18 Oct 2002 18:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265376AbSJRWnC>; Fri, 18 Oct 2002 18:43:02 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36616 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265368AbSJRWnC>; Fri, 18 Oct 2002 18:43:02 -0400
Date: Fri, 18 Oct 2002 15:51:36 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Hanna Linder <hannal@us.ibm.com>, Benjamin LaHaise <bcrl@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>
Subject: Re: [PATCH] sys_epoll system call interface to /dev/epoll
In-Reply-To: <Pine.LNX.4.44.0210181538100.1537-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.44.0210181542140.1202-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Oct 2002, Davide Libenzi wrote:
> 
> Linus, yesterday I was sugesting Hanna to use most of the existing code
> and to make :
> 
> int sys_epoll_create(int maxfds);
> 
> to actually return an fd. Basically during this function call the code
> allocates a file*, initialize it, allocates a free fd, maps the file* to
> the fd, creates the vma* for the shared events area between the kernel and
> user space, maps allocated kernel pages to the vma*, install the vma* and
> returns the fd.

But that's what her patch infrastructure seems to do. It's not just
epoll_create(), it's all the other ioctl's too (unlink, remove etc). One
queston is whether there is one epoll system call (that multiplexes, like
in Hanna's patch) or many. I personally don't like multiplexing system
calls - the system call number _is_ a multiplexor, I don't see the point 
of having multiple levels.

		Linus

