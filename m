Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRACV42>; Wed, 3 Jan 2001 16:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131161AbRACV4S>; Wed, 3 Jan 2001 16:56:18 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:10161 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131155AbRACV4G>;
	Wed, 3 Jan 2001 16:56:06 -0500
Date: Wed, 3 Jan 2001 16:54:38 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Dan Aloni <karrde@callisto.yi.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>, mark@itsolve.co.uk
Subject: Re: [RFC] prevention of syscalls from writable segments, breaking
 bug exploits
In-Reply-To: <Pine.LNX.4.21.0101032259550.20246-100000@callisto.yi.org>
Message-ID: <Pine.GSO.4.21.0101031648250.17363-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Jan 2001, Dan Aloni wrote:

> It is known that most remote exploits use the fact that stacks are
> executable (in i386, at least).
> 
> On Linux, they use INT 80 system calls to execute functions in the kernel
> as root, when the stack is smashed as a result of a buffer overflow bug in
> various server software.
> 
> This preliminary, small patch prevents execution of system calls which
> were executed from a writable segment. It was tested and seems to work,
> without breaking anything. It also reports of such calls by using printk.

Get real. Attacker can set whatever registers he needs and jump to one
of the many instances of int 0x80 in libc. There goes your protection.

Win: 0
Loss: cost of find_vma() (and down(&mm->mmap_sem), BTW) on every system
call.

And the reason to apply that patch would be...?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
