Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263807AbUEGVgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263807AbUEGVgh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 17:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263804AbUEGVgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 17:36:37 -0400
Received: from mail1.kontent.de ([81.88.34.36]:57294 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S263807AbUEGVgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 17:36:36 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Stefan Smietanowski <stesmi@stesmi.com>
Subject: Re: Load hid.o module synchronously?
Date: Fri, 7 May 2004 19:50:30 +0200
User-Agent: KMail/1.6.2
Cc: "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <s5g8ygi4l3q.fsf@patl=users.sf.net> <s5gekpxslti.fsf@patl=users.sf.net> <409BB71F.9090601@stesmi.com>
In-Reply-To: <409BB71F.9090601@stesmi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200405071950.30130.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 7. Mai 2004 18:19 schrieb Stefan Smietanowski:
> Hi Patrick.
> 
> >>The set of devices connected to the machine is not static. Waiting
> >>until all hardware is ready is very hard to even define.
> > 
> > It is very easy to define for 99.999% of all keyboards, which start
> > off connected and stay connected.
> > 
> > This should be simple.  I want to load a driver at boot time and wait
> > until it either binds to something or fails to do so.  If the user is
> 
> But that means that the driver must include some sort of arbitrary
> timelimit. Why push that from userspace to the driver?

No, upon module load the device tree could be locked and the module
insertion could wait for all matching devices in the tree to be probed.
It definitely can be done and that solution cannot be achieved from
userspace because exporting such locks would be a disaster.

However, it is probably not wise to provide for this special case.
It would probably be best to provide a generic probe method for
devices, which could run synchronously.

	Regards
		Oliver
