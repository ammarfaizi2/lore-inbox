Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262553AbVCBVe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262553AbVCBVe2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 16:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbVCBVeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 16:34:06 -0500
Received: from isilmar.linta.de ([213.239.214.66]:25047 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S262553AbVCBVdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 16:33:20 -0500
Date: Wed, 2 Mar 2005 22:33:19 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Karol Kozimor <sziwan@hell.org.pl>, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk
Subject: Re: kernel BUG at drivers/serial/8250.c:1256!
Message-ID: <20050302213319.GA11320@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Karol Kozimor <sziwan@hell.org.pl>, linux-kernel@vger.kernel.org,
	rmk@arm.linux.org.uk
References: <20050301230946.GA30841@hell.org.pl> <20050301233720.B17470@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050301233720.B17470@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 11:37:20PM +0000, Russell King wrote:
> On Wed, Mar 02, 2005 at 12:09:46AM +0100, Karol Kozimor wrote:
> > I've finally got around to test latest kernels and managed to find a bug in 
> > the serial subsystem, which happens during suspend.
> 
> Yes, serial_cs is claiming that we don't have a device associated with
> the port, so we're treating it as a legacy port.  However, serial_cs is
> implementing the suspend/resume methods.  This is wrong, since that
> means the port will be suspended twice, and hence causes this bug.
> 
> serial_cs needs to register the ports along with the PCMCIA device with
> which the port belongs to.  This will stop it being treated as a legacy
> serial port.
> 
> Unfortunately, it's too late tonight for me to dig into PCMCIA to work
> out how we get at the device structure - I can't find any examples off
> hand either.

For the time being:

{
	client_handle_t handle = ...
	struct device *dev;

	dev = &handle_to_dev(handle);
}


	Dominik
