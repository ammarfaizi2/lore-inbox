Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265982AbSKTJKw>; Wed, 20 Nov 2002 04:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265993AbSKTJKw>; Wed, 20 Nov 2002 04:10:52 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64854 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S265982AbSKTJKu>; Wed, 20 Nov 2002 04:10:50 -0500
To: suparna@in.ibm.com
Cc: Andy Pfiffer <andyp@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [ANNOUNCE][CFT] kexec for v2.5.48 && kexec-tools-1.7 -- Success Story!
References: <Pine.LNX.4.44.0211091901240.2336-100000@home.transmeta.com>
	<m1vg349dn5.fsf@frodo.biederman.org> <1037055149.13304.47.camel@andyp>
	<m1isz39rrw.fsf@frodo.biederman.org> <1037148514.13280.97.camel@andyp>
	<m1k7jb3flo.fsf_-_@frodo.biederman.org>
	<m1el9j2zwb.fsf@frodo.biederman.org>
	<m11y5j2r9t.fsf_-_@frodo.biederman.org>
	<1037668241.10400.48.camel@andyp> <20021120141925.A2524@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Nov 2002 02:17:04 -0700
In-Reply-To: <20021120141925.A2524@in.ibm.com>
Message-ID: <m1smxwzjlb.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> writes:

> On Mon, Nov 18, 2002 at 05:10:38PM -0800, Andy Pfiffer wrote:
> > On Mon, 2002-11-18 at 00:53, Eric W. Biederman wrote:
> > > kexec is a set of systems call that allows you to load another kernel
> > > from the currently executing Linux kernel.  The current implementation
> > > has only been tested, and had the kinks worked out on x86, but the
> > > generic code should work on any architecture.
> > 
> > Great News, Eric.  For the first time *ever* I got a kexec reboot to
> > work on my most troublesome machine (see below).
> 
> Same here - preloading the new kernel and issuing kexec -e after 
> init 1 works on the troublesome SMP system I'd earlier been sending 
> you earlier. Bootimg used to work on this setup, so bypassing the 
> bios calls had the expected effect.
> 
> If I issue the call earlier though, it runs into trouble with aic7xxx
> reporting interrupts during setup. Guess you know why we are looking
> at that case - eventually need to be able to transition directly at dump 
> time without a chance to go through user-space shutdown ... 

The needed hooks are there.  You can make certain an appropriate
->shutdown()/reboot_notifier method is present, or you can fix the driver
so it can initialize the device from any random state.  

I really don't know what kinds of failures you hope to recover
from with the kexec on panic code, so I really can't comment on
how well things will work.  There will always be a set of failures
that are non-recoverable, but that doesn't mean there isn't a useful
subset.  Anyway there is certainly plenty of material for you to
experiment with and see what works usefully in practice.

Eric

