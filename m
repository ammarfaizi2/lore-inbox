Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262020AbSJQTBo>; Thu, 17 Oct 2002 15:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262032AbSJQTBo>; Thu, 17 Oct 2002 15:01:44 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:25614 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262020AbSJQTBn>;
	Thu, 17 Oct 2002 15:01:43 -0400
Date: Thu, 17 Oct 2002 12:07:23 -0700
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Cc: linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021017190723.GB32537@kroah.com>
References: <20021017195015.A4747@infradead.org> <20021017185352.GA32537@kroah.com> <20021017195838.A5325@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017195838.A5325@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 07:58:38PM +0100, Christoph Hellwig wrote:
> On Thu, Oct 17, 2002 at 11:53:52AM -0700, Greg KH wrote:
> > No, don't remove this!
> 
> > Yes, it's a big switch, but what do you propose otherwise?  SELinux
> > would need a _lot_ of different security calls, which would be fine, but
> > we don't want to force every security module to try to go through the
> > process of getting their own syscalls.
> 
> They should register their syscalls with the kernel properly. Look
> at what e.g. the streams people did after the sys_call_table
> removal.  It's enough that IRIX suffers from the syssgi syndrome, no
> need to copy redo their mistakes in Linux.

Hm, as I'm not a SELinux developer, I can't tell you how many different
syscalls they need, or what they are for, sorry.

But this will require every security module project to petition for a
syscall, which would be a pain, and is the whole point of having this
sys_security call.

> > And other subsystems in the kernel do the same thing with their syscall,
> > like networking, so there is a past history of this usage.
> 
> But they don't allow any random module to implement it.  And anyone
> asked today says the horrible sys_Scoketcall and sys_ipc cludges
> were a mistake.

How would they be done differently now?  Multiple different syscalls?

I do know that Dave Miller has also complained about the sys_security
call in the past, and the difficulties along the same lines as the
ioctl 32bit problem.  If we were to go to individual syscalls for every
security function, this would go away.

In the end, it's Linus's call.

thanks,

greg k-h

p.s. you might want to copy the lsm mailing list in your messages, so
those people there are aware of your comments.
