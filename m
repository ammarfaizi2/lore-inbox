Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWJQQik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWJQQik (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 12:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWJQQik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 12:38:40 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:10890 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751278AbWJQQij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 12:38:39 -0400
Subject: Re: [PATCH] libsas: support NCQ for SATA disks
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: brking@us.ibm.com, "Darrick J. Wong" <djwong@us.ibm.com>,
       linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>,
       Mike Anderson <andmike@us.ibm.com>
In-Reply-To: <4534BB5B.6080002@garzik.org>
References: <453027A9.3060606@us.ibm.com> <45340A62.7050406@us.ibm.com>
	 <4534BB5B.6080002@garzik.org>
Content-Type: text/plain
Date: Tue, 17 Oct 2006 11:35:37 -0500
Message-Id: <1161102937.3720.11.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-17 at 07:15 -0400, Jeff Garzik wrote:
> Brian King wrote:
> > This doesn't look like the right fix for the oops you were seeing. The
> > SAS usage of libata has ap->scsi_host as NULL, which indicates that
> > libata does not own the associated scsi_host. I'm concerned you may
> > have broken some other code path by making this change. I think the correct
> > fix may require removing the dependence of ap->scsi_host from
> > ata_dev_config_ncq. 
> 
> Yep.  I had already mentioned this on IRC.

I understand, but right at the moment, my priority is sorting out the
aic94xx driver so that it works with SATA devices.  It has become
apparent that there's some need for a bit of code sorting out in libata
to drive intelligent sas controllers, so we can take a look at bugs in
ata_dev_config_ncq() when someone's time frees up to look into the
libata issues.

James



