Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318255AbSHZUZT>; Mon, 26 Aug 2002 16:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318256AbSHZUZT>; Mon, 26 Aug 2002 16:25:19 -0400
Received: from dsl-213-023-020-192.arcor-ip.net ([213.23.20.192]:46523 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318255AbSHZUZS>;
	Mon, 26 Aug 2002 16:25:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Subject: Re: MM patches against 2.5.31
Date: Mon, 26 Aug 2002 22:09:38 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <3D644C70.6D100EA5@zip.com.au> <E17jO6g-0002XU-00@starship> <20020826200048.3952.qmail@thales.mathematik.uni-ulm.de>
In-Reply-To: <20020826200048.3952.qmail@thales.mathematik.uni-ulm.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17jQB8-0002Zi-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 August 2002 22:00, Christian Ehrhardt wrote:
> On Mon, Aug 26, 2002 at 07:56:52PM +0200, Daniel Phillips wrote:
> > On Monday 26 August 2002 17:29, Christian Ehrhardt wrote:
> > > On Mon, Aug 26, 2002 at 04:22:50PM +0200, Daniel Phillips wrote:
> > > > On Monday 26 August 2002 11:10, Christian Ehrhardt wrote:
> > > > > + * A special Problem is the lru lists. Presence on one of these lists
> > > > > + * does not increase the page count.
> > > > 
> > > > Please remind me... why should it not?
> > > 
> > > Pages that are only on the lru but not reference by anyone are of no
> > > use and we want to free them immediatly. If we leave them on the lru
> > > list with a page count of 1, someone else will have to walk the lru
> > > list and remove pages that are only on the lru.
> > 
> > I don't understand this argument.  Suppose lru list membership is worth a 
> > page count of one.  Then anyone who finds a page by way of the lru list can 
> 
> This does fix the double free problem but think of a typical anonymous
> page at exit. The page is on the lru list and there is one reference held
> by the pte. According to your scheme the pte reference would be freed
> (obviously due to the exit) but the page would remain on the lru list.
> However, there is no point in leaving the page on the lru list at all.

If you want the page off the lru list at that point (which you probably do)
then you take the lru lock and put_page_testzero.

> If you think about who is going to remove the page from the lru you'll
> see the problem.

Nope, still don't see it.  Whoever hits put_page_testzero frees the page,
secure in the knowlege that there are no other references to it.

-- 
Daniel
