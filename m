Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267580AbRGNGNc>; Sat, 14 Jul 2001 02:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267581AbRGNGNW>; Sat, 14 Jul 2001 02:13:22 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7525 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S267580AbRGNGNG>; Sat, 14 Jul 2001 02:13:06 -0400
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu, <linux-mm@kvack.org>
Subject: Re: RFC: Remove swap file support
In-Reply-To: <3B472C06.78A9530C@mandrakesoft.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Jul 2001 00:07:38 -0600
In-Reply-To: <3B472C06.78A9530C@mandrakesoft.com>
Message-ID: <m1elrk3uxh.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> writes:

> Since you can make any file into a block device using loop,
> is there any value to supporting swap files in 2.5?
> 
> swap files seem like a special case that is no longer necessary...

Yes, and no.  I'd say what we need to do is update rw_swap_page to
use the address space functions directly.  With block devices and
files going through the page cache in 2.5 that should remove any
special cases cleanly.

In 2.4 the swap code really hasn't been updated, the old code has only
been patched enough to work on 2.4.  This adds layers of work that we
really don't need to be doing.  Removing the extra redirection has the
potential to give a small performance boost to swapping.

The case to watch out for are deadlocks doing things like using
swapfiles on an NFS mount.  As you point out we can already do this
with the loop back devices so it isn't really a special case.  The
only new case I can see working are swapfiles with holes in them, or
swapfiles that do automatic compression.  I doubt those cases are
significant improvements but it looks like they will fall out
naturally. 

Eric
