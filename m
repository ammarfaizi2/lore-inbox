Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263729AbTEYT6j (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 25 May 2003 15:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263731AbTEYT6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 15:58:39 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:12846 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263729AbTEYT6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 15:58:38 -0400
Date: Sun, 25 May 2003 13:15:12 -0700
From: Andrew Morton <akpm@digeo.com>
To: Alistair J Strachan <alistair@devzero.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm9
Message-Id: <20030525131512.45ce0cc2.akpm@digeo.com>
In-Reply-To: <200305251619.40137.alistair@devzero.co.uk>
References: <200305251619.40137.alistair@devzero.co.uk>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 May 2003 20:11:48.0415 (UTC) FILETIME=[DF3EECF0:01C322F9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair J Strachan <alistair@devzero.co.uk> wrote:
>
> 
> These changes don't even get to login for me. I changed the mm9 command line 
> to include init=/bin/sh and got to a prompt. I was able to reproduce an 
> enormous number of oopses by issuing:
> 
> mount -o remount,rw /
> 
> I tried to log it with klogd pointed to a different partition (vfat) but the 
> problem segfaults klogd before it commits anything to disc. I'll probably try 
> to do it via serial console this evening if nobody else can reproduce this.

It sounds like that would be a useful course of action.

> Another oddity is that changing my / partition to ext2 in /etc/fstab and 
> booting normally (i.e., without init=) doesn't make any difference. If these 
> changes are ext3/jbd only, why is my ext3 volume mounted as ext2 still not 
> mounting rw?

Changing fstab will not cause / to be mounted by ext2: the kernel makes the
decision for /.  You may be able to use "rootfstype=" (I don't think I've
ever tried it).

The proper way to convert to ext2 is:

- boot with init=/bin/sh

- /sbin/tune2fs -O ^has_journal /dev/hda1

- /sbin/e2fsck -fy /dev/hda1

- reboot, edit /etc/fstab for the non-root filesystems.


