Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265275AbUGZNCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265275AbUGZNCw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 09:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265269AbUGZNCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 09:02:52 -0400
Received: from main.gmane.org ([80.91.224.249]:40920 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265275AbUGZNCs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 09:02:48 -0400
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
From: Benjamin Rutt <rutt.4+news@osu.edu>
Subject: Re: clearing filesystem cache for I/O benchmarks
Date: Mon, 26 Jul 2004 09:02:45 -0400
Message-ID: <87pt6iq5u2.fsf@osu.edu>
References: <87vfgeuyf5.fsf@osu.edu> <20040726002524.2ade65c3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dhcp065-025-157-254.columbus.rr.com
Mail-Copies-To: nobody
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
Cancel-Lock: sha1:Ajg1sW2keETBTx19qEfqixlUNcw=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Benjamin Rutt <rutt.4+news@osu.edu> wrote:
>>
>>  How can I purge all of the kernel's filesystem caches, so I can trust
>>  that my I/O (read) requests I'm trying to benchmark bypass the kernel
>>  filesystem cache?
>
> Either delete the benchmark test files or

I'm not sure I follow.  If I delete the benchmark files, I'll only
need to create them again later in order to do a read test, and I'll
have the same problem then, of how to eliminate the just-written-data
from cache.  Unless you're suggesting I write using some special mode
that won't enter the written data into cache?  (e.g. O_DIRECT?)

> , in 2.6, use fsync+posix_fadvise(POSIX_FADV_DONTNEED);

Thanks for the reference, I wasn't aware of that one.  We are running
some 2.4 kernels in our storage cluster unfortunately so that won't be
usable for us everywhere.  I take it POSIX_FADV_DONTNEED is ignored
under 2.4.

A related question...if no posix_fadvise() advice has been given, does
reading sequentially every byte of an 8GB file on a machine with <=
8GB of RAM guarantee that any page cache data that existed on the
machine prior to the start of the 8GB read is now gone?
-- 
Benjamin Rutt

