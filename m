Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265326AbUAFDkX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 22:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265329AbUAFDkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 22:40:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:22192 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265326AbUAFDkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 22:40:22 -0500
Date: Mon, 5 Jan 2004 19:40:11 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@muc.de>
cc: David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
In-Reply-To: <m37k054uqu.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.4.58.0401051937510.2653@home.osdl.org>
References: <1aJdi-7TH-25@gated-at.bofh.it> <m37k054uqu.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Jan 2004, Andi Kleen wrote:
> 
> IMHO the only reliable way to get physical bus space for mappings
> is to allocate some memory and map the mapping over that.

You literally can't do that: the RAM addresses are decoded by the 
northbridge before they ever hit the PCI bus, so it's impossible to "map 
over" RAM in general. 

Normally, the way this works is that there are magic northbridge mapping
registers that remap part of the memory, so that the memory that is
physically in the upper 4GB of RAM shows up somewhere else (or just
possibly disappears entirely - once you have more than 4GB of RAM, you
might not care too much about a few tens of megs missing).

			Linus
