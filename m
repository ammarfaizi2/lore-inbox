Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbVJDTs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbVJDTs6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 15:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbVJDTs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 15:48:58 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:50513 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S964941AbVJDTs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 15:48:57 -0400
Message-ID: <4342DCB1.7080405@tls.msk.ru>
Date: Tue, 04 Oct 2005 23:49:05 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Debian Thunderbird 1.0.2 (X11/20050817)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: David Leimbach <leimy2k@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: /etc/mtab and per-process namespaces
References: <3e1162e60510021508r6ef8e802p9f01f40fcf62faae@mail.gmail.com> <3e1162e60510041214t3afd803re27b742705d27900@mail.gmail.com> <20051004191818.GA31328@infradead.org>
In-Reply-To: <20051004191818.GA31328@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> I suspect not one cares about /etc/mtab.  It's a pretty horrible
> interface.  Use /proc/self/mounts if your care about the mount table
> for your current namespace, it's guranteed uptodate.

Well, it's uptodate, but it isn't the same as mtab.  Like:

   /tmp/test on /mnt/test type ext2 (rw,loop=/dev/loop/0)
(mtab), vs
   /dev/loop/0 /mnt/test ext2 rw 0 0

or:

  tmpfs on /dev type tmpfs (rw,size=10M,mode=0755)
vs
  tmpfs /dev tmpfs rw 0 0

ie, sometimes, mtab format is more useful.  Also, with the
above example with loop device, umount is able to delete the
loop device for loop-mounts.

Another funky example:

   losetup /dev/loop/0 /tmp/test
   cd /dev/loop
   mount 0 /mnt/test

now, mtab shows:

   /dev/loop/0 /mnt/test ext2 rw 0 0

while /proc/mounts shows

   0 /mnt/test ext2 rw 0 0

which is rather useless.

/mjt
