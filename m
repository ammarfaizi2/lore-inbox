Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbTI1B45 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 21:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbTI1B45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 21:56:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7079 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262301AbTI1B4z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 21:56:55 -0400
Date: Sun, 28 Sep 2003 02:56:52 +0100
From: Matthew Wilcox <willy@debian.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: min_not_zero()
Message-ID: <20030928015652.GY24824@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a thought ...

#define min_not_zero(l, r) \
	min((unsigned long)(l - 1), (unsigned long)(r - 1)) + 1

Seems to me that'll always give the right answer ... 0 if both 0,
otherwise the lower of the two.  And it's kind of an awkward name.
How about making it *really* specific to request_queue, putting it in
blkdev.h and calling it request_sector_min() like so:

#define request_sector_min(a, b) \
	min((a)->max_sectors - 1, (b)->max_sectors - 1) + 1

(no cast needed cos they're already unsigned.  um, unless I've misremembered
how C constants work again... should they be 1U?)

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
