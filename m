Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbTDUXpg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 19:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262685AbTDUXpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 19:45:36 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:10884 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262683AbTDUXpc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 19:45:32 -0400
Date: Tue, 22 Apr 2003 00:57:32 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@muc.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Runtime memory barrier patching
Message-ID: <20030421235732.GA17793@mail.jlokier.co.uk>
References: <20030421192734.GA1542@averell> <Pine.LNX.4.44.0304211254190.17221-100000@home.transmeta.com> <20030421205333.GA13883@averell> <20030421233557.GB17595@mail.jlokier.co.uk> <20030421234611.GA15191@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030421234611.GA15191@averell>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> > Such as removing the lock prefix when running non-SMP?
...
> .altinstructions section after load to avoid too much kernel bloat (it
> currently costs 7 byte + the length of the replacement. And lock
> is quite common in the kernel these days.

1. It should cost at most 4 bytes, in a table of "remove me" address,
with topmost bits of each word used to give the length of the
instruction to remove - i.e. to replace with an optimal nop sequence.

2. Not just locks - a lot of spinlock code could be removed completely.
I don't have an opinion on whether this is worth doing - one can
simply run a UP kernel after all.

-- Jamie
