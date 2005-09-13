Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964933AbVIMRji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbVIMRji (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 13:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbVIMRji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 13:39:38 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:58088 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964927AbVIMRjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 13:39:37 -0400
Date: Tue, 13 Sep 2005 23:03:53 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Anton Blanchard <anton@samba.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.14-rc1] sym scsi boot hang
Message-ID: <20050913173353.GB4612@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050913124804.GA5008@in.ibm.com> <20050913131739.GD26162@krispykreme> <20050913142939.GE26162@krispykreme> <1126629345.4809.36.camel@mulgrave> <20050913164727.GA26353@krispykreme> <1126632760.4809.38.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126632760.4809.38.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 12:32:40PM -0500, James Bottomley wrote:
> On Wed, 2005-09-14 at 02:47 +1000, Anton Blanchard wrote:
> > Good idea, I wonder why the IO isnt completing.
> > 
> > Anton
> > 
> > [c0000000004945fc] schedule+0x63c/0xf70
> > [c0000000004954c8] wait_for_completion+0xb8/0x140
> > [c0000000002a3800] blk_execute_rq+0xb0/0x120
> > [c000000000338a98] scsi_execute+0xf8/0x150
> > [c000000000338bc0] scsi_execute_req+0xd0/0x140
> > [c00000000033bce4] scsi_probe_and_add_lun+0x204/0x9f0
> > [c00000000033cfc4] __scsi_scan_target+0x164/0x4f0
> > [c00000000033d430] scsi_scan_channel+0xe0/0x120
> > [c00000000033d598] scsi_scan_host_selected+0x128/0x1d0
> > [c000000000361c20] ibmvscsi_probe+0x270/0x400
> > [c0000000000367fc] vio_bus_probe+0x7c/0x90
> > [c000000000299a78] driver_probe_device+0x98/0x160
> > [c000000000299ce8] __driver_attach+0xa8/0xd0
> > [c000000000298938] bus_for_each_dev+0x88/0xe0
> > [c000000000299738] driver_attach+0x28/0x40
> > [c000000000299074] bus_add_driver+0xc4/0x200
> > [c00000000029a1cc] driver_register+0x5c/0x80
> > [c0000000000365b0] vio_register_driver+0x50/0x70
> > [c000000000565bac] ibmvscsi_module_init+0x1c/0x40
> 
> That trace says the ibmvscsi driver (not sym2) has lost an I/O

Anton's trace is from a different machine. Mine has symbios.
Backing out the scsi merge (Anton's backout patch) of a day ago
fixes my problem.

Thanks
Dipankar
