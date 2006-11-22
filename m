Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161995AbWKVLJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161995AbWKVLJo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 06:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162063AbWKVLJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 06:09:44 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:33693 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161995AbWKVLJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 06:09:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kXyzI7IG0V+Q9w+bYuDqQwM7UJK/tNrGMrO5mLpMB73qCAnYzKiqdjEG74YVaXDcL/IYc3VGH30XAax30uQ7TwGXVa8SniKpTEi/lfIx5Sq2ksBQ7bkm+5qXnuqZ4D8bCr6pxpBa+lAvRX4JUsKL1ejrLGbHJ7vQpGXPEti0xTA=
Message-ID: <6d6a94c50611220309w3ef0fc3eh93492297e759eadd@mail.gmail.com>
Date: Wed, 22 Nov 2006 19:09:41 +0800
From: Aubrey <aubreylee@gmail.com>
To: "Peter Zijlstra" <a.p.zijlstra@chello.nl>
Subject: Re: The VFS cache is not freed when there is not enough free memory to allocate
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, mel <mel@csn.ul.ie>,
       "Andy Whitcroft" <apw@shadowen.org>
In-Reply-To: <1164192171.5968.186.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6d6a94c50611212351if1701ecx7b89b3fe79371554@mail.gmail.com>
	 <1164185036.5968.179.camel@twins>
	 <6d6a94c50611220202t1d076b4cye70dcdcc19f56e55@mail.gmail.com>
	 <1164192171.5968.186.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/06, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
>
> Mel's patches alone aren't quite enough, you also need some reclaim
> modifications, I'll ping Andy to see how far he's on that.
>

I think so. A quick look at Mei's patch, I found the patch can't help our case.
The current situation is  that the application need 8 M memory, but
ther is only 5M free memory, cached memory eat almost 40Mbyte. When
the application is requesting the memory, kernel just report failure,
not attempt to release the VFS cache and try it again.
==============================
root:/mnt> cat /proc/meminfo
MemTotal:        54196 kB
MemFree:          5520 kB <== only 5M free
Buffers:            76 kB
Cached:          44696 kB <== cache eat 40MB
SwapCached:          0 kB
Active:          21092 kB
Inactive:        23680 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        54196 kB
LowFree:          5520 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
AnonPages:           0 kB
Mapped:              0 kB
Slab:             3720 kB
PageTables:          0 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:     27096 kB
Committed_AS:        0 kB
VmallocTotal:        0 kB
VmallocUsed:         0 kB
VmallocChunk:        0 kB
==========================================

-Aubrey
