Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267979AbUIBJFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267979AbUIBJFb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 05:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268026AbUIBJFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 05:05:31 -0400
Received: from wasp.net.au ([203.190.192.17]:51668 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S267979AbUIBJFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 05:05:20 -0400
Message-ID: <4136E277.6000408@wasp.net.au>
Date: Thu, 02 Sep 2004 13:05:59 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.7+ (X11/20040730)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg Stark <gsstark@mit.edu>
CC: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Crashed Drive, libata wedges when trying to recover data
References: <87oekpvzot.fsf@stark.xeocode.com>
In-Reply-To: <87oekpvzot.fsf@stark.xeocode.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Stark wrote:

> Any clue what I need to do to achieve this? Is this a bug because this isn't a
> well-travelled code-path? (Dead drives not being something you can conjure up
> on demand)? Or is this indicative of more problems than just a crashed drive?
> 
> This is on a stock 2.6.6 kernel tree, btw.
> 

Known issue, fixed in 2.6.9-rc1. Apply this to 2.6.6 and your good to go.

Regards,
Brad

brad@srv:/usr/src$ diff -u temp/linux-2.6.8.1/drivers/scsi/libata-scsi.c 
linux-2.6.8.1/drivers/scsi/libata-scsi.c
--- temp/linux-2.6.8.1/drivers/scsi/libata-scsi.c       2004-08-14 14:55:19.000000000 +0400
+++ linux-2.6.8.1/drivers/scsi/libata-scsi.c    2004-08-18 01:04:11.000000000 +0400
@@ -213,6 +213,7 @@

         ap = (struct ata_port *) &host->hostdata[0];
         ap->ops->eng_timeout(ap);
+       host->host_failed--;

         DPRINTK("EXIT\n");
         return 0;

T
