Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271712AbTHDM2O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 08:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271713AbTHDM2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 08:28:14 -0400
Received: from [217.157.19.70] ([217.157.19.70]:4103 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S271712AbTHDM2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 08:28:11 -0400
Date: Mon, 4 Aug 2003 14:28:10 +0200 (CEST)
From: Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To: Arjan van de Ven <arjanv@redhat.com>
cc: Jeff Garzik <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (2.4.2x) Driver for Medley software RAID (Silicon Image
 3112 SATARaid, CMD680, etc?) for testing
In-Reply-To: <1059995461.5291.0.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.40.0308041418070.22732-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Aug 2003, Arjan van de Ven wrote:

> > I was under the impression that silraid.c never worked at all (it
> > certainly didn't on my system), because the magic number it looks for is
> > incorrect (actually, part of the drive's serial number), and thus not
> > present on all systems with this RAID).
>
> well... that's a 1 line fix to silraid.c......

Not really, it needs to look up the PCI device ID of the card to do it (of
course still just a few lines).

But the reason for rewriting the driver was that I wanted to use the
specification as a guideline instead of the old implementation which was
really for a different RAID type (with the cutoff handling of the
differing disk sizes etc).

In hindsight, after the driver is "completed" at least for RAID0, I can
see that modifying the old driver could have been just as good (although
I'd still advocate renaming it), but now it is done like this and I think
the new driver is certainly a better starting point for Medley (e.g. if
one wanted to add support for the striped modes etc).

Keep in mind that I didn't know anyone had successfully used silraid.c
since on my system it a) looked in the wrong place for the superblock and
b) looked for a wrong magic number, and I didn't get any response when I
provided you with a lot of details about this.

The detection of the arrays is certainly safer, and the make request
routine is improved in my driver so bottom line I thik it's a better
driver and will also provide a better starting point for adding stuff like
RAID1 and RAID0+1 support (although one could argue that the whole ataraid
method should be regarded as a temporary solution and there would be ways
to integrate support for these software RAIDs better in the future).

Regards,
Thomas


