Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291716AbSBALeX>; Fri, 1 Feb 2002 06:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291707AbSBALeN>; Fri, 1 Feb 2002 06:34:13 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:41389 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S291714AbSBALeA>; Fri, 1 Feb 2002 06:34:00 -0500
Message-ID: <3C5A7D18.FF50865F@redhat.com>
Date: Fri, 01 Feb 2002 11:33:44 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <E16WReX-0003gt-00@the-village.bc.nu> <Pine.LNX.4.33L.0202010903380.17106-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Fri, 1 Feb 2002, Alan Cox wrote:
> 
> > > the prefetch engine will have to restart every 4kB, so we would want to
> > > use 16MB pages if possible.
> > >
> > > How would we allocate large pages? Would there be a boot option to
> > > reserve an area of RAM for large pages only?
> >
> > If you have an rmap all you have to do is to avoid smearing kernel objects
> > around lots of 16Mb page sets. If need be you can then get a 16Mb page
> > back just by shuffling user pages.
> >
> > It does make the performance analysis much more interesting though.
> 
> Actually, I suspect that for most workloads the amount of
> large pages vs. the amount of small pages should be fairly
> static.
> 
> In that case we can just reclaim an old large page from
> the inactive_clean list whenever we want to allocate a new
> one.
> 
> As for not putting kernel objects everywhere, this comes
> naturally with HIGHMEM ;)

well except when you start doing pagetables high, as Andrea is doing
(and it makes tons of sense to do that)
