Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262709AbUJ1SD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbUJ1SD1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 14:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263025AbUJ1SD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 14:03:26 -0400
Received: from kludge.physics.uiowa.edu ([128.255.33.129]:3593 "EHLO
	kludge.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id S262709AbUJ1SDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 14:03:06 -0400
Date: Thu, 28 Oct 2004 13:02:30 -0500
From: Joseph Pingenot <trelane@digitasaru.net>
To: linux-kernel@vger.kernel.org
Subject: Max groups one can be a member of linux/sched.h and NGROUPS_SMALL
Message-ID: <20041028180230.GD10255@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

In my quest to try and figure out the max number of groups one can be a
  member of (and to learn more about the kernel internals), I stumbled
  across the following tidbit:

(excerpted from linux/sched.h)
#define NGROUPS_SMALL           32
#define NGROUPS_PER_BLOCK       ((int)(PAGE_SIZE / sizeof(gid_t)))
struct group_info {
        int ngroups;
        atomic_t usage;
        gid_t small_block[NGROUPS_SMALL];
        int nblocks;
        gid_t *blocks[0];
};

This seems to be the place where group information is stored (linked to from
  task_struct).

So, it appears to hold 32 gids, but what is this blocks bit?  Is 32 the max
  number of groups one can be a member of?

Thanks!

-Joseph

-- 
Joseph===============================================trelane@digitasaru.net
      Graduate Student in Physics, Freelance Free Software Developer
