Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261360AbTCJQp1>; Mon, 10 Mar 2003 11:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261361AbTCJQp1>; Mon, 10 Mar 2003 11:45:27 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:39438 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S261360AbTCJQp0>; Mon, 10 Mar 2003 11:45:26 -0500
Date: Mon, 10 Mar 2003 11:55:48 -0500
From: Ben Collins <bcollins@debian.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Device removal callback
Message-ID: <20030310165548.GA753@phunnypharm.org>
References: <20030310010232.GB16134@phunnypharm.org> <Pine.LNX.4.33.0303100949490.1002-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0303100949490.1002-100000@localhost.localdomain>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I much prefer this, as I would like to see it eventually, but I'd rather
> see the implications worked out before it's generalized.

Then I have to be concerned about parts of the driver model removing
parents of my devices without my knowing it. Didn't PCI already go
through this problem with bus's being removed?

If my PCI devices gets removed, it simply calls my PCI callbacks, but
then my PCI drivers have to link into the core and call remove on all
the host devices, then node devices, then unit directories. All this has
to happen manually, and it puts the burden all the way down the tree,
when it should remain only in the bus.

It also does not help the case where something emulates an IEEE-1394
node on the locally handled bus. If it creates a node, and then behind
that, creates unit directories, and then attaches some other sort of
children unknown to the ieee1394 core. There's no possible way that
device can safely be removed by the ieee1394 core. So then I have to
export all sorts of extra functionality to provide the same thing this
2 line callback can do.

I'm not sure what the problem is in allowing the bus driver to know when
a device is about to be removed for some reason. At the very least it
makes for a good sanity check mechanism.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
