Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262962AbUK0CTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262962AbUK0CTj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 21:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbUK0CQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 21:16:21 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:20423 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S263052AbUK0COd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 21:14:33 -0500
To: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: Suspend 2 merge: 9/51: init/* changes.
In-Reply-To: <20041125170718.GA1417@openzaurus.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101293918.5805.221.camel@desktop.cunninghams> <1101293918.5805.221.camel@desktop.cunninghams> <20041125170718.GA1417@openzaurus.ucw.cz>
Date: Sat, 27 Nov 2004 02:14:31 +0000
Message-Id: <E1CXs6Z-0001cv-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
> 
>> 1) Make name_to_dev_t non init. Why should you need to reboot if all you
>> want to do is change the device you're using to suspend? That's M_'s way
> 
> Well, if you change it using /proc and forget to change kernel cmd line, you'll have
> a problem. Do you really change this so often?

name_to_dev_t needs to be non-init in order to make it possible to
trigger a resume when the block device driver isn't static. Pavel, would
you be willing to consider a patch to make it possible to trigger swsusp
resume from userspace? That gets things working with initrd kernels.
I've been using something along these lines for a few weeks now, and it
hasn't eaten my filesystem yet.

> Hmm , this will need a lot of testing and a lot of care... You for example
> mah not write to your fs's before activating it. And if you use this feature,
> kernel no longer has chance to kill suspend signature on normal boot,
> making "shoot(self, foot)" easier.

Yes, I was thinking of this mostly from a distribution perspective.
There's always potential for data-loss if users resume after touching
the root filesystem. On the other hand, it's currently possible for them
to do that anyway (think booting a different kernel without swsusp
support, then rebooting back into the swsusp one)

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
