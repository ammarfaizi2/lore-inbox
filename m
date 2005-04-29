Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262265AbVD2KJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbVD2KJN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 06:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbVD2KJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 06:09:11 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:63382 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262244AbVD2KIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 06:08:52 -0400
Date: Fri, 29 Apr 2005 11:08:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Douglas Gilbert <dougg@torque.net>
Cc: Luben Tuikov <luben_tuikov@adaptec.com>,
       Christoph Hellwig <hch@infradead.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       andrew.patterson@hp.com, Eric.Moore@lsil.com, mike.miller@hp.com,
       Madhuresh_Nagshain@adaptec.com
Subject: Re: [RFC] SAS domain layout for Linux sysfs
Message-ID: <20050429100848.GB3342@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Douglas Gilbert <dougg@torque.net>,
	Luben Tuikov <luben_tuikov@adaptec.com>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	andrew.patterson@hp.com, Eric.Moore@lsil.com, mike.miller@hp.com,
	Madhuresh_Nagshain@adaptec.com
References: <425D392F.2080702@adaptec.com> <20050424111908.GA23010@infradead.org> <426D1572.70508@adaptec.com> <20050425161411.GA11938@infradead.org> <426D2723.8070308@adaptec.com> <20050425181831.GA14190@infradead.org> <426E5BAF.4040003@adaptec.com> <426F86D3.4070909@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426F86D3.4070909@torque.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> sysfs and SAS discovery
> -----------------------
> It seems reasonable that sda should be visible in sysfs
> since the silicon in the HBA (for scsi0) knows about it.
> However the silicon for scsi1 knows about ex1 (and
> nothing beyond that). SAS defines the Serial Management
> Protocol (SMP) for the purpose of probing what (else) is
> connected to an expander. SMP is similar to a SCSI command
> set and SMP frames need to be sent via scsi1 to ex1.
> Note that ex1 is _not_ a SCSI device (it is
> part of the service delivery subsystem) and we have no
> representation currently for it in sysfs. [Fibre channel
> switches are architecturally similar to SAS expanders.]

Note that the current scsi code allows to create custom per-transport
objects below the target object.  We're using that in the fibre channel
transport class for the concept of remote ports.

> Once the SAS discovery algorithm has been run should we
> show its results in sysfs??

I think so, yes.  Similar to how we have all fibre channel remote ports
in sysfs, even if they are not scsi targets.

