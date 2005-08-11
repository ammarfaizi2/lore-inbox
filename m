Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbVHKUxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbVHKUxB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 16:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbVHKUxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 16:53:01 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:36311 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932451AbVHKUxB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 16:53:01 -0400
Date: Thu, 11 Aug 2005 16:52:57 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: dtor_core@ameritech.net
cc: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Don't use a klist for drivers' set-of-devices
In-Reply-To: <d120d50005081113294dbb4961@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.0508111643200.6745-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Aug 2005, Dmitry Torokhov wrote:

> Hmm, so what do I do in the following scenario - I have a serio port
> (AUX) that has a synaptics touchpad bound to it which is driven by
> psmouse driver. psmouse driver registers a child port (synaptics
> pass-through) during probe call. The child port is also driven by
> psmouse module - but it looks like it will deadlock when binding.
> 
> Am I missing something here?

I hate to say this, but you are right.  Can you suggest a way around this 
problem?  Perhaps arranging things so that the devlist_mutex is held only 
during the actual __device_bind_driver call and not during probe...  But 
there are so many tricky interactions and possible races that this 
requires a lot of thought.  I'll get back to you.

Alan Stern

