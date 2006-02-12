Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWBLFjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWBLFjD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 00:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWBLFjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 00:39:03 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:18922
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932268AbWBLFjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 00:39:01 -0500
Date: Sat, 11 Feb 2006 21:38:49 -0800
From: Greg KH <greg@kroah.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sysfs-related oops during module unload (2.6.16-rc2)
Message-ID: <20060212053849.GA27587@kroah.com>
References: <20060211220351.GA3293@localhost.localdomain> <20060211224526.GA25237@kroah.com> <20060212052751.GB3293@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060212052751.GB3293@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2006 at 11:27:52PM -0600, Nathan Lynch wrote:
> Greg KH wrote:
> > On Sat, Feb 11, 2006 at 04:03:53PM -0600, Nathan Lynch wrote:
> > > If the refcnt attribute of a module is open when the module is
> > > unloaded, we get an oops when the file is closed.  I used ide_cd for
> > > this report but I don't think the oops is caused by the driver itself.
> > > This bug seems to be restricted to the /sys/module hierarchy; it
> > > doesn't happen with /sys/class etc.
> > > 
> > > I suspect it's an extra put or a missing get somewhere, but the fix
> > > isn't obvious to me after looking at it for a little while, so I'm
> > > punting.
> > > 
> > > I'm pretty sure this happens with 2.6.15; I can double-check if
> > > needed.
> > 
> > Ugh, we aren't setting the owner of these fields properly, good catch.
> > 
> > Does the patch below (built tested only), solve this for you?
> 
> Thanks, but no, I get the same oops.  The refcnt attribute isn't part
> of the modinfo_attrs array.

Ah, crap, you're right.  We really need to dynamically create these
attributes for every module to get the owner right.  That will be a
bigger patch that I'll work on on Monday...

thanks for testing,

greg k-h
