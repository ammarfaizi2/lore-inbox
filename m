Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbVBHS0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVBHS0o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 13:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVBHS0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 13:26:44 -0500
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:4997 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S261620AbVBHS0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 13:26:42 -0500
Date: Tue, 8 Feb 2005 13:21:27 -0500
To: Greg KH <greg@kroah.com>
Cc: brking@us.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Dynids - passing driver data
Message-ID: <20050208182127.GA28367@neo.rr.com>
Mail-Followup-To: ambx1@neo.rr.com, Greg KH <greg@kroah.com>,
	brking@us.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-kernel@vger.kernel.org
References: <200502072200.j17M0S0N008552@d01av02.pok.ibm.com> <20050207221820.GA27543@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050207221820.GA27543@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
From: ambx1@neo.rr.com (Adam Belay)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2005 at 02:18:20PM -0800, Greg KH wrote:
> On Mon, Feb 07, 2005 at 04:00:27PM -0600, brking@us.ibm.com wrote:
> > 
> > Currently, code exists in the pci layer to allow userspace to specify
> > driver data when adding a pci dynamic id from sysfs. However, this data
> > is never used and there exists no way in the existing code to use it.
> 
> Which is a good thing, right?  "driver_data" is usually a pointer to
> somewhere.  Having userspace specify it would not be a good thing.

Yeah, I don't think it's safe to use "driver_data".  Although it can be a
set of flags, it's also often used as an index in an array, or as a
pointer.  An invalid value could result in an oops.

Most drivers don't use "driver_data".  For those that do, it might be
helpful to have the capability of setting a few static configuration values
before probing the device. Currently "driver_data" fills this role.
Perhaps we need a new mechanism that would be more useable with sysfs?
The current code is limiting because the configuration options in
"driver_data" are not well defined.  Any ideas?

Thanks,
Adam

P.S.: The pci serial driver is a good example.

