Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbTDQBY2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 21:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbTDQBY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 21:24:28 -0400
Received: from dp.samba.org ([66.70.73.150]:6566 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262272AbTDQBY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 21:24:26 -0400
Date: Thu, 17 Apr 2003 11:23:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ranty@debian.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: firmware separation filesystem (fwfs)
Message-ID: <20030417012321.GB9219@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, ranty@debian.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030416163641.GA2183@ranty.ddts.net> <1050508028.28586.126.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1050508028.28586.126.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 16, 2003 at 04:47:09PM +0100, Alan Cox wrote:
> On Mer, 2003-04-16 at 17:36, Manuel Estrada Sainz wrote:
> >  On the other hand, there are already many drivers in the kernel that
> >  include firmware in headers, keyspan, io_edgeport, dabusb, ser_a2232,
> >  sym53c8xx_2, ...
> 
> But so would loading it from hotplug via ioctl. It might be we want
> a clean hotplug way to ask for 'firmare for xyz'.

True, but ioctl()s are horrid.  And the driver needs to set up a
suitable device to which the ioctl() is applied, and deal with binding
the right image to the right instance, which can get messy in some
cases.  As I see it the chief purpose of fwfs, or an equivalent sysfs
formulation would be to provide a clean mechanism for passing firmware
images to the kernel - figuring out which image to provide and
supplying it at the relevant moment can and should be the job of
hotplug or a similar userland helper.

Incidentally another approach that also avoids nasty ioctl()s would be
to invoke the userland helper with specially set up FD 1, which lets
the kernel capture the program's stdout.  When the driver needs a
firmware it invokes the helper, which figures out the relevant image
from its parameters and cats it.  The driver (presumably sleeping
waiting for this) grabs the image, stuffs it into the hardware, then
throws it away.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
