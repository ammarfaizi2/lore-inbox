Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbULABEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbULABEn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 20:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbULABBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 20:01:19 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:26965 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261197AbULABAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 20:00:45 -0500
Date: Wed, 1 Dec 2004 01:00:13 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Chris Wright <chrisw@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, Michael Kerrisk <michael.kerrisk@gmx.net>,
       Linus Torvalds <torvalds@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       Rik van Riel <riel@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] shmtcl SHM_LOCK perms
In-Reply-To: <20041130125045.E2357@build.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0412010049520.3344-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2004, Chris Wright wrote:
> * Hugh Dickins (hugh@veritas.com) wrote:
> > Michael Kerrisk has observed that at present any process can SHM_LOCK
> > any shm segment of size within process RLIMIT_MEMLOCK, despite having no
> > permissions on the segment: surprising, though not obviously evil.  And
> > any process can SHM_UNLOCK any shm segment, despite no permissions on it:
> > that is surely wrong.
> 
> You may be neither the owner, nor the creator of a segment but have read
> access to it.  In which case you could simply copy the contents of the
> segment anywhere you like, which has similar effect to SHM_UNLOCK from
> the point of view of paging out sensitive data.

True, and if securing sensitive data against pageout were the only reason
for SHM_LOCK, then I guess it might be an argument for letting anyone with
read permission do SHM_UNLOCK.

But that's not the only reason for SHM_LOCK, and all you're telling us
there is that the owner of sensitive data should be careful who they
give read permission to - indeed!  So I still tend to agree with
Michael, that the most natural restriction is to owner or creator -
relax that if some app actually has a good case for relaxing it.

Hugh

