Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263860AbTH1K7P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 06:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263891AbTH1K7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 06:59:15 -0400
Received: from magic-mail.adaptec.com ([216.52.22.10]:49816 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S263860AbTH1K7N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 06:59:13 -0400
Date: Thu, 28 Aug 2003 04:28:01 +0530 (IST)
From: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
X-X-Sender: tomar@localhost.localdomain
Reply-To: nagendra_tomar@adaptec.com
To: Timo Sirainen <tss@iki.fi>
cc: David Schwartz <davids@webmaster.com>, Jamie Lokier <jamie@shareable.org>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Lockless file reading
In-Reply-To: <1062066411.1451.319.camel@hurina>
Message-ID: <Pine.LNX.4.44.0308280425380.14580-100000@localhost.localdomain>
Organization: Adaptec
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Aug 2003, Timo Sirainen wrote:

> On Thu, 2003-08-28 at 12:56, David Schwartz wrote:
> > > > You said that MD5 wasn't strong enough, and you would like a
> guarantee.
> > 
> > > Yes. I don't really like it if my program heavily relies on
> something
> > > that can go wrong in some situations.
> > 
> > 	Okay, this is too much. Your alternative, assuming the kernel
> won't
> > re-order writes, is clearly relying on something that can go wrong.
> 
> Reorder on per-byte basis? Per-page/block would still be acceptable.
> 
> Anyway, the alternative would be shared mmap()ed file. You can trust
> 32bit memory updates to be atomic, right?
> 
> Or what about: write("12"), fsync(), write("12")? Is it still possible
> for read() to return "1x1x"?

No. Not possible. fsync() doesn't really make a difference here. Just that 
the first "12" gets its way into the disk. Th read will still read both 
"12"s from the cache (in very high possibility). Even if the page caches 
are stolen (due to mem shortage) the kernel file cachecing will ensure 
that you get consistent data.

> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

