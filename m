Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAIPgE>; Tue, 9 Jan 2001 10:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129561AbRAIPfz>; Tue, 9 Jan 2001 10:35:55 -0500
Received: from zeus.kernel.org ([209.10.41.242]:7912 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129324AbRAIPfo>;
	Tue, 9 Jan 2001 10:35:44 -0500
Date: Tue, 9 Jan 2001 15:31:19 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Christoph Rohland <cr@sap.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        "Sergey E. Volkov" <sve@raiden.bancorp.ru>,
        linux-kernel@vger.kernel.org
Subject: Re: VM subsystem bug in 2.4.0 ?
Message-ID: <20010109153119.G9321@redhat.com>
In-Reply-To: <Pine.LNX.4.10.10101081003410.3750-100000@penguin.transmeta.com> <Pine.LNX.4.21.0101081621590.21675-100000@duckman.distro.conectiva> <20010109140932.E4284@redhat.com> <qwwhf387p4s.fsf@sap.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <qwwhf387p4s.fsf@sap.com>; from cr@sap.com on Tue, Jan 09, 2001 at 03:53:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 09, 2001 at 03:53:55PM +0100, Christoph Rohland wrote:
> 
> On Tue, 9 Jan 2001, Stephen C. Tweedie wrote:
> > But again, how do you clear the bit?  Locking is a per-vma property,
> > not per-page.  I can mmap a file twice and mlock just one of the
> > mappings.  If you get a munlock(), how are you to know how many
> > other locked mappings still exist?
> 
> It's worse: The issue we are talking about is SYSV IPC_LOCK.

The issue is locked VA pages.  SysV is just one of the ways in which
it can happen: the solution has got to address both that and
mlock()/mlockall().

> This is a
> per segment thing. A user can (un)lock a segment at any time. But we
> do not have the references to the vmas attached to the segemnts

Why not?  Won't the address space mmap* lists give you this?

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
