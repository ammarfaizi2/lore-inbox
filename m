Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161058AbVLWV5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161058AbVLWV5m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 16:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161060AbVLWV5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 16:57:42 -0500
Received: from ns.dynamicweb.hu ([195.228.155.139]:20620 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1161058AbVLWV5l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 16:57:41 -0500
Message-ID: <006001c6080b$03759da0$a700a8c0@dcccs>
From: "JaniD++" <djani22@dynamicweb.hu>
To: "Nate Diller" <nate.diller@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
References: <EXCHG2003iSnRMWuLn500000618@EXCHG2003.microtech-ks.com> <00ad01c5eefd$7990b370$a700a8c0@dcccs> <5c49b0ed0512230058q157ddedx96059d876c45a69f@mail.gmail.com>
Subject: Re: buffer cache question
Date: Fri, 23 Dec 2005 22:50:11 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: Nate Diller
To: JaniD++
Cc: Roger Heflin ; linux-kernel@vger.kernel.org
Sent: Friday, December 23, 2005 9:58 AM
Subject: Re: buffer cache question


On 11/21/05, JaniD++ <djani22@dynamicweb.hu> wrote:
Hi,

I have read back in the kernel-archives, and found this messages, about the
same theme, but there is one difference!

On the old messages:
>Nate Diller wrote:
> just found the culprit.  guess i should have read the code the first
> time.  get_dirty_limits() in drivers/block/page_writeback.c has a
> hard-coded upper limit to dirty_ratio.  it's capped to half of the
> unmapped pages, so maybe 30-40% of your system's memory.  so if you are
> brave, just remove the "/ 2" parts from the 'if (dirty_ratio >
> unmapped_ratio / 2) dirty_ratio = unmapped_ratio / 2;' check, and you
> can have all the OOM goodness you want.
...
>I changed that bit of code to:
>
> if (dirty_ratio > unmapped_ratio - 10)
>  dirty_ratio = unmapped_ratio - 10;
>
>and added a couple of sanity checks so that it couldn't get below 5 or
above 95.
>
>Then set /proc/sys/vm/dirty_ratio to 95 and dirty_background_ratio to 1.

In this case, this modification is only for the *dirty* memory buffer.
I want to use more buffer *cache*! :-)
The unwritten dirty memory ratio is good enough for me.

Anybody has an idea?

<snip>



> > [root@st-0001 root]# free
> >              total       used       free     shared
> > buffers     cached
> > Mem:       2073152     933188    1139964          0
> > 836776      43416
> > -/+ buffers/cache:      52996    2020156
> > Swap:            0          0          0
> > [root@st-0001 root]# cat /proc/meminfo
> > MemTotal:      2073152 kB
> > MemFree:       1139012 kB
> > Buffers:        835928 kB
> > Cached:          43448 kB
> > SwapCached:          0 kB
> > Active:          12872 kB
> > Inactive:       871424 kB
> > HighTotal:     1179584 kB
> > HighFree:      1129764 kB
> > LowTotal:       893568 kB
> > LowFree:          9248 kB
> > SwapTotal:           0 kB
> > SwapFree:            0 kB
> > Dirty:               0 kB
> > Writeback:           0 kB
> > Mapped:           9104 kB
> > Slab:            30248 kB
> > CommitLimit:   1036576 kB
> > Committed_AS:    15428 kB
> > PageTables:        408 kB
> > VmallocTotal:   114680 kB
> > VmallocUsed:       196 kB
> > VmallocChunk:   114476 kB
> > [root@st-0001 root]#

looks like you're barely using any of your high memory.  maybe NBD doesn't
have highmem support.  what file system are you using?

NATE


I cannot understant this.
NBD need to support highmem for buffering?
If know right, the kernel does buffering, not NBD!
But the kernel only use ~830MB for buffer cache instead of dinamically use
all free memory like page cache.

This is one raw disk node, independent from file system.

Cheers,
Janos

