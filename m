Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVDUGww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVDUGww (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 02:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVDUGww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 02:52:52 -0400
Received: from colino.net ([213.41.131.56]:35834 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S261238AbVDUGwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 02:52:47 -0400
Date: Thu, 21 Apr 2005 08:52:37 +0200
From: Colin Leroy <colin@colino.net>
To: Klaus Halfmann <klaus.halfmann@t-online.de>, ")"@colino.net
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: hpfsck question
Message-ID: <20050421085237.14376aef@colin.toulouse>
X-Mailer: Sylpheed-Claws 1.9.6 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Klaus,

Yesterday I tried to mount my iPod as usual, but the hfsplus kernel
module complained the following:

  HFS+-fs warning: Filesystem was not cleanly unmounted, running
  fsck.hfsplus is recommended.  mounting read-only.

So I installed your hfsplusutils package and ran hpfsck. After that I
tried to remount /dev/sda3, and sure enough, the kernel spit out the
same message.

After a bit of time debugging what was wrong during the hpfsck run, I
found out that the filesystem is opened read-only:

    result = fscheck_volume_open(&vol, device, HFSP_MODE_RDONLY);

Hence, the volume_close() call couldn't write anything like
HFSPLUS_VOL_UNMNT in the FS' attributes... Once I changed that to open
the device read-write, the next mount attempt worked. Is there any
reason why hpfsck would attempt to fix a filesystem read-only ?

-- 
Colin
