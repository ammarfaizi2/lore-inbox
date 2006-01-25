Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWAYPdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWAYPdI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 10:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbWAYPdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 10:33:08 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:50823
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751229AbWAYPdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 10:33:07 -0500
Date: Wed, 25 Jan 2006 07:33:03 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: udev/hotplug and automatic /dev node creation
Message-ID: <20060125153303.GA18932@kroah.com>
References: <20060118024710.GB26895@quickstop.soohrt.org> <20060118040718.GA6579@kroah.com> <20060125125017.GD10068@quickstop.soohrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060125125017.GD10068@quickstop.soohrt.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 01:50:17PM +0100, Horst Schirmeier wrote:
> On Tue, 17 Jan 2006, Greg KH wrote:
> > On Wed, Jan 18, 2006 at 03:47:10AM +0100, Horst Schirmeier wrote:
> > > Hi,
> > > 
> > > I'm looking for documentation regarding how to write a Linux kernel
> > > module that creates its own /dev node via udev/hotplug.
> > > register_chrdev() and a simple udev/rules.d/ entry don't seem to be
> > > sufficient...
> > 
> > Yes, register_chrdev() will do nothing for udev.
> > 
> > Take a look at the book, Linux Device Drivers, third edition (free
> > online).  In the chapter about the driver model, there is a section
> > about what udev needs.  The functions it says to use are no longer in
> > the kernel, but it should point you in the right direction (hint, use
> > class_device_create().)
> > 
> > If you have a pointer to your code, I can probably knock out a patch for
> > you very quickly.
> 
> Now I'm using class_create() and class_device_create() (together with
> class_device_destroy() and class_destroy()), which works fine on
> 2.6.15 and 2.6.16-rc1, and with some hackish LINUX_VERSION_CODE-checking
> #define wrapper around class_device_create() also on 2.6.13 and
> 2.6.14...
> 
> But: Is there a common way to get this working on 2.6.12 or earlier?

Look at the class_simple* functions in that older kernel version.  They
should do much of the same thing of what you need.

Hope this helps,

greg k-h
