Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265413AbSJRXNx>; Fri, 18 Oct 2002 19:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265417AbSJRXNx>; Fri, 18 Oct 2002 19:13:53 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:41961 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265413AbSJRXNw>;
	Fri, 18 Oct 2002 19:13:52 -0400
Message-ID: <3DB094B0.2040400@watson.ibm.com>
Date: Fri, 18 Oct 2002 19:09:36 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Davide Libenzi <davidel@xmailserver.org>, Hanna Linder <hannal@us.ibm.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org
Subject: Re: [PATCH] sys_epoll system call interface to /dev/epoll
References: <Pine.LNX.4.44.0210181538100.1537-100000@blue1.dev.mcafeelabs.com> <Pine.LNX.4.44.0210181542140.1202-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Apart from the multiple vs. single system call issue, are you okay with
the creation of an fd,file * etc. without having a device ?

The former issue could certainly be avoided by having multiple syscalls.
In fact, Davide had originally suggested an interface looking somewhat like
this:

	int sys_epoll_create(int maxfds);
	int sys_epoll_addfd(int epd, int fd);
	void sys_epoll_close(int epd);
	int sys_epoll_wait(int epd, struct pollfd **pevts, int timeout);
	
which is roughly what Hanna tried to multiplex onto the single sys_epoll. 	

-- Shailabh



Linus Torvalds wrote:
> On Fri, 18 Oct 2002, Davide Libenzi wrote:
> 
>>Linus, yesterday I was sugesting Hanna to use most of the existing code
>>and to make :
>>
>>int sys_epoll_create(int maxfds);
>>
>>to actually return an fd. Basically during this function call the code
>>allocates a file*, initialize it, allocates a free fd, maps the file* to
>>the fd, creates the vma* for the shared events area between the kernel and
>>user space, maps allocated kernel pages to the vma*, install the vma* and
>>returns the fd.
> 
> 
> But that's what her patch infrastructure seems to do. It's not just
> epoll_create(), it's all the other ioctl's too (unlink, remove etc). One
> queston is whether there is one epoll system call (that multiplexes, like
> in Hanna's patch) or many. I personally don't like multiplexing system
> calls - the system call number _is_ a multiplexor, I don't see the point 
> of having multiple levels.
> 
> 		Linus




