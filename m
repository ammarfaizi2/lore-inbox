Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbUEFMut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbUEFMut (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 08:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbUEFMut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 08:50:49 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:12731 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261611AbUEFMur
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 08:50:47 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: Force IDE cache flush on shutdown
Date: Thu, 6 May 2004 13:38:50 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <20040506070449.GA12862@devserv.devel.redhat.com> <20040506084918.B12990@infradead.org>
In-Reply-To: <20040506084918.B12990@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405061338.50311.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 of May 2004 09:49, Christoph Hellwig wrote:
> On Thu, May 06, 2004 at 09:04:49AM +0200, Arjan van de Ven wrote:
> > +static int ide_disk_notify_reboot (struct notifier_block *this, unsigned
> > long event, void *x) +{
> > +	ide_hwif_t *hwif;
> > +	ide_drive_t *drive;
> > +	int i, unit;
> > +
> > +	switch (event) {
> > +		case SYS_HALT:
> > +		case SYS_POWER_OFF:
> > +			break;
> > +		default:
> > +			return NOTIFY_DONE;
> > +	}
>
> Please don't use reboot notifiers in new driver code.  The driver
> model has a ->shutdown method for that.

There is one problem with using ->shutdown:
handling of SYS_RESTART isn't the same as of SYS_HALT and SYS_POWER_OFF.

