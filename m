Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbUKCXTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbUKCXTM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 18:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbUKCXQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 18:16:56 -0500
Received: from mail.kroah.org ([69.55.234.183]:7371 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261984AbUKCXIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 18:08:37 -0500
Date: Wed, 3 Nov 2004 15:08:27 -0800
From: Greg KH <greg@kroah.com>
To: "Kilau, Scott" <Scott_Kilau@digi.com>
Cc: germano.barreiro@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: patch for sysfs in the cyclades driver
Message-ID: <20041103230826.GA31333@kroah.com>
References: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D81D@minimail.digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D81D@minimail.digi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 04:35:44PM -0600, Kilau, Scott wrote:
> 
> > Your driver can use whatever name you wanted, as long as it's the
> > LANNANA name that you asked for and were assigned.  We do have
> standards
> > for a good reason, and the kernel will follow them.
> 
> >That being said, have your customers use a tool like udev.  Then they
> > can name their tty devices whatever they want.  No limitations there
> at
> > all.
> 
> The problem is that LANANA assumes a product/driver
> may only have a few tty's, say up to maybe 256 or so.
> 
> For example, we have a driver that can support 1000s or 10000s of tty's.

Great, use udev for that.

> When dealing with that large amount of ttys, telling a customer
> that they should remember that a tty down in Austin TX is ttyD19234,
> and that the tty over in England is ttyD57267 is pretty ridiculous.

I agree, use udev.

> Our customers want to select a custom tty name base,
> as well as a custom tty port number...
> This way they can use logical names in an "area" specific range.

I agree, use udev.

> For example, maybe they have 10 16 port units in down in Texas,
> they may want to group them as /dev/ttytx000 to /dev/ttytx159,
> and the guy in england might want to name theirs
> /dev/ttyengland_a to /dev/ttyengland_h

Fine, have them use udev.

> I agree using udev is a solution to the final name problem in /dev,
> as long as they are using 2.6, (altough I have to support 2.4 as well).

We aren't talking about 2.4 here though.  2.4 is a totally different
subject.

> But using udev still doesn't allow me to create that custom name in
> /sys/class/tty.

You don't want to do that.  The kernel doesn't want you to do that.
Userspace doesn't want you to do that.  No one wants that.

> I understand this is where you would say we should use the ttyD12143
> value,
> but I feel that it simply doesn't show the "linkage" between that value
> and the "custom" name in /dev as easily as it would if I could create a
> custom name for the tty in /sys/class/tty.

udev will show you that /dev/ttyfoo really is /sys/class/tty/ttyD12143:

	$ udevinfo -n /dev/ttyfoo -q path
	/class/tty/ttyD12143

So you do have that "linkage".  Don't mess around with kernel names,
it's not allowed.  Mess around with userspace names, that's allowed.

thanks,

greg k-h
