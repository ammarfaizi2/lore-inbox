Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbTKCDCe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 22:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbTKCDCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 22:02:34 -0500
Received: from hera.kernel.org ([63.209.29.2]:30619 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261879AbTKCDCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 22:02:32 -0500
To: linux-kernel@vger.kernel.org
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [OOPS] Linux-2.6.0-test9
Date: Sun, 02 Nov 2003 19:01:51 -0800
Organization: OSDL
Message-ID: <bo4gf0$4o8$1@build.pdx.osdl.net>
References: <20031103000924.494d960f.us15@os.inf.tu-dresden.de> <20031103001913.612795b3.us15@os.inf.tu-dresden.de>
Reply-To: torvalds@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: build.pdx.osdl.net 1067828513 4872 172.20.1.2 (3 Nov 2003 03:01:53 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Mon, 3 Nov 2003 03:01:53 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Udo A. Steinberg wrote:
> 
> I just noticed that my last report was actually the second OOPS in a whole
> series. Here is the first one.
> 
> Unable to handle kernel paging request at virtual address 50d35f7c
> EIP is at __d_lookup+0xf2/0x150

Ok, looks like your dentry lists got seriously corrupted.

The good news (?) is that you seem to have preempt enabled, and there is one
known (but fairly hard-to-hit) race in UP+preempt locking due to bad
barrier ordering in test9 (and all previous kernels too, for that matter).
That should be fixed in the current BK snapshots, but you can also avoid
the problem by just not enabling preempt.

Of course, if you see the bug without preempt, or if this was on a SMP
kernel (which _should_ have hidden the preempt problem even with preempt
enabled), holler.

                Linus
