Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317892AbSHZT4z>; Mon, 26 Aug 2002 15:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318225AbSHZT4z>; Mon, 26 Aug 2002 15:56:55 -0400
Received: from thales.mathematik.uni-ulm.de ([134.60.66.5]:64693 "HELO
	thales.mathematik.uni-ulm.de") by vger.kernel.org with SMTP
	id <S317892AbSHZT4y>; Mon, 26 Aug 2002 15:56:54 -0400
Message-ID: <20020826200048.3952.qmail@thales.mathematik.uni-ulm.de>
From: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Date: Mon, 26 Aug 2002 22:00:48 +0200
To: Daniel Phillips <phillips@arcor.de>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: MM patches against 2.5.31
References: <3D644C70.6D100EA5@zip.com.au> <E17jKlX-0001i0-00@starship> <20020826152950.9929.qmail@thales.mathematik.uni-ulm.de> <E17jO6g-0002XU-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17jO6g-0002XU-00@starship>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2002 at 07:56:52PM +0200, Daniel Phillips wrote:
> On Monday 26 August 2002 17:29, Christian Ehrhardt wrote:
> > On Mon, Aug 26, 2002 at 04:22:50PM +0200, Daniel Phillips wrote:
> > > On Monday 26 August 2002 11:10, Christian Ehrhardt wrote:
> > > > + * A special Problem is the lru lists. Presence on one of these lists
> > > > + * does not increase the page count.
> > > 
> > > Please remind me... why should it not?
> > 
> > Pages that are only on the lru but not reference by anyone are of no
> > use and we want to free them immediatly. If we leave them on the lru
> > list with a page count of 1, someone else will have to walk the lru
> > list and remove pages that are only on the lru.
> 
> I don't understand this argument.  Suppose lru list membership is worth a 
> page count of one.  Then anyone who finds a page by way of the lru list can 

This does fix the double free problem but think of a typical anonymous
page at exit. The page is on the lru list and there is one reference held
by the pte. According to your scheme the pte reference would be freed
(obviously due to the exit) but the page would remain on the lru list.
However, there is no point in leaving the page on the lru list at all.

If you think about who is going to remove the page from the lru you'll
see the problem.

     regards   Christian

-- 
THAT'S ALL FOLKS!
