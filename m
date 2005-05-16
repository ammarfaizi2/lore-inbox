Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbVEPL1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVEPL1h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 07:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVEPL1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 07:27:37 -0400
Received: from verein.lst.de ([213.95.11.210]:18305 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261541AbVEPL1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 07:27:23 -0400
Date: Mon, 16 May 2005 13:27:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: finding out whether a device supports ordered writes ahead of time
Message-ID: <20050516112722.GA9736@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently ext3 and reiserfs submit bios with BIO_RW_BARRIER and when the
device doesn't support it it returns EOPNOTUPP.  This scheme doesn't
work at all for XFS because our I/O submission path keeps around far too
much state (XFS supports multi-page metadata buffers).  From looking at
the code it seems that we can assume such a submission will just work
if q->ordered is not QUEUE_ORDERED_NONE.  Is that a valid assumption?
and if yes should we look directly at the queue or provide an assecor?
