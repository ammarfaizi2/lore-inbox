Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbUEDV4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbUEDV4v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 17:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUEDV4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 17:56:51 -0400
Received: from mail-ext.curl.com ([66.228.88.132]:19467 "HELO
	mail-ext.curl.com") by vger.kernel.org with SMTP id S261205AbUEDV4t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 17:56:49 -0400
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: Load hid.o module synchronously?
References: <s5g8ygi4l3q.fsf@patl=users.sf.net>
	<408D65A7.7060207@nortelnetworks.com>
	<s5gisfm34kq.fsf@patl=users.sf.net> <c6od9g$53k$1@gatekeeper.tmr.com>
	<s5ghdv0i8w4.fsf@patl=users.sf.net> <20040504200147.GA26579@kroah.com>
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Message-ID: <s5ghduvdg1u.fsf@patl=users.sf.net>
Date: 04 May 2004 17:56:48 -0400
In-Reply-To: <20040504200147.GA26579@kroah.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> On Sat, May 01, 2004 at 09:21:31AM -0400, Patrick J. LoPresti wrote:
>
> > So there is no way to load this hardware driver and wait until it
> > either binds or fails to bind to its associated hardware?  That seems
> > like a bad bug in the design...
> 
> Um, what is wrong with the proposals I made for how you can detect
> this?

Your proposals were:

 - look at the device in /proc/bus/usb/devices and wait until the
   driver is bound to that device "(hid)" will show up as the
   driver bound to that interface

 - look at the sysfs directory for the hid driver and wait for
   the symlink to the device shows up.  This should be at
   /sys/bus/usb/drivers/hid

I see how these let me wait until the hid.o module successfully binds
to the hardware.

But what if it fails to bind?  For example, what if an error occurs?
Or what if the keyboard is on the module's blacklist?  How do I know
when to stop waiting?

Ideally, what I would like is for "modprobe <driver>" to wait until
all hardware handled by that driver is either ready for use or is
never going to be.  That seems simple and natural to me.  But I would
be glad to use any other mechanism to achieve the same effect; I just
have not seen one yet.

 - Pat
