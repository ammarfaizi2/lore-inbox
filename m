Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbTISVlG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 17:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbTISVlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 17:41:06 -0400
Received: from mail.kroah.org ([65.200.24.183]:8930 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261739AbTISVlB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 17:41:01 -0400
Date: Fri, 19 Sep 2003 14:22:32 -0700
From: Greg KH <greg@kroah.com>
To: Jan Rychter <jan@rychter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 USB problem (uhci)
Message-ID: <20030919212232.GG7282@kroah.com>
References: <m2znh1pj5z.fsf@tnuctip.rychter.com> <20030919190628.GI6624@kroah.com> <m2d6dwr3k8.fsf@tnuctip.rychter.com> <20030919201751.GA7101@kroah.com> <m28yokr070.fsf@tnuctip.rychter.com> <20030919204419.GB7282@kroah.com> <m2smmspjjq.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2smmspjjq.fsf@tnuctip.rychter.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 19, 2003 at 02:14:49PM -0700, Jan Rychter wrote:
> >>>>> "Greg" == Greg KH <greg@kroah.com> writes:
>  Greg> On Fri, Sep 19, 2003 at 01:29:55PM -0700, Jan Rychter wrote: If
>  Greg> you want to suspend using 2.4, unload the usb drivers entirely.
>  Greg> That's the only safe way.
>  >>
>  >> I wasn't talking about suspending, but about processor
>  >> C-states. These are power states that the mobile processors enter
>  >> dynamically, many times a second. In my case:
> 
>  Greg> Ah, sorry.  I'm getting D and C states mixed up here.
> [...]
> 
> You probably mean S-states, which are for sleep.

Ugh, ok, I give up :)

>  >> As you can see, C3 (lowest power) is being used a lot. This makes my
>  >> laptop run cool. If I use usb-uhci, the processor is never able to
>  >> go into C3 because of DMA activity. uhci is better, because it at
>  >> least permits me to use C3 when there are no devices plugged in.
>  >>
>  >> And going back to the uhci problem... ?
> 
>  Greg> UHCI by design sucks massive PCI bandwidth.  There is logic in
>  Greg> the uhci drivers that try to help this out by reducing
>  Greg> transactions when not much is going on, but there's only so much
>  Greg> we can do in software, sorry.  I'm guessing that you aren't going
>  Greg> to be able to change this.
> 
>  Greg> Unless you go buy a ohci usb cardbus controller card :)
> 
> Now you've confused me.
> 
> Do your comments above apply to "uhci" or "usb-uhci"?
> 
> Please allow me to restate the original problem:
> 
>   -- I usually use uhci instead of usb-uhci, because it is able to go
>      into "suspend mode" when no devices are plugged, which allows the
>      CPU to enter C3 states,
> 
>   -- usb-uhci eats CPU power by keeping it in C2 constantly because of
>      busmastering DMA activity, therefore being much less useful,
> 
>   -- uhci generally works for me just fine, but breaks in one particular
>      case, when removing the device causes a strange message to be
>      printed and the system being unable to use the C3 states again,
>      until uhci is unloaded and reloaded back again.
> 
>      Just as a reminder, this message is:
> 
>        uhci.c: efe0: host controller halted. very bad
> 
> I hope if the message says "very bad", then this is something that can
> be fixed. I was therefore reporting a problem with "uhci" and kindly
> asking for help.

Ok, sorry for the confusion.  No I don't know of a fix for this problem,
but one just went into the 2.6 kernel tree for the uhci-hcd driver that
you might want to take a look at that fixed a problem almost exactly
like this.

thanks,

greg k-h
