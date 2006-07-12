Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWGLLTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWGLLTI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 07:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWGLLTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 07:19:08 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50562 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751258AbWGLLTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 07:19:06 -0400
Subject: Re: tty's use of file_list_lock and file_move
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Theodore Tso <tytso@mit.edu>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e4733910607111650m16630157ya8c27949ae639ffc@mail.gmail.com>
References: <9e4733910607100810r6e02f69g9a3f6d3d1400b397@mail.gmail.com>
	 <1152554708.27368.202.camel@localhost.localdomain>
	 <9e4733910607101535i7f395686p7450dc524d9b82ae@mail.gmail.com>
	 <1152573312.27368.212.camel@localhost.localdomain>
	 <9e4733910607101604j16c54ef0r966f72f3501cfd2b@mail.gmail.com>
	 <9e4733910607101649m21579ae2p9372cced67283615@mail.gmail.com>
	 <20060711012904.GD30332@thunk.org>
	 <20060711194456.GA3677@flint.arm.linux.org.uk>
	 <9e4733910607111508x526ee642p5b587698306b22d3@mail.gmail.com>
	 <1152657465.18028.72.camel@localhost.localdomain>
	 <9e4733910607111650m16630157ya8c27949ae639ffc@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 12 Jul 2006 12:37:11 +0100
Message-Id: <1152704232.22943.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-07-11 am 19:50 -0400, ysgrifennodd Jon Smirl:
> My original goal was to do some work on the VT layer but I got sucked
> into the TTY code because of VT/TTY interactions. I think I understand
> enough now that I can make changes in the VT code without breaking
> everything. I also see now that the VT code wasn't as closely
> intertwined into the TTY code as much as I initially thought it was.

VT is just an instance of a tty driver, at least from the tty layer
viewpoint.

> This may also explain why the init functions are all chained together.
> tty_init() -> vty_init() -> vcs_init(), kbd_init(), prom_con_init(),
> etc... Since the link order is wrong the chained init functions are
> compensating.

Its a bit more fundamental than that, there are various video side init
functions that are done before the module_init calls are made. The VT is
both a tty driver and a console.

The only real "magic" hooks in there are the resize one and the ioctl
hook. The resize one could easily be moved to be a tty driver method
that is usually NULL and would be a nice cleanup. 

Alan

