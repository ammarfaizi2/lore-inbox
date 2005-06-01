Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVFATXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVFATXd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 15:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVFATVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 15:21:04 -0400
Received: from avexch02.qlogic.com ([198.70.193.200]:54448 "EHLO
	avexch01.qlogic.com") by vger.kernel.org with ESMTP id S261222AbVFASsY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 14:48:24 -0400
Date: Wed, 1 Jun 2005 11:48:20 -0700
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>
Cc: Ake <Ake.Sandgren@hpc2n.umu.se>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@SteelEye.com>,
       James Smart <James.Smart@emulex.com>
Subject: Re: 2.6.12-rc5: sleeping function called from invalid context (qla2xxx/scsi_transport_fc?)
Message-ID: <20050601184820.GE22083@plap.qlogic.org>
References: <20050530125118.GG17514@hpc2n.umu.se> <20050530140700.5a4fafa1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050530140700.5a4fafa1.akpm@osdl.org>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.9i
X-OriginalArrivalTime: 01 Jun 2005 18:48:20.0282 (UTC) FILETIME=[7B05F9A0:01C566DA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 May 2005, Andrew Morton wrote:

> Ake.Sandgren@hpc2n.umu.se (Ake) wrote:
> >
> > Hi!
> > I got the following when i pulled the FC cable from one of my qla2312
> > cards.
> > This is a 2.6.12-rc5 kernel (with udm1 patches for 2.6.12-rc2)
> > 
> > 
> > May 30 14:12:45 ican-i kernel: [ 1109.864830] qla2300 0000:03:09.0: LOOP DOWN detected.
> > May 30 14:12:45 ican-i kernel: [ 1109.875948] Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
> > May 30 14:12:45 ican-i kernel: [ 1109.894492] in_atomic():1, irqs_disabled():1
> > May 30 14:12:45 ican-i kernel: [ 1109.903864]  [dump_stack+30/48] dump_stack+0x1e/0x30
> > May 30 14:12:45 ican-i kernel: [ 1109.913648]  [__might_sleep+167/176] __might_sleep+0xa7/0xb0
> > May 30 14:12:45 ican-i kernel: [ 1109.924003]  [device_for_each_child+35/144] device_for_each_child+0x23/0x90
> > May 30 14:12:45 ican-i kernel: [ 1109.935865]  [pg0+944279047/1069622272] scsi_target_block+0x57/0x60 [scsi_mod]
> > May 30 14:12:45 ican-i kernel: [ 1109.949142]  [pg0+944996009/1069622272] fc_remote_port_block+0x39/0x60 [scsi_transport_fc]
...
> 
> This was reported (and anaylsed) a month ago:
> 
> 	http://lkml.org/lkml/2005/4/29/82
> 
> I don't know if anything has been done about it yet though?

Greg,

Is there some other interrupt-safe alternative:

	http://lkml.org/lkml/2005/4/29/129

to using device_for_each_child()?  The scsi_target_[block/unblock]()
functions need to iterate over all the child-scsi_device's belonging
to an fc_rport.

Thanks,
Andrew Vasquez
