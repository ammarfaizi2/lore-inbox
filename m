Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbTKOVMS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 16:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbTKOVMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 16:12:18 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:30727 "EHLO w.ods.org")
	by vger.kernel.org with ESMTP id S262040AbTKOVMR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 16:12:17 -0500
Date: Sat, 15 Nov 2003 22:12:01 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Shane Wegner <shane-keyword-kernel.a35a91@cm.nu>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 crash on Intel SDS2
Message-ID: <20031115211201.GC9634@alpha.home.local>
References: <20031112182219.GA2921@cm.nu> <Pine.LNX.4.44.0311151029310.10014-100000@logos.cnet> <20031115205828.GA1367@cm.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031115205828.GA1367@cm.nu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Nov 15, 2003 at 12:58:28PM -0800, Shane Wegner wrote:
 
> I did and unfortunately, it was of little help.  If
> anything though, it made the lockup more consistent.  The
> three times I tried to boot with nmi_watchdog=1, it locked
> up when starting SpamAssassin.  Nothing special about that
> process but just above that it started the hotplug
> subsystem which I use to automatically insert various usb
> drivers as needed.  Could that have anything to do with it?

Would it be possible to print a "starting XXX" and
"XXX started" before and after every service ? And please
also try to disable automatic modprobe, or change it to
something which logs what is loaded. Eg:

   echo /root/mymodprobe >/proc/sys/kernel/modprobe

with mymodprobe basically looking like :

#!/bin/bash
{date;echo "starting $@"} >> /tmp/modprobe.log
sync
exec modprobe $@

> Btw, to clarify, when the lockup occurs with nmi_watchdog,
> no oops gets printed.

You may try nmi_watchdog=2. I once was adviced to try =1,
but it never worked for me, while =2 worked as expected.
Don't ask me why, all I know is that there are a few other
people out there happily using it this way too.

Regards,
Willy

