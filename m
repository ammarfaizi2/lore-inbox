Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbWDZPy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWDZPy7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 11:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWDZPy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 11:54:58 -0400
Received: from isilmar.linta.de ([213.239.214.66]:46773 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S964839AbWDZPy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 11:54:58 -0400
Date: Wed, 26 Apr 2006 17:54:56 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Michal Purzynski <michal@rsbac.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pcmcia subsystem completely broken
Message-ID: <20060426155456.GA9108@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Michal Purzynski <michal@rsbac.org>, linux-kernel@vger.kernel.org
References: <200604261651.18350.michal@rsbac.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604261651.18350.michal@rsbac.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 26, 2006 at 04:51:13PM +0200, Michal Purzynski wrote:
> #Use Manufacturing ID to match all GlobeTrotter variants
> manfid 0x0013, 0x0000
> cis "cis/GLOBETROTTER.cis"
> bind "serial_cs"
> 
> as you can see, i'm using old pcmcia-cs tools, since it's not possible to 
> replace firmware on demand with pcmciautils - 1st. hence first question - 
> when it will be possible ?

Since 2.6.13 or so. You need to add a line to the serial_id table in
drivers/serial/serial_cs.c, though:
	PCMCIA_DEVICE_CIS_MANF_CARD(0x0013, 0x0000, "GLOBETROTTER.cis");
and GLOBETROTTER.cis needs to be available in /lib/firmware/ . Of course the
default kernel firmware loading mechanism (either udev or hotplug) must
work, too...

> i supposed old tools will finally stop working and 
> i'll be fried after that change.

Old tools will only be removed once there's no regression. Oh, and where did
you read that replacing firmware on demand wasn't possible with
pcmciautils?

> second problem with it - even after serial port is detected properly, i'm 
> still unable to communicate with that card, no AT command is delivered, no 
> reaction from card.

Please post a lspcmcia and dmesg output to the linux-pcmcia list at
linux-pcmcia (AT) lists (DOT) infradead (DOT) org

	Dominik
