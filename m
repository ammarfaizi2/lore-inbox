Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266528AbTAFK0A>; Mon, 6 Jan 2003 05:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266514AbTAFKZ7>; Mon, 6 Jan 2003 05:25:59 -0500
Received: from [217.167.51.129] ([217.167.51.129]:48383 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S266528AbTAFKZ6>;
	Mon, 6 Jan 2003 05:25:58 -0500
Subject: Re: [patch 2.5] PCI: allow alternative methods for probing the BARs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Paul Mackerras <paulus@samba.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       grundler@cup.hp.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0301052009050.3087-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0301052009050.3087-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1041848998.666.4.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 06 Jan 2003 11:31:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-06 at 05:14, Linus Torvalds wrote:

> Alternatively, we could even have a very limited phase #1 that only 
> enumerates _reachable_ devices (ie it doesn't even try to create bus 
> numbers, it only enumerates devices and buses that have already been set 
> up by the firmware, and ignores bridges that aren't set up yet). A pure 
> discovery phase, without any configuration at all.

That would only work for cases where the kernel isn't responsible for
the actual bus numbering/renumbering. For example, since we do not quite
deal with PCI domains yet, I have to force pcibios_assign_all_busses()
on pmac so that my 3 root busses get re-numbered (else I get 3 trees
with conflicting bus numbers all starting at 0). Another case is embedded
which can deal with completely unassigned bus numbers.

Ben.

