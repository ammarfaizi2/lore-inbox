Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbTLSVEB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 16:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbTLSVEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 16:04:01 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:28323 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263600AbTLSVD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 16:03:58 -0500
Subject: Re: [RFC] 2.6.0 EDD enhancements
From: James Bottomley <James.Bottomley@steeleye.com>
To: Matt Domsch <Matt_Domsch@Dell.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20031219143749.A8351@lists.us.dell.com>
References: <Pine.LNX.4.44.0312191254550.2465-100000@humbolt.us.dell.com>
	<20031219130129.B6530@lists.us.dell.com>
	<1071865401.1943.31.camel@mulgrave> 
	<20031219143749.A8351@lists.us.dell.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 19 Dec 2003 16:03:25 -0500
Message-Id: <1071867809.1943.39.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-12-19 at 15:37, Matt Domsch wrote:
> Ok, I'll gladly make that change, but I still need a handle on the
> sdev_gendev.kobj in order to make the symlink:

the scsi device does its refcounting through the generic device (and
hence the kobject), so scsi_device_get() does get a handle on the
kobject for you (as well as doing some checks with the SCSI state model
and getting a handle on the underlying module).

> static inline struct device *
> sdev_to_gendev(struct scsi_device *sdev)
> {
>     return &sdev->sdev_gendev;
> }

I'm not too sure about this...exporting such a function might be seen as
encouraging further abuse...

James


