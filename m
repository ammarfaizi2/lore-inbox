Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267712AbUHPPSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267712AbUHPPSs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 11:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267693AbUHPPRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 11:17:35 -0400
Received: from vsmtp14.tin.it ([212.216.176.118]:56998 "EHLO vsmtp14.tin.it")
	by vger.kernel.org with ESMTP id S267712AbUHPPPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 11:15:49 -0400
Subject: Packet writing problems
From: Frediano Ziglio <freddyz77@tin.it>
To: petero2@telia.com, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1092669361.4254.24.camel@freddy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 16 Aug 2004 17:16:02 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to do packet writing with my new DVD writer.

# cat /proc/ide/hdc/model
PIONEER DVD-RW DVR-107D

dma enabled.
After some tests with 2.4 I decided to switch to 2.6.
I used Fedora Core 2 with a vanilla kernel 2.6.8.1 + patch from
http://w1.894.telia.com/~u89404340/patches/packet/2.6/, udftools with
Petero patch (http://w1.894.telia.com/~u89404340/patches/packet/, same
site and author).

However I get a lot of problems mount/unmounting devices...

DVD+RW
mkudffs /dev/hdc does not works... doing a strace opening /dev/hdc for
read/write open returns EROFS (or similar). I tried with blockdev
--setrw but still same errors... Than I used pktsetup. mkudffs with
packet device (/dev/pktcdvd/test) worked so I mounted it (still /dev/hdc
report readonly so I used /dev/pktcdvd/test). I copied a directory (4
MB) an deleted it. Then I unmounted device and then waited... after a
while DVD led turned off and DVD spin down... umount command still not
exited... I waited 20 minutes but still hangs so I restarted my PC.

DVD-RW
After a lot of tests I realized that I have to use dvd+rw-format with
-force=full cause DVD was not empty. Then I used pktsetup and mkudffs
(with no problem). I tried to mount my DVD but mount (not umount) hangs.
Using ps it seems than mount call wait_to_buffer. After 10/15 minutes I
restarted my PC...

I have also a SCSI CD recorder (Waitec WT4260) and a CDRW formatted with
UDF (using 2.4.23 and an old patch from Petero site) and it works
without problems... Is the problem related to IDE or to DVD ??

I'm not (still :) ? ) a linux guru and I don't know how to debug or what
check should I execute... Should I send my .config ? Stop some daemons ?
Work without X ?

freddy77


