Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278391AbRKHVSi>; Thu, 8 Nov 2001 16:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278450AbRKHVS2>; Thu, 8 Nov 2001 16:18:28 -0500
Received: from intranet.resilience.com ([209.245.157.33]:3463 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S278391AbRKHVSS>; Thu, 8 Nov 2001 16:18:18 -0500
Mime-Version: 1.0
Message-Id: <p05100306b810a66e5eb2@[10.128.7.49]>
In-Reply-To: <20011108155749.A24023@devserv.devel.redhat.com>
In-Reply-To: <20011108155749.A24023@devserv.devel.redhat.com>
Date: Thu, 8 Nov 2001 13:18:06 -0800
To: Pete Zaitcev <zaitcev@redhat.com>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: if (a & X || b & ~Y) in dasd.c
Cc: linux-kernel@vger.kernel.org, Linux390@de.ibm.com
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 3:57 PM -0500 11/8/01, Pete Zaitcev wrote:
>Carsten and others:
>
>this code in 2.2.14 looks suspicious to me:
>
>./drivers/s390/block/dasd.c:
>         /* first of all lets try to find out the appropriate era_action */
>         if (stat->flag & DEVSTAT_FLAG_SENSE_AVAIL ||
>             stat->dstat & ~(DEV_STAT_CHN_END | DEV_STAT_DEV_END)) {
>                 /* anything abnormal ? */
>                 if (device->discipline->examine_error == NULL ||
>                     stat->flag & DEVSTAT_HALT_FUNCTION) {
>                         era = dasd_era_fatal;
>                 } else {
>                         era = device->discipline->examine_error (cqr, stat);
>                 }
>                 DASD_DRIVER_DEBUG_EVENT (1, dasd_int_handler," era_code %d",
>                                          era);
>         }
>
>Are you sure any parenthesises are not needed here?

It's OK. You're probably used to seeing (necessary) parens when || is 
replaced by == in this kind of expression.
-- 
/Jonathan Lundell.
