Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265815AbUGTMGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265815AbUGTMGA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 08:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbUGTMF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 08:05:59 -0400
Received: from relay02.roc.ny.frontiernet.net ([66.133.131.35]:16043 "EHLO
	relay02.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S265815AbUGTMEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 08:04:44 -0400
Message-ID: <40FD0A61.1040503@xfs.org>
Date: Tue, 20 Jul 2004 07:04:49 -0500
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Cahya Wirawan <cwirawan@email.archlab.tuwien.ac.at>
CC: linux-kernel@vger.kernel.org
Subject: Re: 4K stack kernel get Oops in Filesystem stress test
References: <20040720114418.GH21918@email.archlab.tuwien.ac.at>
In-Reply-To: <20040720114418.GH21918@email.archlab.tuwien.ac.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cahya Wirawan wrote:
> Hi,
> I use vanila kernel 2.6.7 and 2.6.8-rc1 with 4K stack enabled,
> but if I execute the filesystem stress test from ltp.sf.net (linux test
> project) the machine always crash immediately. Or it will crash also after few
> hours if I do kernel compile test repeatedly. But if I use 8K stack,
> my server survive this filesystem stress test.
> Also my notebook get oops if I used 4k stack in kernel , but it crashed 
> after few minutes running the filesystem stress test (not immediately).
> My configuration is
> compaq proliant ML530/G2 , 2 processor intel 2.4Ghz, 1GB ram ,
> LVM1 volume with XFS filesystem.
> and here is the Oops message:


Don't use 4K stacks and XFS. What you hit here is a path where the
filesystem is getting full and it needs to free some reserved space
by flushing cached data which is using reserved extents. Reserved
extents do not yet have an on disk address and they include a
reservation for the worst case metadata usage. Flushing them will
get you room back.

As you can see, it is a pretty deep call stack, most of XFS is going
to work just fine with a 4K stack, but there are end cases like
this one which will just not fit.

Steve

