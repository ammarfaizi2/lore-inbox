Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbVL0JeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbVL0JeT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 04:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbVL0JeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 04:34:19 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:25287 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932279AbVL0JeS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 04:34:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cG5nrkemw3wr84w3plMFW/RhkU3ZchMhSojKvV5vIc9SFOiuM0jVmy8MgKVekf6P/4vDc5/Hmon9xMOKoBPxDC65bqfaIEmgort8wlveUDEmLu+tbfo5gu9OfaRq/G68wBe9miaR6hBE8eNnwOpLxSA8LagHA9SHsVBozkzsRjw=
Message-ID: <9a8748490512270134i5e8efc59s795aff748e6a1f1a@mail.gmail.com>
Date: Tue, 27 Dec 2005 10:34:17 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [WTF?] sys_tas() on m32r
Cc: Andrew Morton <akpm@osdl.org>, Al Viro <viro@ftp.linux.org.uk>,
       linux-kernel@vger.kernel.org, Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <1135365035.22177.17.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051223061556.GR27946@ftp.linux.org.uk>
	 <20051223055526.bc1a4044.akpm@osdl.org>
	 <1135365035.22177.17.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Fri, 2005-12-23 at 05:55 -0800, Andrew Morton wrote:
> > Al Viro <viro@ftp.linux.org.uk> wrote:
> > >
> > > asmlinkage int sys_tas(int *addr)
> > > {
> > >         int oldval;
> > >         unsigned long flags;
> > >
> > >         if (!access_ok(VERIFY_WRITE, addr, sizeof (int)))
> > >                 return -EFAULT;
> > >         local_irq_save(flags);
> > >         oldval = *addr;
> > >         if (!oldval)
> > >                 *addr = 1;
> > >         local_irq_restore(flags);
> > >         return oldval;
> > > }
> > > in arch/m32r/kernel/sys_m32r.c.  Trivial oops *AND* ability to trigger
> > > IO with interrupts disabled.
> >
> > Yeah.  I pointed this out to Takata in October last year and then promptly
> > forgot about it.  It's rather amazing that this code (which appears to be in
> > live use in linuxthreads) hasn't generated oopses.
>
> No one uses LinuxThreads anymore?
>
Slackware still uses LinuxThreads.
Latest release and -current include both NPTL & LinuxThreads, and use
NPTL if the running kernel is >2.6.4 or LinuxThreads if <=2.6.4 or
when running a 2.4 kernel (2.4 is still the default kernel in
Slackware although 2.6.x is also fully supported).

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
