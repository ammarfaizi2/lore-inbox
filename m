Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317232AbSIEHgO>; Thu, 5 Sep 2002 03:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317253AbSIEHgO>; Thu, 5 Sep 2002 03:36:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56592 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317232AbSIEHgN>;
	Thu, 5 Sep 2002 03:36:13 -0400
Message-ID: <3D770D77.BF85645E@zip.com.au>
Date: Thu, 05 Sep 2002 00:53:27 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Race in shrink_cache
References: <E17mooe-00064m-00@starship> <E17mqFV-00065Y-00@starship> <3D7702BE.85A5D11D@zip.com.au> <E17mr4K-000660-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> ...
> You said something about your lru locking strategy in 2.5.33-mm2.  I have not
> reverse engineered it yet, would you care to wax poetic?

I'm not sure what you're after here?  Strategy is to make the locks per-zone,
per-node, to not take them too long, to not take them too frequently, to do
as much *needed* work as possible for a single acquisition of the lock and
to not do unnecessary work while holding it - and that includes not servicing
ethernet interrupts.

Not having to bump page counts when moving pages from the LRU into a private
list would be nice.

The strategy for fixing the double-free race is to wait until you
buy an IDE disk ;)

The elaborate changelogs are at

http://linux.bkbits.net:8080/linux-2.5/user=akpm/ChangeSet@-4w?nav=!-|index.html|stats|!+|index.html
