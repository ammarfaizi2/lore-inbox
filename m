Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265325AbUATJok (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 04:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265332AbUATJok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 04:44:40 -0500
Received: from hera.cwi.nl ([192.16.191.8]:61102 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S265325AbUATJoi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 04:44:38 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 20 Jan 2004 10:44:27 +0100 (MET)
Message-Id: <UTC200401200944.i0K9iRE25868.aeb@smtp.cwi.nl>
To: der.eremit@email.de, torvalds@osdl.org
Subject: Re: [PATCH] fix for ide-scsi crash
Cc: Andries.Brouwer@cwi.nl, akpm@osdl.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From torvalds@osdl.org  Tue Jan 20 08:33:03 2004

    > This patch seems to solve all my 2.6 ide-scsi problems.

    I've applied the fix part of it and pushed it out.

Good.

    If Andries wants to
    re-send the whitespace fixes, I can apply those too, but I hate applying 
    patches like this where the whitespace fixes hide the real fix.

Yes, it seems we presently have no good mechanism / policy here.
Patches are noise. If some kernel version works and another doesnt,
one has to look at the diffs. Whitespace-only diffs are bad,
I would never submit them. They also needlessly invalidate existing patches.

On the other hand, nice, readable kernel sources are important.
I used to polish the immediate neighbourhood of an actual change.
If that is undesirable, what would you prefer?

    > Andrew, you can drop the atapi-mo-support patches from -mm if you
    > like. That patch only works with 2048 byte sector discs, while
    > the ide-scsi/sd solution also works with 512 and 1024 byte sector
    > discs.

    I'd really like the ATA cdrom driver to handle different sector sizes 
    properly. There really is no excuse for a block device driver to hardcode 
    its blocksize if it can avoid it.

Yes, it is very easy to change that.
And another thing that is very easy is to move partitioning away
from the individual block devices. It was part of the stuff I did
last year. Hope to try again for 2.7.
And then there is the read-only part that must be removed.

Those are three reasons why ide-cd today doesnt work so well
with optical disks. But I am not sure it is desirable to make
ide-cd work with them. The source would be littered with ifs -
all this toc stuff is inappropriate for disks.

Andries




