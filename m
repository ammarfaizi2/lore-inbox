Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbTIYK3R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 06:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbTIYK3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 06:29:17 -0400
Received: from dyn-ctb-210-9-245-204.webone.com.au ([210.9.245.204]:61959 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261793AbTIYK3O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 06:29:14 -0400
Message-ID: <3F72C371.5010909@cyberone.com.au>
Date: Thu, 25 Sep 2003 20:29:05 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Aaron Lehmann <aaronl@vitelus.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Complete I/O starvation with 3ware raid on 2.6
References: <20030925071252.GE22525@vitelus.com> <20030925004301.171f6645.akpm@osdl.org> <20030925075852.GI22525@vitelus.com> <20030925011052.6f8beab2.akpm@osdl.org> <20030925083142.GK22525@vitelus.com> <3F72B1BC.7080405@cyberone.com.au> <20030925101546.GL22525@vitelus.com>
In-Reply-To: <20030925101546.GL22525@vitelus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Aaron Lehmann wrote:

>On Thu, Sep 25, 2003 at 07:13:32PM +1000, Nick Piggin wrote:
>
>>But the load average will be 11 because there are processes stuck in the
>>kernel somewhere in D state. Have a look for them. They might be things
>>like pdflush, kswapd, scsi_*, etc.
>>
>
>They're pdflush and kjournald. I don't have sysrq support compiled in
>at the moment.
>

OK, it would be good if you could get a couple of sysrq T snapshots then
and post them to the list.

>
>I've noticed the problem does not occur when the raid can absorb data
>faster than the other drive can throw data at it. My naive mind is
>pretty sure that this is just an issue of way too much being queued
>

Although your system (usr, lib, bin etc) is on the IDE disk, right?
And that is only doing reads?

How does your system behave if you are doing just the read side (ie.
going to /dev/null), or just the write side (coming from /dev/zero).

>
>for writing. If someone could tell me how to control this parameter,
>I'd definately give it a try [tomorrow]. All I've found on my own is
>#define TW_Q_LENGTH 256 in 3w-xxxx.h and am not sure if this is the
>right thing to change or safe to change.
>

That looks like it, try it at 4.

