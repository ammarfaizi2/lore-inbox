Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278962AbRKIHkw>; Fri, 9 Nov 2001 02:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279627AbRKIHkb>; Fri, 9 Nov 2001 02:40:31 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:32269 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S278962AbRKIHkZ>; Fri, 9 Nov 2001 02:40:25 -0500
Message-ID: <3BEB8728.801344DC@zip.com.au>
Date: Thu, 08 Nov 2001 23:35:04 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: "David S. Miller" <davem@redhat.com>, ak@suse.de, anton@samba.org,
        linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
In-Reply-To: <3BEB82B8.541558CA@zip.com.au> <Pine.LNX.4.33.0111090920240.2240-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> On Thu, 8 Nov 2001, Andrew Morton wrote:
> 
> > Well on my setup, there are more hash buckets than there are pages in
> > the system.  So - basically empty.  If memory serves me, never more
> > than two pages in a bucket.
> 
> how much RAM and how many buckets are there on your system?
> 

urgh.  It was ages ago.  I shouldn't have stuck my head up ;)

I guess it was 256 megs:

Kernel command line: ...  mem=256m
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)

And that's one entry per page, yes?

I ended up concluding that

a) The hash is sucky and
b) Except for certain specialised workloads, a lookup is usually
   associated with a big memory copy, so none of it matters and
c) given b), the page cache hashtable is on the wrong side of the
   size/space tradeoff :)

-
