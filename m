Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262371AbSKCUJn>; Sun, 3 Nov 2002 15:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262374AbSKCUJn>; Sun, 3 Nov 2002 15:09:43 -0500
Received: from holomorphy.com ([66.224.33.161]:23440 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262371AbSKCUJl>;
	Sun, 3 Nov 2002 15:09:41 -0500
Date: Sun, 3 Nov 2002 12:14:48 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@digeo.com>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Hot/cold allocation -- swsusp can not handle hot pages
Message-ID: <20021103201448.GM23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@digeo.com>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20021102181900.GA140@elf.ucw.cz> <20021102184612.GI23425@holomorphy.com> <20021102202208.GC18576@atrey.karlin.mff.cuni.cz> <3DC44839.A3AEAE41@digeo.com> <20021103200809.GC27271@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021103200809.GC27271@elf.ucw.cz>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, Andrew Morton wrote:
>> I'm not really sure what to suggest here.  Emptying the per-cpu
>> page pools would be tricky.  Maybe a swsusp-special page allocator
>> which goes direct to the buddy lists or something.

On Sun, Nov 03, 2002 at 09:08:09PM +0100, Pavel Machek wrote:
> Well, see the patch above. That seems to do the trick for
> me. It seems that even "cold" allocation can give page from per-cpu
> pool. I thought that was a bug?

Not a bug. The semantics only imply a preference for merging, not
a requirement to do so. A direct dequeue-from-buddy method either
by adjusting watermarks or a specialized interface in combination
with per-cpu list shootdown is required to enforce your invariants.


Bill
