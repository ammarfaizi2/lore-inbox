Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261352AbTCJQTq>; Mon, 10 Mar 2003 11:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261353AbTCJQTq>; Mon, 10 Mar 2003 11:19:46 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:15630 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S261352AbTCJQTp>; Mon, 10 Mar 2003 11:19:45 -0500
Date: Mon, 10 Mar 2003 11:30:07 -0500
From: Ben Collins <bcollins@debian.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Device removal callback
Message-ID: <20030310163007.GA555@phunnypharm.org>
References: <20030309181413.GA492@phunnypharm.org> <Pine.LNX.4.33.0303100939001.1002-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0303100939001.1002-100000@localhost.localdomain>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 10, 2003 at 09:45:12AM -0600, Patrick Mochel wrote:
> 
> > So, here's my simple patch. I'd really like this to be applied to the
> > proper kernel. I really can't see how the driver model is working
> > without walking children on unregister, but this atleast allows you to
> > handle it yourself.
> 
> The assumption is that the bus driver will take care of cleaning up all 
> the children before unregistering the parent. This place a bit more 
> responsibility on the bus driver, but it keeps it simple in the core. 
> 
> That's not to say that it can't change in the future, but I don't want to 
> take that step right now. There are a lot of implications WRT locking and 
> recursion that need to be worked out, and I'd rather wait on making these 
> kind of core changes.

That's fine, I can deal with that. But this patch only allows you to add
a ->remove member to a device, which will aide in ensuring that.
Currently there's not even a check in the driver core for whether a
device has children when it is removed. Adding the remove function will
make it easier for the bus to validate a device, sanity check it, and
cleanup after it before it gets demolished from the core.

Maybe you need to {get,put}_device() wrap the call to remove, but that
shouldn't be a big problem with locking (really, the patch is simple).

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
