Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262952AbUCMBnM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 20:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262975AbUCMBnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 20:43:12 -0500
Received: from mail.kroah.org ([65.200.24.183]:55984 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262952AbUCMBnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 20:43:08 -0500
Date: Fri, 12 Mar 2004 17:40:53 -0800
From: Greg KH <greg@kroah.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (8/10): zfcp fixes.
Message-ID: <20040313014053.GA10930@kroah.com>
References: <20040312193816.GI2757@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040312193816.GI2757@mschwid3.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 08:38:16PM +0100, Martin Schwidefsky wrote:
> zfcp host adapter fixes:
>  - Reuse freed scsi_ids and scsi_luns for mappings.
>  - Order list of ports/units by assigned scsi_id/scsi_lun.
>  - Don't update max_id/max_lun in scsi_host anymore.
>  - Get rid of all magics.
>  - Add owner field to ccw_driver structure.
>  - Replace release function for device structures by kfree. Move struct
>    device to the start of struct zfcp_port/zfcp_unit to make it work.

Ick, ick, ick!

Why?  Please do not do this, as it is not needed, and completly
unnecessary.  The fact that you have to create a cast like:

> +	unit->sysfs_device.release = (void (*)(struct device *))kfree;

Should set off all kinds of "this is a something we should not be doing"
warning flags.

thanks,

greg k-h
