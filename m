Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262781AbTIQPYr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 11:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbTIQPYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 11:24:47 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:63448 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262781AbTIQPYl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 11:24:41 -0400
Date: Wed, 17 Sep 2003 08:23:59 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Olivier Galibert <olivier.galibert@limsi.fr>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: AIC7xxx LUN enumeration failure and DV config failure
Message-ID: <20030917082359.A23802@beaverton.ibm.com>
References: <20030917130656.GA2948@m23.limsi.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030917130656.GA2948@m23.limsi.fr>; from olivier.galibert@limsi.fr on Wed, Sep 17, 2003 at 03:06:56PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 17, 2003 at 03:06:56PM +0200, Olivier Galibert wrote:

> We have two transtec 5016 IDE disks/SCSI interface raid arrays
> connected to a motherboard Adaptec AIC7902 Ultra320 SCSI adapter on
> scsi1.  Each is split in two LUNs, 2x1.4Tb for the first and 2x2Tb for
> the second.  There is also the root disk and $DEITY-knows-what on
> scsi0.
> 
> With 2.4.22-pre9 aic79xx driver:

> Sep 17 14:41:42 m61 kernel: scsi1:A:0:0: DV failed to configure device.  Please file a bug report against this driver.
> Sep 17 14:41:42 m61 kernel: scsi1:A:1:0: DV failed to configure device.  Please file a bug report against this driver.

Are you sure the above is not a bug or a failure with the array (Justin)?

> Sep 17 14:41:42 m61 kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
> Sep 17 14:41:42 m61 kernel: Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
> Sep 17 14:41:42 m61 kernel: Attached scsi disk sdc at scsi1, channel 0, id 0, lun 1
> Sep 17 14:41:42 m61 kernel: Attached scsi disk sdd at scsi1, channel 0, id 1, lun 0
> Sep 17 14:41:42 m61 kernel: Attached scsi disk sde at scsi1, channel 0, id 1, lun 1

> There is a DV configuration failure which limits the speed to U160,
> but otherwise everything works nicely.

> With 2.4.23-pre4 aix7xxx driver:

The following looks like 2.6.x output, since 2.4.x does not have REPORT
LUN support.

> Sep 17 14:37:25 m61 kernel: scsi: On host 1 channel 0 id 0 only 128 (max_scsi_report_luns) of 536870896 luns reported, try increasing max_scsi_report_luns.
> Sep 17 14:37:25 m61 kernel: scsi: host 1 channel 0 id 0 lun 0x7400616e73746563 has a LUN larger than currently supported.
> Sep 17 14:37:25 m61 kernel: scsi: host 1 channel 0 id 0 lun 0x2001202020202020 has a LUN larger than currently supported.
> Sep 17 14:37:25 m61 kernel: scsi: host 1 channel 0 id 0 lun 0x2002202020202020 has a LUN larger than currently supported.
> Sep 17 14:37:25 m61 kernel: scsi: host 1 channel 0 id 0 lun808529923 has a LUN larger than allowed by the host adapter
> Sep 17 14:37:25 m61 kernel: scsi: host 1 channel 0 id 0 lun3078 has a LUN larger than allowed by the host adapter
> Sep 17 14:37:25 m61 kernel: scsi: host 1 channel 0 id 0 lun 0x000000000f000000 has a LUN larger than currently supported.
> Sep 17 14:37:25 m61 kernel: (scsi1:A:1): 160.000MB/s transfers (80.000MHz DT, 16bit)
> Sep 17 14:37:25 m61 kernel:   Vendor: transtec  Model:                   Rev: 0001
> Sep 17 14:37:25 m61 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
> Sep 17 14:37:25 m61 kernel: scsi1:A:1:0: Tagged Queuing enabled.  Depth 32
> Sep 17 14:37:25 m61 kernel: scsi: On host 1 channel 0 id 1 only 128 (max_scsi_report_luns) of 536870896 luns reported, try increasing max_scsi_report_luns.
> Sep 17 14:37:25 m61 kernel: scsi: host 1 channel 0 id 1 lun 0x7400616e73746563 has a LUN larger than currently supported.
> Sep 17 14:37:25 m61 kernel: scsi: host 1 channel 0 id 1 lun 0x2001202020202020 has a LUN larger than currently supported.
> Sep 17 14:37:25 m61 kernel: scsi: host 1 channel 0 id 1 lun 0x2002202020202020 has a LUN larger than currently supported.
> Sep 17 14:37:25 m61 kernel: scsi: host 1 channel 0 id 1 lun808529923 has a LUN larger than allowed by the host adapter
> Sep 17 14:37:25 m61 kernel: scsi: host 1 channel 0 id 1 lun3078 has a LUN larger than allowed by the host adapter
> Sep 17 14:37:25 m61 kernel: scsi: host 1 channel 0 id 1 lun 0x000000000f000000 has a LUN larger than currently supported.

My guess is that something is totally screwed up with the arrays REPORT
LUN results.

Does it work OK if you turn off CONFIG_SCSI_REPORT_LUNS?

Did you check with the vendor about the problem?

You could also try modifying the arrays to report as SCSI 2, and then the
REPORT LUNS will not be sent.

If you could dump the result of sending a REPORT LUN to the device, that
would be useful. You could use the sg interface on a system (modify one of
the sg utils programs, like sg_inq.c) that found the LUNs OK, or hack the
kernel to dump the REPORT LUN output, or get a trace.

Also with CONFIG_SCSI_LOGGING enabled (hope I have this right), turn on
scsi scan logging by booting with:

	scsi_mod.scsi_logging_level=0x000001c0
	
And post the output. The extra logging probably won't help, given that the
REPORT LUN output looks corrupted.

-- Patrick Mansfield
