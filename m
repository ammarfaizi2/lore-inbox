Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbTH1KIw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 06:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263832AbTH1KHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 06:07:52 -0400
Received: from ip213-185-36-189.laajakaista.mtv3.fi ([213.185.36.189]:65485
	"EHLO oma.irssi.org") by vger.kernel.org with ESMTP id S263842AbTH1Jfd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 05:35:33 -0400
Subject: Re: Lockless file reading
From: Timo Sirainen <tss@iki.fi>
To: nagendra_tomar@adaptec.com
Cc: Jamie Lokier <jamie@shareable.org>, root@chaos.analogic.com,
       Martin Konold <martin.konold@erfrakon.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0308280242340.14580-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0308280242340.14580-100000@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1062063331.1459.263.camel@hurina>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 28 Aug 2003 12:35:31 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-28 at 00:15, Nagendra Singh Tomar wrote:
> > >     I beleive ur original post was to address the case of a reader
> > reading 
> > > a file getting *incorrect* data due to the file being written 
> > > simultaneously by another writer process.
> > 
> > Well, "old" data, which mixed with new data would become incorrect as a
> > whole.
> 
> What is this mixing we are talking of ??

I can easily see that the data might be divided into two separate pages
and between updating those pages, another process would have read the
first page, but not the second page. That would result in a mixed old
and new data. Probably just <old><new> or <new><old> instead of
<new><old><new> what I was worrying about, but still it would be nicer
to rely only on byte atomicity and read/write ordering. :)

> > That was my original plan, to just rely on such kernel behaviour. I just
> > don't know if it's such a good idea to rely on that, especially if I
> > want to keep my program portable. I'll probably fallback to that anyway
> > if my checksumming ideas won't work.
> 
> But I don't see any problem with a single writer and >=1 reader. There is 
> no question of portability.

There are of multiple writers, but it's fine for them to do locking
between each others.


