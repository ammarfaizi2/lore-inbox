Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUIOGdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUIOGdy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 02:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUIOGdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 02:33:54 -0400
Received: from relay2.scripps.edu ([137.131.200.30]:33271 "EHLO
	relay2.scripps.edu") by vger.kernel.org with ESMTP id S261234AbUIOGdv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 02:33:51 -0400
Date: Tue, 14 Sep 2004 23:33:50 -0700 (PDT)
From: Andy Arvai <arvai@scripps.edu>
Message-Id: <200409150633.XAA16537@astra.scripps.edu>
To: linux-raid@vger.kernel.org
Subject: mkraid problem with 2+TB devices
Cc: linux-kernel@vger.kernel.org
X-Sun-Charset: US-ASCII
X-CanItPRO-Stream: admin redirected to 10_OptOut
X-Spam-Score: undef - spam-scanning disabled
X-Canit-Stats-ID: 2802415 - aca833bbcc09
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There's a problem with mkraid creating a raid device where the
individual devices are each over 2TB:

  [root@rad7 3dm2]# mkraid --really-force /dev/md0
  DESTROYING the contents of /dev/md0 in 5 seconds, Ctrl-C if unsure!
  handling MD device /dev/md0
  analyzing super-block
  couldn't get device size for /dev/sdb -- File too large
  mkraid: aborted.
  (In addition to the above messages, see the syslog and /proc/mdstat as well
   for potential clues.)

The kernel (2.6.8-1) is able to read the device, although with a warning:

  Aug 26 16:38:59 localhost kernel: sdb : very big device. try to use READ CAPACITY(16).
  Aug 26 16:38:59 localhost kernel: SCSI device sdb: 4687368192 512-byte hdwr sectors (2399933 MB)
 
I assume mkraid needs to do something like use READ CAPACITY(16).
There's a similar problem with mdadm and I've discussed this with Neil
Brown who plans to fix it. I don't know if mkraid is being actively
maintained, but if someone does come up with a patch soon, then
I would be willing to try it.

Andy
