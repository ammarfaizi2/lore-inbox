Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWC1JWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWC1JWp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 04:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWC1JWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 04:22:44 -0500
Received: from 213-140-2-71.ip.fastwebnet.it ([213.140.2.71]:2219 "EHLO
	aa004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751251AbWC1JWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 04:22:44 -0500
Date: Tue, 28 Mar 2006 11:22:41 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Random GCC segfaults -- Was: [2.6.16] slab error in
 slab_destroy_objs(): cache `radix_tree_node'...
Message-ID: <20060328112241.40b9c975@localhost>
In-Reply-To: <20060328004137.607e51db.akpm@osdl.org>
References: <20060326215346.1b303010@localhost>
	<20060328095521.52ea3424@localhost>
	<20060328004137.607e51db.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.12; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2006 00:41:37 -0800
Andrew Morton <akpm@osdl.org> wrote:

> If those errors had no corresponding kernel messages then what you have is
> a classic symptom of failing memory hardware.  Suggest you grab memtest86,
> run it for 24 hours.

I've already run memtest86+ for hours (not 24 ok... "only" 4/5h) and I
found this:

An easly reproducilble memory failure (single bit flipping always at
the same address) <---- this one goes AWAY disabling bank interleaving
in BIOS.

Another memory failure (different address, always one bit flipping)
isn't found by memtest86+: I found it with CONFIG_DEBUG_SLAB and
I "fixed" it with memmap=... boot option.


Now, these 2 problems are both in my first 256MB memory module, so maybe
it is really another memory failure.

BUT now that I'm back on 2.6.15.6 I'm compiling a LOT of big CPP
projects and I haven't seen a single GCC segfault yet.

Maybe I should retry with 2.6.16 and if I can reproduce the problem I
can start testing 2.6.16-rc1 and so on...

-- 
	Paolo Ornati
	Linux 2.6.15.6 on x86_64
