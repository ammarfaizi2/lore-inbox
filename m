Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313713AbSD3Qy1>; Tue, 30 Apr 2002 12:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313714AbSD3Qy0>; Tue, 30 Apr 2002 12:54:26 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:21867 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S313713AbSD3QyZ>; Tue, 30 Apr 2002 12:54:25 -0400
Date: Tue, 30 Apr 2002 12:52:14 -0400
From: Arjan van de Ven <arjanv@redhat.com>
To: Dave Hansen <haveblue@us.ibm.com>, g@redhat.com
Cc: Russell King <rmk@arm.linux.org.uk>, Arjan van de Ven <arjanv@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: devfs: BKL *not* taken while opening devices
Message-ID: <20020430125214.A19533@devserv.devel.redhat.com>
In-Reply-To: <20020429141301.B16778@flint.arm.linux.org.uk> <3CCD672E.5040005@us.ibm.com> <3CCD811E.8689F4B0@redhat.com> <20020430134557.C26943@flint.arm.linux.org.uk> <3CCEC978.2090602@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2002 at 09:42:32AM -0700, Dave Hansen wrote:
> Russell King wrote:
> > On Mon, Apr 29, 2002 at 06:21:34PM +0100, Arjan van de Ven wrote:
> > 
> >>I'm not convinced of that. It's not nearly a critical path and it's
> >>better to get even the "dumb" drivers safe than to risk having big
> >>security holes in there for years to come.
> > 
> > Would it be worth dropping a  BUG_ON(!kernel_locked()) in tty_open() to
> > catch this type of error?  The tty code heavily relies on the BKL.
> > 
> > This way, such locking problems would get caught early, since everyone
> > uses the tty code during boot, right?
> 
> I like the idea.  But, while we're at it, does anyone have a good enough 
> grasp of locking the the TTY layer that we can start peeling some of the 
> BKL out of there?  Somebody was doing tests over a serial console here 
> and the lockmeter data showed horrible BKL contention and hold times.

I really really doubt that fixing contention will make serial ports go
faster... it'll just move to another lock since I suspect we're
just waiting for hardware
