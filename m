Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293283AbSCUEXA>; Wed, 20 Mar 2002 23:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293288AbSCUEWv>; Wed, 20 Mar 2002 23:22:51 -0500
Received: from smtp.actcom.co.il ([192.114.47.13]:42199 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S293283AbSCUEWj>; Wed, 20 Mar 2002 23:22:39 -0500
Message-Id: <200203210421.g2L4Lwx22756@lmail.actcom.co.il>
Content-Type: text/plain; charset=US-ASCII
From: Itai Nahshon <nahshon@actcom.co.il>
Reply-To: nahshon@actcom.co.il
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, hch@infradead.org (Christoph Hellwig)
Subject: Re: Creating a per-task kernel space for kmap, user pagetables, et al
Date: Thu, 21 Mar 2002 06:21:45 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Martin.Bligh@us.ibm.com (Martin J. Bligh),
        andrea@suse.de (Andrea Arcangeli), hugh@veritas.com (Hugh Dickins),
        riel@conectiva.com.br (Rik van Riel),
        dmccr@us.ibm.com (Dave McCracken),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <E16npfo-0003gA-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 March 2002 01:39 am, Alan Cox wrote:
> > That has been implemented in Caldera OpenUnix in the last years.
>
> V7 unix had it. Thats where the "uarea" aka u. comes in. Its one of the
> killer problems with Linux 8086 - on the 11 they could put the kernel stack
> file handles and other process local crap into a swappable segment that
> could also be swapped from the kernel address space. On the 8086 thats
> trickier

Some 20 years ago I knew almost everything about BSD-4.x on a VAX.
The user area was just above the user stack. Actually it was part of the
user space, accessible RO from user mode and RW for the kernel.
It was always mapped at a fixed address that was just below the 2G
marker.

The process table contained whatever was needed to swap-in
and access the user area, some scheduling parameters and
signal mask/pending bits (I'm sure I missed something).

This arrangement might save some physical memory because
this area was swapped with the process (actually that was the last
thing to swap out/first to swap in because the page table for the
rest of the process was in there).

I think this arrangement made stuff as shared memory (and libs),
ptrace and other IPC more complicated. Then memory management
stuff... Remember that the system base architecture knew how
to swap in/out only whole processes. Paging was implemented
above it with a global clock (LRU like) algorithm.

Truely I thought that putting everything in "current" in Linux was
more of a design decision and not something that's derived from
the '86 architecture.

-- Itai

