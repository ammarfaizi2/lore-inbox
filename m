Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261520AbSIXBRT>; Mon, 23 Sep 2002 21:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261521AbSIXBRS>; Mon, 23 Sep 2002 21:17:18 -0400
Received: from holomorphy.com ([66.224.33.161]:14744 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261520AbSIXBRS>;
	Mon, 23 Sep 2002 21:17:18 -0400
Date: Mon, 23 Sep 2002 18:22:01 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.38 semaphore.c calls sleeping function in illegal context
Message-ID: <20020924012201.GA3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20020924002052.GS25605@holomorphy.com> <3D8FBC16.6A4BCDE4@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D8FBC16.6A4BCDE4@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> Trace; c01175f7 <__might_sleep+27/2b>
>> Trace; c011a4a1 <acquire_console_sem+2d/50>
>> Trace; c011a78a <register_console+122/1cc>
>> Trace; c0105000 <_stext+0/0>

On Mon, Sep 23, 2002 at 06:12:54PM -0700, Andrew Morton wrote:
> Don't know.  Who called register_console()?
> But I suspect in_atomic() is returning incorrect or misleading
> answers early in boot.

I would suspect console_init(). I believe some kind of change was
done here for preempt bootstrap ordering issues (vm86_info: BAD) as
it's a bit too early to schedule here. Things have gotten interesting
down here in other contexts where sleeping and/or waitqueue fiddling
is illegal so early on. Getting a better stack dump might be helpful.
I'll see if I can do that soon.


Cheers,
Bill
