Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262610AbUKZTzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbUKZTzI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 14:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263951AbUKZTyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:54:37 -0500
Received: from zeus.kernel.org ([204.152.189.113]:53187 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262473AbUKZTbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:31:13 -0500
Date: Thu, 25 Nov 2004 18:07:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 9/51: init/* changes.
Message-ID: <20041125170718.GA1417@openzaurus.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101293918.5805.221.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101293918.5805.221.camel@desktop.cunninghams>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 1) Make name_to_dev_t non init. Why should you need to reboot if all you
> want to do is change the device you're using to suspend? That's M_'s way

Well, if you change it using /proc and forget to change kernel cmd line, you'll have
a problem. Do you really change this so often?

And if you really want to make it changeable, pass major:minor from userland; once
userland is running getting them is easy.

> 2) Hooks for resuming. Suspend2 functionality can be compiled as modules
> or built in. Resuming can be activated via an initrd. These hooks allow
> for all of the combinations of the above. Allowing resuming from within
> an initrd is important because then you can set up LVM volumes
> (including encrypted devices), compile drivers for your resume device as
> modules and so on.

Hmm , this will need a lot of testing and a lot of care... You for example
mah not write to your fs's before activating it. And if you use this feature,
kernel no longer has chance to kill suspend signature on normal boot,
making "shoot(self, foot)" easier.

But for encrypted stuff it is probably only way to go, so... Just
make sure people are not using it unless they *have* to.
				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

