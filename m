Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbVJFS34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbVJFS34 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 14:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbVJFS34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 14:29:56 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4872 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751289AbVJFS3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 14:29:55 -0400
Date: Thu, 6 Oct 2005 19:29:38 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Mark Underwood <basicmark@yahoo.com>
Cc: David Brownell <david-b@pacbell.net>, vwool@ru.mvista.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       pavel@ucw.cz, linux-kernel@vger.kernel.org, dpervushin@gmail.com
Subject: Re: [PATCH/RFC 1/2] simple SPI framework
Message-ID: <20051006182938.GA5312@flint.arm.linux.org.uk>
Mail-Followup-To: Mark Underwood <basicmark@yahoo.com>,
	David Brownell <david-b@pacbell.net>, vwool@ru.mvista.com,
	stephen@streetfiresound.com,
	spi-devel-general@lists.sourceforge.net, pavel@ucw.cz,
	linux-kernel@vger.kernel.org, dpervushin@gmail.com
References: <20051005143946.7D9C9EE8EC@adsl-69-107-32-110.dsl.pltn13.pacbell.net> <20051006182349.7430.qmail@web33007.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051006182349.7430.qmail@web33007.mail.mud.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2005 at 07:23:48PM +0100, Mark Underwood wrote:
> --- David Brownell <david-b@pacbell.net> wrote:
> > Vitaly ... comments from Russell and Pavel both addresses your comments
> > about that obsolete parameter.  What letter?  The one I remember was
> > one responding to Mark Underwood (?) where you complained about issuing
> > three calls for one suspend event.  You can't have it both ways!!
> > Either that parameter should be used in the documented way (call the
> > suspend method three times, one right after another) or it should be used
> > more sanely (parameter is constant.
> 
> Yes, that was in reply to my SPI subsystem patch set (in which Vitaly
> didn't like the fact that I call suspend/resume 3 times) and then in
> the same thread (in answer to David's response of dropping this as he
> didn't think anyone would mind this) Vitaly said that you can't do this.

Vitaly has a problem then.  We must _not_ call suspend three times
just because it has different "levels" - SUSPEND_DISABLE,
SUSPEND_SAVE_STATE and SUSPEND_POWER_DOWN.

As I've said earlier in the thread, the only reason these exist is
because no one has gone to the effort of cleaning up the crap left
behind from PM version 1 for the platform devices.

When PM v2 happened, I just hacked the platform device drivers to
work with this new model.  So please consider the three argument
suspend callback a legacy feature and if you're going to use it,
call it exactly once.

And please document that this is the case for your bus type, and
that the "level" argument is meaningless.  Better still, please
do not use the device_driver suspend/resume pointers at all.  Same
argument applies - only platform devices use them, and these should
eventually be killed off.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
