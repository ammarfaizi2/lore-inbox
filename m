Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268085AbUHQDnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268085AbUHQDnk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 23:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268086AbUHQDnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 23:43:40 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:16796 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268085AbUHQDng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 23:43:36 -0400
Date: Mon, 16 Aug 2004 20:43:40 -0700
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: bcasavan@sgi.com, linux-mm@kvack.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] get_nodes mask miscalculation
Message-Id: <20040816204340.5068b4f7.pj@sgi.com>
In-Reply-To: <20040810104547.GA59597@muc.de>
References: <2rr7U-5xT-11@gated-at.bofh.it>
	<m31xifu5pn.fsf@averell.firstfloor.org>
	<20040809222531.1d2d8d05.pj@sgi.com>
	<20040810104547.GA59597@muc.de>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul wrote:
> 	a) Notes the situation in a prominent "==> Beware <==".
> 	b) Consistently decrements maxnode immediately on each system call
> 	   entry (where someone reading the code might best notice).

Perhaps I missed it, but I didn't notice a response to these points in
your reply, Andi.  In addition to improving the man pages, the other
primary documentation is the code itself.  I look forward to seeing your
proposed patch on this, I hope that patch includes consistent handling
of the value 'maxnode' (which is sometimes numnodes, and sometimes
numnodes+1).  The combination of consistent maxnode usage, and more
explicit, commented, handling of the calls expecting the plus one value
might improve the chances that a reader of the code will correctly use
it.


> The only way would be to allocate new system call slot ...
>
> ... most of them are using libnuma, which you are proposing to break. 

No ... I didn't say "add a syscall", and I didn't say "break libnuma"
(at least, not break any real world usage).

Libnuma doesn't pass in just any old value ... it seems to only pass in
one of the two hard coded values 129 (x86_64 or i386 arches) or 2049
(other arches).

Without divulging any of SGI's plans, I think I can safely predict that
not many systems with _exactly_ 2049 nodes will ship in the next year. 
Perhaps even zero.  2049 is an odd number.

Do you have any idea, Andi, what would be a reasonable upper bound on
the world wide number of shipments of 129 node x86_64 or i386 systems? 
My conjecture - zero.  It's another odd number ;).

If we changed both kernel and libnuma, and required that anyone actually
needing to use the full 128 nodes (or 2048 on the other arches) had to
match kernel and libnuma (both old or both new), then seems like a
change in this convention would actually have vanishingly small real
world impact (less impact in the long run than not doing this ;).

Either:
  1) almost no 128 node x86_64 or i386 systems will ship, and it's not
     a big issue, practically,
or
  2) some will ship, and libnuma will soon be broken anyway, when someone
     does the inevitable and ships an even larger x86_64 or i386 system.

So I am not asking you to break any real world usage, nor to add a
system call.  I'm just asking you to describe what would be the _actual_
problems caused by changing this at this time.  So far, I can't see
any real world problem that would be caused by changing this, while I
already see problems caused by not changing it.

Certainly, if we ever do change this, the sooner the better.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
