Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291727AbSBHSuo>; Fri, 8 Feb 2002 13:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291729AbSBHSue>; Fri, 8 Feb 2002 13:50:34 -0500
Received: from mx2.elte.hu ([157.181.151.9]:30888 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S291727AbSBHSuY>;
	Fri, 8 Feb 2002 13:50:24 -0500
Date: Fri, 8 Feb 2002 21:47:23 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Andrew Morton <akpm@zip.com.au>
Cc: Christoph Hellwig <hch@ns.caldera.de>, yodaiken <yodaiken@fsmlabs.com>,
        Martin Wirth <Martin.Wirth@dlr.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        torvalds <torvalds@transmet.com>, rml <rml@tech9.net>,
        nigel <nigel@nrg.org>
Subject: Re: [RFC] New locking primitive for 2.5
In-Reply-To: <3C641BCE.196E1A37@zip.com.au>
Message-ID: <Pine.LNX.4.33.0202082144350.15826-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 8 Feb 2002, Andrew Morton wrote:

> I'd be interested in hearing more details on the regression which Ingo
> has seen due to the introduction of i_sem locking in llseek. [...]

i saw heavy scheduling during dbench runs (even if just running 6 threads
on an 8 CPU box), and checked out the source of the scheduling storm -
most of it was due to llseek()'s down().

i also wrote a dbench-alike load simulator for pagecache scalability,
there i saw this in an even more prominent way, 200k/sec reschedules in a
situation when there should be none.

i'd suggest 64-bit update instructions on x86 as well, they do exist.
spinlock only for the truly hopeless cases like SMP boxes composed of
i486's. We really want llseek() to scale ...

	Ingo

