Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279029AbRKFJ0X>; Tue, 6 Nov 2001 04:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278709AbRKFJ0D>; Tue, 6 Nov 2001 04:26:03 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:25607 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S278928AbRKFJZw>; Tue, 6 Nov 2001 04:25:52 -0500
Message-ID: <3BE7AB6C.97749631@zip.com.au>
Date: Tue, 06 Nov 2001 01:20:44 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: ext3-0.9.15 against linux-2.4.14
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Download details and documentation are at

	http://www.uow.edu.au/~andrewm/linux/ext3/

Changes since ext3-0.9.13 (which was against linux-2.4.13):

- Fixed a null-pointer dereference oops which could hit on
  SMP machines.  This fix was applied to 2.4.12-ac6, but the
  oops has never been reported against -ac kernels.

- Large amounts of developer debug code has been removed.  This
  will now be maintained separately.

- There is an interaction failure between ext3 and the current
  Extended Attributes and Access Control Lists patch which leads
  to crashes under heavy load on SMP.  This is possibly due to
  a subtle API change between ext3 in 2.2 and 2.4 kernels (ie: I
  broke it).  On the to-do list.

- For a long time, the ext3 patch has used a semaphore in the core
  kernel to prevent concurrent pagein and truncate of the same
  file.  This was to prevent a race wherein the paging-in task
  would wake up after the truncate and would instantiate a page
  in the process's page tables which had attached buffers.  This
  leads to a BUG() if the swapout code tries to swap the page out.

  This semaphore has been removed.  The swapout code has been altered
  to simply detect and ignore these pages.

  This is an incredibly obscure and hard-to-hit situation.  The testcase
  which used to trigger it can no longer do so.  So if anyone sees the
  message "try_to_swap_out: page has buffers!", please shout out.

  There are no plans to remove this semaphore from -ac kernels,
  unless Alan wants it that way.

-
