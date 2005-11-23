Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbVKWQFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbVKWQFa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbVKWQFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:05:30 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48913 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751185AbVKWQF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:05:29 -0500
Date: Wed, 23 Nov 2005 16:05:20 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Marc Koschewski <marc@osknowledge.org>
Cc: Jon Smirl <jonsmirl@gmail.com>, Vojtech Pavlik <vojtech@suse.cz>,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Christmas list for the kernel
Message-ID: <20051123160520.GH15449@flint.arm.linux.org.uk>
Mail-Followup-To: Marc Koschewski <marc@osknowledge.org>,
	Jon Smirl <jonsmirl@gmail.com>, Vojtech Pavlik <vojtech@suse.cz>,
	Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com> <20051122204918.GA5299@kroah.com> <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com> <20051123121726.GA7328@ucw.cz> <9e4733910511230643j64922738p709fecd6c86b4a95@mail.gmail.com> <20051123150349.GA15449@flint.arm.linux.org.uk> <9e4733910511230712y2b394851rc17fa71c6f9c6ecf@mail.gmail.com> <20051123155650.GB6970@stiffy.osknowledge.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123155650.GB6970@stiffy.osknowledge.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 04:56:50PM +0100, Marc Koschewski wrote:
> * Jon Smirl <jonsmirl@gmail.com> [2005-11-23 10:12:58 -0500]:
> 
> > On 11/23/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > > > Plus I have 64 tty devices. Couldn't the tty devices be created
> > > > dynamically as they are consumed? Same for the loop and ram devices?
> > >
> > > You do realise that the dynamic device creation for those 64 console
> > > devices is done via the console device being _opened_ by userspace?
> > >
> > > Hence, if the device doesn't exist in userspace, it can't be created
> > > for userspace to open it to create the device via udev.  Have you
> > > noticed a catch-22 with that statement?
> > 
> > Couldn't we create tty0-3 and then when one of those gets opened,
> > create tty4, and so on? Then there would always be two or three more
> > tty devices than there are open tty devices.
> > 
> 
> How does that work when you ie. have tty0, tty1, tty2, tty3 per default,
> open tty4, tty5, tty6 and the close tty4? And what if you then open
> another? Will it be tty4 oder tty7? If so, what if the maximum numer is
> reached even if only 3 ttys are left open?

And what if you want consoles on 1-6 and syslog messages on tty12?

Also, remember that when init starts the gettys on tty1-N, they're
started in parallel, so you will end up with the gettys opening those
in a random order.

Therefore, you can not infer that if tty1 has been opened, tty2 will
be next, followed by tty3 and then tty4, etc.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
