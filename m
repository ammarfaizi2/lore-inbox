Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbUCLPNn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 10:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUCLPNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 10:13:43 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:63704 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262175AbUCLPNk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 10:13:40 -0500
Message-ID: <4051D39D.80207@cyberone.com.au>
Date: Sat, 13 Mar 2004 02:13:33 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mark_H_Johnson@raytheon.com
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mfedyk@matchmail.com, m.c.p@wolk-project.de,
       owner-linux-mm@kvack.org, plate@gmx.tm
Subject: Re: [PATCH] 2.6.4-rc2-mm1: vm-split-active-lists
References: <OF62A00090.6117DDE8-ON86256E55.004FED23@raytheon.com>
In-Reply-To: <OF62A00090.6117DDE8-ON86256E55.004FED23@raytheon.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mark_H_Johnson@raytheon.com wrote:

>
>
>
>Nick Piggin <piggin@cyberone.com.au> wrote:
>
>>Not too sure what you mean. If we've swapped out the pages, it is
>>because we need the memory for something else. So no.
>>
>
>Actually - no, from what Andrew said, the system was not under memory
>pressure and did not need the memory for something else. The swapping
>occurred "just because". In that case, it would be better to keep track
>of where the pages came from (i.e., swap them in from the free list).
>
>

In Linux, all reclaim is driven by a memory shortage. Often it
is just because more memory is being requested for more file
cache.

My patch does make it a bit more probable that process memory will
be swapped out before file cache is discarded.

>Don't get me wrong - that behavior may be the "right thing" from an
>overall performance standpoint. A little extra disk I/O when the system
>is relatively idle may provide needed reserve (free pages) for when the
>system gets busy again.
>
>
>>One thing you could do is re read swapped pages when you have
>>plenty of free memory and the disks are idle.
>>
>That may also be a good idea. However, if you keep a mapping between
>pages on the "free list" and those in the swap file / partition, you
>do not actually have to do the disk I/O to accomplish that.
>
>

But presumably if you are running into memory pressure, you really
will need to free those free list pages, requiring the page to be
read from disk when it is used again.

