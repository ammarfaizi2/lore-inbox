Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751167AbWFEO4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWFEO4O (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 10:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWFEO4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 10:56:14 -0400
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:25199 "HELO
	smtp101.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751167AbWFEO4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 10:56:13 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] USB devices fail unnecessarily on unpowered hubs
Date: Mon, 5 Jun 2006 07:32:52 -0700
User-Agent: KMail/1.7.1
Cc: Oliver Neukum <oliver@neukum.org>, Pavel Machek <pavel@suse.cz>,
        David Liontooth <liontooth@cogweb.net>, linux-kernel@vger.kernel.org
References: <447EB0DC.4040203@cogweb.net> <20060530200134.GB4074@ucw.cz> <200606031129.54580.oliver@neukum.org>
In-Reply-To: <200606031129.54580.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606050732.53496.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 June 2006 2:29 am, Oliver Neukum wrote:
> Am Dienstag, 30. Mai 2006 22:01 schrieb Pavel Machek:

> > Actually I have exactly opposite problem: my computer (spitz) can't
> > supply full 500mA on its root hub, and linux tries to power up
> > 'hungry' devices, anyway, leading to very weird behaviour.
> 
> 
> You could lower the obvious values in this code from drivers/usb/core/hub.c
> 
> 	if (hdev == hdev->bus->root_hub) {
> 		if (hdev->bus_mA == 0 || hdev->bus_mA >= 500)
> 			hub->mA_per_port = 500;
> 		else {
> 			hub->mA_per_port = hdev->bus_mA;
> 			hub->limited_power = 1;
> 		}
> 
> If that does the job we need to somehow inherit the power supply maximum from
> PCI when we allocate the root hub's device structure.

I don't think there is such a convention that's generic for PCI.  There might
be ACPI-specific tables holding that value, but on embedded hardware the model
is often that the arch/.../board-ZZZ.c file just "knows" things like how much
power the regulator powering that port can provide, and arranges bus_mA to match.
Just like it knows all sorts of other details about how that board works.

- Dave
