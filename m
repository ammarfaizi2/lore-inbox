Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272468AbTHNQJI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 12:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272560AbTHNQIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 12:08:12 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13062 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S272481AbTHNQHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 12:07:34 -0400
Date: Thu, 14 Aug 2003 17:07:21 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Christoph Hellwig <hch@infradead.org>, Pavel Machek <pavel@suse.cz>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] call drv->shutdown at rmmod
Message-ID: <20030814170721.B332@flint.arm.linux.org.uk>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Christoph Hellwig <hch@infradead.org>, Pavel Machek <pavel@suse.cz>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <m1he4kzpiy.fsf@frodo.biederman.org> <20030814085442.A21232@infradead.org> <20030814090605.A25516@flint.arm.linux.org.uk> <m17k5gz1aq.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m17k5gz1aq.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Thu, Aug 14, 2003 at 09:50:05AM -0600
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 09:50:05AM -0600, Eric W. Biederman wrote:
> Russell King <rmk@arm.linux.org.uk> writes:
> > That's likely to remove the keyboard driver, and some people like
> > to configure their box so that ctrl-alt-del halts the system, and
> > a further ctrl-alt-del reboots the system once halted.
> 
> Hmm.  That is a very weird case.  Semantically the keyboard driver
> and everything else should be removed in any case.

I don't view it as "really weird" - it's something I've always done
with 2.2 and 2.4, and in fact the first thing I do when I get a machine
is to modify the inittab to halt the machine on ctrl-alt-del.

It's far safer than hitting ctrl-alt-del and trying to power the machine
off at the exact moment it reboots.

However, sometimes you want it to reboot, and in this case its far
simpler to wait for the machine to halt, and then use ctrl-alt-del
again.  It's something that's been supported by both the kernel and
init for eons.

> After device_shutdown is called it is improper for any driver
> to be handling interrupts because the are supposed to be in a quiescent
> state.  And if they are not it is likely to break a soft reboot.

I guess then this is another bug we need to add to the list of bugs
introduced during 2.5 into 2.6 then...

If it is changing, then someone needs to get that information into
davej's document.

> Russell do you have any objects to always calling shutdown before
> remove?   I don't think this looses knowledge and in most cases it should
> work, but if there are bus devices were we need to do things significantly
> differently I am open to other solutions.

The way I'm treating ->shutdown at present is that it is the final call
to the device driver.  Once this call has been made, the bus driver
puts the bus into the correct state for reboot, and the device driver
must not attempt to access it.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

