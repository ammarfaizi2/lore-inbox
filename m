Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbTISVAS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 17:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbTISVAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 17:00:18 -0400
Received: from mail.kroah.org ([65.200.24.183]:730 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261714AbTISVAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 17:00:14 -0400
Date: Fri, 19 Sep 2003 13:44:19 -0700
From: Greg KH <greg@kroah.com>
To: Jan Rychter <jan@rychter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 USB problem (uhci)
Message-ID: <20030919204419.GB7282@kroah.com>
References: <m2znh1pj5z.fsf@tnuctip.rychter.com> <20030919190628.GI6624@kroah.com> <m2d6dwr3k8.fsf@tnuctip.rychter.com> <20030919201751.GA7101@kroah.com> <m28yokr070.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m28yokr070.fsf@tnuctip.rychter.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 19, 2003 at 01:29:55PM -0700, Jan Rychter wrote:
>  Greg> If you want to suspend using 2.4, unload the usb drivers
>  Greg> entirely.  That's the only safe way.
> 
> I wasn't talking about suspending, but about processor C-states. These
> are power states that the mobile processors enter dynamically, many
> times a second. In my case:

Ah, sorry.  I'm getting D and C states mixed up here.

> [10:52] tnuctip:/usr/src/linux#cat /proc/acpi/processor/CPU0/power 
> active state:            C3
> default state:           C1
> bus master activity:     00000000
> states:
>     C1:                  promotion[C2] demotion[--] latency[000] usage[00000520]
>     C2:                  promotion[C3] demotion[C1] latency[001] usage[00159073]
>    *C3:                  promotion[--] demotion[C2] latency[100] usage[02297764]
> [13:28] tnuctip:/usr/src/linux#
> 
> As you can see, C3 (lowest power) is being used a lot. This makes my
> laptop run cool. If I use usb-uhci, the processor is never able to go
> into C3 because of DMA activity. uhci is better, because it at least
> permits me to use C3 when there are no devices plugged in.
> 
> And going back to the uhci problem... ?

UHCI by design sucks massive PCI bandwidth.  There is logic in the uhci
drivers that try to help this out by reducing transactions when not much
is going on, but there's only so much we can do in software, sorry.  I'm
guessing that you aren't going to be able to change this.

Unless you go buy a ohci usb cardbus controller card :)

thanks,

greg k-h
