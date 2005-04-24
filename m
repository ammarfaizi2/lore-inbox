Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262318AbVDXLTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbVDXLTj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 07:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262313AbVDXLTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 07:19:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62338 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262312AbVDXLTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 07:19:15 -0400
Date: Sun, 24 Apr 2005 12:19:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       andrew.patterson@hp.com, Eric.Moore@lsil.com, mike.miller@hp.com,
       dougg@torque.net, Madhuresh_Nagshain@adaptec.com,
       Sukanta_Ganguly@adaptec.com
Subject: Re: [RFC] SAS domain layout for Linux sysfs
Message-ID: <20050424111908.GA23010@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Luben Tuikov <luben_tuikov@adaptec.com>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	andrew.patterson@hp.com, Eric.Moore@lsil.com, mike.miller@hp.com,
	dougg@torque.net, Madhuresh_Nagshain@adaptec.com,
	Sukanta_Ganguly@adaptec.com
References: <425D392F.2080702@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425D392F.2080702@adaptec.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 11:22:23AM -0400, Luben Tuikov wrote:
> SAS domain layout for Linux sysfs
> =================================
> 
> 0. Introduction
> 
> The use of SAS address and WWN are used interchangeably.
> 
> There are two domains which we want to represent in sysfs, in
> order to eliminate redundancies.
> 
>             |     /-------------------\
> +-------+   |    /  SAS_ADDR0          \
> |ha0 [] =---|---(                       )
> +---||||+   |    \                     /
>             |     |       SAS_ADDR2   |
> +-------+   |    /                     \
> |ha1 [] =---|---(      SAS_ADDR1        )
> +---||||+   |    \                     /
>             |     \___________________/
>             |
> Host domain |         SAS Domain
> 
>      Figure 1. Domains represented by sysfs
> 
> The host domain (/sys/class/sas_ha/ha0/, etc) shows the SAS
> domain as seen by the Host Adapter.  The sysfs SAS domain
> (/sys/bus/sas/ ), shows the SAS domain as it exists
> irrespectively of which HA (Host Adapter) you use to connect
> to it (to a device).

This is contrary to any sysfs topology I know about, especially any
existing transport class (SPI, FC, iSCSI).  We only ever care about
what's seen from a HA, e.g. if you have muliple SPI cards that are
on a single parallel bus you'll have the same bus represented twice,
similarly if you have two fibre channel HBAs connected to the same
SAN you'll have the SAN topology duplicated in both sub-topologies.
This matches the internal data structure of the scsi subsystem and
the transport class, e.g. we have a scsi_device object for every lun
that's seen from a hba, linked to the HBAs Scsi_Host object and not
one shared by multiple HBAs.  Dito for fibre channel remote ports.


One note to this proposal:  it probably doesn't make a lot of sense to
try to flesh out the sysfs topology before doing the kernel internal
object model as the former pretty much follows the latter.
