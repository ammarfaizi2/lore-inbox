Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265730AbTFNUuc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 16:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265736AbTFNUub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 16:50:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14348 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265730AbTFNUuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 16:50:22 -0400
Date: Sat, 14 Jun 2003 22:04:01 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Oliver Neukum <oliver@neukum.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [patch] input: Add PCI PS/2 controller support [5/13]
Message-ID: <20030614220401.G14835@flint.arm.linux.org.uk>
Mail-Followup-To: Oliver Neukum <oliver@neukum.org>,
	Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <20030614223513.A25948@ucw.cz> <20030614223934.C25997@ucw.cz> <20030614224022.D25997@ucw.cz> <200306142251.51235.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200306142251.51235.oliver@neukum.org>; from oliver@neukum.org on Sat, Jun 14, 2003 at 10:51:51PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 14, 2003 at 10:51:51PM +0200, Oliver Neukum wrote:
> > +static int pcips2_write(struct serio *io, unsigned char val)
> > +{
> > +	struct pcips2_data *ps2if = io->driver;
> > +	unsigned int stat;
> > +
> > +	do {
> > +		stat = inb(ps2if->base + PS2_STATUS);
> > +		cpu_relax();
> > +	} while (!(stat & PS2_STAT_TXEMPTY));
> 
> What will happen if somebody unplugs the base station while this
> is running?

PCI guarantees that we'll read 0xff, which means we will not loop.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

