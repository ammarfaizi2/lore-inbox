Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030258AbVKRWVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbVKRWVG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 17:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbVKRWVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 17:21:06 -0500
Received: from nproxy.gmail.com ([64.233.182.193]:56200 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751046AbVKRWVF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 17:21:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s82+5hCcFTfUtmtQTg0WFMkoL13YC29H1Wf6tWW0+rsioAokSnmo1+na6toMIZ0+fmGY+8Xo7lZo3LvnaDdFoJRTnc7MIg1DIp6S1NeJM/HugTTHKZhT/UzZ8Ge9SSogX9b+KIro9LsLC50TN+A1fv01kXfSJbi3gJp1kWxfzHY=
Message-ID: <58cb370e0511181421jc64f32es7f5b0b710eba20ec@mail.gmail.com>
Date: Fri, 18 Nov 2005 23:21:03 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Kasper Sandberg <lkml@metanurb.dk>
Subject: Re: [PATCH] update ide.c to use pci_get_drvdata()
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <1132179131.24326.5.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1132179131.24326.5.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ akpm and linus removed from cc: ]

On 11/16/05, Kasper Sandberg <lkml@metanurb.dk> wrote:
> This updates drivers/ide/ide.c to use pci_get_drvdata() instead of
> accessing driver_data directly.
>
> Signed-off-by: Kasper Sandberg <lkml@metanurb.dk>

diff -Naur linux-2.6.15-rc1-git4-a/drivers/ide/ide.c
linux-2.6.15-rc1-git4-b/drivers/ide/ide.c
--- linux-2.6.15-rc1-git4-a/drivers/ide/ide.c	2005-11-16
22:50:43.700117269 +0100
+++ linux-2.6.15-rc1-git4-b/drivers/ide/ide.c	2005-11-16
23:00:43.891060658 +0100
@@ -1216,7 +1216,7 @@

 static int generic_ide_suspend(struct device *dev, pm_message_t state)
 {
-	ide_drive_t *drive = dev->driver_data;
+	ide_drive_t *drive = pci_get_drvdata(dev);

dev is of "struct device *" type not "struct pci_dev *"
so dev_get_drvdata() should be used instead

 	struct request rq;
 	struct request_pm_state rqpm;
 	ide_task_t args;
@@ -1235,7 +1235,7 @@

 static int generic_ide_resume(struct device *dev)
 {
-	ide_drive_t *drive = dev->driver_data;
+	ide_drive_t *drive = pci_get_drvdata(dev);

ditto

 	struct request rq;
 	struct request_pm_state rqpm;
 	ide_task_t args;

Care to respin the patch?

[ Am I the only one reviewing IDE patches?  It seems so... ]

Bartlomiej
