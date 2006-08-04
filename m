Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161058AbWHDF6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161058AbWHDF6w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161055AbWHDF6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:58:52 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:33214 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1161054AbWHDF6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:58:50 -0400
Date: Fri, 4 Aug 2006 07:58:00 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Xin Zhao <uszhaoxin@gmail.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: Can someone explain under what condition inode cache pages can
 be swapped out?
In-Reply-To: <4ae3c140608030832n2124b8abu479b7b4ae3eda1f@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0608040753030.8519@yvahk01.tjqt.qr>
References: <4ae3c140608022315y675eed20hcefbb8fb0407f4a3@mail.gmail.com> 
 <Pine.LNX.4.61.0608030951270.32738@yvahk01.tjqt.qr>
 <4ae3c140608030832n2124b8abu479b7b4ae3eda1f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Many thanks for kind replies.
>
> You said inode cache is never swapped at all.

Yes.

> How do you know the pages are never swapped out?

Because
- they are in kernel memory
- if someone needs memory, we free some cache

> How can I tell whether a specific memory page is
> swappable?

Kernel memory is in general not swappable.

> If my understanding is right, inode cache shrinker only frees the
> reclaimable inodes, which means, if a lot of files are opened when
> shrinker is activated, the shrinker may not find sufficient
> reclaimable inodes to free enough space. What will Linux do under such
> condition?

Userspace will start to be swapped out to make room for kernel memory.
And if the swap is full, the OOM killer comes into action and will kill 
programs.
That's why it is so important to make sure that there are no memory leaks 
in kernelspace.


Jan Engelhardt
-- 
