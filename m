Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbUK0HKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbUK0HKx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 02:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbUK0HJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 02:09:01 -0500
Received: from zeus.kernel.org ([204.152.189.113]:32190 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261202AbUKZTG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:06:59 -0500
Date: Thu, 25 Nov 2004 06:40:59 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Michael Kerrisk <mtk-lkml@gmx.net>
cc: hugh@veritas.com, chrisw@osdl.org, manfred@colorfullife.com,
       torvalds@osdl.org, akpm@osdl.org, michael.kerrisk@gmx.net,
       linux-kernel@vger.kernel.org
Subject: Re: Further shmctl() SHM_LOCK strangeness
In-Reply-To: <24718.1101372632@www65.gmx.net>
Message-ID: <Pine.LNX.4.61.0411250639530.10497@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0411242216210.10497@chimarrao.boston.redhat.com>
 <24718.1101372632@www65.gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Nov 2004, Michael Kerrisk wrote:

> As noted by Hugh, the problem also applies for
> SHM_UNLOCK: anyone can unlock any System V shared
> memory segment.  If our reason for locking memory
> was security (no swapping), then this does allow
> for exploits.

Good point.  I guess that for SHM_UNLOCK operations
we need to check for either:

1) current->user is the same user who SHM_LOCKed the
    segment in question

or

2) the process has the correct capabilities set

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
