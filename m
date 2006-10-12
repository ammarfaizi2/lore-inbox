Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWJLTCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWJLTCs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 15:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbWJLTCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 15:02:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62898 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750796AbWJLTCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 15:02:47 -0400
Subject: Re: Can context switches be faster?
From: Arjan van de Ven <arjan@infradead.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <452E8FE1.7080503@comcast.net>
References: <452E62F8.5010402@comcast.net>
	 <20061012171929.GB24658@flint.arm.linux.org.uk>
	 <452E888D.6040002@comcast.net>
	 <1160678231.3000.451.camel@laptopd505.fenrus.org>
	 <452E8FE1.7080503@comcast.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 12 Oct 2006 21:02:45 +0200
Message-Id: <1160679765.3000.468.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-12 at 14:56 -0400, John Richard Moser wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> 
> Arjan van de Ven wrote:
> > On Thu, 2006-10-12 at 14:25 -0400, John Richard Moser wrote:
> > 
> > Hi,
> > 
> >> So apparently most CPUs virtually address L1 cache and physically
> >> address L2; but sometimes physically addressing L1 is better.. hur.
> > 
> > if you are interested in this I would strongly urge you to read Curt
> > Schimmel's book (UNIX(R) Systems for Modern Architectures: Symmetric
> > Multiprocessing and Caching for Kernel Programmers); it explains this
> > and related materials really really well.
> > 
> 
> That will likely be more useful when I've got more background knowledge;

the book is quite explenatory, so maybe your uni has it in the library
so that you can try to see if it makes sense?

> > 
> > the cache flushing is a per architecture property. On x86, the cache
> > flushing isn't needed; but a TLB flush is. Depending on your hardware
> > that can be expensive as well. 
> > 
> 
> Mm.  TLB flush is expensive, and pretty unavoidable unless you do stupid
> things like map libc into the same address everywhere. 

TLB flush is needed if ANY part of the address space is pointing at
different pages. Since that is always the case for different processes,
where exactly glibc is doesn't matter... as long as there is ONE page of
memory different you have to flush. (And the flush is not expensive
enough to do partial ones based on lots of smarts; the smarts will be
more expensive than just doing a full flush)

>  TLB flush
> between threads in the same process is probably avoidable; aren't
> threads basically processes with the same PID in something called a
> thread group?  (Hmm... creative scheduling possibilities...)

the scheduler is smart enough to avoid the flush then afaik
(threads share the "mm" in Linux, and "different mm" is used as trigger
for the flush. Linux is even smarter; kernel threads don't have any mm
at all so those count as wildcards in this respect, so that if  you have
"thread A" -> "kernel thread" -> "thread B" you'll have no flush)



