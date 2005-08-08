Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbVHHTrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbVHHTrO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 15:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbVHHTrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 15:47:14 -0400
Received: from smtp3.akamai.com ([63.116.109.25]:28581 "EHLO smtp3.akamai.com")
	by vger.kernel.org with ESMTP id S932241AbVHHTrN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 15:47:13 -0400
Message-ID: <42F7B6B6.BE1C42E1@akamai.com>
Date: Mon, 08 Aug 2005 12:47:02 -0700
From: Prasanna Meda <pmeda@akamai.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix madvise vma merging
References: <Pine.LNX.4.61.0508051911120.6203@goblin.wat.veritas.com>
	 <42F3FF90.9C030CEB@akamai.com> <Pine.LNX.4.61.0508061134520.6205@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

> On Fri, 5 Aug 2005, Prasanna Meda wrote:
> > Hugh Dickins wrote:
> >
> > > 2. Correct initial value of prev when starting part way into a vma: as
> > >    in sys_mprotect and do_mlock, it needs to be set to vma in this case
> > >    (vma_merge handles only that minimum of cases shown in its comments).
> >
> > Acknowledge corrections 1 and  3 readily.  Treated vma_merge
> > as block box that can handle all cases.  Motivation for pointless
> > case 3 is to skip holes and did not notice that has been covered.
> > Thanks for corrections.
>
> And thanks for the confirmations.
>
> > Correction 2 is tricky.  Sometimes it merges similar to case 3,
> > misses a needed split,  where after the fix  we can get case 4
> > merge. If that is what you are saying, we are in agreement.
> > Otherwise, can you explain the real problem?
>
> I probably am saying what you are saying there,
> but it's hard for me to understand it that way.
>
> Missing out the "start > vma->vm_start" adjustment of prev introduces
> additional (but redundant: non-canonical) cases not considered at all
> by vma_merge, now entered with a "prev" which is remote and surely
> irrelevant to merging.  "misses a needed split", yes, I saw that;
> indeed my test ended up taking the "cases 3, 8" path, when, given
> the right prev, it should have been handled as a "case 4".
>

Ok,   we both are on the same page.  Your obseravtions are same.
Thanks a lot for the  code review and finding corner cases.

-Prasanna.

