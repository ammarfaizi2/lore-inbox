Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265665AbUEZQyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265665AbUEZQyW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 12:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265706AbUEZQyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 12:54:21 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:43263 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S265665AbUEZQwz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 12:52:55 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] 0/5: Device-Mapper bug-fixes and cleanups
Date: Wed, 26 May 2004 11:52:33 -0500
User-Agent: KMail/1.6
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405261152.33233.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Revision 1:
  dm-ioctl.c: Fix an OB1 error when calculating an output buffer size,
  that could cause a missing null termininator in the 'list devices'
  ioctl results.  [Steffan Paletta]

Revision 2:
  In __map_bio(), if the target returns an error while mapping the I/O, the
  cloned bio needs to be freed.

Revision 3:
  Replace dm_[add|remove]_wait_queue() with dm_wait_event().

  Some testing of DM multipath has turned up a problem with the DEVICE_WAIT
  command. In the tests, while performing a DEVICE_WAIT on a multipath device,
  the command sometimes returns immediately, even though the event-number is
  correct and no path-failure has occurred to trigger an event. The problem
  was tracked down to the call to schedule() in dev_wait(), which would return
  even though it was not woken up by a DM table event.

  This patch moves the responsibility for waiting from the ioctl interface
  into the core driver, and uses wait_event_interruptible() instead of relying
  on wait-queues and schedule().

Revision 4:
  DM: Add static and __init qualifiers. [Dave Olien]

Revision 5:
  dm-table.c: Proper usage of dm_vcalloc. [Dave Olien]
