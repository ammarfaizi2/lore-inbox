Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262320AbVERQIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbVERQIT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 12:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbVERQGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 12:06:21 -0400
Received: from mail.kroah.org ([69.55.234.183]:56725 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262332AbVERQFo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 12:05:44 -0400
Date: Wed, 18 May 2005 09:11:43 -0700
From: Greg KH <greg@kroah.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: linux-kernel@vger.kernel.org, david-b@pacbell.net
Subject: Re: [PATCH] Driver Core: remove driver model detach_state
Message-ID: <20050518161143.GB16756@kroah.com>
References: <11163679452255@kroah.com> <1116411191.27701.4.camel@dhcp-188.off.vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116411191.27701.4.camel@dhcp-188.off.vrfy.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 12:13:11PM +0200, Kay Sievers wrote:
> On Tue, 2005-05-17 at 15:12 -0700, Greg KH wrote:
> > [PATCH] Driver Core: remove driver model detach_state
> > 
> > The driver model has a "detach_state" mechanism that:
> > 
> >  - Has never been used by any in-kernel drive;
> >  - Is superfluous, since driver remove() methods can do the same thing;
> >  - Became buggy when the suspend() parameter changed semantics and type;
> >  - Could self-deadlock when called from certain suspend contexts;
> >  - Is effectively wasted documentation, object code, and headspace.
> > 
> > This removes that "detach_state" mechanism; net code shrink, as well
> > as a per-device saving in the driver model and sysfs.
> 
> Huh, we need to fix a lot of userspace programs now. libsysfs depends on
> finding that file, udev waits for this to recognize sysfs population. I
> will go fix this where I know this is used, but be prepared for stupid
> failures... :)

Yeah, good catch, so that's why udev stoped working for me on some
custom rules...

Anyway, I think it was pretty stupid for libsysfs to depend on that
file, I'll work on fixing that up.  Luckily, no one uses libsysfs :)

thanks,

greg k-h
