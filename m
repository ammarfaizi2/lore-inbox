Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265418AbUGNT4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265418AbUGNT4J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 15:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265508AbUGNT4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 15:56:09 -0400
Received: from [208.223.9.37] ([208.223.9.37]:19472 "EHLO maestro.symsys.com")
	by vger.kernel.org with ESMTP id S265418AbUGNT4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 15:56:03 -0400
Date: Wed, 14 Jul 2004 14:53:27 -0500 (CDT)
From: Greg Ingram <ingram@symsys.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org, <tiwai@suse.de>,
       Jaroslav Kysela <perex@suse.cz>
Subject: Re: via82xx.c vs. sonypi.c i/o region conflict on vaio
In-Reply-To: <40F58A20.1090807@pobox.com>
Message-ID: <Pine.LNX.4.44.0407141447540.16050-100000@maestro.symsys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 Jul 2004, Jeff Garzik wrote:

> Greg Ingram wrote:
> > I modified the sound driver to grab only 128 ports instead of 256 and the
> > driver works fine on this hardware.  In 2.6.7, it's line 2049 or so of
> > sound/pci/via82xx.c:
> >
> > old:	if ((chip->res_port = request_region(chip->port, 256, card->driver)) == NULL) {
> > new:	if ((chip->res_port = request_region(chip->port, 256, card->driver)) == NULL) {
>
>
> I don't see any difference between these two lines.

Doh!  In new I replaced '256' with '128'.

> Regardless, I see two bugs:
>
> 1) Hardcoding 256 for resource size.  Should be using pci_resource_len()
>
> 2) via82xx sound driver should be using pci_request_regions() and
> pci_release_regions(), not request_region.  Doing this eliminates issue #1.

Is the fix in?  Or is there something I need to do?

Incidentally, on the notebook, cutting the region grabbed by the audio
driver also eliminated a nifty hang-the-machine issue if I pressed Fn-F7
trying to shove video out the external display port.

Regards,

- Greg


