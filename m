Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266219AbTGDXab (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 19:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbTGDXab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 19:30:31 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:31423
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S266219AbTGDXaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 19:30:09 -0400
Date: Sat, 5 Jul 2003 01:44:32 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, Rik van Riel <riel@redhat.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030704234432.GY23578@dualathlon.random>
References: <Pine.LNX.4.44.0307030904260.16582-100000@chimarrao.boston.redhat.com> <20030703185341.GJ20413@holomorphy.com> <20030703192750.GM23578@dualathlon.random> <20030703201607.GK20413@holomorphy.com> <20030704004000.GQ23578@dualathlon.random> <20030704014624.GN20413@holomorphy.com> <20030704023414.GV23578@dualathlon.random> <20030704041048.GO20413@holomorphy.com> <20030704055426.GW23578@dualathlon.random> <20030704081522.GP20413@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030704081522.GP20413@holomorphy.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't disagree more but I don't have any more time to argue with you.
Especially your paragraph where you mention pte-highmem wasn't worth an
answer. If you for istance could raise one single thing that make me
realize I'm missing something, you would have a chance to change my
mind. In the meantime it simply seems I fail to communicate with you and
the more posts, the less I find those posts informative and useful.

So to avoid endless non informative emails  I'm only interested to
mention numbers or things where the english language is not involved so
there's no risk to disagree anymore.

Since we seem not to have time to hack on a userspace app that you
consier to have "pagetable" problems, just tell me a date number
(1/1/2005 or 1/1/2010? whatever you want) when you expect a number of
significant 64bit programs (1/5/10/200?) to use remap_file_pages with
"rather hefty speedups over mmap" (1%/5%/10%/200%?) on 64bit archs and
we'll check how many are using it and what kind of improvements they get
out of it. this is the only thing I care about.  Excluding emulators of
course.

My forecast is the number of 64bit apps will be 0, without date limit
and the improvement will be of the order of -1/2%.

If it generates as you claim "rather hefty speedups over mmap" on 64bit
archs (with rather hefty I hope you mean something more than 1%), you
must expect at least a dozen (or at the very least 2/3) of those 64bit
apps to be converted to remap_file_pages before 2005 to save the
pagetables overhead right? I would also expect to hear from many excited
userspace developers to post here agreeing with you, claiming that
they're looking forward to drop mmap and to start using
remap_file_pages so they can save pagetables, despite they'll generate
tlb flushes and pte mangling and they'll enter kernel all the time, and
they'll have to reinvent some part of the page replacement of the vm to
choose the parameters of remap_file_pages in their 64bit apps.  I'm
talking about 64bit only of course. We all agree remap_file_pages makes
perfect sense in 32bit archs when used on top of shmfs (especially to
get rid of rmap in the 2.4 backports).

Also note that by 2005 I guarantee mmap will work in O(log(N)) always
(also w/o MAP_FIXED, as worse in 2.7, but infact it might happen even in
2.4) and likely by 2005 the unused pagetables might be garbage collected
too, shall anybody think remap_file_pages could help them to drop
pagetable overhead.

If you're not confortable to give at least a very conservative forecast
for a "rather hefty speedups over mmap" feature like:

	1/1/2005 - 2/3 apps - >1% improvement

then you also know you are wrong in my voucabulary but you fail to admit
it.

Also please tell me a deadline where you will have mlock dropping rmap
merged in mainline and some user tool to raise privilegies via PAM to
run mlock as single user, so that 2.5 will be able to run as good as 2.4
for some critical app.

If it's me doing the work you already know what I would do (VM bypass
for remap_file_pages, no slowdown and additional complexity in munlock,
and a single sysctl to manage security if swap is non null), so I think
you prefer me to stay away from remap_file_pages in 2.5. I disagree in
the direction you take for 2.5, but since I'll never call into those
syscalls in my boxes, I don't mind as far as the rest of the system
isn't slowed down or unstable, so I'm fine that you do what you want in
that area.

Andrea
