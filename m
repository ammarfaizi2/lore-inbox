Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbUARMVB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 07:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbUARMVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 07:21:01 -0500
Received: from hera.cwi.nl ([192.16.191.8]:33504 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261411AbUARMU7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 07:20:59 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 18 Jan 2004 13:20:51 +0100 (MET)
Message-Id: <UTC200401181220.i0ICKpx05161.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, der.eremit@email.de
Subject: Re: Making MO drive work with ide-cd
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From der.eremit@email.de  Sun Jan 18 02:16:30 2004
    From: Pascal Schmidt <der.eremit@email.de>

    > By some coincidence I got hold of an MO drive today. Under 2.4.21
    > and 2.6.1 using ide-scsi all seems to work at first sight.

    For me, it doesn't work at all with ide-scsi in 2.6. 2.4 is fine
    in that regard.

    Please fill the whole disk and then reread and compare via ide-scsi.
    That never worked for me in 2.6 using ide-scsi, but it does work
    with the patch in -mm.

Yes, you are right. Yesterday night I tried a small amount of I/O,
and that worked fine, but today the kernel couldn't cope with a diff
between two 640MB trees.
Unable to handle kernel paging request at virtual address 6b6b6b6b.
Followed by a bad kernel crash (vanilla 2.6.1).

OK. So, just like the rumours said already, ide-scsi is badly broken.

Since small amounts of I/O work - a race somewhere? bad locking?

    > With ide-cd I get errors only.
    > Not surprising: ide-cd expects a CD so sends READ_TOC and
    > gets "illegal request / invalid command" back.
    > The appropriate command is READ CAPACITY.

    There is a patch by me with some rework by Jens Axboe in -mm that
    corrects this situation. It hasn't seen much testing, though.

OK, will find that and try later.

    By the way, what hardware sector size does your MO use? I have
    only tested my patch with 2048 byte sector size - everything else
    is unlikely to work with ide-cd...

It uses media with 512-byte and media with 2048-byte sectors.
     
    > Are there cases where ide-cd is useful?
    > Should we retarget ide_optical to ide-scsi?

    I agree that the situation in mainline as it is now is undesirable,
    only mounting prewritten discs read-only works.

Yes. We must find out what is wrong in ide-scsi and fix it.

Andries

