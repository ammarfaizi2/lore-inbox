Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289113AbSAVAwk>; Mon, 21 Jan 2002 19:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289114AbSAVAwb>; Mon, 21 Jan 2002 19:52:31 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:30050 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289113AbSAVAw0>; Mon, 21 Jan 2002 19:52:26 -0500
Date: Tue, 22 Jan 2002 01:53:21 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Russell King <rmk@arm.linux.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, reid.hekman@ndsu.nodak.edu,
        linux-kernel@vger.kernel.org, akpm@zip.com.au, alan@lxorg.ukuu.org
Subject: Re: Athlon PSE/AGP Bug
Message-ID: <20020122015321.O8292@athlon.random>
In-Reply-To: <1011610422.13864.24.camel@zeus> <20020121.053724.124970557.davem@redhat.com> <20020121175410.G8292@athlon.random> <20020121.141931.105134927.davem@redhat.com> <20020122013743.M8292@athlon.random> <20020122004359.G11489@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20020122004359.G11489@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Tue, Jan 22, 2002 at 12:43:59AM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2002 at 12:43:59AM +0000, Russell King wrote:
> On Tue, Jan 22, 2002 at 01:37:43AM +0100, Andrea Arcangeli wrote:
> > On Mon, Jan 21, 2002 at 02:19:31PM -0800, David S. Miller wrote:
> > > That's not true, see the ptrace() helper code.  Russell King pointed
> > > this out to me last week and it's on my TODO list to fix it up.
> > 
> > Where? :) ptrace doesn't change pagetables, no need to flush any tlb in
> > ptrace.
> 
> See:
> 
> int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write)
> {
> ...
>                 flush_cache_page(vma, addr);
> ...
> }
> 
> flush_cache_page() is passed a non-page aligned address.  AFAIK that is
> the only instance where the flush_{cache,tlb}_* stuff is called with
> non-page aligned addresses.

flush_cache_page is by no means a _tlb_ flush. It is a virtual indexed
cache flush needed before you can access data at such address (noop on
x86).

I'm not even sure that we should consider incorrect if anybody would do
a tlb flush on a not aligned address, also given it works fine for the
4k pages, I mainly wanted to point out that with tlb flushes it gets
pretty natural to do them aligned in the code, and that's what linux
does with the 4k pages (we never invalidate 4M pages as Dave pointed out
but it sounds unlikely nvidia tlb flush 4M pages misaligned).

Andrea
