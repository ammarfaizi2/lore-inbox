Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbUCLOVW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 09:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbUCLOVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 09:21:22 -0500
Received: from dfw-gate2.raytheon.com ([199.46.199.231]:32608 "EHLO
	dfw-gate2.raytheon.com") by vger.kernel.org with ESMTP
	id S262136AbUCLOVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 09:21:18 -0500
Subject: Re: [PATCH] 2.6.4-rc2-mm1: vm-split-active-lists
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mfedyk@matchmail.com, m.c.p@wolk-project.de,
       owner-linux-mm@kvack.org, plate@gmx.tm
X-Mailer: Lotus Notes Release 5.0.9  November 16, 2001
Message-ID: <OF9DC8F5B1.0044A21E-ON86256E55.004DF368@raytheon.com>
From: Mark_H_Johnson@Raytheon.com
Date: Fri, 12 Mar 2004 08:18:15 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.0.2CF2|July 23, 2003) at
 03/12/2004 08:18:16 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Nick Piggin <piggin@cyberone.com.au> wrote:
>Andrew Morton wrote:

>>That effect is to cause the whole world to be swapped out when people
>>return to their machines in the morning.  Once they're swapped back in
the
>>first thing they do it send bitchy emails to you know who.
>>
>>>From a performance perspective it's the right thing to do, but nobody
likes
>>it.
>>
>>
>
>Yeah. I wonder if there is a way to be smarter about dropping these
>used once pages without putting pressure on more permanent pages...
>I guess all heuristics will fall down somewhere or other.

Just a question, but I remember from VMS a long time ago that
as part of the working set limits, the "free list" was used to keep
pages that could be freely used but could be put back into the working
set quite easily (a "fast" page fault). Could you keep track of the
swapped pages in a similar manner so you don't have to go to disk to
get these pages [or is this already being done]? You would pull them
back from the free list and avoid the disk I/O in the morning.

By the way - with 2.4.24 I see a similar behavior anyway [slow to get
going in the morning]. I believe it is due to our nightly backup walking
through the disks. If you could FIX the retention of sequentially read
disk blocks from the various caches - that would help a lot more in
my mind.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

