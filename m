Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWC1O3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWC1O3V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 09:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWC1O3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 09:29:21 -0500
Received: from 213-140-2-69.ip.fastwebnet.it ([213.140.2.69]:24230 "EHLO
	aa002msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932161AbWC1O3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 09:29:21 -0500
Date: Tue, 28 Mar 2006 16:30:27 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Random GCC segfaults -- Was: [2.6.16] slab error in
 slab_destroy_objs(): cache `radix_tree_node'...
Message-ID: <20060328163027.1e755745@localhost>
In-Reply-To: <20060328132346.GB3300@elf.ucw.cz>
References: <20060326215346.1b303010@localhost>
	<20060328095521.52ea3424@localhost>
	<20060328004137.607e51db.akpm@osdl.org>
	<20060328112241.40b9c975@localhost>
	<20060328132346.GB3300@elf.ucw.cz>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.12; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2006 15:23:46 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> I'd really get new RAM... If the machine is "known bad", debugging on
> it is likely waste of time.

I know.

The fact is that when I was having memory problems I also have
filesystem corruption associated.

After fixing the first problem (easly reproducible) the filesystem
corruption become more rare.

After fixing the second problem (address detected by DEBUG_SLAB) I have
NEVER seen a single filesystem corruption yet.

Additionally I have tested 2.6.16-rc1 (found BAD after 20 min) and now
I'm re-testing with 2.6.15.6 --> it is compiling by some hours without
a single segfault.

So, I think it could be:

1) a memory problem exposed by the different behaviour of the kernel

2) a kernel BUG somewhere between 2.6.15 / 2.6.16.

Maybe, before using git-bisect, I can simply try to reproduce the
problem using only the first memory module (the bad one) and then try
with only the second one (good).

This should reveal if it is a memory problem or not (or maybe the
combination of GCC eating a lot of memory AND only 256MB of RAM instead
of 512MB will make the system swap a lot resulting in less memory stress
and thus make me unable to reproduce the problem ;)

-- 
	Paolo Ornati
	Linux 2.6.15.6 on x86_64
