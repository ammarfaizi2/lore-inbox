Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbVEZRey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbVEZRey (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 13:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVEZRey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 13:34:54 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:12949 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S261642AbVEZRee
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 13:34:34 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: [linux-pm] potential pitfall? changing configuration while PC in hibernate (fwd)
Date: Thu, 26 May 2005 10:34:27 -0700
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, cijoml@volny.cz,
       linux-kernel@vger.kernel.org
References: <20050321184512.GA1390@elf.ucw.cz> <200503212310.37801.cijoml@volny.cz> <20050525164701.52a45680.akpm@osdl.org>
In-Reply-To: <20050525164701.52a45680.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505261034.28186.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 May 2005 4:47 pm, Andrew Morton wrote:
> Michal Semler <cijoml@volny.cz> wrote:
> >
> > It is real stupid, that Linux kernel freezes when simply during hibernate I 
> > change Bluetooth dongle to USB mouse in my USB port.

That is, you unplug the dongle -- breaking the USB power session -- and then
plug in a mouse?  And the kernel does something other than disconnecting the
dongle, and then enumerate a new mouse?  That'd be a bug.  Somewhere.  It'd
probably help a lot if the bluetooth USB driver had a suspend() method.

It's not clear to me what you mean by "hibernate".  If that's an "everything
powered off" pseudo-suspend state, then the dongle should always be getting
disconnected, and USB always re-enumerated by Linux.  Only "real suspend"
states, like suspend-to-RAM, can normally maintain USB power sessions.  And
even then, the device drivers need to be prepared to maintain them ... and
do things like stop active I/O requests, and resume them later.

You said this was an all-Intel system.  So which host controller driver is
in use here ... UHCI?  EHCI?  With RC5 and CONFIG_USB_DEBUG, what do the
USB debug messages say is happening?  Does CONFIG_USB_SUSPEND change things?
Try this with purely modular USB for now.

- Dave

