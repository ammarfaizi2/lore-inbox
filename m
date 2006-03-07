Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751966AbWCGIwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbWCGIwa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 03:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752123AbWCGIwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 03:52:30 -0500
Received: from 213-140-2-73.ip.fastwebnet.it ([213.140.2.73]:17132 "EHLO
	aa006msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751966AbWCGIw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 03:52:29 -0500
Date: Tue, 7 Mar 2006 09:52:08 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dean Roe <roe@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel BUG at mm/slab.c:2564 - 2.6.16-rc5-g7b14e3b5
Message-ID: <20060307095208.6ddc1c4f@localhost>
In-Reply-To: <Pine.LNX.4.64.0603061112470.13139@g5.osdl.org>
References: <20060301160656.370e1ee0@localhost>
	<20060301173636.GA20861@sgi.com>
	<20060302090728.2fee8f3c@localhost>
	<Pine.LNX.4.64.0603061112470.13139@g5.osdl.org>
X-Mailer: Sylpheed-Claws 2.0.0-rc4 (GTK+ 2.8.8; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2006 11:16:13 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> On Thu, 2 Mar 2006, Paolo Ornati wrote:
> > 
> > Something is happened again here!
> 
> I think you have bad ram.
> 
> > Slab corruption: start=ffff81000d0ffb30, len=104
> > Redzone: 0x5a2cf071/0x5a2cf071.
> > Last user: [<ffffffff8015caac>](end_bio_bh_io_sync+0x35/0x39)
> > 000: 6b 6b 6b 2b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b

My suspect was that the failing addr was the same one I had already
seen some time ago with memtest86+ and that was (apparently?) fixed by
disabling "bank interleaving" in the BIOS.

But now that I've rechecked... it was a different address:

76.1 MB -- 04c0 37fc

TEST 6
good	FF FF FF FD
bad	F7 FF FF FD


The one detected with DEBUG_SLAB is at 208.99 MB (so both problems are
in my first 256MB memory module) but I'm unable to reproduce it with
memtest86+...

I wonder if these two are related in some way... or maybe it's just a
weak memory module ;)

-- 
	Paolo Ornati
	Linux 2.6.16-rc5-g501f74f2 on x86_64
