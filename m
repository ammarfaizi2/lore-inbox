Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266139AbTLIQW7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 11:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266143AbTLIQW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 11:22:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:59580 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266139AbTLIQW5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 11:22:57 -0500
Date: Tue, 9 Dec 2003 08:22:44 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jani Vaarala <flame@pygmyprojects.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11, PCMCIA,, Cirrus CL  6729 bridge not working
In-Reply-To: <20031209082544.60005.qmail@nuoli.com>
Message-ID: <Pine.LNX.4.58.0312090814210.19936@home.osdl.org>
References: <20031209082544.60005.qmail@nuoli.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Dec 2003, Jani Vaarala wrote:
>
> It is a PCI-to-PCMCIA bridge based on Cirrus Logic CL 6729 (rev 07).

Whee. Those are getting rare.

Anyway, it really looks like it's a _PCMCIA_ bridge, not a cardbus one, so
you can forget about the yenta module. Basically, "yenta" is for the newer
32-bit-capable Cardbus bridges (which do have an i82365 compatible legacy
mode), and i82365 is for the old legacy-_only_ 16-bit PCMCIA bridges.

It should be an i82365-compatible chip (they almost always are - it's
either yenta or i82365 in the normal case, and the others are for some
really odd-ball things or non-PC-compatibles).

It looks like you tried every single module _except_ for the i82365.

Give that one a whirl. Just "modprobe i82365"

		Linus
