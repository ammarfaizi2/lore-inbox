Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265101AbUAJLbv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 06:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265105AbUAJLbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 06:31:51 -0500
Received: from imap.gmx.net ([213.165.64.20]:19597 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265101AbUAJLbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 06:31:49 -0500
X-Authenticated: #20450766
Date: Sat, 10 Jan 2004 12:10:46 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 NFS-server low to 0 performance
In-Reply-To: <20040110013824.GA17845@matchmail.com>
Message-ID: <Pine.LNX.4.44.0401101143280.2363-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jan 2004, Mike Fedyk wrote:

> On Sat, Jan 10, 2004 at 01:38:00AM +0100, Guennadi Liakhovetski wrote:
> > On Fri, 9 Jan 2004, Mike Fedyk wrote:
> > > Find out how many packets are being dropped on your two hosts with 2.4 and
> > > 2.6.
> >
> > So, I've run 2 tcpdumps - on server and on client. Woooo... Looks bad.
> >
> > With 2.4 (_on the server_) the client reads about 8K at a time, which is
> > sent in 5 fragments 1500 (MTU) bytes each. And that works. Also
> > interesting, that fragments are sent in the reverse order.
> >
> > With 2.6 (on the server, same client) the client reads about 16K at a
> > time, split into 11 fragments, and then packets number 9 and 10 get
> > lost... This all with a StrongARM client and a PCMCIA network-card. With a
> > PXA-client (400MHz compared to 200MHz SA) and an on-board eth smc91x, it
> > gets the first 5 fragments, and then misses every other fragment. Again -
> > in both cases I was copying files to RAM. Yes, 2.6 sends fragments in
> > direct order.
>
> Is that an x86 server, and an arm client?

Yes. The reason for the problem seems to be the increased default size of
the transfer unit of NFS from 2.4 to 2.6. 8K under 2.4 was still ok, 16K
is too much - only the first 5 fragments pass fine, then data starts to
get lost. If it is a hardware limitation (not all platforms can manage
16K), it should be probably set back to 8K. If the reason is that some
buffer size was not increased correspondingly, then this should be done.

Just checked - mounting with rsize=8192,wsize=8192 fixes the problem -
there are again 5 fragments and they all are received properly.

Anyway, I think, default values should be safe on all platforms, with
further optimisations being possible, where it is safe.

Thanks
Guennadi
---
Guennadi Liakhovetski



