Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263750AbUEGUjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263750AbUEGUjF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 16:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbUEGUi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 16:38:27 -0400
Received: from zero.aec.at ([193.170.194.10]:39950 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263750AbUEGUhs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 16:37:48 -0400
To: Steve Lord <lord@xfs.org>
cc: arjanv@redhat.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
References: <1Sq6O-4gJ-25@gated-at.bofh.it> <1Sss1-7qC-53@gated-at.bofh.it>
	<1SzjQ-4EY-21@gated-at.bofh.it> <1SCB0-7kE-11@gated-at.bofh.it>
	<1SSZ6-3vy-13@gated-at.bofh.it> <1STip-3L3-11@gated-at.bofh.it>
	<1T1IW-2eH-3@gated-at.bofh.it> <1T7vo-6C2-7@gated-at.bofh.it>
	<1TfiY-4s1-17@gated-at.bofh.it> <1TfVX-4T4-51@gated-at.bofh.it>
	<1Tg5k-55S-19@gated-at.bofh.it> <1Tgf4-5cp-27@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 07 May 2004 20:38:07 +0200
In-Reply-To: <1Tgf4-5cp-27@gated-at.bofh.it> (Steve Lord's message of "Fri,
 07 May 2004 18:20:14 +0200")
Message-ID: <m3fzachyls.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Lord <lord@xfs.org> writes:


> That was not really my point, consider any memory allocation on the
> stack which is being replaced with an allocate to save space. Then replace
> the saved stack space with the potential stack space used to
> free memory by writing it out via a filesystem. You cannot make all
> the allocations in the kernel GFP_NOFS.

I suspect making memory reclamation less multithreaded (doing 
it in specialized threads only) would be actually a good thing.
I remember there were lots of races in the past with too many
memory reclaimers in parallel that were just papered over with
various hacks. Maybe doing it with less threads would make
this all a bit more controlled.

The question is just how many threads it would need and if
any of the existing threads can do the job.

Overall it sounds more like 2.7 material.

-Andi


