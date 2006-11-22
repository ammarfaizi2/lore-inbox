Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967007AbWKVCC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967007AbWKVCC7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 21:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967008AbWKVCC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 21:02:59 -0500
Received: from firewall.rowland.harvard.edu ([140.247.233.35]:60990 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S967007AbWKVCC7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 21:02:59 -0500
Date: Tue, 21 Nov 2006 21:02:57 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
cc: linux1394-devel@lists.sourceforge.net, Greg Kroah-Hartman <gregkh@suse.de>,
       <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH] ieee1394: nodemgr: fix deadlock in shutdown
In-Reply-To: <tkrat.fb60b517d907f89e@s5r6.in-berlin.de>
Message-ID: <Pine.LNX.4.44L0.0611212028160.5677-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2006, Stefan Richter wrote:

> There is now a /sys/bus/ieee1394/drivers/ieee1394, whose "bind" and
> "unbind" attributes are not welcome.  Is there a way to disable them?

You can always prevent "bind" from operating by returning an error code
from the driver's probe routine (although it's not clear why you would
want to do that).  I don't think there's any way to make the "unbind"
attribute stop working.

You could violate the layering and remove the attribute files directly.  
But that would be a race; there would remain a brief interval between the 
time the files were created and the time you removed them.

Lastly, you could remove source of your deadlock by having the unbind 
routine for the new driver delete all the child device structures.  In 
fact, just to make things more symmetric and logical you could have the 
probe routine create those child devices in the first place!

Alan Stern

