Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317393AbSFRMT3>; Tue, 18 Jun 2002 08:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317394AbSFRMT1>; Tue, 18 Jun 2002 08:19:27 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30625 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317393AbSFRMSq>;
	Tue, 18 Jun 2002 08:18:46 -0400
Date: Tue, 18 Jun 2002 14:18:46 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] block-highmem-all-19
Message-ID: <20020618121846.GC814@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In preparation of 2.4.20-pre, here's an updated version of the
block-highme patch. This enables block drivers to do I/O to high memory
pages instead of reverting to low memory bounce buffers.

Changes:

- (scsi) Fix critical SCpnt->request_buffer -> SCpnt->request.buffer
  error

- (scsi) Backport __init_io() changes from 2.5, that enable us to
  politely back off on queueing more I/O with any failure. We use this
  now instead of reverting to single segment requests on sgtable
  allocation failures. For a highmem host this got nasty, because we had
  to map the buffer_head and use a bounce buffer for that single segment
  anyway. That is now eliminated. Even for non-highmem I/O the single
  segment fall back is slower because of the over head associated with
  command setup etc.

*.kernel.org/pub/linux/kernel/people/axboe/patches/v2.4/2.4.19-pre10/block-highmem-all-19.bz2

Enjoy,
-- 
Jens Axboe

