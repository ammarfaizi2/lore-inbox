Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932708AbVLRTRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708AbVLRTRg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 14:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932707AbVLRTRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 14:17:01 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:38662 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S965245AbVLRTQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 14:16:47 -0500
Date: Sun, 18 Dec 2005 20:16:42 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Vijay Sampath <Vijay.Sampath@aktino.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RESUBMITTING [PATCH] MTD (kernel 2.4.32): kernel stuck in tight loop occasionally on flash access
Message-ID: <20051218191642.GJ15993@alpha.home.local>
References: <02DAE179D5CEED4C992055C823ED90FF8ACE91@ex1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02DAE179D5CEED4C992055C823ED90FF8ACE91@ex1>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vijay,

On Sun, Dec 18, 2005 at 10:50:54AM -0800, Vijay Sampath wrote:
> Resubmitting patch after feedback from Grant Coady and Willy Tarreau.
> Changed description and erroneous diff output for dontdiff file.
> 
> 
> We are running a Timesys modified version of the 2.4 kernel.
> Occasionally we see board lockups on heavy file system and direct MTD
> flash accesses. I have traced this down to a bug in the 2.4 MTD code
> (chip driver to be specific) and see this problem even in the latest 2.4
> kernel (2.4.32). I realize that this problem may not be seen by others
> using the stock kernel, but I think it needs to be fixed anyway for
> correctness.
> 
> The problem is in cfi_cmdset_0001.c, and is present in drivers for other
> chips as well. In the function cfi_intelext_sync() function before
> calling schedule(), the current process needs to be put to sleep by
> calling set_current_state(TASK_UNINTERRUPTIBLE). If it is not put to
> sleep, the task remains in the run queue of the kernel and if its
> priority is high enough, the kernel will constantly keep scheduling this
> process, the state of the chip will never change.
> 
> Adding this one line seems to make our lockups go away. There were
> questions raised as to why TASK_UNINTERRUPTIBLE. The same driver uses
> TASK_UNINTERRUPTIBLE in other similar places while waiting for hardware
> to complete erasing etc. I chose the same thing.

OK, that seems reasonnable. Thanks for the explanation.
I'm queuing it for the -hf tree.

> I am not subscribed to the mailing list, so please CC me on any replies.
> 
> Signed-off-by: Vijay Sampath <vijay.sampath@aktino.com>
> 

Thanks,
Willy

