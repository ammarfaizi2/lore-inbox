Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263965AbTH1Mkr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 08:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263962AbTH1Mkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 08:40:47 -0400
Received: from magic-mail.adaptec.com ([216.52.22.10]:64653 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S263963AbTH1Mkm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 08:40:42 -0400
Date: Thu, 28 Aug 2003 06:09:27 +0530 (IST)
From: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
X-X-Sender: tomar@localhost.localdomain
Reply-To: nagendra_tomar@adaptec.com
To: Jamie Lokier <jamie@shareable.org>
cc: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>, Timo Sirainen <tss@iki.fi>,
       David Schwartz <davids@webmaster.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Lockless file reading
In-Reply-To: <20030828121823.GB6800@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.44.0308280556170.14580-100000@localhost.localdomain>
Organization: Adaptec
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Aug 2003, Jamie Lokier wrote:

> Nagendra Singh Tomar wrote:
> > > Or what about: write("12"), fsync(), write("12")? Is it still
> possible
> > > for read() to return "1x1x"?
> >
> > Th read will still read both "12"s from the cache (in very high
> possibility).
> 
> That is a terrible assumption.
> 
> On all the Linux architures, even single CPUs, with no fancy memory
> ordering, even 386, Pentiums etc., it is possible for read() to return
> "1x1x".
> 
> Like this: the write() is preempted (see CONFIG_PREEMPT) after writing
> one "1" byte, the read() runs, reads "1x" and is then preempted back
> to the writer, which writes "2", calls fsync(), writes "1" and is then
> preempted back to the reader, which continues and reads its second
> "1x".

kernel mode premption in Linux has still not sunk within me. All this 
while I was assuming that the kernel cannot be preempted. But I have one 
question:
While the write had "12" in its buffers and it  would have grabbed the 
page lock to write it into the page cache, won't it set some flag saying 
that I don't want to be prempted now. I think there is a small primitive 
for it in from 2.5 onwards. I don't think it will be a good idea to prempt 
while it is holding the page lock. How is it possible that it just wrote 
"1" and did not write "2" though it had grabbed the page lock for that 
purpose. 
I am yet to read the 2.5 kernel premption code.
Thanx for ur nice explaination though.

> 
> Interrupts caused by network packets arriving at just the wrong moment
> can trigger that sort of thing.
> 
> > Even if the page caches are stolen (due to mem shortage) the kernel
> > file cachecing will ensure that you get consistent data.
> 
> The kernel does not provide synchronisation between read() and write()
> data transfers, and it does not always use atomic 32-bit reads and
> writes either.


> 
> -- Jamie
> 

