Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbVF0U7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbVF0U7l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 16:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVF0U7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 16:59:14 -0400
Received: from [63.81.117.10] ([63.81.117.10]:10711 "EHLO mail00hq.adic.com")
	by vger.kernel.org with ESMTP id S261796AbVF0U6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 16:58:33 -0400
Message-ID: <42C06873.7020102@xfs.org>
Date: Mon, 27 Jun 2005 15:58:27 -0500
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Hans Reiser <reiser@namesys.com>, Markus T?rnqvist <mjt@nysv.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       David Masover <ninja@slaphack.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <42BB7B32.4010100@slaphack.com> <200506240334.j5O3YowB008100@laptop11.inf.utfsm.cl> <20050627092138.GD11013@nysv.org> <20050627124255.GB6280@thunk.org> <42C0578F.7030608@namesys.com> <42C05F16.5000804@xfs.org> <20050627202841.GA27805@thunk.org>
In-Reply-To: <20050627202841.GA27805@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Jun 2005 20:58:28.0985 (UTC) FILETIME=[F81CFE90:01C57B5A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:
> On Mon, Jun 27, 2005 at 03:18:30PM -0500, Steve Lord wrote:
> 
>>I presume Ted is referring to problems guaranteeing the integrity of
>>the journal at recovery time. I am coming into this without all the
>>available context, so I may be barking up the wrong tree.... In
>>particular, I am not sure how journaling whole blocks protects
>>you from this.
> 
> 
> Actually, I was talking about the problem what happens when power
> fails while DMA'ing to the disk, and memory, which is more sensitive
> to voltage drops than the rest of the system, starts sending garbage
> to the bus, which the disk then faithfully writes to the inode table.
> 
> As I recall, you were the one who told me about this problem, and how
> it was fixed in Irix by using a powerfail interrupt to abort DMA
> transfers, as well as giving me a program which tests for this
> condition (basically it writes known test pattern to the disk, and
> then you do an unclean shutdown, and you look to see if garbage is
> written to the disk instead of one of the known test patterns).  If it
> wasn't you, it must have been Jim Mostek --- but I could have sworn it
> was you.....
> 
> 						- Ted
> 

Your memory is better than mine, not sure about the test program, but
there was at one point a scenario like that on Irix, and I quite
probably did mention it to you. That was certainly not PC hardware,
but more likely a large Irix system with multiple power busses spread
around a large amount of hardware. I presume you are saying that the fact
that ext3 journals complete inode blocks rather that subsections of inodes
means that, should a similar trashing of metadata occur during power down,
a journal replay would fix it?

I see no way short of hardware fixes of avoiding the general problem of
a system failing in an ugly manner like this. Unless you write everything
to disk twice (i.e. journal all data), you can still end up with a
legitimate set of metadata, and the master copy of your employee
database full of nasty little bits of corruption.

Steve
