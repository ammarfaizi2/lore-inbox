Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264454AbTFCAkd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 20:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbTFCAkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 20:40:33 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:46892 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264454AbTFCAkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 20:40:32 -0400
Date: Mon, 2 Jun 2003 17:54:10 -0700
From: Andrew Morton <akpm@digeo.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: kernel@kolivas.org, linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] 2.5.70-mm2 with contest
Message-Id: <20030602175410.5f198657.akpm@digeo.com>
In-Reply-To: <3EDBEC27.9070705@cyberone.com.au>
References: <200306030806.49885.kernel@kolivas.org>
	<20030602151644.06252b28.akpm@digeo.com>
	<3EDBEC27.9070705@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Jun 2003 00:53:58.0524 (UTC) FILETIME=[9DAE8BC0:01C3296A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> It will be interesting to see what happens if we set the
>  ext3 journal write paths as PF_SYNCWRITE. I'll try some tests
>  a bit later today.
> 

OK.

Longer-term it would be best to lose the PF_SYNCWRITE thing and to just
mark the BIOs as synchronous prior to submitting them.  It's a matter of
transferring the info in writeback_control.sync_mode at the pagecache/BIO
boundary: mpage_bio_submit(), __block_write_full_page->submit_bh(), etc.

But we can worry about that later, once it is established that the
synchronous write detection is sufficiently useful.

