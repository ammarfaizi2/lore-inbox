Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262435AbULOU2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbULOU2p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 15:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbULOU2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 15:28:45 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:40085 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262435AbULOU2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 15:28:40 -0500
Subject: Re: How to add/drop SCSI drives from within the driver?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Matt Domsch <Matt_Domsch@Dell.com>
Cc: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>, brking@us.ibm.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>, bunk@fs.tum.de,
       Andrew Morton <akpm@osdl.org>, "Ju, Seokmann" <sju@lsil.com>,
       "Doelfel, Hardy" <hdoelfel@lsil.com>, "Mukker, Atul" <Atulm@lsil.com>
In-Reply-To: <20041215072453.GB17274@lists.us.dell.com>
References: <60807403EABEB443939A5A7AA8A7458B7F5071@otce2k01.adaptec.com>
	 <1102536081.4218.0.camel@localhost.localdomain>
	 <20041215072453.GB17274@lists.us.dell.com>
Content-Type: text/plain
Organization: SteelEye Technology, inc.
Date: Wed, 15 Dec 2004 13:49:18 -0500
Message-Id: <1103136559.5232.1.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-15 at 01:24 -0600, Matt Domsch wrote:
> James, I've been thinking about this a little more, and you may be on
> to something here. Let each driver add files as such:
> 
> /sys/class/scsi_host
>  |-- host0
>  |   |-- add_logical_drive
>  |   |-- remove_logical_drive
>  |   `-- rescan_logical_drive
> 
> Then we can go 2 ways with this.
> 1) driver functions directly call scsi_add_device(),
> scsi_remove_device(), and something for rescan (option 2 handles this
> one cleanly for us).  ATM, megaraid_mbox doesn't implement a rescan
> function, so this point may be moot. 
> 
> 2) driver functions call a midlayer library function, which invokes
>    /sbin/hotplug with appropriate data, and add a new /etc/hotplug.d
>    helper app which would then write to these files:
> 
> /sys/class/scsi_host
> |-- host0
> |   |-- scan
> /sys/devices/pci0000:0x/0000:0x:0x.0/host0
> |-- 0:0:0:0
> |   |-- delete
> |   |-- rescan
> 
> to do likewise.

I'll buy this (option 2).. it seems like a good way to export the
megaraid specific information and at the same time integrate it more
fully into the evolving hotplug infrastructure.

James


