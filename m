Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262189AbVFUReI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbVFUReI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 13:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVFUReH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 13:34:07 -0400
Received: from webmail.topspin.com ([12.162.17.3]:59944 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262189AbVFUReE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 13:34:04 -0400
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: get_user_pages() and shared memory question
X-Message-Flag: Warning: May contain useful information
References: <42B82DF2.2050708@ammasso.com>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 21 Jun 2005 10:33:59 -0700
In-Reply-To: <42B82DF2.2050708@ammasso.com> (Timur Tabi's message of "Tue,
 21 Jun 2005 10:10:42 -0500")
Message-ID: <523brbwr5k.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 21 Jun 2005 17:34:00.0041 (UTC) FILETIME=[68C63590:01C57687]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Timur> Hi, Is it possible for a page of memory that's been
    Timur> "grabbed" with get_user_pages() to ever be allocated to
    Timur> another process?  I'm assuming the answer is no, but I have
    Timur> a specific case I want to ask about.

Not to the best of my knowledge, although you should probably read the
code to convince yourself.

    Timur> Until 2.6.7, there was a bug in the VM where a page that
    Timur> was grabbed with get_user_pages() could be swapped out.
    Timur> Those of you familar with the OpenIB work know what I'm
    Timur> talking about.  Would that bug affect anything I'm talking
    Timur> about?

This isn't what the bug caused.  What could happen was that the
swapper could unmap a page from a process's virtual memory map before
it noticed that the page had an elevated reference count.  The page
wouldn't get swapped out, but when the process caused a page fault to
bring the virtual address back, it would get a different piece of
physical memory.

 - R.
