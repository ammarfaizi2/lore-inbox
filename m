Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263214AbUCXKRW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 05:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263258AbUCXKRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 05:17:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:39844 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263214AbUCXKRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 05:17:20 -0500
Date: Wed, 24 Mar 2004 11:17:17 +0100
From: Jens Axboe <axboe@suse.de>
To: slindber@uiuc.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Problem]: "access beyond end" of DVD-R
Message-ID: <20040324101717.GL3377@suse.de>
References: <21ddee39.25333f6f.81c3b00@expms3.cites.uiuc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21ddee39.25333f6f.81c3b00@expms3.cites.uiuc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22 2004, slindber@uiuc.edu wrote:
> attempt to access beyond end of device
> hdc: rw=0, want=8174536, limit=8123200
> Buffer I/O error on device hdc, logical block 2043633
> 
> There are more attempt to "access beyond end of device" messages, but
> they are similar so I've snipped them.
> 
> I've had this problem on every kernel I've used (2.4.22 and 2.6.3 from
> gentoo, and 2.6.4-rc1-mm1).  I've had it with three different discs,
> ISO, ISO/UDF, and UDF only (the output comes from the last disc).  The
> entire disc is readable in Windows.

Does this make a difference for you (2.6 patch)?

===== drivers/ide/ide-cd.c 1.75 vs edited =====
--- 1.75/drivers/ide/ide-cd.c	Tue Mar 16 09:39:41 2004
+++ edited/drivers/ide/ide-cd.c	Wed Mar 24 11:16:22 2004
@@ -2372,7 +2372,7 @@
 
 	/* Now try to get the total cdrom capacity. */
 	stat = cdrom_get_last_written(cdi, &last_written);
-	if (!stat && last_written) {
+	if (!stat && (last_written > toc->capacity)) {
 		toc->capacity = last_written;
 		set_capacity(drive->disk, toc->capacity * sectors_per_frame);
 	}

-- 
Jens Axboe

