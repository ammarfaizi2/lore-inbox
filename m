Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262678AbTCJAKq>; Sun, 9 Mar 2003 19:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262679AbTCJAKq>; Sun, 9 Mar 2003 19:10:46 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:21009 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262678AbTCJAKp>;
	Sun, 9 Mar 2003 19:10:45 -0500
Date: Sun, 9 Mar 2003 16:11:02 -0800
From: Greg KH <greg@kroah.com>
To: Ben Collins <bcollins@debian.org>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Device removal callback
Message-ID: <20030310001102.GE6082@kroah.com>
References: <20030309181413.GA492@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030309181413.GA492@phunnypharm.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 09, 2003 at 01:14:13PM -0500, Ben Collins wrote:
> 
> So I added a new callback to the device stucture called remove. This
> callback is done when device_del is about to remove a device from the
> tree. I've used this internally to make sure I can walk the list of
> children myself, and also do some other cleanups.

But don't you really want to remove the children before you remove the
parent?  If you do this patch, then the remove() function will have to
clean up the children first, right?  Can we handle the core recursion
with the current locks properly?

Yes, for USB we still have a list of a device's children, as we need
them for various things, and the current driver model only has a parent
pointer, not a child pointer (which is good, as for USB we can have
multiple children).  So in the function where we know a USB device is
disconnected, we walk our list of children and disconnect them in a
depth-first order.  With this patch I don't see how it helps me push
code into the driver core.

Confused,

greg k-h
