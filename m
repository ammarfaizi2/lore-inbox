Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264412AbUEMTIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264412AbUEMTIh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 15:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264422AbUEMTIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:08:36 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:22755 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S264412AbUEMTIf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:08:35 -0400
Date: Thu, 13 May 2004 12:08:33 -0700
From: Andy Isaacson <adi@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: 1352 NUL bytes at the end of a page?
Message-ID: <20040513190833.GH17965@bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've got a user who's reporting BK problems which we've traced down to
the fact that his s.ChangeSet file has a hole, filled with '\0' bytes,
that's so far always 1352 bytes long, and the end is page-aligned.  (In
fact, the two cases we've seen so far have been 8k-aligned.)  The
correct file data picks up again after the hole.

bk is writing the data using stdio in a child process (fork, exec,
wait), then mmaping the result.  The corruption is persistent; he sent
us the s.ChangeSet file and there it was (not a cache or buffering
problem, therefore).

2.6.6-bk (current head of tree from whenever he built), UP PIII, symptom
observed on both ext3 and reiserfs.  (However, we've explicitly verified
the hole only on reiser.)

The problem is intermittent, having happened "several" times over the
last few months, and doesn't appear to be tied to any particular kernel
version.

To me, this looks awfully close to an Ethernet frame size... but that's
just a wild guess.  And I don't think he's running Ethernet (still
waiting for dmesg and .config).

I've asked for more info, memtest86, and will attempt to reproduce it on
another box.

Does anyone have insight into this peculiar problem?

-andy
