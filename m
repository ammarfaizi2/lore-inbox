Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263886AbTH1KHZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 06:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263883AbTH1KHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 06:07:24 -0400
Received: from magic-mail.adaptec.com ([216.52.22.10]:56797 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S263896AbTH1JQm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 05:16:42 -0400
Date: Thu, 28 Aug 2003 02:45:25 +0530 (IST)
From: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
X-X-Sender: tomar@localhost.localdomain
Reply-To: nagendra_tomar@adaptec.com
To: Timo Sirainen <tss@iki.fi>
cc: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>,
       Jamie Lokier <jamie@shareable.org>, <root@chaos.analogic.com>,
       Martin Konold <martin.konold@erfrakon.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Lockless file reading
In-Reply-To: <1062060035.1456.222.camel@hurina>
Message-ID: <Pine.LNX.4.44.0308280242340.14580-100000@localhost.localdomain>
Organization: Adaptec
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Aug 2003, Timo Sirainen wrote:

> On Wed, 2003-08-27 at 21:42, Nagendra Singh Tomar wrote:
> > Hi,
> >     I beleive ur original post was to address the case of a reader
> reading 
> > a file getting *incorrect* data due to the file being written 
> > simultaneously by another writer process.
> 
> Well, "old" data, which mixed with new data would become incorrect as a
> whole.

What is this mixing we are talking of ??

> 
> > Why do u require file locking if there is a *single* writer ?? I don't
> 
> > understand why a 123 written over XXX can result in 1X3. The kernel
> should 
> > take care of this. When the writer process is writing 123 it will
> first be 
> > written to the page cache. The page cache lock will be taken inside
> the 
> > kernel before writing to it, so we know that writing 123 over XXX will
> be 
> > atomic.  Now even when this page is flushed to disk, the page lock
> would 
> > be taken. So I cannot see a possibility of 123 written over XXX being
> read 
> > as 1X3.
> 
> That was my original plan, to just rely on such kernel behaviour. I just
> don't know if it's such a good idea to rely on that, especially if I
> want to keep my program portable. I'll probably fallback to that anyway
> if my checksumming ideas won't work.

But I don't see any problem with a single writer and >=1 reader. There is 
no question of portability.

tomar
> 
> 

