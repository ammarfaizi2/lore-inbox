Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269006AbUJUQmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269006AbUJUQmk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 12:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268838AbUJUQmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 12:42:08 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:45020 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268824AbUJUQkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 12:40:35 -0400
Subject: Re: Linux v2.6.9 (Strange tty problem?)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Paul <set@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1098364808.2815.38.camel@deimos.microgate.com>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org>
	 <20041021024132.GB6504@squish.home.loc>
	 <1098349651.17067.3.camel@localhost.localdomain>
	 <1098364808.2815.38.camel@deimos.microgate.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098373052.17052.141.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 21 Oct 2004 16:37:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-10-21 at 14:20, Paul Fulghum wrote:
> This restores the original behavior for
> devices that have not yet implemented ldisc->hangup()
> and should work with the new locking.

Unfortunately that re-introduces another existing unfixed problem. The
N_TTY layer echoes bytes back up the stack into the drivers which are in
hangup state.

I did try calling the set_tty_ldisc but not every driver in that
situation then did the right thing and I got stuck ttys too. I think
that is fixed but 2.6.9rc4 was a bit tight. 

If you want to do the tty_ldisc_set then add a "nulldisc" that just eats
anything it is fed and EOF's anything the other direction. That
would avoid the driver reflect crash I suspect.

