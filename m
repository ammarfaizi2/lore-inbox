Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267368AbUJBJaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267368AbUJBJaK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 05:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267374AbUJBJaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 05:30:10 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:42679 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S267368AbUJBJ3u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 05:29:50 -0400
Date: Sat, 02 Oct 2004 18:30:15 +0900 (JST)
Message-Id: <20041002.183015.41630389.taka@valinux.co.jp>
To: marcelo.tosatti@cyclades.com
Cc: haveblue@us.ibm.com, akpm@osdl.org, linux-mm@kvack.org,
       piggin@cyberone.com.au, arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] memory defragmentation to satisfy high order allocations
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20041001234200.GA4635@logos.cnet>
References: <20041001190430.GA4372@logos.cnet>
	<1096667823.3684.1299.camel@localhost>
	<20041001234200.GA4635@logos.cnet>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Marcelo.

Generic memory defragmentation will be very nice for me to implement
hugetlbpage migration, as allocating a new hugetlbpage is a hard job.

> For the "defragmentation" operation we want to do an "easy" try - ie if we
> can't remap giveup.
> 
> I feel we should try to "untie" the code which checks for remapping availability / 
> does the remapping from the page migration - so to be able to share the most 
> code between it and other users of the same functionality. 

I think it's possible to introduce non-wait mode to the migration code,
as you may expect. Shall I implement it?

> Curiosity: How did you guys test the migration operation? Several threads on 
> several processors operating on the memory, etc? 

I always test it with the zone hotplug emulation patch, which Mr.Iwamoto
has made. I usually run following jobs concurrently while zones are added
and removed repeatedly on a SMP machine.
      - making linux kernel
      - copying file trees.
      - overwriting file trees.
      - removing file trees
      - some pages are swapped out automatically:)

And Mr.Iwamoto has some small programs to check any kind of page
can be migrated. The programs repeat one of following actions:
    - read/write files .
    - use MAP_SHARED and MAP_PRIVATE mmap()'s and read/write there.
    - use Direct I/O.
    - use AIO.
    - fork to have COW pages.
    - use shmem.
    - use sendfile.

> Cool. I'll take a closer look at the relevant parts of memory hotplug patches 
> this weekend, hopefully. See if I can help with testing of these patches too.

Any comments are very welcome.

Thank you,
Hirokazu Takahashi.






