Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289114AbSAVA4K>; Mon, 21 Jan 2002 19:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289115AbSAVA4A>; Mon, 21 Jan 2002 19:56:00 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:15367 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S289114AbSAVAzz>; Mon, 21 Jan 2002 19:55:55 -0500
Date: Tue, 22 Jan 2002 00:55:47 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, reid.hekman@ndsu.nodak.edu,
        linux-kernel@vger.kernel.org, akpm@zip.com.au, alan@lxorg.ukuu.org
Subject: Re: Athlon PSE/AGP Bug
Message-ID: <20020122005547.I11489@flint.arm.linux.org.uk>
In-Reply-To: <1011610422.13864.24.camel@zeus> <20020121.053724.124970557.davem@redhat.com> <20020121175410.G8292@athlon.random> <20020121.141931.105134927.davem@redhat.com> <20020122013743.M8292@athlon.random> <20020122004359.G11489@flint.arm.linux.org.uk> <20020122015321.O8292@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020122015321.O8292@athlon.random>; from andrea@suse.de on Tue, Jan 22, 2002 at 01:53:21AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2002 at 01:53:21AM +0100, Andrea Arcangeli wrote:
> On Tue, Jan 22, 2002 at 12:43:59AM +0000, Russell King wrote:
> > On Tue, Jan 22, 2002 at 01:37:43AM +0100, Andrea Arcangeli wrote:
> > > On Mon, Jan 21, 2002 at 02:19:31PM -0800, David S. Miller wrote:
> > > > That's not true, see the ptrace() helper code.  Russell King pointed
> > > > this out to me last week and it's on my TODO list to fix it up.
> > > 
> > > Where? :) ptrace doesn't change pagetables, no need to flush any tlb in
> > > ptrace.
> > 
> > See:
> > 
> > int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write)
> > {
> > ...
> >                 flush_cache_page(vma, addr);
> > ...
> > }
> > 
> > flush_cache_page() is passed a non-page aligned address.  AFAIK that is
> > the only instance where the flush_{cache,tlb}_* stuff is called with
> > non-page aligned addresses.
> 
> flush_cache_page is by no means a _tlb_ flush. It is a virtual indexed
> cache flush needed before you can access data at such address (noop on
> x86).

Sigh, I never claimed it was a tlb flush function.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

