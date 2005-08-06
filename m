Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbVHFAI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbVHFAI6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 20:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbVHFAI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 20:08:58 -0400
Received: from smtp3.akamai.com ([63.116.109.25]:61400 "EHLO smtp3.akamai.com")
	by vger.kernel.org with ESMTP id S262013AbVHFAI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 20:08:57 -0400
Message-ID: <42F3FF90.9C030CEB@akamai.com>
Date: Fri, 05 Aug 2005 17:08:49 -0700
From: Prasanna Meda <pmeda@akamai.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix madvise vma merging
References: <Pine.LNX.4.61.0508051911120.6203@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

> Better late than never, I've at last reviewed the madvise vma merging
> going into 2.6.13.  Remove a pointless check and fix two little bugs -
> a simple test (with /proc/<pid>/maps hacked to show ReadHints) showed
> both mismerges in practice: though being madvise, neither was disastrous.
>
> 1. Correct placement of the success label in madvise_behavior: as in
>    mprotect_fixup and mlock_fixup, it is necessary to update vm_flags
>    when vma_merge succeeds (to handle the exceptional Case 8 noted in
>    the comments above vma_merge itself).
>
> 2. Correct initial value of prev when starting part way into a vma: as
>    in sys_mprotect and do_mlock, it needs to be set to vma in this case
>    (vma_merge handles only that minimum of cases shown in its comments).
>
> 3. If find_vma_prev sets prev, then the vma it returns is prev->vm_next,
>    so it's pointless to make that same assignment again in sys_madvise.

Acknowledge corrections 1 and  3 readily.  Treated vma_merge
as block box that can handle all cases.  Motivation for pointless
case 3 is to skip holes and did not notice that has been covered.  Thanks for
corrections.

>  (vma_merge handles only that minimum of cases shown in its comments).
>

Correction 2 is tricky.  Sometimes it merges similar to case 3,
misses a needed split,  where after the fix  we can get case 4
merge. If that is what you are saying, we are in agreement.  Otherwise,
can you explain the real problem?


Thanks,
Prasanna.

