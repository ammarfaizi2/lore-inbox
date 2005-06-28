Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbVF1JkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVF1JkN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 05:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbVF1JkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 05:40:13 -0400
Received: from nome.ca ([65.61.200.81]:45731 "HELO gobo.nome.ca")
	by vger.kernel.org with SMTP id S261836AbVF1JkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 05:40:00 -0400
Date: Tue, 28 Jun 2005 02:40:05 -0700
From: Mike Bell <kernel@mikebell.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Greg KH <greg@kroah.com>, Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Message-ID: <20050628094004.GA4673@mikebell.org>
Mail-Followup-To: Mike Bell <kernel@mikebell.org>,
	Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org
References: <20050624081808.GA26174@kroah.com> <20050625234305.GA11282@kroah.com> <20050627071907.GA5433@mikebell.org> <200506271735.50565.dtor_core@ameritech.net> <20050627232559.GA7690@mikebell.org> <20050628074015.GA3577@kroah.com> <20050628090852.GA966@mikebell.org> <1119950487.3175.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119950487.3175.21.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 11:21:27AM +0200, Arjan van de Ven wrote:
> you still can't have that. think USB harddisks for example. The only way
> you can do this reliable is to use UUIDs from the disks. Guess what..
> udev does that. devfs doesn't.

I thought I had made it clear that I wasn't talking about uniquely
identifying a given piece of hardware, that can only be done in
userspace (and often not even there).

What I'm talking about is the ability to find the device node that
corresponds to the first entry in /proc/bus/input/devices, or play a
sound file on the system's first sound card, or for X to find the drm
device node that corresponds to a given video card. All these things are
easy if you know that /dev/input/event0 is the device node for the first
entry, but if that device node could be called /dev/myfunkykeyboard
(note, the device name, you could still have a symlink to said name if
you wanted without breaking anything), in a world where udev's
supposed feature of allowing devices to be named anything you want is
actually used, this isn't possible without scanning all of /dev.

> actually.. linphone for example shows you the name of the device, not
> the device node. And at runtime it finds which device node belongs to
> that name somehow. I didn't look at the code how it does that, but it
> sure isn't impossible since it's done in practice already.

It is impossible though, if you make use of that particular feature of
udev. Give it a try, move all your alsa device nodes to other names and
see how completely unusable ALSA becomes. Those device nodes HAVE to
exist and HAVE to point to the right devices in order for ALSA to work.

linphone and other programs "just work" because they know where to find
their device nodes. If anything, you're arguing my point.
