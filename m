Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288148AbSACCxH>; Wed, 2 Jan 2002 21:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288150AbSACCw5>; Wed, 2 Jan 2002 21:52:57 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:39174 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S288148AbSACCwx>;
	Wed, 2 Jan 2002 21:52:53 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15411.50997.394792.638980@argo.ozlabs.ibm.com>
Date: Thu, 3 Jan 2002 13:51:33 +1100 (EST)
To: Momchil Velikov <velco@fadata.bg>
Cc: Tom Rini <trini@kernel.crashing.org>, linux-kernel@vger.kernel.org,
        gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <87zo3wtjcm.fsf@fadata.bg>
In-Reply-To: <87g05py8qq.fsf@fadata.bg>
	<20020101234350.GN28513@cpe-24-221-152-185.az.sprintbbd.net>
	<87ital6y5r.fsf@fadata.bg>
	<15411.36909.387949.863222@argo.ozlabs.ibm.com>
	<87zo3wtjcm.fsf@fadata.bg>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Momchil Velikov writes:

> Where do you see changes in pointer arithmetic ? Or in the "memory
> model" (whatever that means) ?

The C standard says that doing pointer arithmetic is only valid within
the bounds of a particular array of objects; do anything outside that
and the behaviour is "undefined".  The reason it says that is that it
is trying to lay down the rules that will ensure that your program
will work on a PDP-10 or on a 286 with 64kB segments, as well as on
reasonable architectures (such as those that Linux runs on).

Now the claim is that RELOC is bad because it adds an offset to a
pointer, and the offset is usually around 0xc0000000, and thus we are
"violating" the C standard.  Thus we are being told that someday this
will break and cause a lot of grief.  My contention is that this will
only break if a pointer becomes something other than a simple address
and pointer arithmetic becomes something other than simple 2's
complement addition, subtraction, etc.  If that happens then C will
have become useless for implementing a kernel, IMHO.

> I'd dare to state that _very_ few people would join the quest for
> writing the kernel in something other than C.

The kernel is already written in a dialect of C that breaks some of
the rules in the C standard.  Look at virt_to_phys, phys_to_virt,
__pa, __va, etc. for a start.  I don't see that changing.

Paul.
