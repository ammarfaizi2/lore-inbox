Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbTHSUjw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 16:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbTHSU2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 16:28:55 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:12775 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S261406AbTHSUTR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 16:19:17 -0400
To: Jamie Lokier <jamie@shareable.org>
Cc: Paolo Ornati <javaman@katamail.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Documentation for PC Architecture
References: <200308181127.43093.javaman@katamail.com>
	<20030818185507.GB8297@www.13thfloor.at>
	<200308182244.01727.javaman@katamail.com>
	<20030818225422.GA23927@www.13thfloor.at>
	<20030819010205.GE11081@mail.jlokier.co.uk>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 19 Aug 2003 17:23:21 +0200
In-Reply-To: <20030819010205.GE11081@mail.jlokier.co.uk>
Message-ID: <m34r0dbriu.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> Paolo's question is, what happens to the 384k of _physical_ addresses
> starting at 0xa0000, which should correspond with 384k of actual
> physical RAM?

Part of it is used for BIOS (shadow of EPROM/flash EPROM - usually
written by BIOS executing from EPROM and then made read-only by
programming chipset registers). This involves main motherboard BIOS
(usually 64 KB at 0xF000-0xFFFF) and any extension BIOSes (VGA, LAN
etc) in 0xC000-0xEFFF (or 0xC000-0xDFFF) range.

The remaining RAM from 0xA000-0xFFFF is unusable. One could program
chipset registers to enable parts of this RAM. It would require
knowledge of particular chipset registers, and there might be only
one read-only/read-write bit for all shadows (so, unless you want the
shadow BIOS to be R/W, the additional RAM would have to be R/O).
RAM is quite cheap and these things are very non-standard so I think
nobody bothers.

And yes, older machines (older chipsets) used to remap fragments of
this memory to the top of RAM. It was common on 80286 machines and
I probably haven't seen a 386DX or faster board doing that.
-- 
Krzysztof Halasa
Network Administrator
