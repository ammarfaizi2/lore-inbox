Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161249AbWBUBJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161249AbWBUBJb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 20:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161253AbWBUBJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 20:09:31 -0500
Received: from digitalimplant.org ([64.62.235.95]:16323 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S1161249AbWBUBJb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 20:09:31 -0500
Date: Mon, 20 Feb 2006 17:09:26 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Greg KH <greg@kroah.com>
cc: Pavel Machek <pavel@suse.cz>, "" <torvalds@osdl.org>, "" <akpm@osdl.org>,
       "" <linux-pm@osdl.org>, "" <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [PATCH 3/5] [pm] Respect the actual device power
 states in sysfs interface
In-Reply-To: <20060220220404.GA25746@kroah.com>
Message-ID: <Pine.LNX.4.50.0602201655580.21145-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0602171758160.30811-100000@monsoon.he.net>
 <20060218155543.GE5658@openzaurus.ucw.cz> <Pine.LNX.4.50.0602191557520.8676-100000@monsoon.he.net>
 <20060220004635.GA22576@kroah.com> <Pine.LNX.4.50.0602200955030.12708-100000@monsoon.he.net>
 <20060220220404.GA25746@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 20 Feb 2006, Greg KH wrote:

> On Mon, Feb 20, 2006 at 09:58:27AM -0800, Patrick Mochel wrote:

> > Would you mind commmenting on why, as well as your opinion on the validity
> > of the patches themselves?
> >
> > This static, hardcoded policy was introduced into the core ~2 weeks ago,
> > and it doesn't seem like it belongs there at all.
>
> That patch was accepted as it fixed a oops.  It also went in for
> 2.6.16-rc2, which is much earlier than 2.6.16-rc4, and it had been in
> the -mm tree for quite a while for people to test it out and verify that
> it didn't break anything.  I didn't hear any complaints about it, so
> that is why it went in.
>
> In contrast, this patch series creates a new api and doesn't necessarily
> fix any reported bugs.  It also has not had the time to be tested in the
> -mm tree, and there is quite a lot of disagreement about the patches on
> the lists.  All of that combinded makes it not acceptable for so late in
> the -rc cycle (remember, -rc4 means only serious bug fixes.)

Thanks.

However, there are a couple of things to note:

- These patches don't create a new API; they fix the semantics of an
  existing API by restoring them to its originally designed semantics.

- The BUG() still exists and is relatively easily triggerable (by calling
  pci_choose_state() with the wrong value). The fact that the BUG() was
  allowed into the kernel is surprising - the mantra for a long time has
  been that no new BUG()s should be added. This one is easily made nicer
  (see patch 4/4 in the next series), so I don't see why it wasn't
  targeted before..

- There is a bug, reported by me, and with patches to fix the behavior.
  What better solution is there than that?

  For context, I am experimenting with the power consumption of devices
  and systems in various power states. Not many devices support states
  other than D3, but some do, and it seems like a completely valid choice
  option to use those states, if I choose to do so.

  There is currently no other nice way to do so. And, I'm sure that most
  will agree that modifying this sysfs interface is a lot nicer than
  manually tickling PCI config space from a userspace process..

> > This seems like the easiest way to fixing it, but I'm open to
> > alternative suggestions..
>
> Care to resend the series based on all of the comments you have
> addressed so far?  I'll be glad to review it then.

Done and done.

Thanks,


	Pat
