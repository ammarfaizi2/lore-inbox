Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268968AbUJQBXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268968AbUJQBXK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 21:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268989AbUJQBXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 21:23:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:467 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268968AbUJQBXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 21:23:06 -0400
Date: Sat, 16 Oct 2004 18:21:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, axboe@suse.de
Subject: Re: Hang on x86-64, 2.6.9-rc3-bk4
Message-Id: <20041016182116.33b3b788.akpm@osdl.org>
In-Reply-To: <4171C20D.1000105@pobox.com>
References: <41719537.1080505@pobox.com>
	<417196AA.3090207@pobox.com>
	<20041016154818.271a394b.akpm@osdl.org>
	<4171B23F.6060305@pobox.com>
	<20041016171458.4511ad8b.akpm@osdl.org>
	<4171C20D.1000105@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> > Can we get a sysrq-M dump from that machine please?
> 
>  alas, for the 'hang' case, my during-initscripts console is going to 
>  strange place.  here's sysrq-m from 2.6.9-rc3-bk4 with the mm/vmscan.c 
>  patch reverted (the its-fixed version).

Is cool - I was wondering if you had the same funny NUMA zone layout.  You
do not.

So there's some new non-terminating condition in there.  It's definitely
the case that we're still failing to throttle kswapd as we should be doing,
but I left it as-is due to lack of reported problems (hah) and because the
fix does cause less reclaim via kswapd and more reclaim via direct reclaim.

Still.  The relevant patches, in order, are at
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/broken-out:

vmscan-total_scanned-fix.patch
revert-vm-no-wild-kswapd.patch
balance_pgdat-cleanup.patch
no-wild-kswapd-2.patch
no-wild-kswapd-kswapd-continue.patch

I expect the first one will fix this up.   Can you confirm?


