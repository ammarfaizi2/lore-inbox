Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269223AbUINSzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269223AbUINSzK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 14:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269297AbUINSxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 14:53:37 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:29366 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S269382AbUINSve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 14:51:34 -0400
Subject: Re: [PATCH] New QStor SATA/RAID Driver for 2.6.9-rc2
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <lkml@rtr.ca>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20040914183502.GA23277@havoc.gtf.org>
References: <41471163.10709@rtr.ca> <414723B0.1090600@pobox.com>
	<1095186343.2008.29.camel@mulgrave>  <20040914183502.GA23277@havoc.gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 14 Sep 2004 14:51:19 -0400
Message-Id: <1095187885.2007.33.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-14 at 14:35, Jeff Garzik wrote:
> The lock is taken in the SCSI layer with spin_lock_irqsave(), but the
> low-level driver cannot perform the exact opposite,
> spin_unlock_irqrestore().  The best they can do is spin_lock_irq(),
> which isnt 100% the same.

That's what they do if you look.

The eh_ stubs are only called from the eh_ thread, so it's safe to
enable interrupts as well.

The business of the mid-layer taking the locks is an annoying holdover
from the "drivers don't need to do locking" mentality.  Unfortunately
most drivers now simply drop the locks immediately they begin an eh_
entry point and reacquire them just prior to returning ... which makes
all the eh code look messy.

James


