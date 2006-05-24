Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWEYCDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWEYCDU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 22:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWEYCDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 22:03:20 -0400
Received: from smtp.enter.net ([216.193.128.24]:14 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S964802AbWEYCDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 22:03:20 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: OpenGL-based framebuffer concepts
Date: Wed, 24 May 2006 22:03:03 +0000
User-Agent: KMail/1.8.1
Cc: Helge Hafting <helge.hafting@aitel.hist.no>,
       Jon Smirl <jonsmirl@gmail.com>, Manu Abraham <abraham.manu@gmail.com>,
       linux cbon <linuxcbon@yahoo.fr>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <44740533.7040702@aitel.hist.no> <447465C6.3090501@ums.usu.ru>
In-Reply-To: <447465C6.3090501@ums.usu.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605242203.04605.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 May 2006 13:55, Alexander E. Patrakov wrote:
> Helge Hafting wrote:
> > Now, a panic/oops message is sure better than a silent hang, but that's
> > it, really.
> > Anything less than that should just go in a logfile where the admin can
> > look
> > it up later.  The very ability to write on the console will alway be
> > abused by some application programmer or kernel driver module vendor.
> > Blindly writing on the console won't be very useful either, the user
> > might be running a game or video which overwrites the message within
> > 1/30s anyway.
> > Well, perhaps it can be done better than that, with some thought. I.e. :
> >
> > * block all further access to /dev/fb0, processes will wait.
> > * Mark graphichs memory "not present" for any process that have it
> > mapped, so as to pagefault anyone using it directly.  (read-only is not
> > enough, processes should see the graphichs memory they expect, not
> >  the kernel message)
> > * Try to allocate memory for saving the screen image (assuming the
> >   machine won't hang completely, it will often keep running after an
> > oops) * Annoy the user by showing the message
> > * Provide some way of letting the user decide when to proceed, such
> >   as pressing a key
> > * Restore the saved screen memory (if that allocation was successful)
> > * Mark framebuffer memory present, releasing pagefaulted processes
> > * Unblock /dev/fb0
>
> Still too complex. Can't this be simplified to:
>
>   * Don't use the kernel text output facility for anything except panics,
> where there is no point in allowing userspace applications to continue
>   * Rely on userspace to display oopses and less important messages,
> because doing this from the kernel leads either to the complex procedure
> outlined above (where the policy is in the kernel, e.g., on which of the
> two keyboards should one wait for a keypress?) or to unreliable displaying
> of messages
>   * Have a method in the framebuffer driver for clearing the screen and
> setting a known good mode, for the Linux equivalent of a "blue screen of
> death"

Exactly - this is what I had planned on doing. Let userspace handle all other 
types of errors, as a panic is the only thing that should leave the kernel 
itself unstable.

The setting of a "known good" mode is also simple - just swap the card back to 
the boot video mode and clear the screen.

DRH
