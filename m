Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262679AbVDYR2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbVDYR2Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 13:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbVDYRZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 13:25:44 -0400
Received: from magic.adaptec.com ([216.52.22.17]:58855 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S262713AbVDYRV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 13:21:57 -0400
Message-ID: <426D2723.8070308@adaptec.com>
Date: Mon, 25 Apr 2005 13:21:39 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       andrew.patterson@hp.com, Eric.Moore@lsil.com, mike.miller@hp.com,
       dougg@torque.net, Madhuresh_Nagshain@adaptec.com
Subject: Re: [RFC] SAS domain layout for Linux sysfs
References: <425D392F.2080702@adaptec.com> <20050424111908.GA23010@infradead.org> <426D1572.70508@adaptec.com> <20050425161411.GA11938@infradead.org>
In-Reply-To: <20050425161411.GA11938@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Apr 2005 17:21:40.0619 (UTC) FILETIME=[3E7F9DB0:01C549BB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/25/05 12:14, Christoph Hellwig wrote:
> Please read the previous mail again, you're not getting it at all. 
> If you don't understand the problems it's not worth talking about more.

Here is your original email:

On 04/24/05 07:19, Christoph Hellwig wrote:
> This is contrary to any sysfs topology I know about, especially any
> existing transport class (SPI, FC, iSCSI).  We only ever care about
> what's seen from a HA, e.g. if you have muliple SPI cards that are
> on a single parallel bus you'll have the same bus represented twice,
> similarly if you have two fibre channel HBAs connected to the same
> SAN you'll have the SAN topology duplicated in both sub-topologies.
> This matches the internal data structure of the scsi subsystem and
> the transport class, e.g. we have a scsi_device object for every lun
> that's seen from a hba, linked to the HBAs Scsi_Host object and not
> one shared by multiple HBAs.  Dito for fibre channel remote ports.

You're are stating that:
1) You "only ever care about what's seen from a HA",
2) "if you have muliple SPI cards that are on a single parallel
    bus you'll have the same bus represented twice"
3) "we have a scsi_device object for every lun
    that's seen from a hba, linked to the HBAs Scsi_Host object
    and not one shared by multiple HBAs"

So in effect, you _want_ duplication, right?  This is perfectly OK.
In fact it is desirable (and has never been under question).

This isn't directly related to the RFC.  The RFC basically
outlines the result of *a SAS discovery process*.  The discovery
process/LLDD can register the LU many times.  This has *never* been an
issue of discussion.

Your concern is satisfied in that, /sys/bus/scsi/devices/... would
point to the LU.  And a link from /sys/class/sas_ha/ha0/devices/
to the LU could be placed (outside the scope of this RFC).  The RFC
doesn't mention LUs, but they could be included if you wish so.

	Luben
