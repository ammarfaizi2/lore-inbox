Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262183AbVBVAmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbVBVAmP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 19:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVBVAmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 19:42:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57240 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262183AbVBVAmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 19:42:01 -0500
Date: Mon, 21 Feb 2005 16:41:51 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
       zaitcev@redhat.com
Subject: Re: Merging fails reading /dev/uba1
Message-ID: <20050221164151.0a63f906@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.58.0502211152330.2378@ppc970.osdl.org>
References: <20050220200059.53db7b1e@localhost.localdomain>
	<20050221075131.GT4056@suse.de>
	<20050221102431.64de6c6c@localhost.localdomain>
	<Pine.LNX.4.58.0502211152330.2378@ppc970.osdl.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2005 12:00:48 -0800 (PST), Linus Torvalds <torvalds@osdl.org> wrote:

> That said, I'm surprised that the difference in performance is _that_ 
> large. Regardless of whether the disk blocksize is 512 bytes or 4096 
> bytes, you should be getting IO merging - it might use more CPU time, but 
> the actual IO should still be done in much larger blocks.

I am surprised too. Jens says "ub effectively disables merging by setting
max hw/phys segment limit of 1." But surely this ought not to be a problem
for reads within the same page.

> 	int size = 4096;
> 	ioctl(fd, BLKBSZSET, &size);

Thank you for the tip. This works fine, 4KB I/O is restored for dd.
However, I still have this problem with people who use ub to read CF sticks
from their cameras, mounted as FAT or VFAT. I verified that the effect of
this ioctl disappears at mount time, just as you said.

I'll think what I can do about it.

-- Pete
