Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262418AbSKTTAJ>; Wed, 20 Nov 2002 14:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262420AbSKTTAJ>; Wed, 20 Nov 2002 14:00:09 -0500
Received: from packet.digeo.com ([12.110.80.53]:56220 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262418AbSKTTAI>;
	Wed, 20 Nov 2002 14:00:08 -0500
Message-ID: <3DDBDD5A.F76AAD0E@digeo.com>
Date: Wed, 20 Nov 2002 11:07:06 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Haverkamp <markh@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Call trace at mm/page-writeback.c in 2.5.47
References: <1037808468.6367.41.camel@markh1.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Nov 2002 19:07:06.0605 (UTC) FILETIME=[04AC39D0:01C290C8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Haverkamp wrote:
> 
> While running a memory stress workload test on a 16 processor numa
> system, I received a number of call traces like the following:

What is the workload?  And in which journalling mode was ext3
being used?

Was the workload actually being run against ext3?

> buffer layer error at mm/page-writeback.c:559
> Pass this trace through ksymoops for reporting
> Call Trace:
>  [<c013f1fb>] __set_page_dirty_buffers+0x3b/0x150
>  [<c012d746>] zap_pte_range+0x1d6/0x2c0
>  [<c0183401>] do_get_write_access+0x4a1/0x4d0
>  [<c012d89c>] zap_pmd_range+0x6c/0x80

A non-uptodate page mapped into pagetables.  I _think_ I
can see how that can happen.  If the workload was, say,
bash-shared-mapping...

If it is reproducible, does the removal of the ClearPageUptodate
statement from mm/truncate.c:truncate_complete_page() make it
go away?

Thanks.
