Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTIQQQx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 12:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbTIQQQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 12:16:53 -0400
Received: from magic-mail.adaptec.com ([216.52.22.10]:51131 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S261175AbTIQQQv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 12:16:51 -0400
Date: Wed, 17 Sep 2003 10:20:02 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Olivier Galibert <olivier.galibert@limsi.fr>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: AIC7xxx LUN enumeration failure and DV config failure
Message-ID: <2589900000.1063815602@aslan.btc.adaptec.com>
In-Reply-To: <20030917130656.GA2948@m23.limsi.fr>
References: <20030917130656.GA2948@m23.limsi.fr>
X-Mailer: Mulberry/3.1.0b6 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We have two transtec 5016 IDE disks/SCSI interface raid arrays
> connected to a motherboard Adaptec AIC7902 Ultra320 SCSI adapter on
> scsi1.  Each is split in two LUNs, 2x1.4Tb for the first and 2x2Tb for
> the second.

...

> Sep 17 14:41:42 m61 kernel: scsi1:A:0:0: DV failed to configure device.  Please file a bug report against this driver.
> Sep 17 14:41:42 m61 kernel: scsi1:A:1:0: DV failed to configure device.  Please file a bug report against this driver.

In the case of SCSI-IDE RAID arrays, many of which are of questionable
quality, this typically means that the device is not providing a valid
echo buffer size for performing domain validation.  In this case, the
driver defaults to running at the maximum speed supported by the device,
but also prints out a diagnostic.  I plan to remove the diagnostic for
the echo buffer issue since there seem to be lots of broken devices
out there.

Your RAID array only supports U160, so it only runs at that speed.
This has everything to do with the device, and nothing to do with the
aic79xx controller/driver.

As to the LUN issues, as already pointed out by others, it looks like
the report luns support in this device is broken.  Perhaps the vendor
has a firmware update available.

--
Justin

