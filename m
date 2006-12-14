Return-Path: <linux-kernel-owner+w=401wt.eu-S1751335AbWLNFU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWLNFU4 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 00:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWLNFU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 00:20:56 -0500
Received: from mtiwmhc11.worldnet.att.net ([204.127.131.115]:39007 "EHLO
	mtiwmhc11.worldnet.att.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751335AbWLNFUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 00:20:55 -0500
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 00:20:55 EST
Message-ID: <4580DD6F.8060907@lwfinger.net>
Date: Wed, 13 Dec 2006 23:13:19 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Mike Christie <michaelc@cs.wisc.edu>, LKML <linux-kernel@vger.kernel.org>,
       Jens Axboe <jens.axboe@oracle.com>
Subject: Regression in v2.6.19-git18: Unable to write CD
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a regression in v2.6.19-rc18 that makes one unable to write CD's. In k3b, the drive status 
shows no devices. I used git bisect to find the bad commit is the following:

0e75f9063f5c55fb0b0b546a7c356f8ec186825e is first bad commit
commit 0e75f9063f5c55fb0b0b546a7c356f8ec186825e
Author: Mike Christie <michaelc@cs.wisc.edu>
Date:   Fri Dec 1 10:40:55 2006 +0100

     [PATCH] block: support larger block pc requests

     This patch modifies blk_rq_map/unmap_user() and the cdrom and scsi_ioctl.c
     users so that it supports requests larger than bio by chaining them together.

     Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
     Signed-off-by: Jens Axboe <jens.axboe@oracle.com>

:040000 040000 e8ca778ffe67908f24bb7bdf2e7f2e86c64c9d73 cc8c200f9e4b690b6ead717ecb8ff3687a2b5179 M
     block
:040000 040000 512435f7df5397c515a27a58b944f553697c6902 f7eab7589a5950dd589d44015f02973f717da8c2 M
     drivers
:040000 040000 c589bd48a88bffabbaaffb83a64aa8d484797991 717277cb369c0cb46301115285421de087825843 M
     fs
:040000 040000 5083595bd2ac0c60764ac8dfe627bec09726edb8 874a14cb29cfda0c1dfe7b05638ac8304b1bd423 M
     include


Larry
