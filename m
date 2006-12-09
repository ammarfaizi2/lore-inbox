Return-Path: <linux-kernel-owner+w=401wt.eu-S967681AbWLIK0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967681AbWLIK0N (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 05:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967636AbWLIK0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 05:26:13 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:56086 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936595AbWLIK0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 05:26:11 -0500
X-Originating-Ip: 74.102.209.62
Date: Sat, 9 Dec 2006 05:22:32 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: why are some of my patches being credited to other "authors"?
Message-ID: <Pine.LNX.4.64.0612090515480.12992@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  perhaps i'm just being clueless about the authorship protocol here,
but i'm a bit hacked off by noticing that at least one submitted patch
of mine was apparently re-submitted (albeit slightly modified) a few
days later by another poster and applied under that poster's name.

  on sun, dec 3, i submitted to the list:

http://marc.theaimsgroup.com/?l=linux-kernel&m=116516635728664&w=2

and yet, just by accident this morning, i see the log for that file
ipc/sem.c contains:

======================================================
commit 4668edc334ee90cf50c382c3e423cfc510b5a126
Author: Burman Yan <yan_952@hotmail.com>
Date:   Wed Dec 6 20:38:51 2006 -0800

    [PATCH] kernel core: replace kmalloc+memset with kzalloc

    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/ipc/sem.c b/ipc/sem.c
index 21b3289..d3e12ef 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -1070,14 +1070,13 @@ static struct sem_undo *find_undo(struct
        ipc_rcu_getref(sma);
        sem_unlock(sma);

-       new = (struct sem_undo *) kmalloc(sizeof(struct sem_undo) + sizeof(short)*nsems, GFP_KERNEL);
+       new = kzalloc(sizeof(struct sem_undo) + sizeof(short)*nsems, GFP_KERNEL);
        if (!new) {
                ipc_lock_by_ptr(&sma->sem_perm);
                ipc_rcu_putref(sma);
                sem_unlock(sma);
                return ERR_PTR(-ENOMEM);
        }
-       memset(new, 0, sizeof(struct sem_undo) + sizeof(short)*nsems);
        new->semadj = (short *) &new[1];
        new->semid = semid;
======================================================

  admittedly, mr. yan's patch is technically cleaner since it removes
the superfluous cast applied to kzalloc().  however, i very
*deliberately* left that cast in, and i explained why a couple days
later here in another context:

http://marc.theaimsgroup.com/?l=linux-kernel&m=116553652920469&w=2

  quite simply, as per the guidelines given for creating and
submitting kernel patches, i'm trying to keep each submission
well-defined, as i was going to follow up the above with another
submission to remove *all* superfluous casts in one fell swoop.  but
it's not just a matter of proper patch attribution.

  i've submitted a number of patches recently and, every time i do a
"git pull", i check the log to see if any of them have been applied so
i can delete them from my personal "submitted but not applied"
directory.  if they've been applied by another author, then naturally
i'll never notice and i'll keep wondering about the delay.

  so what's the protocol here?  are more senior kernel developers
allowed to poach on my patch submissions, tidy them up slightly, then
drop any attribution to me?  enquiring minds *definitely* want this
cleared up.

rday

p.s.  it's possible that this is all just a wild coincidence, of
course.  stranger things have happened.
