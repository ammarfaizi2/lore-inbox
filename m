Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266744AbUFYO0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266744AbUFYO0S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 10:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266743AbUFYOY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 10:24:57 -0400
Received: from [66.199.228.3] ([66.199.228.3]:15376 "EHLO xdr.com")
	by vger.kernel.org with ESMTP id S266744AbUFYOYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 10:24:10 -0400
Date: Fri, 25 Jun 2004 07:24:09 -0700
From: David Ashley <dash@xdr.com>
Message-Id: <200406251424.i5PEO9UX000396@xdr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Cache memory never gets released
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
>Cached memory can be easily reclaimed, take a look at /proc/meminfo "Inactive"
>list.

Here is /proc/meminfo from a box that has all but exhausted its free memory:
        total:    used:    free:  shared: buffers:  cached:
Mem:  122064896 84348928 37715968        0   634880 74829824
Swap:        0        0        0
MemTotal:       119204 kB
MemFree:         36832 kB
MemShared:           0 kB
Buffers:           620 kB
Cached:          73076 kB
SwapCached:          0 kB
Active:          70380 kB
Inactive:         7324 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       119204 kB
LowFree:         36832 kB
SwapTotal:           0 kB
SwapFree:            0 kB

>Add more swap.

Might as well suggest walking on water. The hardware is set in stone, this is
a software issue :^).

Something is preventing the cached memory to get reused, it's like it's gone
for good.

Is there any count of how often a cached block is accessed? If there is such
a count, and the count has an effect on whether to allow the release of the
cached block, that could explain this behaviour. Because it could turn out
that the cached blocks are accessed thousands of times.

Thanks--
Dave
