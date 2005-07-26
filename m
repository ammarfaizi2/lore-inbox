Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbVGZK5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVGZK5B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 06:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVGZKye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 06:54:34 -0400
Received: from dwdmx4.dwd.de ([141.38.3.230]:43202 "EHLO dwdmx4.dwd.de")
	by vger.kernel.org with ESMTP id S261783AbVGZKwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 06:52:44 -0400
Date: Tue, 26 Jul 2005 10:52:30 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@praktifix.dwd.de
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-scsi@vger.kernel.org
Subject: As of 2.6.13-rc1 Fusion-MPT very slow
Message-ID: <Pine.LNX.4.61.0507261025000.22613@praktifix.dwd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On a four CPU Opteron with Fusion-MPT compiled in, I get the following
results (up to 2.6.13-rc3-git7) with hdparm on the first channel with
four disks:

            sdc    74 MB/s
            sdd     2 MB/s
            sde     2 MB/s
            sdf     2 MB/s

On the second channel also with the same type of disks:

            sdg    74 MB/s
            sdh    74 MB/s
            sdi    74 MB/s
            sdj    74 MB/s

All disk are of the same type. Compiling Fusion-MPT as module for the
same kernel I get 74 MB/s for all eight disks. Taking kernel 2.6.12.2 and
compile it in, all eigth disks give the expected performance of 74 MB/s.
When I exchange the two cables, put the first cable on second channel and
second cable on first channel, always sdd, sde and sdf will only get
approx. 2 MB/s with any 2.6.13-* kernels.

Another problem observed with 2.6.13-rc3-git7 and Fusion-MPT compiled in
is when making a ext3 filesystem over those eight disks (software Raid10),
makes mke2fs hang for a very long time in D-state and /var/log/messages
writting a lot of these messages:

        mptscsih: ioc0: >> Attempting task abort! (sc=ffff81014ead3ac0)
        mptscsih: ioc0: >> Attempting task abort! (sc=ffff81014ead38c0)
        mptscsih: ioc0: >> Attempting task abort! (sc=ffff81014ead36c0)
        mptscsih: ioc0: >> Attempting task abort! (sc=ffff81014ead34c0)
           .
           .
           .

And finally, when I do a halt or powerdown just after all filesystems
are unmounted the fusion driver tells me that it puts the two controllers
in power save mode. Then kernel whants to flush the SCSI disks but
hangs forever. This does not happen when doing a reboot.

Holger
-- 

