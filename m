Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbVI0P15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbVI0P15 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 11:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbVI0P15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 11:27:57 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:6122 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S964969AbVI0P14
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 11:27:56 -0400
X-ORBL: [69.107.75.50]
Date: Tue, 27 Sep 2005 08:27:41 -0700
From: David Brownell <david-b@pacbell.net>
To: vendor-sec@lst.de, security@linux.kernel.org,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       laforge@gnumonks.org, hch@infradead.org, greg@kroah.com
Subject: Re: [vendor-sec] [BUG/PATCH/RFC] Oops while completing async USB via 
 usbdevio
References: <20050925151330.GL731@sunbeam.de.gnumonks.org>
 <20050927080413.GA13149@kroah.com>
 <20050927124846.GA29649@infradead.org>
 <20050927125755.GA10738@kroah.com>
 <20050927125956.GA29861@infradead.org>
 <20050927130937.GA11060@kroah.com>
In-Reply-To: <20050927130937.GA11060@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050927152741.2D52FA84A1@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2005 at 06:09:38 Greg KH wrote:
> On Tue, Sep 27, 2005 at 01:59:56PM +0100, Christoph Hellwig wrote:
> > 
> > This is more than messy.  usbfs is the only user of SI_ASYNCIO, and the
> > way it uses it is more than messy.  Why can't USB simply use the proper
> > AIO infrastructure?
>
> No one has taken the time and effort to do this.  No other reason that I
> know of.  David?  I know you have looked into this a bit in the past.

Time and effort are the main issues I know of.  First we'd need some
kind of FD-per-endpoint infrastructure, then it should be easy to
implement the AIO file ops, one kiocb per URB ... much like "gadgetfs"
does for USB peripherals, one kiocb per usb_request.

- Dave

