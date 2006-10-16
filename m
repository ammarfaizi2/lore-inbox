Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161090AbWJPV1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161090AbWJPV1N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 17:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161095AbWJPV1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 17:27:13 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:62471 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1161090AbWJPV1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 17:27:12 -0400
Date: Mon, 16 Oct 2006 17:27:09 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
cc: Duncan Sands <duncan.sands@math.u-psud.fr>, Greg K-H <greg@kroah.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 3/3] Driver core: Per-subsystem multithreaded probing.
In-Reply-To: <20061016190405.3570f547@gondolin.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0610161717120.5813-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006, Cornelia Huck wrote:

> > So the question is what do do if someone calls device_register() or
> > device_add() with dev->driver set.  If everything succeeds except for
> > creation of the symlinks, should the device remain registered?  The driver
> > core has been vacillating about this recently.  I'm not sure what the 
> > right answer is.
> 
> If dev->driver has not been set and symlink creation failed, we'll end
> up with an unbound but registered device. Maybe the same should happen
> if dev->driver had been set before (register the device but reset
> dev->driver to NULL)?

That _seems_ reasonable.  But what do subsystem drivers expect?  They
might assume that the binding succeeded whenever the registration 
succeeded.  Although it may not make any real difference in the end.

And of course, we always have the excuse that up until a week ago, failure
to create the symlinks would not cause device registration to fail...

Alan Stern

