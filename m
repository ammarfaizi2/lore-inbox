Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263807AbUDOJVf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 05:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbUDOJVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 05:21:35 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:32962 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S263882AbUDOJVd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 05:21:33 -0400
From: Duncan Sands <baldrick@free.fr>
To: Oliver Neukum <oliver@neukum.org>, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] [PATCH 7/9] USB usbfs: destroy submitted urbs only on the disconnected interface
Date: Thu, 15 Apr 2004 11:21:31 +0200
User-Agent: KMail/1.5.4
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Frederic Detienne <fd@cisco.com>
References: <200404141245.37101.baldrick@free.fr> <200404151047.48239.baldrick@free.fr> <200404151108.52351.oliver@neukum.org>
In-Reply-To: <200404151108.52351.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404151121.31227.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The "if" cannot be optimized away for the case in point, because it
> > does something (clears the bit) if it passes the test.  If I used WARN_ON
> > then it would have to be WARN_ON(1) in the else branch of the if.
>
> True. You should use BUG_ON().
>
> If this ever happens the device tree is screwed. There's no use going on.

I'm not sure - isn't it more likely that someone stuffed up in usbfs?  BUG_ON
seems kind of harsh, since it will kill the hub thread.  If it wasn't for that I
wouldn't hesitate to use BUG_ON here.

> > > But there is another point. The embedded people deserve a single switch
> > > to remove assertion checks. The purpose of macros like WARN_ON() is
> > > easy and _central_ choice of debugging output vs. kernel size.
> >
> > This is not an argument against using USB's warn, it is an argument for
> > building warn on top of a centralized macro like WARN_ON or a friend.
>
> It is an argument against USB making its own constructs. There's nothing
> terribly specific about USB that would justify it. If the usual debug
> statements are inadequate, improve them.

I don't see that there is anything wrong with USB using it's own constructs even
if they were just defined to be equal to some centralized macro (as they probably
should be).  In fact there is an advantage: they can be modified for debugging
purposes (to add a backtrace for example) without disturbing the rest of the
kernel.

All the best,

Duncan.
