Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUDOIR6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 04:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUDOIR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 04:17:58 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23813 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262574AbUDOIR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 04:17:57 -0400
Date: Thu, 15 Apr 2004 09:17:52 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Maneesh Soni <maneesh@in.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: [RFC] fix sysfs symlinks
Message-ID: <20040415091752.A24815@flint.arm.linux.org.uk>
Mail-Followup-To: viro@parcelfarce.linux.theplanet.co.uk,
	Maneesh Soni <maneesh@in.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
References: <20040413124037.GA21637@in.ibm.com> <20040413133615.GZ31500@parcelfarce.linux.theplanet.co.uk> <20040414064015.GA4505@in.ibm.com> <20040414070227.GA31500@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040414070227.GA31500@parcelfarce.linux.theplanet.co.uk>; from viro@parcelfarce.linux.theplanet.co.uk on Wed, Apr 14, 2004 at 08:02:27AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2004 at 08:02:27AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Wed, Apr 14, 2004 at 12:10:16PM +0530, Maneesh Soni wrote:
> > I am not sure, if pinning the kobject for the life time of symlink (dentry)
> > may result in same problems like rmmod hang which we saw in case of pinning
> > kobject for the life time of its directory (dentry).
> 
> Erm...  If rmmod _ever_ waits for refcount on kobject to reach zero, it's
> already broken.  Do you have any examples of such behaviour?

Every single module which unregisters a struct device_driver.

 *      driver_unregister - remove driver from system.
 *      @drv:   driver.
...
 *      This will block until the driver refcount reaches 0, and it is
 *      released. Only modular drivers will call this function, and we
 *      have to guarantee that it won't complete, letting the driver
 *      unload until all references are gone.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
