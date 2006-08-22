Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWHVMkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWHVMkV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 08:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWHVMkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 08:40:21 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:24760 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932213AbWHVMkU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 08:40:20 -0400
Date: Tue, 22 Aug 2006 16:39:32 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Christoph Hellwig <hch@infradead.org>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>
Subject: Re: [PATCH] kevent_user: remove non-chardev interface
Message-ID: <20060822123932.GA27181@2ka.mipt.ru>
References: <12345678912345.GA1898@2ka.mipt.ru> <11561555871530@2ka.mipt.ru> <20060822115459.GA10839@infradead.org> <20060822121709.GA4815@2ka.mipt.ru> <20060822122731.GA2994@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060822122731.GA2994@infradead.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 22 Aug 2006 16:39:36 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 01:27:31PM +0100, Christoph Hellwig (hch@infradead.org) wrote:
> On Tue, Aug 22, 2006 at 04:17:10PM +0400, Evgeniy Polyakov wrote:
> > I personally do not have objections against it, but it introduces
> > additional complexies - one needs to open /dev/kevent and then perform
> > syscalls on top of returuned file descriptor.
> 
> it disalllows
> 
> int fd = sys_kevent_ctl(<random>, KEVENT_CTL_INIT, <random>, <random>);
> 
> in favour of only
> 
> int fd = open("/dev/kevent", O_SOMETHING);
> 
> which doesn't seem like a problem, especially as I really badly hope
> no one will use the syscalls but some library instead.

Yep, exactly about above open/kevent_ctl I'm talking.
I still have a system which has ioctl() based kevent setup, and it
works - I really do not want to rise another flamewar about which
approach is better. If no one will complain until tomorrow I will commit
it.

> In addition to that I'm researching whether there's a better way to
> implement the other functionality instead of the two syscalls.  But I'd
> rather let code speak, so wait for some patches from me on that.

There were implementation with pure ioctl() and with one syscall for all
oprations (and control block embedded in it), all were rejected in
favour of two syscalls, so I'm waiting for your patches.

-- 
	Evgeniy Polyakov
