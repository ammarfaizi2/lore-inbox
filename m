Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264717AbSJOTGr>; Tue, 15 Oct 2002 15:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264719AbSJOTGq>; Tue, 15 Oct 2002 15:06:46 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:9199 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S264717AbSJOTGo>; Tue, 15 Oct 2002 15:06:44 -0400
Date: Tue, 15 Oct 2002 15:12:38 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
Message-ID: <20021015151238.L14596@redhat.com>
References: <20021015150201.K14596@redhat.com> <Pine.LNX.4.44.0210151213170.1554-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210151213170.1554-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Tue, Oct 15, 2002 at 12:16:39PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 12:16:39PM -0700, Davide Libenzi wrote:
> Ben, one of the reasons of the /dev/epoll speed is how it returns events
> and how it collapses them. A memory mapped array is divided by two and
> while the user consumes events in one set, the kernel fill the other one.
> The next wait() will switch the pointers. There is no copy from kernel to
> user space. Doing :
> 
> int sys_epoll_wait(int epd, struct pollfd **pevts, int timeout);
> 
> the only data the kernel has to copy to userspace is the 4(8) bytes for
> the "pevts" pointer.

Erm, the aio interface has support for the event ringbuffer being accessed 
by userspace (it lives in user memory and the kernel acts as a writer, with 
userspace as a reader), that's one of its advantages -- completion events 
are directly accessible from userspace after being written to by an 
interrupt.  Ideally this is to be wrapped in a vsyscall, but we don't have 
support for that yet on x86, although much of the code written for x86-64 
should be reusable.

		-ben
