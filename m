Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262364AbUKDTTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbUKDTTt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 14:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbUKDTTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 14:19:35 -0500
Received: from mail.tmr.com ([216.238.38.203]:12554 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262335AbUKDTNr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 14:13:47 -0500
Date: Thu, 4 Nov 2004 14:04:58 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Pete Zaitcev <zaitcev@redhat.com>
cc: Wolfgang Scheicher <worf@sbox.tu-graz.ac.at>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 USB storage problems
In-Reply-To: <20041104011932.0b5d2aae@lembas.zaitcev.lan>
Message-ID: <Pine.LNX.3.96.1041104135949.12155B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Nov 2004, Pete Zaitcev wrote:

> On Wed, 03 Nov 2004 17:02:43 -0500, Bill Davidsen <davidsen@tmr.com> wrote:
> 
> > I just got information on this in another thread, in case you didn't see 
> > my note there, is this behaviour a bug, design choice, or unavoidable 
> > hardware issue? I can turn it off now, but I'm supposed to be getting a 
> > flash key thing to test, which is why I turned it on in the first place.
> 
> The explanation may be a little long.

Thank you for taking the time to make it! I now understand the problem
not only well enough to avoid it, but to ask another question below.
> 
> On most distributions, drivers are loaded with hotplug. Nobody, and I do
> mean it, for all practical reasons nobody loads their drivers from
> /etc/rc.d/rc.local anymore. (Side note: it is possible to load ub from
> /etc/modprobe.conf, but not usb-storage, because of too many layers
> between a block device and usb-storage: an open is a non-event there)
> 
> The hotplug is controlled by match lists, generated from C source (indirectly;
> actually from object files, compiled from C source). This way, what is loaded
> by hotplug would match what is present if same things were linked in, among
> other things. The hotplug has no preference mechanism aside from hand-editing
> those match lists. They have to be non-conflicting.
> 
> Given the above, it's hurtful to allow drivers to conflict, so such conflicts
> are rare. I know of bcm5700 vs. tg3, eepro100 vs. e100, 812x vs 8130too.
> AFAIK, in all such cases if one is configured, another cannot be configured
> and vice versa. The USB contains an exception, curiously enough. In 2.4
> kernels, it was possible to configure both uhci (ALT) and usb-uhci as
> modules. It was annoying; Red Hat resolved it by loading usb-uhci from
> /etc/rc.d/rc.sysinit (also marked in /etc/modules.conf, but that was
> just a tag for kudzu and other tools).
> 
> So, when ub is configured to service certain classes of devices, usb-storage
> relinquishes its control of them, resolving the conflict. This is assymmetric
> in its implementation, but it's an artefact; no implication is made about
> which driver is first among equals. In an ideal world we'd have something
> like CONFIG_USB_STORAGE_PREF with two values "ub" and "usb-storage", or such.
> 
> I thought about the coexistence between the two at some length, and it seems
> to me that the current scheme is the simplest workable scheme. I even thought
> it as "least confusing" until messages from Wolfgang and others made it clear
> that relationship between ub and usb-storage is not obvious enough to them.
> I'm always open to patches, too.

It would seem that wanting to use both flash keys and more common USB
devices would be the common case for those who use flash keys at all.
Would it be possible to have the regular USB drivers support the slow
devices, if only to the extent of handing them off as they do CD, NIC, or
disk? Or are these slow devices so unique that they are totally
incompatible with faster devices?

> 
> -- Pete
> 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

