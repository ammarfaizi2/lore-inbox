Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129414AbRBSLyq>; Mon, 19 Feb 2001 06:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129384AbRBSLyh>; Mon, 19 Feb 2001 06:54:37 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:30244 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129170AbRBSLy1>; Mon, 19 Feb 2001 06:54:27 -0500
Date: Mon, 19 Feb 2001 05:54:11 -0600 (CST)
From: Philipp Rumpf <prumpf@mandrakesoft.com>
Reply-To: Philipp Rumpf <prumpf@mandrakesoft.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, prumpf@parcelfarce.linux.theplanet.co.uk,
        rusty@linuxcare.com
Subject: Re: Linux 2.4.1-ac15
In-Reply-To: <E14Uob0-0003Cs-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1010219054120.16489F-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2001, Alan Cox wrote:
>         mod->next = module_list;

put_mod_name() here.

>         module_list = mod;      /* link it in */
> 
> Note no write barrier.

put_mod_name calls free_page which always implies a memory barrier.  This
isn't beautiful but it won't blow up either.

Actually that isn't relevant since the actual table is copied _after_
ex_table_{start,end}.  We'll scan uninitialized memory and if some word
happens to match the fault EIP we jump to the bogus fixup.

> Delete is even worse
> 
> We unlink the module
> We free the memory
> 
> At the same time another cpu may be walking the exception table that we free.

True.

Rusty had a patch that locked the module list properly IIRC.


