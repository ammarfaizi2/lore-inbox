Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbTISVOt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 17:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbTISVOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 17:14:49 -0400
Received: from screech.rychter.com ([212.87.11.114]:29084 "EHLO
	screech.rychter.com") by vger.kernel.org with ESMTP id S261744AbTISVOr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 17:14:47 -0400
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 USB problem (uhci)
References: <m2znh1pj5z.fsf@tnuctip.rychter.com>
	<20030919190628.GI6624@kroah.com> <m2d6dwr3k8.fsf@tnuctip.rychter.com>
	<20030919201751.GA7101@kroah.com> <m28yokr070.fsf@tnuctip.rychter.com>
	<20030919204419.GB7282@kroah.com>
X-Spammers-Please: blackholeme@rychter.com
From: Jan Rychter <jan@rychter.com>
Date: Fri, 19 Sep 2003 14:14:49 -0700
In-Reply-To: <20030919204419.GB7282@kroah.com> (Greg KH's message of "Fri,
 19 Sep 2003 13:44:19 -0700")
Message-ID: <m2smmspjjq.fsf@tnuctip.rychter.com>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Greg" == Greg KH <greg@kroah.com> writes:
 Greg> On Fri, Sep 19, 2003 at 01:29:55PM -0700, Jan Rychter wrote: If
 Greg> you want to suspend using 2.4, unload the usb drivers entirely.
 Greg> That's the only safe way.
 >>
 >> I wasn't talking about suspending, but about processor
 >> C-states. These are power states that the mobile processors enter
 >> dynamically, many times a second. In my case:

 Greg> Ah, sorry.  I'm getting D and C states mixed up here.
[...]

You probably mean S-states, which are for sleep.

 >> As you can see, C3 (lowest power) is being used a lot. This makes my
 >> laptop run cool. If I use usb-uhci, the processor is never able to
 >> go into C3 because of DMA activity. uhci is better, because it at
 >> least permits me to use C3 when there are no devices plugged in.
 >>
 >> And going back to the uhci problem... ?

 Greg> UHCI by design sucks massive PCI bandwidth.  There is logic in
 Greg> the uhci drivers that try to help this out by reducing
 Greg> transactions when not much is going on, but there's only so much
 Greg> we can do in software, sorry.  I'm guessing that you aren't going
 Greg> to be able to change this.

 Greg> Unless you go buy a ohci usb cardbus controller card :)

Now you've confused me.

Do your comments above apply to "uhci" or "usb-uhci"?

Please allow me to restate the original problem:

  -- I usually use uhci instead of usb-uhci, because it is able to go
     into "suspend mode" when no devices are plugged, which allows the
     CPU to enter C3 states,

  -- usb-uhci eats CPU power by keeping it in C2 constantly because of
     busmastering DMA activity, therefore being much less useful,

  -- uhci generally works for me just fine, but breaks in one particular
     case, when removing the device causes a strange message to be
     printed and the system being unable to use the C3 states again,
     until uhci is unloaded and reloaded back again.

     Just as a reminder, this message is:

       uhci.c: efe0: host controller halted. very bad

I hope if the message says "very bad", then this is something that can
be fixed. I was therefore reporting a problem with "uhci" and kindly
asking for help.

--J.
