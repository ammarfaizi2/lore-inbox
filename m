Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbWAFRGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbWAFRGS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 12:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752484AbWAFRGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 12:06:18 -0500
Received: from magic.adaptec.com ([216.52.22.17]:58017 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1751396AbWAFRGR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 12:06:17 -0500
content-class: urn:content-classes:message
Subject: RE: RAID controller safety
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Fri, 6 Jan 2006 12:06:13 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Message-ID: <547AF3BD0F3F0B4CBDC379BAC7E4189F02027065@otce2k03.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RAID controller safety
Thread-Index: AcYS1ISylGSc5lqzQz6eTNAUoySYQQAALj/A
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Kenny Simpson" <theonetruekenny@yahoo.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "linux kernel" <linux-kernel@vger.kernel.org>,
       "Markus Lidel" <Markus.Lidel@shadowconnect.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenny Simpson [mailto:theonetruekenny@yahoo.com] sez:
> Won't the i2o_block driver use i2o_block_device_flush to 
> flush the devices' cache (by issuing a
> I2O_CMD_BLOCK_CFLUSH), or this this function used in some 
> very different context?

We support I2O_BSA_CACHE_FLUSH, which is the i2o spec definition of this
identifier. It is merely internally re-issued as a SCSI
SYNCHRONIZE_CACHE command issued to the block device TID.

> Oddly enough, I see I2O_CMD_BLOCK_CFLISH #define'd to 0x37 in 
> both the i2o driver
> (include/linux/i2o.h), AND in the dpt driver 
> (drivers/scsi/dpt/dpti_i2o.h).  However, I do not see
> the dpt driver using this value anywhere.

The dpt_i2o driver is a *SCSI* driver, and the card accepts SCSI
commands to all the devices (including block). The dpt_i2o driver uses
the SCSI synchronize as the path for this action, that is why you see no
utilization of I2O_BSA_CACHE_FLUSH.

A DPT private message is used to issue these SCSI commands to the
controller.

Sincerely -- Mark Salyzyn
