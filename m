Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269629AbUIRUen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269629AbUIRUen (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 16:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269630AbUIRUen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 16:34:43 -0400
Received: from pop.gmx.de ([213.165.64.20]:49871 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269629AbUIRUej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 16:34:39 -0400
X-Authenticated: #1725425
Date: Sat, 18 Sep 2004 22:37:48 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: udev is too slow creating devices
Message-Id: <20040918223748.7ed34912.Ballarin.Marc@gmx.de>
In-Reply-To: <414C9003.9070707@softhome.net>
References: <414C9003.9070707@softhome.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Sep 2004 21:44:03 +0200
Ihar 'Philips' Filipau <filia@softhome.net> wrote:

> 
>    That's wrong attitude. I'm working on workstation where 95% of 
> hardware plugged 100% of time. That's not exception. Not eerything is 
> hot-pluggable USB/FireWire/whatever.

Even PCI devices are "attached" to the kernel at bootup. From an
abstracted POV they are plugged in.

> 
>    Event-based hot-plug scripts are great thing. As an implementation. 
> But user cares about one thing: 'modprobe usb-storage; mount /whatever' 
> working reliably.

That's actually something the user doesn't want to be bothered with.
modprobe is done automatically when the device is plugged in. Mounting is
done automatically when udev signals the script in dev.d (or your desktop
environment via D-BUS). This is what users care about.
Even uber-geeks don't enjoy unnecessary work.

> 
>    /etc/dev.d probably great thing - but I'm not going to implement FSM 
> into every shell script which does modprobe for sake being Ok with 
> dynamic /dev/.

Why not switch completely. Of course, there still is Kernel 2.4, but there
is little reason not to use udev on 2.6. We all know that open source is
about choice, but his may well mean that more work is needed (ie. two
versions of an init script)

> 
>    You need to change your attitude for first. For second - come up with
>    
> a way for user space to block until device is here, and if it is not 
> here/error detected - fail.

Already done. All userspace nees to do is wait in /etc/dev.d. The only
issue is error handling, but after some consideration I have to admit,
that this is not different than before.
In a situation where modprobe failed before, it will still do so. In a
situation where modprobe succeeded, but later phases failed (like
partition detection), the situation isn't any worse with udev.
Instead of a non-working device node and an error in dmesg you now get no
device node and an error in dmesg. Checking for such a condition is
equally hard in both cases.

> 
>    As it was said before - /all/ we need, is to be able to tell 
> discovery phase from idle state of driver. "/All/" is quite much here - 
> but it must be a goal.

Why? You couln't do so from userspace before, and there is little reason
to do so. Or am I missing something?

> 
>    I'm absolutely sure, that for PCI devices it is implementable quite 
> easy - probing is already done outside of modules. And we know precisely
> are we Ok, or are we not. And we know when we are done.

Not really. modprobe may return sucessfully, but the hardware still might
fail to work - either silently or with error messages in kernel log. All
you really can rely on is that the module has been loaded. Nothin changes
with udev.

Regards
