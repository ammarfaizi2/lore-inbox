Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291645AbSBHQwT>; Fri, 8 Feb 2002 11:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291642AbSBHQwJ>; Fri, 8 Feb 2002 11:52:09 -0500
Received: from nrg.org ([216.101.165.106]:59716 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S291637AbSBHQvx>;
	Fri, 8 Feb 2002 11:51:53 -0500
Date: Fri, 8 Feb 2002 08:51:36 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Christoph Hellwig <hch@ns.caldera.de>
cc: Ingo Molnar <mingo@elte.hu>, yodaiken <yodaiken@fsmlabs.com>,
        Martin Wirth <Martin.Wirth@dlr.de>,
        linux-kernel <linux-kernel@vger.kernel.org>, akpm <akpm@zip.com.au>,
        torvalds <torvalds@transmet.com>, rml <rml@tech9.net>
Subject: Re: [RFC] New locking primitive for 2.5
In-Reply-To: <200202081231.g18CV7e31341@ns.caldera.de>
Message-ID: <Pine.LNX.4.40.0202080838230.3883-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Feb 2002, Christoph Hellwig wrote:
> In article <Pine.LNX.4.33.0202072305480.2976-100000@localhost.localdomain> you wrote:
> > i think one example *could* be to turn inode->i_sem into a combi-lock. Eg.
> > generic_file_llseek() could use the spin variant.
>
> No.  i_sem should be split into a spinlock for short-time accessed
> fields that get written to even if the file content is only read (i.e.
> atime) and a read-write semaphore.

Read-write semaphores should never be used.  As others have pointed out,
they cause really intractable priority inversion problems (because a
high priority writer will often have to wait for an unbounded number of
lower priority readers, some of which may have called a blocking
function while holding the read lock).

Note that I'm not talking about read-write spinlocks, which are (or
should be) held for a short, bounded time and can't be held over a
blocking call, so they are not quite so problematic.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

