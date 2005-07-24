Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVGXUCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVGXUCn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 16:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVGXUCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 16:02:30 -0400
Received: from isilmar.linta.de ([213.239.214.66]:61162 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261182AbVGXUC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 16:02:28 -0400
Date: Sun, 24 Jul 2005 22:02:27 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Noah Misch <noah@cs.caltech.edu>, linux-pcmcia@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13-rc3] pcmcia: pcmcia_request_irq for !IRQ_HANDLE_PRESENT
Message-ID: <20050724200227.GA26872@isilmar.linta.de>
Mail-Followup-To: Noah Misch <noah@cs.caltech.edu>,
	linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20050717035124.GC13529@orchestra.cs.caltech.edu> <20050723201113.GA12537@dominikbrodowski.de> <20050724124040.C4908@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050724124040.C4908@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2005 at 12:40:40PM +0100, Russell King wrote:
> On Sat, Jul 23, 2005 at 10:11:13PM +0200, Dominik Brodowski wrote:
> > Thanks for the excellent debugging. Your patch seems to work, however it
> > might be better to do just this:
> 
> This can be racy if two drivers are simultaneously trying to request an
> IRQ.  'data' must be unique to different threads if they are to avoid
> interfering with each other.

As it's enough to keep PCMCIA functions apart (there can't be two drivers
registering with the same PCMCIA function at the same moment), I'll use that
now.
	void *data = &p_dev->dev.driver; /* something unique to this device */


Thanks,
	Dominik
