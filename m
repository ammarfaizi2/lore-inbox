Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265517AbUHFKGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265517AbUHFKGb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 06:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268113AbUHFKGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 06:06:31 -0400
Received: from users.linvision.com ([62.58.92.114]:42477 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S265517AbUHFKG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 06:06:29 -0400
Date: Fri, 6 Aug 2004 12:06:28 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: linux-kernel@vger.kernel.org
Subject: Caching. 
Message-ID: <20040806100628.GA23325@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On our server we run: 

Linux version 2.4.25-rmap-nonapi (root@obelix) (gcc version 2.95.4
  20011002 (Debian prerelease)) #1 SMP Tue Jun 15 13:35:04 CEST 2004

I have this file: 

 249412 -rw-rw-r--    2 wolff    hdr      1073741824 Aug  5 15:21 disk.img3

which takes some 250Mb on disk, but is 1Gb in size. It's sparse. 

When I repeatedly GREP trhough this file, I see large amounts of the
file being reread from disk every time, even though the machine easily
has enough memory to cache the whole 250Mb of diskblocks that the file
compromises.

The server has 1Gb of memory. 

To be sure the memory was free, I created a 900Mb application that
would run-and-touch all it's memory. Killing that would leave the
machine with "900Mb free" (actualy just over 908000 kb). Then running
the multiple searches would still page in about half the pages that
should have been cached.

Even when the file on disk only takes about 1Mb of disk space, still
500 of the 1000 kbytes of data on the disk was read every time through
the loop.

My "task at hand" will be done by the time anybody reads this, but
kernel-memory managing could be better, and someone might want to take
a look what's going on.

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
