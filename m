Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbUCLPDs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 10:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbUCLPDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 10:03:48 -0500
Received: from lax-gate3.raytheon.com ([199.46.200.232]:35447 "EHLO
	lax-gate3.raytheon.com") by vger.kernel.org with ESMTP
	id S262165AbUCLPDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 10:03:45 -0500
Subject: Re: [PATCH] 2.6.4-rc2-mm1: vm-split-active-lists
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mfedyk@matchmail.com, m.c.p@wolk-project.de,
       owner-linux-mm@kvack.org, plate@gmx.tm
X-Mailer: Lotus Notes Release 5.0.9  November 16, 2001
Message-ID: <OF62A00090.6117DDE8-ON86256E55.004FED23@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Fri, 12 Mar 2004 09:00:43 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.0.2CF2|July 23, 2003) at
 03/12/2004 09:00:45 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Nick Piggin <piggin@cyberone.com.au> wrote:
>Mark_H_Johnson@Raytheon.com wrote:
>>Nick Piggin <piggin@cyberone.com.au> wrote:
>>
>>>Andrew Morton wrote:
>>>
>>
>>>>That effect is to cause the whole world to be swapped out when people
>>>>return to their machines in the morning.  Once they're swapped back in
>>>>
[this is the symptom being reported]
>>Just a question, but I remember from VMS a long time ago that
>>as part of the working set limits, the "free list" was used to keep
>>pages that could be freely used but could be put back into the working
>>set quite easily (a "fast" page fault). Could you keep track of the
>>swapped pages in a similar manner so you don't have to go to disk to
>>get these pages [or is this already being done]? You would pull them
>>back from the free list and avoid the disk I/O in the morning.
>
>Not too sure what you mean. If we've swapped out the pages, it is
>because we need the memory for something else. So no.

Actually - no, from what Andrew said, the system was not under memory
pressure and did not need the memory for something else. The swapping
occurred "just because". In that case, it would be better to keep track
of where the pages came from (i.e., swap them in from the free list).

Don't get me wrong - that behavior may be the "right thing" from an
overall performance standpoint. A little extra disk I/O when the system
is relatively idle may provide needed reserve (free pages) for when the
system gets busy again.

>One thing you could do is re read swapped pages when you have
>plenty of free memory and the disks are idle.
That may also be a good idea. However, if you keep a mapping between
pages on the "free list" and those in the swap file / partition, you
do not actually have to do the disk I/O to accomplish that.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

