Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271203AbTHNW67 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 18:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271283AbTHNW67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 18:58:59 -0400
Received: from pu29.warszawa.cvx.ppp.tpnet.pl ([217.99.4.29]:40201 "EHLO
	satan.blackhosts") by vger.kernel.org with ESMTP id S271203AbTHNW65
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 18:58:57 -0400
Date: Fri, 15 Aug 2003 00:54:37 +0200
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: "attempt to access beyond end of device" on ide-scsi+sr_mod in 2.6.0-test3
Message-ID: <20030814225437.GA31481@satan.blackhosts>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I mounted my CDRW disk with isofs through ide-scsi as I used to do
in Linux 2.4 (drive is CD recorder, and I'm using 2.6 for testing, so
I haven't changed configuration for direct ATAPI writing).
I successfully read some files, but when I was trying to read more,
I/O errors occurred. Kernel said:
kernel: attempt to access beyond end of device
kernel: sr0: rw=0, want=315596, limit=307404
kernel: Buffer I/O error on device sr0, logical block 78898
kernel: attempt to access beyond end of device
kernel: sr0: rw=0, want=315600, limit=307404
kernel: Buffer I/O error on device sr0, logical block 78899
[...etc., many times...]

I unmounted and mounted again the same disk and everything was OK
- I couldn't repeat that errors. That disk contained ~222MB of data.

But when I inserted _larger_ CD (over 500MB of data) and tried to read
some files, I/O errors happened again:
kernel: attempt to access beyond end of device
kernel: sr0: rw=0, want=1270892, limit=453448
kernel: Buffer I/O error on device sr0, logical block 317722
kernel: attempt to access beyond end of device
kernel: sr0: rw=0, want=1270896, limit=453448
kernel: Buffer I/O error on device sr0, logical block 317723
[...]

But see - now limit matches the _previous_ disk!
unmounting and mounting the same disk helped again.
(I've made even more tests to confirm this)

It seems that kernel updates some device block count too late (after
some data reads?), remembering count for _previous_ mounted disk, not
the current one.

This behaviour is specific for sr_mod and/or ide-scsi.
When I mounted CD through plain ide-cd, such errors didn't happen.


PS. please Cc answers to me

-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Linux       http://www.pld-linux.org/
