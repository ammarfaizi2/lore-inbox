Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbUKCNR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbUKCNR5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 08:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbUKCNR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 08:17:57 -0500
Received: from zone3.gcu-squad.org ([217.19.50.74]:55308 "EHLO
	zone3.gcu-squad.org") by vger.kernel.org with ESMTP id S261584AbUKCNRy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 08:17:54 -0500
Date: Wed, 3 Nov 2004 14:12:07 +0100 (CET)
To: ak@suse.de
Subject: Re: dmi_scan on x86_64
X-IlohaMail-Blah: khali@gcu.info
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <oW5plZBL.1099487525.5944720.khali@gcu.info>
In-Reply-To: <20041103124642.GD18867@wotan.suse.de>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: LKML <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "Greg KH" <greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andi,

> > Any reason why dmi_scan is availble on the i386 arch and not on the
> > x86_64 arch? I would have a need for the latter (for run-time
> > identification purposes, not boot-time blacklisting).
>
> So far nothing needed it, so I didn't add it.  For what do you need it?

I am in the process of adding SMBus multiplexing support for the Tyan
S4882 motherboard, as seen on this thread:
http://marc.theaimsgroup.com/?l=linux-kernel&m=109863982018999&w=2

In the proposed patch, I use the PCI ID of the SMBus master to identify
the board and enable the additional code. However, I just asked for
confirmation to the Tyan engineers I am working with and they told me
that the PCI ID has not been customized (I should have figured that out
by myself since the subvendor ID was AMD's, not Tyan's, but well
sometimes you just don't get it). Thus my approach is not correct.

One possible approach would be to use the DMI data, since it is properly
set on the S4882 motherboard:

Handle 0x0001
  DMI type 1, 25 bytes.
  System Information
      Manufacturer: TYAN
      Product Name: S4882

Thus my question. As you can see, what I would need is merely an
include/linux/dmi.h-like interface that would work for x86_64 instead of
only i386. I do not need the dmi_scan blacklisting mechanism, just the
part which fetches and stores DMI data for later use. As a side note, I
wonder if this can be done without duplicating a large part of
arch/i386/kernel/dmi_scan.c.

Before you ask, detecting the need of SMBus multiplexing by somehow
scanning the SMBus is believed to be unreliable and possibly dangerous,
which is why I favor the approach of a list of known boards to enable
the multiplexing on.

Thanks,
Jean
