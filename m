Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293285AbSCOVgD>; Fri, 15 Mar 2002 16:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293326AbSCOVfp>; Fri, 15 Mar 2002 16:35:45 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63751 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293337AbSCOVfc>; Fri, 15 Mar 2002 16:35:32 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH] Cleanup port 0x80 use (was: Re: IO delay ...)
Date: Fri, 15 Mar 2002 21:33:45 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a6tpbp$snd$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0203151736460.1477-100000@biker.pdb.fsc.net> <E16lw5V-0004ES-00@the-village.bc.nu> <a6tm95$c55$1@cesium.transmeta.com>
X-Trace: palladium.transmeta.com 1016228107 17646 127.0.0.1 (15 Mar 2002 21:35:07 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 15 Mar 2002 21:35:07 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <a6tm95$c55$1@cesium.transmeta.com>,
H. Peter Anvin <hpa@zytor.com> wrote:
>
>The ISA bus doesn't time out; a cycle on the ISA bus just happens, and
>the fact that noone is there to listen doesn't seem to matter.

The ISA bus doesn't time out, but the PCI access before it gets
forwarded to the ISA bus _does_, if the ISA bus is decoded using
nagative decoding.

This is why it's important that there not be a motherboard PCI device
that can decode the port - because if there is, the access is
potentially a much faster PCI-only decode.

Note that this really only matters on low-end machines anyway, as the
whole "inb_p()" thing tends to be used only for old ISA devices.  If you
have a new machine that is all PCI, I doubt that port 80h access matters
not at all. 

(Another way of saying it: if you have a machine with a PCI POST card,
none of this will matter)

			Linus
