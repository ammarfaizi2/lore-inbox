Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261574AbTCOVod>; Sat, 15 Mar 2003 16:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261584AbTCOVod>; Sat, 15 Mar 2003 16:44:33 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:55192 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261574AbTCOVoc>; Sat, 15 Mar 2003 16:44:32 -0500
To: Andrew Morton <akpm@digeo.com>
Cc: bzzz@tmi.comex.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from ext2's readdir
From: Andi Kleen <ak@muc.de>
Date: Sat, 15 Mar 2003 22:55:11 +0100
In-Reply-To: <20030315023614.3e28e67b.akpm@digeo.com.suse.lists.linux.kernel> (Andrew
 Morton's message of "15 Mar 2003 11:38:42 +0100")
Message-ID: <m3adfwnvls.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <m3vfyluedb.fsf@lexa.home.net.suse.lists.linux.kernel>
	<20030315023614.3e28e67b.akpm@digeo.com.suse.lists.linux.kernel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:

> foo_readdir()
> {
> 	loff_t pos = file->f_pos;
>
> 	....
> 	<code which doesn't touch file->f_pos, but which modifies pos>
> 	...
>
> 	file->f_pos = pos;
> }

At least for alpha this will require an rmb_depends() between the read
and the write. Probably on x86 an rmb() wouldn't hurt neither.

Otherwise there is no guarantee other CPUs see that intended memory 
modification order

-Andi
