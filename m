Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263670AbUDOJJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 05:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbUDOJJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 05:09:27 -0400
Received: from mail1.kontent.de ([81.88.34.36]:38348 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S263670AbUDOJJZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 05:09:25 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Duncan Sands <baldrick@free.fr>, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] [PATCH 7/9] USB usbfs: destroy submitted urbs only on the disconnected interface
Date: Thu, 15 Apr 2004 11:08:52 +0200
User-Agent: KMail/1.5.1
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Frederic Detienne <fd@cisco.com>
References: <200404141245.37101.baldrick@free.fr> <200404151031.19940.oliver@neukum.org> <200404151047.48239.baldrick@free.fr>
In-Reply-To: <200404151047.48239.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404151108.52351.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 15. April 2004 10:47 schrieb Duncan Sands:
> > > Hi Oliver, I thought you meant that CONFIG_EMBEDDED made WARN_ON go
> > > away (or something like that).  If you just mean that it is easy to
> > > redefine WARN_ON by hand, then all I can say is: it is also easy to
> > > redefine warn by hand!  Anyway, I made you the following patch:
> >
> > Yes, but I don't trust gcc to optimise away the 'if' if you redefine
> > warn().
>
> The "if" cannot be optimized away for the case in point, because it
> does something (clears the bit) if it passes the test.  If I used WARN_ON
> then it would have to be WARN_ON(1) in the else branch of the if.

True. You should use BUG_ON().
If this ever happens the device tree is screwed. There's no use going on.

> > But there is another point. The embedded people deserve a single switch
> > to remove assertion checks. The purpose of macros like WARN_ON() is
> > easy and _central_ choice of debugging output vs. kernel size.
>
> This is not an argument against using USB's warn, it is an argument for
> building warn on top of a centralized macro like WARN_ON or a friend.

It is an argument against USB making its own constructs. There's nothing
terribly specific about USB that would justify it. If the usual debug statements
are inadequate, improve them.

	Regards
		Oliver

