Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266907AbTGHJHk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 05:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266909AbTGHJHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 05:07:39 -0400
Received: from ns2.uk.superh.com ([193.128.105.170]:27827 "EHLO
	ns2.uk.superh.com") by vger.kernel.org with ESMTP id S266907AbTGHJHe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 05:07:34 -0400
Date: Tue, 8 Jul 2003 10:21:28 +0100
From: Richard Curnow <Richard.Curnow@superh.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.22-pre4 won't link without CONFIG_QUOTA
Message-ID: <20030708092128.GB5725@malvern.uk.w2k.superh.com>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-OS: Linux 2.4.19 i686
X-OriginalArrivalTime: 08 Jul 2003 09:22:01.0560 (UTC) FILETIME=[6371F580:01C34532]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

I'm building without quota support.  I get the following error at link
time:

fs/fs.o(.text..SHmedia32+0x33fa0): In function `v1_get_stats':
: undefined reference to `dqstats'
fs/fs.o(.text..SHmedia32+0x33fa4): In function `v1_get_stats':
: undefined reference to `dqstats'
make: *** [vmlinux] Error 1

Looking in fs/Makefile, fs/quota.c it's apparent that quota.o is being
included unconditionally in the link now, and quota.c references
dqstats, but dqstats is defined in fs/dquot.c which is only linked in if
CONFIG_QUOTA is set.

I'm sorry I'm not familiar enough with this area of the code to suggest
a fix.

Cheers
Richard

-- 
Richard \\\ SuperH Core+Debug Architect /// .. At home ..
  P.    /// richard.curnow@superh.com  ///  rc@rc0.org.uk
Curnow  \\\ http://www.superh.com/    ///  www.rc0.org.uk
