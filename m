Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbTFIV7R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 17:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbTFIV7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 17:59:17 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:56265 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262177AbTFIV7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 17:59:16 -0400
Date: Mon, 9 Jun 2003 15:09:05 -0700
From: Andrew Morton <akpm@digeo.com>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] 12% improvement in fork load from mm3 to mm4
Message-Id: <20030609150905.7e37bc1f.akpm@digeo.com>
In-Reply-To: <20030609220255.GA8524@rushmore>
References: <20030609220255.GA8524@rushmore>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Jun 2003 22:12:56.0127 (UTC) FILETIME=[475604F0:01C32ED4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rwhron@earthlink.net wrote:
>
> > autoconf build test creates about 1.2 million processes in
> > 35 minutes.  On quad xeon, there was an improvement of
> > ~ 12% between 2.5.70-mm3 and 2.5.70-mm4.
> > 
> >               Avg of 3 runs
> > 2.5.70-mm3    829.0
> > 2.5.70-mm4    737.9
> 
> profile shows the biggest change is in do_page_fault.

Well that's amusing.  In mm4 I replaced the patch which runs
remap_file_pages() against all prot_exec mappings with a patch which just
prefaults those mappings into pagecache.

The difference _should_ be that in mm3, all pte's are set up at mmap time.
So -mm4 should have more pagefaults, not less.

Something fishy is going on there.  Makes one wonder if remap_file_pages()
is successfully avoiding the minor fault.

