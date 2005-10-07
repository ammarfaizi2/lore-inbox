Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932528AbVJGNNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbVJGNNg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 09:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbVJGNNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 09:13:36 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:52560 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S932528AbVJGNNf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 09:13:35 -0400
Message-ID: <4346747C.2080903@tls.msk.ru>
Date: Fri, 07 Oct 2005 17:13:32 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050817)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: kernel freeze (not even an OOPS) on remount-ro+umount when using
 quotas
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is something that has biten me quite successefully
in last few days... ;)

To make a long story short:

 # mke2fs -j /dev/hda6
 # mount -o usrquota /dev/hda6 /mnt
 # cp -a /home /mnt                # to make some files to work with
 # quotacheck -uc /mnt
 # quotaon /mnt
 # mount -o remount,ro             # this is the important step!
 # ls -l /mnt /mnt/home            # to do "something" (also important)
 # umount /mnt

At this time (attempting to umount the read-only filesystem with quotas
enabled), the machine freezes without any messages on the console.  No
OOPS, no response, no nothing - until a hard reboot (powercycle).

This happens on 2.6.11, 2.6.12 and 2.6.13 kernels -- ie, with "current"
kernel release.

According to the themperature sensors on my test laptop and CPU fan
behaviour, the kernel goes to some infinite loop at this point, because
the fan starts rotating in a few sec after the freeze.

This happens with both quota_v1 and quota_v2.

Note that it isn't 100% reproduceable - sometimes it umounts
ok, sometimes (rare) there's no need to do that pre-final
'ls -l', and sometimes more "work" is needed around remount-ro
to trigger the freeze.

The filesystem is ext3.

Any hints on the way to debug the problem?

Thanks.

/mjt
