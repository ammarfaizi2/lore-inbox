Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbTFOR1B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 13:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbTFOR1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 13:27:01 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:45317
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S262008AbTFOR04
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 13:26:56 -0400
Subject: Re: Flaw in the driver-model implementation of attributes
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>, Patrick Mochel <mochel@osdl.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0306151221190.32270-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.0306151221190.32270-100000@netrider.rowland.org>
Content-Type: text/plain
Message-Id: <1055698845.1351.44.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 15 Jun 2003 10:40:45 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-06-15 at 09:42, Alan Stern wrote:
> If you're already aware of this, please forgive the intrusion.
> 
> There's a general problem in the driver model's implementation of 
> attribute files, in connection with loadable kernel modules.  The 
> sysfs_ops structure stores function pointers with no means for identifying 
> the module that contains the corresponding code.  As a result, it's 
> possible to call through one of these pointers even after the module has 
> been unloaded, causing an oops.
> 
> It's not hard to provoke this sort of situation.  A user process can
> open a sysfs device file, for instance, and delay trying to read it until 
> the module containing the device driver has been removed.  When the read 
> does occur, it runs into trouble.

I've seen this oops when a program has its cwd in a /sys directory
corresponding to a removed (or replaced) module.  I think active
references to a part of the /sys namespace corresponding to a module
should just pin the module.  But I haven't looked into it really.
	
	J

