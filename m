Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264331AbTLESth (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 13:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264303AbTLESsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 13:48:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9405 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264289AbTLESrj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 13:47:39 -0500
Message-ID: <3FD0D2B7.2050403@pobox.com>
Date: Fri, 05 Dec 2003 13:47:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCHES] libata fixes
References: <20031205181643.GA6877@gtf.org> <Pine.LNX.4.58.0312051041000.9125@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312051041000.9125@home.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------040409010709090900050206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040409010709090900050206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> On Fri, 5 Dec 2003, Jeff Garzik wrote:
> 
>>Linus, please do a
>>
>>	bk pull bk://gkernel.bkbits.net/libata-2.5
>>
>>This will update the following files:
>>
>> drivers/scsi/libata-core.c  |   17 ++---
>> drivers/scsi/sata_promise.c |  128 +++++++++++++++++++++++++-------------------
> 
> 
> Right now, I'm accepting one-liners that I think are "obvious" and also
> "very important" (ie fixes for oopses that anybody can trigger, rather
> than for example updates to one particular driver). So it sounds like I
> might accept _one_ of these:
> 
> 
>><jgarzik@redhat.com> (03/12/05 1.1498)
>>   [libata] fix use-after-free
>>
>>   Fixes oops some were seeing on module unload.
>>
>>   Caught by Jon Burgess.
> 
> 
> If this is basically an obvious one-liner ("move a kfree")?
> 
> Andrew is still off, and he can make a decision independently, but right
> now I'm not going to apply anything bigger.


Yep, split out and attached...

	Jeff



--------------040409010709090900050206
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1497  -> 1.1498 
#	drivers/scsi/libata-core.c	1.8     -> 1.9    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/12/05	jgarzik@redhat.com	1.1498
# [libata] fix use-after-free
# 
# Fixes oops some were seeing on module unload.
# 
# Caught by Jon Burgess.
# --------------------------------------------
#
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	Fri Dec  5 13:46:54 2003
+++ b/drivers/scsi/libata-core.c	Fri Dec  5 13:46:54 2003
@@ -3224,8 +3224,6 @@
 		scsi_host_put(ap->host); /* FIXME: check return val */
 	}
 
-	kfree(host_set);
-
 	pci_release_regions(pdev);
 
 	for (i = 0; i < host_set->n_ports; i++) {
@@ -3242,6 +3240,7 @@
 		}
 	}
 
+	kfree(host_set);
 	pci_disable_device(pdev);
 	pci_set_drvdata(pdev, NULL);
 }

--------------040409010709090900050206--

