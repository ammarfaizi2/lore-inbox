Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbTEJQDC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 12:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264420AbTEJQDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 12:03:01 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:52864 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S264419AbTEJQC7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 12:02:59 -0400
Date: Sat, 10 May 2003 17:15:29 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@muc.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use correct x86 reboot vector
Message-ID: <20030510161529.GB29271@mail.jlokier.co.uk>
References: <20030510025634.GA31713@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030510025634.GA31713@averell>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Extensive discussion by various experts on the discuss@x86-64.org
> mailing list concluded that the correct vector to restart an 286+ 
> CPU is f000:fff0, not ffff:0000. Both seem to work on current systems, 
> but the first is correct.

You are right.  That's what a 286 does when the RESET signal is asserted.

Which is amazing, because I wrote that ffff:0000 and I was reading
from the Phoenix BIOS book at the time.  It was long ago but I'm
fairly sure I got that address from the book.

I just did some Googling and found that there examples of DOS code
fragments using both vectors.  Also, the original IBM BIOS (as they
say) had a long jump at the vector, which is presumably one of the
many de facto ABIs which real mode programmers grew to depend on.

> See the "DPMI on AMD64" and "Warm reboot for x86-64 linux" threads
> on http://www.x86-64.org/mailing_lists/list?listname=discuss&listnum=0 
> for more details.

One would hope that AMD64 systems, being a new design and all, offer a
documented and reliable method of rebooting.

It should never be necessary to have to write "reboot=..." on the
kernel command line to choose which legacy method works on different
AMD64 motherboards.  Am I too idealistic?

-- Jamie
