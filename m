Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269291AbUIYJTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269291AbUIYJTs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 05:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269292AbUIYJTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 05:19:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13833 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269291AbUIYJTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 05:19:44 -0400
Date: Sat, 25 Sep 2004 10:19:37 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.9-rc2-mm3
Message-ID: <20040925101937.A29796@flint.arm.linux.org.uk>
Mail-Followup-To: Paul Fulghum <paulkf@microgate.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <Xine.LNX.4.44.0409241127220.7816-300000@thoron.boston.redhat.com> <Xine.LNX.4.44.0409241210220.8009-100000@thoron.boston.redhat.com> <20040925013135.GJ9106@holomorphy.com> <1096082711.7111.38.camel@at2.pipehead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1096082711.7111.38.camel@at2.pipehead.org>; from paulkf@microgate.com on Fri, Sep 24, 2004 at 10:25:11PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 10:25:11PM -0500, Paul Fulghum wrote:
> My suggestion was flawed in that it could
> violate POSIX requirements (as Russell pointed out).
> 
> Removing the lock from tty_termios_baud_rate(), tty_io.c
> corrects the problem for the path from change_termios()
> to tty_termios_baud_rate(), which is causing the deadlock.
> 
> This may not be, and probably is not,
> correct for all paths to tty_termios_baud_rate().

I wonder if we should consider adding:

	WARN_ON(!spin_is_locked(&tty_termios_lock));

in there.

However, the one annoying thing about "spin_is_locked" is that, on UP,
it defaults to "unlocked" which makes these kinds of checks too noisy.
Maybe we need a spin_is_locked() with a bias towards being locked for UP?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
