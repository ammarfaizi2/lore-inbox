Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbUJXQXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbUJXQXT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 12:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbUJXQUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 12:20:44 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:2780 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261534AbUJXQUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 12:20:25 -0400
Subject: Re: [PATCH] use mmiowb in qla1280.c
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>, jeremy@sgi.com,
       jes@sgi.com
In-Reply-To: <200410211617.14809.jbarnes@engr.sgi.com>
References: <200410211613.19601.jbarnes@engr.sgi.com> 
	<200410211617.14809.jbarnes@engr.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 24 Oct 2004 12:20:05 -0400
Message-Id: <1098634812.10906.38.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-21 at 19:17, Jesse Barnes wrote:
> There are a few spots in qla1280.c that don't need a full PCI write flush to 
> the device, but rather a simple write ordering guarantee.  This patch changes 
> some of the PIO reads that cause write flushes into mmiowb calls instead, 
> which is a lighter weight way of ensuring ordering.
> 
> Jes and James, can you ack this and/or push it in via the SCSI BK tree?

This doesn't seem to work:

  CC [M]  drivers/scsi/qla1280.o
drivers/scsi/qla1280.c: In function `qla1280_64bit_start_scsi':
drivers/scsi/qla1280.c:3404: warning: implicit declaration of function
`mmiowb'

  MODPOST
*** Warning: "mmiowb" [drivers/scsi/qla1280.ko] undefined!

James


