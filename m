Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318857AbSICRYo>; Tue, 3 Sep 2002 13:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318858AbSICRYn>; Tue, 3 Sep 2002 13:24:43 -0400
Received: from dsl-213-023-043-116.arcor-ip.net ([213.23.43.116]:53396 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318856AbSICRYn>;
	Tue, 3 Sep 2002 13:24:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "Heiko Carstens" <Heiko.Carstens@de.ibm.com>
Subject: Re: Kernel BUG at page_alloc.c:91! (2.4.19)
Date: Tue, 3 Sep 2002 19:31:52 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <OF3A6E6F2C.2609CEE7-ONC1256C29.005E7DDC@de.ibm.com>
In-Reply-To: <OF3A6E6F2C.2609CEE7-ONC1256C29.005E7DDC@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17mHWq-0005i3-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 September 2002 19:16, Heiko Carstens wrote:
> Hi,
> 
> >> Thanks for the patch but unfortunately it doesn't change the behaviour 
> at
> >> all. This BUG is still 100% reproducible by just having 1 process which
> >> allocates memory chunks of 256KB and after each allocation writes to 
> each
> >> of the pages in order to make them dirty.
> >Um, no smp --> no free race anyway.  But try the following instead, to
> >start narrowing down the possibilities:
> 
> Still the same BUG in __free_pages_ok happens, or in other words both of 
> your
> checks didn't catch the error...

My intention was to verify which one of the two possible execution paths
was taken, and also to verify that swap_duplicate doesn't see any problem
(there's a missing error check here).  Note that we also definitively
eliminated your original theory since we didn't arrive at the
page_cache_release via the if (page->mapping) path.

> Any other ideas?

Have you trimmed your config down to the absolute minimum?

Is there any such thing as kdb for S390?

-- 
Daniel
