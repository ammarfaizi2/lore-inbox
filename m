Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264969AbSKSKSu>; Tue, 19 Nov 2002 05:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264984AbSKSKSu>; Tue, 19 Nov 2002 05:18:50 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20565 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S264969AbSKSKSt>; Tue, 19 Nov 2002 05:18:49 -0500
To: Andy Pfiffer <andyp@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
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
	<1037668241.10400.48.camel@andyp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Nov 2002 03:25:08 -0700
In-Reply-To: <1037668241.10400.48.camel@andyp>
Message-ID: <m1isyt26wr.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Pfiffer <andyp@osdl.org> writes:

> On Mon, 2002-11-18 at 00:53, Eric W. Biederman wrote:
> > kexec is a set of systems call that allows you to load another kernel
> > from the currently executing Linux kernel.  The current implementation
> > has only been tested, and had the kinks worked out on x86, but the
> > generic code should work on any architecture.
> 
> Great News, Eric.  For the first time *ever* I got a kexec reboot to
> work on my most troublesome machine (see below).

Cool.  I was pretty certain it would get into Linux but the fact the device
drivers are not hanging up is a real plus.
 
> Current .config settings:
> # CONFIG_SMP is not set
> CONFIG_X86_GOOD_APIC=y
> # CONFIG_X86_UP_APIC is not set
> CONFIG_KEXEC=y
> 
> Oddly, kexec_test still hangs.
> # ./kexec-1.7 --force ./kexec_test-1.7
[snip...]
> <hang>

Yep.  I really haven't tracked and fixed the cause of the hang,
I just avoided the issue entirely.  Eventually I will come back
and look into what it takes to improve the odds of having BIOS calls,
work.  --real-mode restores the old kexec behavior.

All of the real changes were to the user space code.  The kernel
patch stayed the same.

> Complete kernel boot-up log attached below.  I'm going to try to find my
> other 576MB of RAM with the right command-line magic... ;^)

Or you can write a routine to gather that information dynamically and send
me a patch for /sbin/kexec.  Though it may take another proc file to do
that one properly.

Eric
