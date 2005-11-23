Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbVKWQh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbVKWQh0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbVKWQh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:37:26 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:63462 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751241AbVKWQhY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:37:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J+TeXp5zn29CzuyvoYwPphMMKUlZ+PqE2WTLjlg+ehRJMcjoZnYnIfDIvECQaQbb9eHdBX4AZW6CkKAiDiysXUaHMy2qbwv/P45X9WIdJZgAJRzauBfsCVEVP5OFbXHJSm4ot3Oa4flHTbjDteBTJVrWloDpcpqOhWs4s4Lz6Lw=
Message-ID: <9e4733910511230837v1519d3b3t28176b1fd6017ffc@mail.gmail.com>
Date: Wed, 23 Nov 2005 11:37:23 -0500
From: Jon Smirl <jonsmirl@gmail.com>
To: Marc Koschewski <marc@osknowledge.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
       rmk+lkml@arm.linux.org.uk
Subject: Re: Christmas list for the kernel
In-Reply-To: <20051123160520.GH15449@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
	 <20051122204918.GA5299@kroah.com>
	 <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com>
	 <20051123121726.GA7328@ucw.cz>
	 <9e4733910511230643j64922738p709fecd6c86b4a95@mail.gmail.com>
	 <20051123150349.GA15449@flint.arm.linux.org.uk>
	 <9e4733910511230712y2b394851rc17fa71c6f9c6ecf@mail.gmail.com>
	 <20051123155650.GB6970@stiffy.osknowledge.org>
	 <20051123160520.GH15449@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Wed, Nov 23, 2005 at 04:56:50PM +0100, Marc Koschewski wrote:
> > * Jon Smirl <jonsmirl@gmail.com> [2005-11-23 10:12:58 -0500]:
> >
> > > On 11/23/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > > > > Plus I have 64 tty devices. Couldn't the tty devices be created
> > > > > dynamically as they are consumed? Same for the loop and ram devices?
> > > >
> > > > You do realise that the dynamic device creation for those 64 console
> > > > devices is done via the console device being _opened_ by userspace?
> > > >
> > > > Hence, if the device doesn't exist in userspace, it can't be created
> > > > for userspace to open it to create the device via udev.  Have you
> > > > noticed a catch-22 with that statement?
> > >
> > > Couldn't we create tty0-3 and then when one of those gets opened,
> > > create tty4, and so on? Then there would always be two or three more
> > > tty devices than there are open tty devices.
> > >
> >
> > How does that work when you ie. have tty0, tty1, tty2, tty3 per default,
> > open tty4, tty5, tty6 and the close tty4? And what if you then open
> > another? Will it be tty4 oder tty7? If so, what if the maximum numer is
> > reached even if only 3 ttys are left open?
>
> And what if you want consoles on 1-6 and syslog messages on tty12?
>
> Also, remember that when init starts the gettys on tty1-N, they're
> started in parallel, so you will end up with the gettys opening those
> in a random order.
>
> Therefore, you can not infer that if tty1 has been opened, tty2 will
> be next, followed by tty3 and then tty4, etc.

Before everyone gets excited, I realize that all of this has
historical implications. But that doesn't mean we can't discuss
possible future alternative solutions.

Thinking about this for a while it seems to me that the problem is
that the various apps (init, syslog) etc should not have a tty name as
part of their command line parameters. Instead these apps could use
ptys instead. Ptys would solve all of the race problems too.

Is there any good reason (other than history) for using a device node
name (tty0, etc) instead of some other naming scheme if names are
needed at all?

If init, syslog, etc can be converted to ptys, do we need ttys? Xterms
use ptys I don't notice that they aren't connect to a fix tty name.
The virtual consoles would still be 0,1,2 but do they have to be
hooked to tty0, 1, 2 instead of a pty?

--
Jon Smirl
jonsmirl@gmail.com
