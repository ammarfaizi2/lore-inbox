Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262694AbULPPeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbULPPeg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 10:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbULPPeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 10:34:36 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:51104 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262694AbULPPeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 10:34:18 -0500
Date: Thu, 16 Dec 2004 16:34:16 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Time sliced cfq ver17
Message-ID: <20041216153416.GC23414@suse.de>
References: <20041215082004.GO3157@suse.de> <20041215120323.GT3157@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041215120323.GT3157@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.6.10-rc3-mm1 patch:

http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.6/2.6.10-rc3-mm1/cfq-time-slices-17-2.6.10-rc3-mm1.gz

2.6-BK patch:

http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.6/2.6.10-rc3/cfq-time-slices-17.gz

Changes:

- Kill the spare queue logic

- wait_request should not imply that queue must be allowed to allocate a
  request, otherwise a write could quickly flood the queue. Add
  must_alloc to handle that and make it one-shot.

- Turn on/off idle window based on process think time and seek time.
  Improve idle timer logic. The seek/think time updates toggle the
  idle_window flag and increase queuing depth if we disable the idle
  window.

- Improve SCSI requeing logic. Add request fully back into cfq queue but
  mark it as next service once this queue gets slice time again.

- More preemption fixes. Allow new sync io to preempt equal priority
  async io to improve reader fairness.

-- 
Jens Axboe

