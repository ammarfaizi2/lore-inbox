Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTDLGjK (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 02:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263177AbTDLGjK (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 02:39:10 -0400
Received: from gate.in-addr.de ([212.8.193.158]:39904 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S263176AbTDLGjJ (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 02:39:09 -0400
Date: Sat, 12 Apr 2003 08:45:05 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Steven Dake <sdake@mvista.com>, Greg KH <greg@kroah.com>
Cc: "Kevin P. Fleming" <kpfleming@cox.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       message-bus-list@redhat.com
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030412064505.GJ21726@marowsky-bree.de>
References: <20030411172011.GA1821@kroah.com> <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk> <20030411182313.GG25862@wind.cocodriloo.com> <3E970A00.2050204@cox.net> <3E9725C5.3090503@mvista.com> <20030411204329.GT1821@kroah.com> <3E9741FD.4080007@mvista.com> <20030411225634.GD3786@kroah.com> <3E975063.9090807@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E975063.9090807@mvista.com>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-04-11T16:31:47,
   Steven Dake <sdake@mvista.com> said:

> What I actually mean is:
> disk is in the bus/loop/etc, powered on, ready to be enumerated.
> The user then tells the OS "please insert the disk"  This is the request 
> which starts the clock.
> The point where a device entry is in /dev ready to be used stops the clock.

A bus rescan on SCSI / FC will take longer than your 20ms already.

A single hickup in the block IO involved updating the information in /dev will
break this requirement. Having to fork /sbin/hotplug will.

I've set Linux on an unloaded, rather well powered machine to heartbeat every
10ms and checked in what intervals it actually did - mostly it was 10-30ms,
but there have been exceptions for upto 200-1000ms. And that's for a
locked-into-memory "soft realtime", no swapping very small piece of code.

Okay, this was our latest 2.4 kernel, and it would be interesting to see
whether 2.5 does better, but still. 20ms are highly ambitious.

I'm not saying "performance" is not a high goal. Having a permanently running
daemon to talk with instead of forking all the time is certainly a very
sensible idea, and the kernel _must_ be able to cope with 4k disks being
plugged in at once.

But evidence suggests that _guaranteeing_ 20ms seems a bit over the top.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
SuSE Labs - Research & Development, SuSE Linux AG
  
"If anything can go wrong, it will." "Chance favors the prepared (mind)."
  -- Capt. Edward A. Murphy            -- Louis Pasteur
