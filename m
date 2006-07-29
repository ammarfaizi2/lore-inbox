Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWG2RLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWG2RLA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 13:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbWG2RK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 13:10:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6060 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751410AbWG2RK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 13:10:59 -0400
Date: Sat, 29 Jul 2006 13:10:44 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: via sata oops on init
Message-ID: <20060729171044.GE16946@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060728233950.GD3217@redhat.com> <20060729144528.GD28712@leiferikson.dystopia.lan> <20060729164115.GA16946@redhat.com> <20060729170402.GA20649@leiferikson.dystopia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060729170402.GA20649@leiferikson.dystopia.lan>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2006 at 07:04:02PM +0200, Johannes Weiner wrote:

 > You jump into loop just to skip it.

You have to. Look at the allocation again. It's in a loop.
The first of which may have succeeded.  Your patch will introduce
a memory leak.

		Dave

 > diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
 > index 386e5f2..064ee85 100644
 > --- a/drivers/scsi/libata-core.c
 > +++ b/drivers/scsi/libata-core.c
 > @@ -5420,7 +5420,7 @@ int ata_device_add(const struct ata_prob
 >  
 >  		ap = ata_host_add(ent, host_set, i);
 >  		if (!ap)
 > -			goto err_out;
 > +			goto err_free_ret;
 >  
 >  		host_set->ports[i] = ap;
 >  		xfer_mode_mask =(ap->udma_mask << ATA_SHIFT_UDMA) |



-- 
http://www.codemonkey.org.uk
