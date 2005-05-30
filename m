Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVE3Ojt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVE3Ojt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 10:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbVE3Oj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 10:39:29 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:58330 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261611AbVE3OjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 10:39:23 -0400
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: =?ISO-8859-1?Q?Gr=E9goire?= Favre <gregoire.favre@gmail.com>
Cc: dino@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050526173518.GA9132@gmail.com>
References: <20050517192636.GB9121@gmail.com>
	 <1116359432.4989.48.camel@mulgrave> <20050517195650.GC9121@gmail.com>
	 <1116363971.4989.51.camel@mulgrave> <20050521232220.GD28654@gmail.com>
	 <1116770040.5002.13.camel@mulgrave> <20050524153930.GA10911@gmail.com>
	 <1117113563.4967.17.camel@mulgrave> <20050526143516.GA9593@gmail.com>
	 <1117118766.4967.22.camel@mulgrave>  <20050526173518.GA9132@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 30 May 2005 09:38:58 -0500
Message-Id: <1117463938.4913.3.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-26 at 19:35 +0200, Grégoire Favre wrote:
> That's with vanilla 2.6.12-rc5 if I have to patch, just tell me :-)

OK, I have two things for you to try.

The first is the attached, which, I think, enforces the limits this
device is expecting.  It's really just a sanity check to see if the
problem is what I think it is (device negotiates a transfer setting it
can't actually support).

James

diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -735,6 +735,7 @@ ahc_linux_slave_configure(struct scsi_de
 
 	/* Initial Domain Validation */
 	if (!spi_initial_dv(device->sdev_target))
+		spi_min_period(device->sdev_target) = 100;
 		spi_dv_device(device);
 
 	return 0;


