Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbTJWVKj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 17:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTJWVKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 17:10:39 -0400
Received: from paclaw.org ([149.175.1.5]:50670 "HELO lewis.lclark.edu")
	by vger.kernel.org with SMTP id S261793AbTJWVKg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 17:10:36 -0400
Subject: Re: [Linux-fbdev-devel] DRM and pci_driver conversion
From: Eric Anholt <eta@lclark.edu>
To: kronos@kronoz.cjb.net
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       Jon Smirl <jonsmirl@yahoo.com>
In-Reply-To: <20031023190421.GA4567@dreamland.darkstar.lan>
References: <1066703516.646.24.camel@leguin>
	 <20031023190421.GA4567@dreamland.darkstar.lan>
Content-Type: text/plain
Message-Id: <1066943415.662.9.camel@leguin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 23 Oct 2003 14:10:16 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-23 at 12:04, Kronos wrote:
> Il Mon, Oct 20, 2003 at 07:31:56PM -0700, Eric Anholt ha scritto: 
> > I recently committed a change to the DRM for Linux in DRI CVS that
> > converted it to use pci_driver and that probe system.  Unfortunately,
> > we've found that there is a conflict between the DRM now and at least
> > the radeon framebuffer.  Both want to attach to the same device, and
> > with pci_driver, the second one to come along doesn't get probe called
> > for that device.  Is there any way to mark things shared, or in some
> > other way get the DRM to attach to a device that's already attached to,
> > in the new model?
> 
> AFAIK no,  pci_dev only  stores one pointer  to the  driver. Two drivers
> fiddling with the same hw can be dangerous. What will happen if radeonfb
> starts using hw  accel, touching registers without  DRM knowing it? What
> is (IMHO) needed is a common  layer that works with hardware and exposes
> an interface to both radeonfb and DRM. I think that Jon Smirl is working
> on something like this.

Apparently loading DRM after radeonfb is okay.  Loading radeonfb after
DRM is okay as long as the DRM is not in use.  For some cards, the fb
after the DRM would still be okay (sis, tdfx at the moment, for
example), but it isn't the case on radeon, apparently.  Other than that
there aren't any issues I know of.

I've moved the Linux DRM to old-style probing as pci.txt described,
which hopefully restores the ability of fb and drm to coexist as well as
they have in the past.  I hope some linux developers can get this all
done right so that the two can coexist better.

-- 
Eric Anholt                                eta@lclark.edu          
http://people.freebsd.org/~anholt/         anholt@FreeBSD.org


