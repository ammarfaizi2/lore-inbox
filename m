Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129517AbRBSQtZ>; Mon, 19 Feb 2001 11:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129738AbRBSQtP>; Mon, 19 Feb 2001 11:49:15 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:19516 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129517AbRBSQtC>; Mon, 19 Feb 2001 11:49:02 -0500
Date: Mon, 19 Feb 2001 10:48:28 -0600 (CST)
From: Philipp Rumpf <prumpf@mandrakesoft.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, prumpf@parcelfarce.linux.theplanet.co.uk,
        rusty@linuxcare.com
Subject: Re: Linux 2.4.1-ac15
In-Reply-To: <E14UtNQ-0003rp-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1010219104445.32729C-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2001, Alan Cox wrote:
> > So you fixed the nonexistent race only.  The real race is that the module
> 
> Umm I fixed the small race. You are right that there is a second race.

There's just one race.  The small race is nonexistent since
put_mod_name always acts as a memory barrier.

> > uninitialized vmalloc'd (module_map'd) memory), then the module data
> > (including the exception table) gets copied.
> > The race window is from the first copy_from_user in sys_init_module until
> > the second one.
> 
> Yep. Obvious answer. Ignore exception tables for modules that are not
> MOD_RUNNING.

You can have exceptions while initializing.  not
MOD_RUNNING|MOD_INITIALIZING should work though.

