Return-Path: <linux-kernel-owner+w=401wt.eu-S965372AbXATUzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965372AbXATUzc (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 15:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965373AbXATUzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 15:55:31 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:24122 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965372AbXATUzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 15:55:31 -0500
Message-ID: <45B281BB.50607@tls.msk.ru>
Date: Sat, 20 Jan 2007 23:55:23 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: Denis Vlasenko <vda.linux@googlemail.com>
CC: Linus Torvalds <torvalds@osdl.org>, Viktor <vvp01@inbox.ru>,
       Aubrey <aubreylee@gmail.com>, Hua Zhong <hzhong@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, akpm@osdl.org
Subject: Re: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org> <45A6704A.40205@tls.msk.ru> <200701201736.22553.vda.linux@googlemail.com>
In-Reply-To: <200701201736.22553.vda.linux@googlemail.com>
X-Enigmail-Version: 0.94.1.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> On Thursday 11 January 2007 18:13, Michael Tokarev wrote:
>> example, which isn't quite possible now from userspace.  But as long as
>> O_DIRECT actually writes data before returning from write() call (as it
>> seems to be the case at least with a normal filesystem on a real block
>> device - I don't touch corner cases like nfs here), it's pretty much
>> THE ideal solution, at least from the application (developer) standpoint.
> 
> Why do you want to wait while 100 megs of data are being written?
> You _have to_ have threaded db code in order to not waste
> gobs of CPU time on UP + even with that you eat context switch
> penalty anyway.

Usually it's done using aio ;)

It's not that simple really.

For reads, you have to wait for the data anyway before doing something
with it.  Omiting reads for now.

For writes, it's not that problematic - even 10-15 threads is nothing
compared with the I/O (O in this case) itself -- that context switch
penalty.

> I hope you agree that threaded code is not ideal performance-wise
> - async IO is better. O_DIRECT is strictly sync IO.

Hmm.. Now I'm confused.

For example, oracle uses aio + O_DIRECT.  It seems to be working... ;)
As an alternative, there are multiple single-threaded db_writer processes.
Why do you say O_DIRECT is strictly sync?

In either case - I provided some real numbers in this thread before.
Yes, O_DIRECT has its problems, even security problems.  But the thing
is - it is working, and working WAY better - from the performance point
of view - than "indirect" I/O, and currently there's no alternative that
works as good as O_DIRECT.

Thanks.

/mjt
