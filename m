Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263306AbTH0LNc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 07:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263310AbTH0LNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 07:13:31 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:25029 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S263306AbTH0LN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 07:13:27 -0400
Date: Wed, 27 Aug 2003 20:14:12 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: cache limit
In-reply-to: <20030827094512.GZ1715@holomorphy.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
Message-id: <1AC36C8C57E018indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.04 (WinNT,501)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
References: <20030827094512.GZ1715@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Aug 2003 02:45:12 -0700, William Lee Irwin III wrote:

>On Wed, Aug 27, 2003 at 06:36:10PM +0900, Takao Indoh wrote:
>> Besides this problem, there are many cases where increase of pagecache
>> causes trouble, I think.
>> For example, DBMS.
>> DBMS caches index of DB in their process space.
>> This index cache conflicts with the pagecache used by other applications,
>> and index cache may be paged out. It cause uneven response of DBMS.
>> In this case, limiting pagecache is effective.
>
>Why is it effective? You're describing pagecache vs. pagecache
>competition and the DBMS outcompeting the cooperating applications for
>memory to the detriment of the workload; this is a very different
>scenario from what "limiting pagecache" sounds like.
>
>How do you know it would be effective? Have you written a patch to
>limit it in some way and tried running it?

It's just my guess. You mean that "index cache" is on the pagecache?
"index cache" is allocated in the user space by malloc,
so I think it is not on the pagecache.


>On Tue, 26 Aug 2003 02:46:34 -0700, William Lee Irwin III wrote:
>>> One thing I thought of after the post was whether they actually had in
>>> mind tunable hard limits on _unmapped_ pagecache, which is, in fact,
>>> useful. OTOH that's largely speculation and we really need them to
>>> articulate the true nature of their problem.
>
>On Wed, Aug 27, 2003 at 06:36:10PM +0900, Takao Indoh wrote:
>> I also think that is effective. Empirically, in the case where pagecache
>> causes memory shortage, most of pagecache is unmapped page. Of course
>> real problem may not be pagecashe, as you or Mike said.
>
>How do you know most of it is unmapped?

I checked /proc/meminfo.
For example, this is my /proc/meminfo(kernel 2.5.73)

MemTotal:       902728 kB
MemFree:         53096 kB
Buffers:         18520 kB
Cached:         732360 kB
SwapCached:          0 kB
Active:         623068 kB
Inactive:       179552 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       902728 kB
LowFree:         53096 kB
SwapTotal:      506036 kB
SwapFree:       506036 kB
Dirty:           33204 kB
Writeback:           0 kB
Mapped:          73360 kB
Slab:            32468 kB
Committed_AS:   167396 kB
PageTables:        988 kB
VmallocTotal:   122808 kB
VmallocUsed:     20432 kB
VmallocChunk:   102376 kB

According to this information, I thought that
all pagecache was 732360 kB and all mapped page was 73360 kB, so
almost of pagecache was not mapped...
Do I misread meminfo?

--------------------------------------------------
Takao Indoh
 E-Mail : indou.takao@soft.fujitsu.com
