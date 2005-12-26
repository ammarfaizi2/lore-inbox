Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbVLZQhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbVLZQhp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 11:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932066AbVLZQhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 11:37:45 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:24842 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S932065AbVLZQho
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 11:37:44 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [EXPERIMENT] Add new "flush" option
References: <877j9ufeio.fsf@devron.myhome.or.jp>
	<20051225041900.38fdcba7.akpm@osdl.org>
	<878xu99rxx.fsf@devron.myhome.or.jp>
	<20051225150500.317bb7b3.akpm@osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 27 Dec 2005 01:37:31 +0900
In-Reply-To: <20051225150500.317bb7b3.akpm@osdl.org> (Andrew Morton's message of "Sun, 25 Dec 2005 15:05:00 -0800")
Message-ID: <87oe336chg.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

>> Umm... If queue is too busy, we can't flush immediately. So, this code
>> is delaying flush, and we can wait the more user's request by it, I think.
>
> The thing is that bdi_write_congested() will only return true when the
> queue is under really really heavy writeout.  Most of the time it just
> won't trigger, so this code isn't doing anything very useful.
>
> If you indeed want to implement something like "only sync the device when
> it is otherwise idle" then some different approach will be needed.  One
> which
>
> a) detects when there is light writeout happening and which
>
> b) detects when there are reads happening too.
>
> I don't know whether any of this is particularly useful, really.  So I'd
> suggest that we just remove the bdi_write_contested() test and leave it at
> that.

OK, I'm not sure whether this part is really useful or not, so I'll
remove this.

Also, for improving this patch overall, I'd like to hear feedback from
real user of hotplug devices.

> I could be wrong, of course - if you have some testcase in which the
> bdi_write_congested() test makes some perceptible difference then I'd be
> interested in hearing about it.  If you put a printk in there, does it
> trigger much?

I didn't trigger this on my test. However queue->nr_requests is
configurable (/sys/block/xxx/queue/nr_requests), so if user changes
it, I guess it may be triggered.

But also I don't know whether it is useful or not.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
