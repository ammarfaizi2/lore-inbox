Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265373AbSJRWba>; Fri, 18 Oct 2002 18:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265376AbSJRWba>; Fri, 18 Oct 2002 18:31:30 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:3724 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265373AbSJRWb3>; Fri, 18 Oct 2002 18:31:29 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 18 Oct 2002 15:45:51 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Hanna Linder <hannal@us.ibm.com>, Benjamin LaHaise <bcrl@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>
Subject: Re: [PATCH] sys_epoll system call interface to /dev/epoll
In-Reply-To: <Pine.LNX.4.44.0210181504470.11349-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0210181538100.1537-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2002, Linus Torvalds wrote:

>
> On Fri, 18 Oct 2002, Hanna Linder wrote:
> >
> > 	You said earlier that you didn't like epoll being
> > in /dev. How about a system call interface instead? this
> > patch provides the skeleton for that system call. We
> > can have Davide's patch ported into it ASAP if you include
> > this by the freeze.
>
> I like it noticeably better as a system call, so it's maybe worth
> discussing. It's not going to happen before I leave (very early tomorrow
> morning), but if people involved agree on this and clean patches to
> actiually add the code (not just system call stubs) can be made..

Linus, yesterday I was sugesting Hanna to use most of the existing code
and to make :

int sys_epoll_create(int maxfds);

to actually return an fd. Basically during this function call the code
allocates a file*, initialize it, allocates a free fd, maps the file* to
the fd, creates the vma* for the shared events area between the kernel and
user space, maps allocated kernel pages to the vma*, install the vma* and
returns the fd. In this way we can avoid the sys_epoll_close() and close()
can be used. Also the task cleanup comes for free being linked to a file*.
In this way also users that are using /dev/epoll in the old way can
continue to use it, being the skeleton code the same.
Do I have to guess that you do not like this idea ?



- Davide


