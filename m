Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265716AbSJYASb>; Thu, 24 Oct 2002 20:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265730AbSJYASa>; Thu, 24 Oct 2002 20:18:30 -0400
Received: from packet.digeo.com ([12.110.80.53]:29853 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265716AbSJYASB>;
	Thu, 24 Oct 2002 20:18:01 -0400
Message-ID: <3DB88F26.AD29F589@digeo.com>
Date: Thu, 24 Oct 2002 17:24:06 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: cmm@us.ibm.com
CC: Hugh Dickins <hugh@veritas.com>, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       lse-tech@lists.sourceforge.net
Subject: Re: [PATCH]updated ipc lock patch
References: <3DB87458.F5C7DABA@digeo.com> <Pine.LNX.4.44.0210242342460.1169-100000@localhost.localdomain> <3DB88298.735FD044@digeo.com> <3DB88B2F.640EA4E@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Oct 2002 00:24:06.0084 (UTC) FILETIME=[D4032840:01C27BBC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mingming cao wrote:
> 
> > Even better: is it possible to embed the rcu_ipc_free inside the
> > object-to-be-freed?  Perhaps not?
> 
> Are you saying that have a static RCU header structure in the
> object-to-be-freed?  I think it's possible.  It fits well in the rmid
> case, where the object to be freed is an kern_ipc_perm structure. But
> for the  grow_ary() case, the object to be freed is a array of struct
> ipc_id, so it need a little bit more changes there. Maybe add a new
> structure ipc_entries, which include the RCU header structure and the
> pointer to the entries array.  Then have the ipc_ids->entries point to
> ipc_entries.  Just a little concern that this way we added a reference
> when looking up the IPC ID from the array.

This is a place where a mempool is appropriate.  The objects have
a "guaranteed to be returned if you wait for long enough" lifecycle.

But Hugh's right here.  The chance of the single-page GFP_KERNEL
allocation failing is tiny; the probability depending upon the
VM-of-the-day.  Let's leave it be.
