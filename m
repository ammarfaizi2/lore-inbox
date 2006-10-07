Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422716AbWJGAGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422716AbWJGAGJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 20:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423015AbWJGAGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 20:06:09 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:16231 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1422716AbWJGAGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 20:06:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pebvDdJcpCtvdFzp6CA8Zmj+OitUR/Pj+f2Fh46fHs0xII+I/0sfulQKeRwXciH8bAsiLBqSnJQPw9J0xEgqQ7VmPXPbcGQ9nH7P72hcEg+bAJMpYSOU4kWAC3BMCsWSRM8e+AkCT1QOm5iH5ANtf366lRMPT+SLOw1+blB4q9w=
Message-ID: <9a8748490610061706k7d8228d4s109108bb94f061a8@mail.gmail.com>
Date: Sat, 7 Oct 2006 02:06:07 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: Simple script that locks up my box with recent kernels
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <20061006165425.23b326e0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490610061636r555f1be4x3c53813ceadc9fb2@mail.gmail.com>
	 <20061006165425.23b326e0.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/06, Andrew Morton <akpm@osdl.org> wrote:
> On Sat, 7 Oct 2006 01:36:24 +0200
> "Jesper Juhl" <jesper.juhl@gmail.com> wrote:
>
> > Hi,
> >
> > I've been using the this very simple script for a while to do test
> > builds of the kernel :
> >
> >
> > #!/bin/bash
> >
> > for i in $(seq 1 100); do
> >         nice make distclean
> >         while true; do
> >                 nice make randconfig
> >                 grep -q "CONFIG_EXPERIMENTAL=y" .config
> >                 if [ $? -eq 1 ]; then
> >                         break
> >                 fi
> >         done
> >         cp .config config.${i}
> >         nice make -j3 > build.log.${i} 2>&1
> > done
> >
> >
> > Which has worked great in the past, but with recent kernels it has
> > been a sure way to cause a complete lockup within 1 hour :-(
> >
>
> This is probably one of those nobody-but-you-can-reproduce-it things.
>
I hope not. But that actually why I post the script, to try an get
more people to reproduce...


> >
> > When the lockup happens the box just freezes and doesn't respond to
> > anything at all. Sometimes I can reboot with alt+sysrq+b but sometimes
> > not even that works.
>
> If you can do sysrq-b then you can do sysrq-t, too?
>
I don't know, haven't tried - but I'll try the next few times it locks up.


> Please ensure that you have all the CONFIG_DEBUG_* things set, apart from
> PAGEALLOC.
>
$ zgrep CONFIG_DEBUG_ /proc/config.gz
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_SLAB_LEAK=y
CONFIG_DEBUG_PREEMPT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_PI_LIST=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_HIGHMEM=y
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_RODATA=y

That good enough?


>
> Once you've got the test set up and running, you can do the alt-ctl-F1
> thing to take you out of X and into the vga console.  I suggest you leave
> it running that way, see if anything pops up when it hangs.
>
I've done that on a few occasions already without seeing anything, but
I'll try a few more times.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
