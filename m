Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129282AbRB1VfH>; Wed, 28 Feb 2001 16:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129306AbRB1Ve5>; Wed, 28 Feb 2001 16:34:57 -0500
Received: from colorfullife.com ([216.156.138.34]:59666 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129284AbRB1Veo>;
	Wed, 28 Feb 2001 16:34:44 -0500
Message-ID: <3A9D6F05.F24D5558@colorfullife.com>
Date: Wed, 28 Feb 2001 22:35:01 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2-ac4 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: neelam_saboo@usa.net
CC: linux-kernel@vger.kernel.org
Subject: Re: paging behavior in Linux
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> When I run my program on a readhat linux machine, I dont get results as 
> expected, work thread seems to be stuck when prefetch thread is waiting on 
> a page fault
>
That's a known problem:

The paging io for a process is controlled with a per-process semaphore.
The semaphore is held while waiting for the actual io. Thus the paging
in multi threaded applications is single threaded.
Probably your prefetch thread is waiting for disk io, and the worker
thread causes a minor pagefault --> worker thread sleeps until the disk
io is completed.

--
	Manfred
