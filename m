Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751842AbWB0MhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbWB0MhD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 07:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbWB0MhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 07:37:02 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:10157 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751236AbWB0Mg5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 07:36:57 -0500
Date: Mon, 27 Feb 2006 05:36:55 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: erich <erich@areca.com.tw>
Cc: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, billion.wu@areca.com.tw, akpm@osdl.org,
       oliver@neukum.org
Subject: Re: Areca RAID driver remaining items?
Message-ID: <20060227123655.GA27759@parisc-linux.org>
References: <001401c63b90$cf646370$b100a8c0@erich2003>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001401c63b90$cf646370$b100a8c0@erich2003>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 07:27:33PM +0800, erich wrote:
> Dear Christoph Hellwig,
> 
> Do you have any comments with arcmsr SATA RAID driver on sysfs attribute?
> There were four types of function template completed in linux.
> iscsi_function_template
> sas_function_template
> spi_function_template
> fc_function_template
> Do you have opintion with "arcmsr_transport_functions" ?
> and Which function templete does "arcmsr" belong to?

The transport really refers to the physical cabling.  iSCSI is
SCSI-over-IP, SAS is Serial Attached SCSI, SPI is Parallel SCSI and FC
is Fibre Channel.  It seems to me from your website that you're
using SATA-II drives, so you'll want to look at the SAS template for
exposing cabling details.

You missed one useful class though, the raid_function_template, which
you almost certainly want to use.  See drivers/scsi/raid_class.c and
include/linux/raid_class.h.  It's early days for the RAID class, so you
may wish to extend it to meet your needs.

James, I presume it's been mis-placed for convenience and it'll move to
block/ or drivers/block/ at some point?
