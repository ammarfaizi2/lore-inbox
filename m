Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262399AbUKZXet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbUKZXet (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263181AbUKZTql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:46:41 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:37022 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262416AbUKZT1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:27:17 -0500
Subject: Re: Suspend 2 merge: 9/51: init/* changes.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041125170718.GA1417@openzaurus.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101293918.5805.221.camel@desktop.cunninghams>
	 <20041125170718.GA1417@openzaurus.ucw.cz>
Content-Type: text/plain
Message-Id: <1101418614.27250.21.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 26 Nov 2004 08:36:54 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-11-26 at 04:07, Pavel Machek wrote:
> Hi!
> 
> > 1) Make name_to_dev_t non init. Why should you need to reboot if all you
> > want to do is change the device you're using to suspend? That's M_'s way
> 
> Well, if you change it using /proc and forget to change kernel cmd line, you'll have
> a problem. Do you really change this so often?

It's mostly used when setting up a new installation, and when attempting
LVM support. It's particularly useful in the later case because you can
swap off and so on, prepare your new LVM volume, prepare swap on it, do
the echo > resume2 and then check dmesg, and be assured that you've got
the right setup, all without needing to reboot. In the case of a new
config, you still need to reboot once, of course, into the new kernel,
but if you get the resume2= parameter wrong, you don't have to waste
time rebooting just because of a typo. You can just fix your lilo.conf
(or equiv) and use echo > resume2 to fix the mistake.

> And if you really want to make it changeable, pass major:minor from userland; once
> userland is running getting them is easy.

Yes, but that's also far uglier, and who thinks in terms of major and
minor numbers anyway? I think of my harddrive as /dev/sda, not 08:xx.
The parsing accepts majors and minors, of course, but shouldn't we make
these things easier to do, not harder? (Would we insist on using majors
and minors for root=?).

> > 2) Hooks for resuming. Suspend2 functionality can be compiled as modules
> > or built in. Resuming can be activated via an initrd. These hooks allow
> > for all of the combinations of the above. Allowing resuming from within
> > an initrd is important because then you can set up LVM volumes
> > (including encrypted devices), compile drivers for your resume device as
> > modules and so on.
> 
> Hmm , this will need a lot of testing and a lot of care... You for example
> mah not write to your fs's before activating it. And if you use this feature,
> kernel no longer has chance to kill suspend signature on normal boot,
> making "shoot(self, foot)" easier.

It has had it. We do rely on the user to make a sensible linuxrc/init,
but there are examples and warnings given in the docs on Berlios, and
plenty of checking done. We have to take the risk anyway: without it, we
can't support Debian (ide support built as modules), LVM (needs to set
up mappings in an initrd) or encrypted storage (ditto).

> But for encrypted stuff it is probably only way to go, so... Just
> make sure people are not using it unless they *have* to.

See above.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

