Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315779AbSGFTwA>; Sat, 6 Jul 2002 15:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315783AbSGFTv7>; Sat, 6 Jul 2002 15:51:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33297 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315779AbSGFTv6>;
	Sat, 6 Jul 2002 15:51:58 -0400
Message-ID: <3D274C6A.C6E23CAA@zip.com.au>
Date: Sat, 06 Jul 2002 13:00:42 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH][RFT](2) minimal rmap for 2.5 - akpm tested
References: <3D268E19.B68559F6@zip.com.au> <Pine.LNX.4.44.0207061205001.1157-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 5 Jul 2002, Andrew Morton wrote:
> >
> > The box died, but not due to rmap.  We have a lock ranking
> > bug:
> >
> >         do_exit
> >         ->mmput
> >           ->exit_mmap                           page_table_lock
> >             ->removed_shared_vm_struct
> >               ->lock_vma_mappings               i_shared_lock
> 
> I _think_ we should just move the remove_shared_vm_struct() down into the
> case where we're closing the mapping, ie something like the appended.
> 
> That way we _only_ do the actual page table stuff under the page table
> lock, and do all the generic VM/FS stuff outside the lock.
> 
> Comments?

That is basically what do_munmap() does.  But I'm quite unfamiliar
with the locking in there.

-
