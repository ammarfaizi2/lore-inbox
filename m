Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262682AbUJ0Xtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262682AbUJ0Xtb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 19:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262678AbUJ0Xsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 19:48:32 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:5612 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S262682AbUJ0Xph
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 19:45:37 -0400
From: David Brownell <david-b@pacbell.net>
To: Colin Leroy <colin@colino.net>
Subject: Re: [linux-usb-devel] 2.6.10-rc1 OHCI usb error messages
Date: Wed, 27 Oct 2004 15:59:37 -0700
User-Agent: KMail/1.6.2
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20041026172843.6ac07c1a.colin@colino.net> <200410260905.14869.david-b@pacbell.net> <20041027110756.3217ed68.colin@colino.net>
In-Reply-To: <20041027110756.3217ed68.colin@colino.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410271559.37540.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 October 2004 02:07, Colin Leroy wrote:
> On 26 Oct 2004 at 09h10, David Brownell wrote:
> 
> > What's wrong there is emitting voluminous diagnostics for
> > something that's not an error ... the root hub is suspended,
> > and as with any suspended device, you can't talk to it.
> 
> Btw, there's something else wrong, because the root hub shouldn't be 
> suspended during boot, should it ?

You're not reporting that it fails to activate when there's an
active device connected; and you obviously enabled CONFIG_PM,
which Kconfig says means that

	... parts of your computer are shut off or put into a
	power conserving "sleep" mode if they are not being used.

So:  since it's not being actively used then, why shouldn't the
root hub (or any other device) be suspended?  During boot, or at
any other time.  So long as it works when you plug in a USB device,
it looks to me like everything is behaving quite reasonably.


> At least, it's not on 2.6.9. Also, 
> lsusb -v fails with long timeouts due to that on 2.6.10-rc1, not on 2.6.9.

I've never observed "lsusb" ever timing out when accessing a
suspended USB device; the URB submissions fail right away.
So if something's timing out, it's for some other reason.
(Such as bugs in "lsusb"; the "usbutils" package is overdue
for a new release, it's changed a lot since the 0.11 tarball
that's widely available.)

- Dave
