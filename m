Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273688AbRIWX2O>; Sun, 23 Sep 2001 19:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273691AbRIWX2E>; Sun, 23 Sep 2001 19:28:04 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30227 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S273688AbRIWX14>;
	Sun, 23 Sep 2001 19:27:56 -0400
Date: Mon, 24 Sep 2001 01:28:01 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: arjanv@redhat.com, "David S. Miller" <davem@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] block highmem zero bounce v15
Message-ID: <20010924012801.H2154@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-RBL-Warning: (relays.orbs.org) 
X-RBL-Warning: (inputs.orbs.org) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've uploaded a new version of the patch that allows direct I/O to
highmem memory without resorting to bouncing to lower memory. Changes
since last time include:

- Update to 2.4.10

- Fix SCSI dont-merge error. No corruption, just a performance
  hit (me)

- Add single_sg_ok entry to SCSI hosts. An alternative solution would be
  to always bounce single entry sg for highmem pages, however I don't
  want decent drivers to take a hit on account of crap drivers. Now the
  entire I/O path should be unaffected for non-highmem enabled
  hosts/drivers. (me)

ATM only aic7xxx and sym53c8xxx have single_sg_ok enabled, others will
follow on a per-audit basis.

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.10/block-highmem-all-15

-- 
Jens Axboe

