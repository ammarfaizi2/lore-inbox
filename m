Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274597AbRITSY0>; Thu, 20 Sep 2001 14:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274596AbRITSYQ>; Thu, 20 Sep 2001 14:24:16 -0400
Received: from [195.223.140.107] ([195.223.140.107]:7924 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274597AbRITSYH>;
	Thu, 20 Sep 2001 14:24:07 -0400
Date: Thu, 20 Sep 2001 20:24:36 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: manfred@colorfullife.com
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: Deadlock on the mm->mmap_sem
Message-ID: <20010920202436.N729@athlon.random>
In-Reply-To: <3BA9CB84.16616163@stud.uni-saarland.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BA9CB84.16616163@stud.uni-saarland.de>; from masp0008@stud.uni-sb.de on Thu, Sep 20, 2001 at 10:57:08AM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 10:57:08AM +0000, Studierende der Universitaet des Saarlandes wrote:
> * A fair, recursive mmap_sem (a task that already owns the mmap_sem can
> acquire it again without deadlocking, all other cases are fair). That's
> what Andrea proposes. (Andrea, is that correct?)

Exactly.

> elf_core_dump should call down_write to prevent concurrent expand_stack

expand_stack doesn't need the write sem, see the locking comments in the
00_silent-stack-overflow patch in -aa.

> calls, and acquire the pagetable_lock around some lines (right now it
> walks the page tables without locking). I'll check the other coredump

Also expand_stack needs the page_table_lock, that's ok.

> I'll write a patch that moves the locking into the coredump handlers,
> then we can compare that with Andrea's proposal.

Ok.

Andrea
