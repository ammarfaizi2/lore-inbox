Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129393AbRBSQfZ>; Mon, 19 Feb 2001 11:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129466AbRBSQfP>; Mon, 19 Feb 2001 11:35:15 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:13360 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129393AbRBSQfC>; Mon, 19 Feb 2001 11:35:02 -0500
Date: Mon, 19 Feb 2001 10:34:49 -0600 (CST)
From: Philipp Rumpf <prumpf@mandrakesoft.com>
Reply-To: Philipp Rumpf <prumpf@mandrakesoft.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, prumpf@parcelfarce.linux.theplanet.co.uk,
        rusty@linuxcare.com
Subject: Re: Linux 2.4.1-ac15
In-Reply-To: <E14UtAP-0003po-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1010219102959.32729B-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2001, Alan Cox wrote:
> > so you hold a spinlock during copy_from_user ?  Or did you change
> > sys_init_module/sys_create_modules semantics ?
> 
> The only points I need to hold a spinlock are editing the chain and
> walking it in a case where I dont hold the kernel lock.
> 
> So I spin_lock_irqsave the two ops updating the list links in each case and
> the exception lookup walk

So you fixed the nonexistent race only.  The real race is that the module
structure gets initialized first (so the exception table pointers point to
uninitialized vmalloc'd (module_map'd) memory), then the module data
(including the exception table) gets copied.

The race window is from the first copy_from_user in sys_init_module until
the second one.

Or am I missing something ?




