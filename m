Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129851AbQKTBxH>; Sun, 19 Nov 2000 20:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129960AbQKTBw6>; Sun, 19 Nov 2000 20:52:58 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:31502 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129689AbQKTBwq>; Sun, 19 Nov 2000 20:52:46 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 2.4.0-test11-pre7: isapnp hang
Date: 19 Nov 2000 17:22:09 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8v9uc1$5c5$1@cesium.transmeta.com>
In-Reply-To: <8v9rf6$54k$1@cesium.transmeta.com> <E13xfQ1-0003CR-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E13xfQ1-0003CR-00@the-village.bc.nu>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
>
> > Try reserving ports 0x300-0x31f on the kernel command line
> > ("reserve=0x300,0x20").
> > 
> > I'm surprised isapnp uses a port in such a commonly used range,
> > though.
> 
> It seems to be a combination of two bugs. The one I posted a patch for and
> something odd that is taking port 0x279 before the pnp probe is run, which
> suggests a link order issue. Although in truth _nobody_ should be claing
> that anyway
> 

It seems to me that it would be better to initialize all the (non-PnP)
ISA cards first, and have them claim their preferred ranges.  Now you
can pick the PnP isolate port out of what is left, and also have a
much better idea of what is available.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
