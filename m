Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbUJYQUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbUJYQUK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 12:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbUJYQT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 12:19:57 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:58516 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262054AbUJYQSI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 12:18:08 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [PATCH] use mmiowb in qla1280.c
Date: Mon, 25 Oct 2004 09:18:01 -0700
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>, jeremy@sgi.com,
       jes@sgi.com
References: <200410211613.19601.jbarnes@engr.sgi.com> <200410211617.14809.jbarnes@engr.sgi.com> <1098634812.10906.38.camel@mulgrave>
In-Reply-To: <1098634812.10906.38.camel@mulgrave>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410250918.01786.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, October 24, 2004 9:20 am, James Bottomley wrote:
> On Thu, 2004-10-21 at 19:17, Jesse Barnes wrote:
> > There are a few spots in qla1280.c that don't need a full PCI write flush
> > to the device, but rather a simple write ordering guarantee.  This patch
> > changes some of the PIO reads that cause write flushes into mmiowb calls
> > instead, which is a lighter weight way of ensuring ordering.
> >
> > Jes and James, can you ack this and/or push it in via the SCSI BK tree?
>
> This doesn't seem to work:
>
>   CC [M]  drivers/scsi/qla1280.o
> drivers/scsi/qla1280.c: In function `qla1280_64bit_start_scsi':
> drivers/scsi/qla1280.c:3404: warning: implicit declaration of function
> `mmiowb'
>
>   MODPOST
> *** Warning: "mmiowb" [drivers/scsi/qla1280.ko] undefined!

Only works in Andrew's tree until he pushes mmiowb to Linus.

Jesse
