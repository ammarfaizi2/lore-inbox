Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263832AbTH1KIx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 06:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263842AbTH1KH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 06:07:57 -0400
Received: from magic-mail.adaptec.com ([216.52.22.10]:31655 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S262543AbTH1Jx3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 05:53:29 -0400
Date: Thu, 28 Aug 2003 03:22:11 +0530 (IST)
From: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
X-X-Sender: tomar@localhost.localdomain
Reply-To: nagendra_tomar@adaptec.com
To: Timo Sirainen <tss@iki.fi>
cc: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>,
       Jamie Lokier <jamie@shareable.org>, <root@chaos.analogic.com>,
       Martin Konold <martin.konold@erfrakon.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Lockless file reading
In-Reply-To: <1062063331.1459.263.camel@hurina>
Message-ID: <Pine.LNX.4.44.0308280309550.14580-100000@localhost.localdomain>
Organization: Adaptec
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Aug 2003, Timo Sirainen wrote:

> On Thu, 2003-08-28 at 00:15, Nagendra Singh Tomar wrote:
> > > >     I beleive ur original post was to address the case of a reader
> > > reading 
> > > > a file getting *incorrect* data due to the file being written 
> > > > simultaneously by another writer process.
> > > 
> > > Well, "old" data, which mixed with new data would become incorrect
> as a
> > > whole.
> > 
> > What is this mixing we are talking of ??
> 
> I can easily see that the data might be divided into two separate pages
> and between updating those pages, another process would have read the
> first page, but not the second page. That would result in a mixed old
> and new data. Probably just <old><new> or <new><old> instead of
> <new><old><new> what I was worrying about, but still it would be nicer
> to rely only on byte atomicity and read/write ordering. :)

Timo, I am at loss. OK, let me put across my understanding of the problem.
Thw writer is *updating* the file and not writing it for the first time,
which means that the file can be 1000 bytes long and the writer might be 
updating bytes 100 onwards. You are worried abt the reader reading 
partially old and partially new data. A question. 
If the writer does not want the reader to read old data why does'nt it 
truncate the file and start writing from the begining every time.
Please correct me if I am missing something significant. All this while I 
was thinking that the writer is writing to the file for the first time. 
i.e as he keeps writing the file size increases, so the reader is sure not 
to read anything else but what the writer writes.

> 
> > > That was my original plan, to just rely on such kernel behaviour. I
> just
> > > don't know if it's such a good idea to rely on that, especially if I
> > > want to keep my program portable. I'll probably fallback to that
> anyway
> > > if my checksumming ideas won't work.
> > 
> > But I don't see any problem with a single writer and >=1 reader. There
> is 
> > no question of portability.
> 
> There are of multiple writers, but it's fine for them to do locking
> between each others.
> 
> 

