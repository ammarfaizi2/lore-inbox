Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266374AbUBLG3h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 01:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266385AbUBLG3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 01:29:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:45724 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266374AbUBLG3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 01:29:31 -0500
Date: Wed, 11 Feb 2004 22:29:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, benh@ozlabs.org
Subject: Re: PPC64 PowerMac G5 support available
In-Reply-To: <1076563481.2285.167.camel@gaston>
Message-ID: <Pine.LNX.4.58.0402112223480.5816@home.osdl.org>
References: <1076563481.2285.167.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Feb 2004, Benjamin Herrenschmidt wrote:
> 
> Linus: you will probably need an updated radeonfb anyway as I told
> you. I'll start working on it now and will post a patch separately.

Actually, at least for me, the _old_ radeon driver works without any 
modifications at all in text mode. Rock stable image, unlike the new one 
that needed the clock fixes.

But trying to start X hangs the system hard, which may well be an issue 
with the old radeonfb. Whenever you have a new driver, I will test.

> Also, there is currently a known build problem with the zImage wrapper
> in 2.6.3-rc2, unrelated to this patch, it doesn't prevent the build of
> the plain vmlinux which is what yaboot uses on the G5.

Actually, there's another issue, which is that the default G5 config 
enables drivers/serial/pmac_zilog.c, which has a

	#include <asm/kgdb.h>

in it that will cause the build to fail.

Anyway, with that fixed, it will compile and appears to work on the G5. 
Thanks. Although I did see it hang when I inserted a USB keyboard (in 
addition to the X problem). Hmm.

		Linus
