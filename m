Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278364AbRKHVLr>; Thu, 8 Nov 2001 16:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278325AbRKHVLh>; Thu, 8 Nov 2001 16:11:37 -0500
Received: from [139.84.194.100] ([139.84.194.100]:19083 "EHLO
	eclipse.pheared.net") by vger.kernel.org with ESMTP
	id <S278364AbRKHVLc>; Thu, 8 Nov 2001 16:11:32 -0500
Date: Thu, 8 Nov 2001 16:10:51 -0500 (EST)
From: Kevin <kevin@pheared.net>
To: Pete Zaitcev <zaitcev@redhat.com>
cc: Cotte@de.ibm.com, <linux-kernel@vger.kernel.org>, <Linux390@de.ibm.com>
Subject: Re: if (a & X || b & ~Y) in dasd.c
In-Reply-To: <20011108155749.A24023@devserv.devel.redhat.com>
Message-ID: <Pine.GSO.4.40.0111081607110.8007-100000@eclipse.pheared.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2001, Pete Zaitcev wrote:

[zaitce] Date: Thu, 8 Nov 2001 15:57:49 -0500
[zaitce] From: Pete Zaitcev <zaitcev@redhat.com>
[zaitce] To: Cotte@de.ibm.com
[zaitce] Cc: linux-kernel@vger.kernel.org, Linux390@de.ibm.com
[zaitce] Subject: if (a & X || b & ~Y) in dasd.c
[zaitce]
[zaitce] Carsten and others:
[zaitce]
[zaitce] this code in 2.2.14 looks suspicious to me:
[zaitce]
[zaitce] ./drivers/s390/block/dasd.c:
[zaitce]         /* first of all lets try to find out the appropriate era_action */
[zaitce]         if (stat->flag & DEVSTAT_FLAG_SENSE_AVAIL ||
[zaitce]             stat->dstat & ~(DEV_STAT_CHN_END | DEV_STAT_DEV_END)) {
[zaitce]                 /* anything abnormal ? */
[zaitce]                 if (device->discipline->examine_error == NULL ||
[zaitce]                     stat->flag & DEVSTAT_HALT_FUNCTION) {
[zaitce]                         era = dasd_era_fatal;
[zaitce]                 } else {
[zaitce]                         era = device->discipline->examine_error (cqr, stat);
[zaitce]                 }
[zaitce]                 DASD_DRIVER_DEBUG_EVENT (1, dasd_int_handler," era_code %d",
[zaitce]                                          era);
[zaitce]         }
[zaitce]
[zaitce] Are you sure any parenthesises are not needed here?

I'm not going to pretend to know what the code is accomplishing, but as
a matter of C, those &'s aren't the same as &&'s and will get executed as
the || is tested.  So the first one will get &'ded and if false then the
second will and if neither return true then we move on.

Or, perhaps I'm being an idiot and misunderstanding the question and the
code.  In that case, I'll pretend I didn't say anything.  :)

-[ kevin@pheared.net                 devel.pheared.net ]-
-[ Rather be forgotten, than remembered for giving in. ]-
-[ ZZ = g ^ (xb * xa) mod p      g = h^{(p-1)/q} mod p ]-


