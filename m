Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267348AbUHEEXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267348AbUHEEXj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 00:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267473AbUHEEXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 00:23:38 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:2179 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267348AbUHEEXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 00:23:30 -0400
Date: Thu, 5 Aug 2004 10:03:01 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: akpm@osdl.org
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Various AIO retry related fixes and enhancements
Message-ID: <20040805043301.GA3532@in.ibm.com>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patches are a collection of various (mostly 
retry infrastructure related) fixes, cleanups and enhancements
for AIO, that I have been maintaining for a while. I ran into
most of them while implementing support for default high
level retry methods (should also be helpful as a foundation
for some network AIO work). Now that we have in-tree use 
of the retry logic, it makes sense to merge these fixes 
upstream. They are mostly localised to AIO code.

Note: The latter two patches involve policy oriented 
optimizations to the AIO workqueue usage, so I chose 
to separate them out.

Please apply.

[1] aio-retry.patch
  Collection of AIO retry infrastructure fixes and enhancements
  AIO: Split iocb setup and execution in io_submit 
       (also fixes io_submit error reporting)
  AIO: Default high level retry methods
  AIO: Subtle use_mm/unuse_mm fix
  AIO: Code commenting
  AIO: Fix aio process hang on EINVAL (Daniel McNeil)
  AIO: flush workqueues before destroying ioctx'es 
  AIO: hold the context lock across unuse_mm
  AIO: Acquire task_lock in use_mm()
  AIO: Allow fops to override the retry method with their own
  AIO: Elevated ref count for AIO retries (Daniel McNeil)
  AIO: set_fs needed when calling use_mm
  AIO: flush workqueue on __put_ioctx (Chris Mason)
  AIO: Fix io_cancel to work with retries (Chris Mason)
  AIO: read-immediate option for socket/pipe retry support

[2] aio-splice-runlist.patch
  AIO: Splice runlist to be fairer across multiple io contexts

[3] aio-context-switch.patch
  AIO: Context switch reduction for retries (Chris Mason)
  AIO: Fix IO stalls with context switch reduction changes
	(Chris Mason)

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

