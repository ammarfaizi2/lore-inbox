Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266195AbUARBQc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 20:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266205AbUARBQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 20:16:32 -0500
Received: from mail0-96.ewetel.de ([212.6.122.96]:60605 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S266195AbUARBQa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 20:16:30 -0500
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: Making MO drive work with ide-cd
In-Reply-To: <1f8mw-3Qk-1@gated-at.bofh.it>
References: <1f8mw-3Qk-1@gated-at.bofh.it>
Date: Sun, 18 Jan 2004 02:16:18 +0100
Message-Id: <E1Ai1Y2-0000cj-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Jan 2004 00:50:04 +0100, you wrote in linux.kernel:

> By some coincidence I got hold of an MO drive today. Under 2.4.21
> and 2.6.1 using ide-scsi all seems to work at first sight.

For me, it doesn't work at all with ide-scsi in 2.6. 2.4 is fine
in that regard.

> With ide-cd I get errors only.
> Not surprising: ide-cd expects a CD so sends READ_TOC and
> gets "illegal request / invalid command" back.
> The appropriate command is READ CAPACITY.

There is a patch by me with some rework by Jens Axboe in -mm that
corrects this situation. It hasn't seen much testing, though.

By the way, what hardware sector size does your MO use? I have
only tested my patch with 2048 byte sector size - everything else
is unlikely to work with ide-cd...
 
> Are there cases where ide-cd is useful?
> Should we retarget ide_optical to ide-scsi?

Please fill the whole disk and then reread and compare via ide-scsi.
That never worked for me in 2.6 using ide-scsi, but it does work
with the patch in -mm.

I agree that the situation in mainline as it is now is undesirable,
only mounting prewritten discs read-only works.

-- 
Ciao,
Pascal
