Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbTENHWc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 03:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbTENHWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 03:22:32 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:2442 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262143AbTENHWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 03:22:31 -0400
Date: Wed, 14 May 2003 00:37:00 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       axel@pearbough.net, axboe@suse.de
Subject: Re: drivers/scsi/aic7xxx/aic7xxx_osm.c: warning is error
Message-ID: <20030514073700.GA3151@beaverton.ibm.com>
Mail-Followup-To: "Justin T. Gibbs" <gibbs@scsiguy.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, axel@pearbough.net, axboe@suse.de
References: <20030514004009.GA20914@neon.pearbough.net> <20030514031826.GB29926@holomorphy.com> <493702704.1052892304@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <493702704.1052892304@aslan.scsiguy.com>
X-Operating-System: Linux 2.0.32 on an i486
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin T. Gibbs [gibbs@scsiguy.com] wrote:
> Comments have indicated since the 2.4.X days that Linux will never allocate
> segments that cross a 4GB boundary.  If this is truely enforced, then this
> code can just be removed.  It was only added out of paranoia (hence the
> printf) while adding high address support to the driver.

Jens can give the more complete answer on enforcement, and also correct
any mis-statements I made.

Base on the queue values below the aic7xxx driver should see the
following characteristics on IO. The IO should be for no more than 8k
made up of no more than 128 sg entries with no segment crossing the
seg_boundary_mask.

Adaptec AIC7xxx driver version: 6.2.33
scsi_alloc_queue: queue for aic7xxx
bounce_pfn: 0xfffff
bounce_gfp: 0x10 (GFP_NOIO)
queue_flags: 0x1 (QUEUE_FLAG_QUEUED)
max_sectors: 0x2000 (8192)
max_phys_segments: 0x80 (128)
max_hw_segments: 0x80 (128)
hardsect_size: 0x200 (512)
max_segment_size: 0x10000 (65536)
seg_boundary_mask: 0xffffffff
dma_alignment: 0x1ff (511)

-andmike
--
Michael Anderson
andmike@us.ibm.com

