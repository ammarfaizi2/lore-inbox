Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbWA0FBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWA0FBI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 00:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWA0FBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 00:01:07 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:20935
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932395AbWA0FBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 00:01:06 -0500
Date: Thu, 26 Jan 2006 21:01:09 -0800
From: Greg KH <greg@kroah.com>
To: Aritz Bastida <aritzbastida@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Right way to configure a driver? (sysfs, ioctl, proc, configfs,....)
Message-ID: <20060127050109.GA23063@kroah.com>
References: <7d40d7190601261206wdb22ccck@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d40d7190601261206wdb22ccck@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 09:06:28PM +0100, Aritz Bastida wrote:
> Hello everybody.
> 
> I'm quite a newbie in the kernel development, but I'm writing a kernel
> module and would like to do the things right. What I'm trying to do
> is, more or less, a kind of "virtual" network device (not really that
> but it will suffice).
> 
> This network device can be configured from userspace. I have read the
> books "Linux Device Drivers 3" (LDD3) and "Linux Kernel Development"
> and after that I didn't find the answer to the question I was making
> myself: What should be the right way to configure it?

It all depends on what you want to configure, and what type of thing you
are configuring.

> In LDD3 it says that ioctls fall out of favor among kernel developers,
> but there is not a  strong _advise_ to use another method. It says
> that instead of that sysfs _could_ be used. Of course, that was almost
> a year ago. I'm sure things have changed since then.

No, not really.

> So, well, I did all this configuration using ioctls and proc, which
> was the fastest for me, but may be not the best solution. So I'm
> asking for advise here.

do NOT use proc, unless you are doing things that concern processes.

> The configuration I need to do is actually quite simple. Most of the
> commands are just set or get a variable defined in my module (for
> example, write to a flags variable, just like in real network devices
> -- i.e. IF_UP). The most difficult "config" I need to do is write a
> struct to the module (just write two variables in the same command).

That sounds like something that sysfs or even debugfs is perfict for.

> What way do you suggest for all this? Is sysfs correct for this? What
> about the new filesystem "configfs"? I've just heard about it, but I
> don't even have it mounted on my system. Would it be what I need?

Read the docs on configfs for details on that.  But for simple variables
like you describe, either sysfs or debugfs are the best.

> On the other hand, I also need to export some statistics to userspace.
> These are similar to the ones in a network device: packets received,
> dropped,... but I would like to export not just the number of packets
> received, but the number received by _each_ cpu, as well as the total.
> Would you recommend me /proc or sysfs?

Again, not proc.  So sysfs.

> In case of using sysfs, would this be the correct approach or you
> would recommend  one value per file?

Yes.

> $ cat rx_packets
>      10     15     25
> where the first value is packets received in CPU0, the second in CPU1
> and the last the total.

No.  Have 3 different files:
	rx_packets_cpu0
	rx_packets_cpu1
	rx_packets_total

Hope this helps,

greg k-h
