Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131306AbRACWFi>; Wed, 3 Jan 2001 17:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131305AbRACWF2>; Wed, 3 Jan 2001 17:05:28 -0500
Received: from pm4-1-c0-73.apex.net ([209.250.32.88]:7944 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S131192AbRACWFQ>; Wed, 3 Jan 2001 17:05:16 -0500
Date: Wed, 3 Jan 2001 16:05:28 -0600
From: Steven Walter <srwalter@yahoo.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] prevention of syscalls from writable segments, breaking bug exploits
Message-ID: <20010103160528.B13576@hapablap.dyn.dhs.org>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0101032259550.20246-100000@callisto.yi.org> <Pine.GSO.4.21.0101031648250.17363-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0101031648250.17363-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, Jan 03, 2001 at 04:54:38PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2001 at 04:54:38PM -0500, Alexander Viro wrote:
> On Wed, 3 Jan 2001, Dan Aloni wrote:
> 
> > It is known that most remote exploits use the fact that stacks are
> > executable (in i386, at least).
> > 
> > On Linux, they use INT 80 system calls to execute functions in the kernel
> > as root, when the stack is smashed as a result of a buffer overflow bug in
> > various server software.
> > 
> > This preliminary, small patch prevents execution of system calls which
> > were executed from a writable segment. It was tested and seems to work,
> > without breaking anything. It also reports of such calls by using printk.
> 
> Get real. Attacker can set whatever registers he needs and jump to one
> of the many instances of int 0x80 in libc. There goes your protection.
> 
> Win: 0
> Loss: cost of find_vma() (and down(&mm->mmap_sem), BTW) on every system
> call.
> 
> And the reason to apply that patch would be...?

Should be a moot point, anyway, as x86 has a seperate stack for each
priviledge level.  Even if the kernel somehow tried to execute code in a
lower priviledge segment (stack or otherwise) shouldn't a GPF get
generated?
-- 
-Steven
"Voters decide nothing.  Vote counters decide everything."
				-Joseph Stalin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
