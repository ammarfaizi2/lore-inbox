Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267446AbTALTza>; Sun, 12 Jan 2003 14:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267447AbTALTza>; Sun, 12 Jan 2003 14:55:30 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:49814
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267446AbTALTz2>; Sun, 12 Jan 2003 14:55:28 -0500
Subject: Re: Linux 2.4.21-pre3-ac4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1042401443.525.223.camel@zion.wanadoo.fr>
References: <200301121807.h0CI7Qp04542@devserv.devel.redhat.com>
	 <1042399796.525.215.camel@zion.wanadoo.fr>
	 <1042403235.16288.14.camel@irongate.swansea.linux.org.uk>
	 <1042401074.525.219.camel@zion.wanadoo.fr>
	 <1042401443.525.223.camel@zion.wanadoo.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042404682.16288.34.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 12 Jan 2003 20:51:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 19:57, Benjamin Herrenschmidt wrote:
> Actually, do we really need that delay as we are waiting for an
> interrupt anyway ? my understanding is that this delay is the required
> before we start polling for BSY bit (that is the max time the drive may
> take to assert BSY after getting the command), but in our case, unless
> we have other bugs, we shall have the channel marked busy, so nobody
> will tap it, except the actual interrupt coming in. Or will the case of
> shared interrupt potentially cause a read of status at the wrong time ?

Precisely. Or a random IRQ from a drive power change or hotplug that
passed our command in the other direction.

We could actually address this another way which might even be easier, 
that is in the IRQ path to wait the 400nS if BSY isnt asserted. I need
to go reread the spec to check if we can poll it before the timeout
but not trust the data, or cannot poll it.

Alan

