Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752147AbWIXGiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbWIXGiK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 02:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752149AbWIXGiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 02:38:10 -0400
Received: from pat.uio.no ([129.240.10.4]:12727 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1752147AbWIXGiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 02:38:09 -0400
Subject: Re: [GIT] Linux client patches against Linux 2.6.18
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0609231700210.4388@g5.osdl.org>
References: <1158982165.5493.12.camel@lade.trondhjem.org>
	 <Pine.LNX.4.64.0609231700210.4388@g5.osdl.org>
Content-Type: text/plain
Date: Sun, 24 Sep 2006 02:37:55 -0400
Message-Id: <1159079875.5633.74.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.173, required 12,
	autolearn=disabled, AWL 1.69, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-23 at 17:06 -0700, Linus Torvalds wrote:

> I'm not seeing a sign-off or ack for the dentry stuff from Al, for 
> example. Was it passed by him? You moved the dentry rehash function inside 
> the dcache_lock, and if that was a bug-fix, it should have been marked as 
> so and done separately etc.

The only function that was moved inside the spinlock was d_hash(), but
that is a fairly trivial change (d_revalidate already does the same).
Otherwise, the only effect of the changes was to create unlocked
versions of d_rehash() for reuse in the new d_materialise_dentry().

In any case, all of those patches have been presented by David on the
fs-devel and lkml lists several times. The last time would be on 27th
July:

 http://marc.theaimsgroup.com/?l=linux-kernel&m=115403487316197&w=2

Al has in addition been Cced on much of the correspondence between David
and myself during the preparation for merging (although that would be
almost half a year ago now).
Finally, Christoph was also pressed into duty as an extra reviewer.

So yes, afaik all the relevant people have been kept informed, even if
they were not labelled as having been Cced in the changelog.

So I apologize for not having sent this as a separate patch, but as I
said above, it was a trivial change as far as the rehash is concerned,
and the only user of the new function is NFS.

Cheers,
  Trond

