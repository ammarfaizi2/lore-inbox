Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbVLCUfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbVLCUfk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 15:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbVLCUfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 15:35:40 -0500
Received: from mail.kroah.org ([69.55.234.183]:51147 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750854AbVLCUfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 15:35:39 -0500
Date: Sat, 3 Dec 2005 12:34:18 -0800
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Adrian Bunk <bunk@stusta.de>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <gregkh@suse.de>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: Golden rule: don't break userland (was Re: RFC: Starting a stable kernel series off the 2.6 kernel)
Message-ID: <20051203203418.GA4283@kroah.com>
References: <20051203135608.GJ31395@stusta.de> <1133620598.22170.14.camel@laptopd505.fenrus.org> <20051203152339.GK31395@stusta.de> <4391E764.7050704@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4391E764.7050704@pobox.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2005 at 01:43:48PM -0500, Jeff Garzik wrote:
> 
> Userland isn't the same.  IMO sysfs hackers have forgotten this. 

No we have not.

> Anytime you change or remove sysfs attributes these days, you have the 
> potential to break userland, which breaks one of the grand axioms of 
> Linux.  Everybody knows "the rules" when it comes to removing system 
> calls, but forgets/ignores them when it comes to ioctls, sysfs 
> attributes, and the like.

The _main_ reason of making sysfs contain "one value per file" was to
help mitigate the problems that proc has had in the past where file
format changes broke userspace programs.

Programs that rely on sysfs need to be able to safely handle the fact
that some attributes might or might not be there.

Now to be fair, yes, udev has had big problems with this in the past,
and kernel updates have broken udev.  But that was because the bug was
MY fault in udev, not in the kernel.  I'll take full responsibility for
that.

And in the future, the driver/class model changes we are going to be
doing (see http://lwn.net/Articles/162242/ for more details on this),
will be going to great lengths to prevent anything in userspace from
breaking.

So, to change your wording a bit, users of sysfs have forgotten how to
program defensively to handle changes that might happen in the future.
I know I'm guilty of this, and am working hard to not make the same
mistakes in the future.

thanks,

greg "still trying to delete devfs after 1 and 1/2 years notice" k-h
