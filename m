Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262140AbVCIH3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbVCIH3F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 02:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVCIH3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 02:29:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:63123 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262140AbVCIH2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 02:28:45 -0500
Date: Tue, 8 Mar 2005 23:28:33 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Chris Wright <chrisw@osdl.org>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>
Subject: [RFC] -stable, how it's going to work.
Message-ID: <20050309072833.GA18878@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So here's a first cut at how this 2.6 -stable release process is going
to work that Chris and I have come up with.  Does anyone have any
problems/issues/questions with this?

thanks,

greg k-h

-------------------

Everything you ever wanted to know about Linux 2.6 -stable releases.


Rules on what kind of patches are accepted, and what ones are not, into
the "-stable" tree:
 - It must be obviously correct and tested.
 - It can not bigger than 100 lines, with context.
 - It must fix only one thing.
 - It must fix a real bug that bothers people (not a, "This could be a
   problem..." type thing.)
 - It must fix a problem that causes a build error (but not for things
   marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
   security issue, or some "oh, that's not good" issue.  In short,
   something critical.
 - No "theoretical race condition" issues, unless an explanation of how
   the race can be exploited.
 - It can not contain any "trivial" fixes in it (spelling changes,
   whitespace cleanups, etc.)
 - It must be accepted by the relevant subsystem maintainer.
 - It must follow Documentation/SubmittingPatches rules.

Procedure for submitting patches to the -stable tree:
 - Send the patch, after verifying that it follows the above rules, to
   stable@kernel.org.
 - The sender will receive an ack when the patch has been accepted into
   the queue, or a nak if the patch is rejected.  This response might
   take a few days, according to the developer's schedules.
 - If accepted, the patch will be added to the -stable queue, for review
   by other developers.
 - Security patches should not be sent to this alias, but instead to the
   documented security@kernel.org.  
   
Review cycle:
 - When the -stable maintainers decide for a review cycle, the patches
   will be sent to the review committee, and the maintainer of the
   affected area of the patch (unless the submitter is the maintainer of
   the area) and CC: to the linux-kernel mailing list.
 - The review committee has 48 hours in which to ack or nak the patch.
 - If the patch is rejected by a member of the committee, or linux-kernel
   members object to the patch by bringing up issues that the maintainer
   and members did not realize, the patch will be dropped from the
   queue.
 - At the end of the review cycle, the acked patches will be added to
   the latest -stable release, and a new -stable release will happen.
 - Security patches will be accepted into the -stable tree directly from
   the security kernel team, and not go through the normal review cycle.
   Contact the kernel security team for more details on this procedure.

Review committe:
 - This will be made up of a number of kernel developers who have
   volunteered for this task, and a few that haven't.

