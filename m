Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269048AbUIXTnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269048AbUIXTnz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 15:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269082AbUIXTnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 15:43:55 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59665 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269048AbUIXTnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 15:43:50 -0400
Date: Fri, 24 Sep 2004 20:43:46 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.9-rc2-mm3
Message-ID: <20040924204345.C11325@flint.arm.linux.org.uk>
Mail-Followup-To: Paul Fulghum <paulkf@microgate.com>,
	James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <Xine.LNX.4.44.0409241210220.8009-100000@thoron.boston.redhat.com> <1096051977.1938.5.camel@deimos.microgate.com> <1096053328.1938.11.camel@deimos.microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1096053328.1938.11.camel@deimos.microgate.com>; from paulkf@microgate.com on Fri, Sep 24, 2004 at 02:15:28PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 02:15:28PM -0500, Paul Fulghum wrote:
> The core purpose of tty_termios_baud_rate() is
> 'read only': returning a value from a table referenced
> by an index in the termios structure.
> 
> It currently also performs a sanity check for
> the index and adjusts the index if it is out of bounds.
> I assume the lock is held to protect this
> possible write access to the termios structure.
> 
> Would it not make sense to move the sanity check
> to change_termios, which would then allow removal
> of the locks from tty_termios_baud_rate()?
> (which also removes the deadlock)

Well, this is not the only place where the termios can be changed.
Drivers can change it in their set_termios method, and are in fact
required to do so for POSIX compliance.

IOW, any feature which drivers are unable to alter needs to
"unsettable".  Eg, a port supporting only 8 bit data transmission
must not report in termios that it is set to 7 bit data transmission.

Unfortunately the way the tty layer currently goes about setting
termios settings does not lend itself well to conforming to that.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
