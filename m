Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266915AbUGNBrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266915AbUGNBrk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 21:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266924AbUGNBrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 21:47:39 -0400
Received: from larry.aptalaska.net ([64.186.96.3]:57318 "EHLO
	larry.aptalaska.net") by vger.kernel.org with ESMTP id S266915AbUGNBrh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 21:47:37 -0400
Message-ID: <40F490B6.6000106@schu.net>
Date: Tue, 13 Jul 2004 17:47:34 -0800
From: Matthew Schumacher <schu@schu.net>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Possible bug with kernel decompressor.
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

List,

I think I found a bug here because I can repeatably get the same kernel 
(checked with md5sum) to decompress and to fail with the error:

invalid compressed format (err=2)

   --System halted


Here is how I can reproduce the problem:

Boot 2.6.8-rc1
Run md5sum on 2.6.8-rc1 kernel
Turn power off (this is an embedded system with only ramdisk mounted)
Turn power on
Kernel fails to boot with "invalid compressed format (err=2)"
Restart system
Boot 2.4.26
Run md5sum on 2.6.8-rc1 kernel (matches md5sum above)
Shutdown properly
boot 2.6.8-rc1 (works fine)
Run md5sum on 2.6.8-rc1 kernel (matches md5sum above)

So you see if I don't shutdown properly (which shouldn't be required for 
an embedded system using a ramdisk) my kernel won't decompress itself 
until I run another kernel and shutdown properly.  I know that the 
kernel didn't change so something else must be causing it to fail.

I call this a bug simply because a power failure could cause someone to 
loose the ability to boot their machine.

Here is the hardware:
Whistle Interjet (486 SBC)
64MB of memory
IDE disk.
Can reproduce with linux  2.6.5, 2.6.6, 2.6.7, and 2.6.8-rc1
Both kernel images and the initrd image both live on a fat16 partition 
and are started with syslinux.  I can reproduce this problem with any 
version of syslinux I have tried.

Please CC me in any replies since I am not on the list.

Thanks,

schu


