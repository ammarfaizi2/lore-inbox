Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318924AbSIITKX>; Mon, 9 Sep 2002 15:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318925AbSIITKW>; Mon, 9 Sep 2002 15:10:22 -0400
Received: from packet.digeo.com ([12.110.80.53]:58060 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S318924AbSIITKU>;
	Mon, 9 Sep 2002 15:10:20 -0400
Message-ID: <3D7CF322.98045305@digeo.com>
Date: Mon, 09 Sep 2002 12:14:42 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.32 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: imran.badr@cavium.com, root@chaos.analogic.com,
       "'David S. Miller'" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Calculating kernel logical address ..
References: <01a801c25831$913c5fd0$9e10a8c0@IMRANPC> <20020909190328Z16576-16323+113@humbolt.nl.linux.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2002 19:14:58.0013 (UTC) FILETIME=[2FE960D0:01C25835]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> ...
> > down(&current->mm->mmap_sem) would help.
> 
> Not for anon pages, and how do you know whether it's anon or not before
> looking at the page, which may be free by the time you look at it?
> In other words, mm->page_table_lock is the one, because it's required
> for unmapping a pte, and any mapped page will be forced to hold a count
> increment until it gets past that lock.  Without this lock, the results
> of pte_page are unstable.

The caller of get_user_pages() needs to hold mmap_sem for reading
to prevent the vmas from going away.  get_user_pages() does the
right thing wrt page_table_lock.  (As a quick peek at the code
would reveal...)
