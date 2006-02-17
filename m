Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbWBQV0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWBQV0v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 16:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbWBQV0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 16:26:51 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61707 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750854AbWBQV0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 16:26:50 -0500
Date: Fri, 17 Feb 2006 21:26:32 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Kilau, Scott" <Scott_Kilau@digi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SIIG 8-port serial boards support
Message-ID: <20060217212632.GD13502@flint.arm.linux.org.uk>
Mail-Followup-To: "Kilau, Scott" <Scott_Kilau@digi.com>,
	linux-kernel@vger.kernel.org
References: <335DD0B75189FB428E5C32680089FB9F8034C6@mtk-sms-mail01.digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <335DD0B75189FB428E5C32680089FB9F8034C6@mtk-sms-mail01.digi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 02:32:03PM -0600, Kilau, Scott wrote:
> Hi everyone,
> (Sorry for the ugly copy/paste here, grabbing from a web browser to
> email)
> 
> On Fri, Feb 17, 2006 at 08:02:13PM +0000, Russell King wrote:
> > Finally, let me explain why I favour the termios solution.  The
> biggest
> > (and most important) aspect is that it allows existing applications
> > such as minicom and gettys to work as expected - getting the correct
> > handshaking mode that they desire without having to change userspace.
> 
> What about creating a "struct termiox".
> Yeah, it creates a new ioctl, but it is a pretty standard
> ioctl among Unix's.
> 
> I know adding termiox calls has been brought up before in
> the past, and of course, nothing ever gets added...

That still requires getty's and minicom etc to be modified, and as
I point out in my follow up mail, not having getty understand it
can be a security issue.

Since we do have spare bits in cflag, I see no reason not to use
them.  If we use these spare bits, we stand a good chance that we'll
have the desired behaviour without modifying userland.

I've seen the occasional alternative suggestion, but no one has yet
put forward a coherent argument against using termios's cflags to
control the handshake mode.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
