Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278358AbRKHU6Q>; Thu, 8 Nov 2001 15:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278391AbRKHU6H>; Thu, 8 Nov 2001 15:58:07 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:4359 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S278325AbRKHU5t>; Thu, 8 Nov 2001 15:57:49 -0500
Date: Thu, 8 Nov 2001 15:57:49 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Cotte@de.ibm.com
Cc: linux-kernel@vger.kernel.org, Linux390@de.ibm.com
Subject: if (a & X || b & ~Y) in dasd.c
Message-ID: <20011108155749.A24023@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carsten and others:

this code in 2.2.14 looks suspicious to me:

./drivers/s390/block/dasd.c:
        /* first of all lets try to find out the appropriate era_action */
        if (stat->flag & DEVSTAT_FLAG_SENSE_AVAIL ||
            stat->dstat & ~(DEV_STAT_CHN_END | DEV_STAT_DEV_END)) {
                /* anything abnormal ? */
                if (device->discipline->examine_error == NULL ||
                    stat->flag & DEVSTAT_HALT_FUNCTION) {
                        era = dasd_era_fatal;
                } else {
                        era = device->discipline->examine_error (cqr, stat);
                }
                DASD_DRIVER_DEBUG_EVENT (1, dasd_int_handler," era_code %d",
                                         era);
        }

Are you sure any parenthesises are not needed here?

-- Pete
