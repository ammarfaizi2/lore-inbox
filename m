Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287764AbSA1Xsh>; Mon, 28 Jan 2002 18:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287769AbSA1Xs1>; Mon, 28 Jan 2002 18:48:27 -0500
Received: from dsl-213-023-039-090.arcor-ip.net ([213.23.39.90]:41351 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287710AbSA1XsT>;
	Mon, 28 Jan 2002 18:48:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Hans Reiser <reiser@namesys.com>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [reiserfs-dev] Re: Note describing poor dcache utilization under high memory pressure
Date: Tue, 29 Jan 2002 00:52:33 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Josh MacDonald <jmacd@CS.Berkeley.EDU>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com, reiserfs-dev@namesys.com
In-Reply-To: <Pine.LNX.4.33.0201280930130.1557-100000@penguin.transmeta.com> <3C55A58F.1070908@namesys.com>
In-Reply-To: <3C55A58F.1070908@namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VLZh-0000Dp-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 28, 2002 08:25 pm, Hans Reiser wrote:
> If I understand you right, your scheme has the fundamental flaw that one 
> dcache entry on a page can keep an entire page full of "slackers" in 
> memory, and since there is little correlation in usage between dcache 
> entries that happen to get stored on a page, the result is that the 
> effectiveness per megabyte of the dcache is decreased by an order of 
> magnitude.  It would be worse to have one dcache entry per page, but 
> maybe not by as much as you might expect.
> 
> When objects smaller than a page are stored on a page but not correlated 
> in their usage, they need to be aged individually not as a page, and 
> then garbage collected as needed.

I had the identical thought - i.e., that this is a job for object aging and 
not lru, then I realized that a slight modification to lru can do the job, 
that is:

  - An access to any object on the page promotes the page to the hot end
    of the lru list.

  - When it's time to recover a page (or pages) scan from the cold end
    towards the hot end, and recover the first page(s) on which all
    objects are free.

> Neither the current model nor your 
> proposed scheme solve the fundamental problem Josh's measurements prove 
> exists.  

My suggestion might.

-- 
Daniel
