Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWGKTwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWGKTwx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWGKTwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:52:53 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14354 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932110AbWGKTww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:52:52 -0400
Date: Tue, 11 Jul 2006 20:52:45 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Theodore Tso <tytso@mit.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: tty's use of file_list_lock and file_move
Message-ID: <20060711195245.GB3677@flint.arm.linux.org.uk>
Mail-Followup-To: Jon Smirl <jonsmirl@gmail.com>,
	Theodore Tso <tytso@mit.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	lkml <linux-kernel@vger.kernel.org>
References: <9e4733910607100810r6e02f69g9a3f6d3d1400b397@mail.gmail.com> <1152552806.27368.187.camel@localhost.localdomain> <9e4733910607101027g5f3386feq5fc54f7593214139@mail.gmail.com> <1152554708.27368.202.camel@localhost.localdomain> <9e4733910607101535i7f395686p7450dc524d9b82ae@mail.gmail.com> <1152573312.27368.212.camel@localhost.localdomain> <9e4733910607101604j16c54ef0r966f72f3501cfd2b@mail.gmail.com> <9e4733910607101649m21579ae2p9372cced67283615@mail.gmail.com> <20060711012904.GD30332@thunk.org> <9e4733910607102033u3e308142o9be47e5a7e0c0af7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910607102033u3e308142o9be47e5a7e0c0af7@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2006 at 11:33:18PM -0400, Jon Smirl wrote:
> I tried changing it to a per tty spinlock. Now I know that the code
> relies on the BKL being broken when a task sleeps.

Not broken - it's unlocked only for the duration of the sleep.  To put
it another way, the BKL is dropped by the scheduler prior to switching
away, and is reacquired by the scheduler when resuming a thread which
previously was BKL-locked.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
