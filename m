Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbUEFHtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbUEFHtW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 03:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbUEFHtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 03:49:22 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:10512 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261231AbUEFHtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 03:49:20 -0400
Date: Thu, 6 May 2004 08:49:18 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl,
       akpm@osdl.org
Subject: Re: Force IDE cache flush on shutdown
Message-ID: <20040506084918.B12990@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
	B.Zolnierkiewicz@elka.pw.edu.pl, akpm@osdl.org
References: <20040506070449.GA12862@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040506070449.GA12862@devserv.devel.redhat.com>; from arjanv@redhat.com on Thu, May 06, 2004 at 09:04:49AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 09:04:49AM +0200, Arjan van de Ven wrote:
> +static int ide_disk_notify_reboot (struct notifier_block *this, unsigned long event, void *x)
> +{
> +	ide_hwif_t *hwif;
> +	ide_drive_t *drive;
> +	int i, unit;
> +	
> +	switch (event) {
> +		case SYS_HALT:
> +		case SYS_POWER_OFF:
> +			break;
> +		default:
> +			return NOTIFY_DONE;
> +	}

Please don't use reboot notifiers in new driver code.  The driver
model has a ->shutdown method for that.

